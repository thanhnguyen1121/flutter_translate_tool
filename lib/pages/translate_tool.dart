import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo_deep_link/constants.dart';
import 'package:demo_deep_link/models/language_model.dart';
import 'package:demo_deep_link/pages/widgets/language_list_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslateTool extends StatefulWidget {
  static const routeName = 'TranslateTool';

  const TranslateTool({Key? key}) : super(key: key);

  @override
  State<TranslateTool> createState() => _TranslateToolState();
}

class _TranslateToolState extends State<TranslateTool> {
  static const tag = 'TranslateTool';
  String inputPath = '';
  String message = "";
  bool showLoading = false;
  final translator = GoogleTranslator();
  final languageInputCtrl = TextEditingController();
  final languageOutCtrl = TextEditingController();
  File? inputFile;

  final List<LanguageModel> languages = [];
  final List<LanguageModel> inputSelectedLanguages = [];
  final List<LanguageModel> outputSelectedLanguages = [];

  @override
  void initState() {
    super.initState();
    for (var element in languagesData) {
      languages.add(LanguageModel.fromJson(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App translate",
        ),
        elevation: 1.0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(inputPath)),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          inputFile = await getFilePath();
                          setState(() {
                            inputPath = inputFile?.path ?? "No file selected";
                          });
                        },
                        child: const Text("open"),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: languageInputCtrl,
                          decoration: const InputDecoration(hintText: "Language Input"),
                          onTap: () {
                            LanguageListWidget.show(
                              context: context,
                              models: languages,
                              selectedModel: inputSelectedLanguages,
                              onPressed: (value) {
                                languageInputCtrl.text = value.englishName;
                                inputSelectedLanguages.clear();
                                if (value.selected) {
                                  inputSelectedLanguages.add(value);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: languageOutCtrl,
                          decoration: const InputDecoration(hintText: "Language out"),
                          onTap: () {
                            LanguageListWidget.show(
                              context: context,
                              models: languages,
                              selectedModel: outputSelectedLanguages,
                              onPressed: (value) {
                                if (value.selected) {
                                  outputSelectedLanguages.add(value);
                                } else {
                                  outputSelectedLanguages.removeWhere((element) => element.code == value.code);
                                }
                                languageOutCtrl.text = outputSelectedLanguages.map((e) => e.englishName).join(",");
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      if (inputFile != null &&
                          inputSelectedLanguages.isNotEmpty &&
                          outputSelectedLanguages.isNotEmpty) {
                        setState(() {
                          message = "";
                          showLoading = true;
                        });
                        for (var element in outputSelectedLanguages) {
                          final languageCode = inputSelectedLanguages.first.code.split("-").first;
                          await translateFunc(inputFile, languageCode, element.code);
                        }
                        setState(() {
                          final temp = inputFile!.path.split("/")..removeLast();
                          message = "Dịch thành công. Check đường dẫn ${(temp.join("/"))}";
                          showLoading = false;
                        });
                      } else {
                        setState(() {
                          message = "Chưa đủ dữ liệu đầu vào!";
                          showLoading = false;
                        });
                      }
                    },
                    child: const Text("Translate"),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          if (showLoading)
            const Align(
              alignment: Alignment.center,
              child: CupertinoActivityIndicator(),
            )
        ],
      ),
    );
  }

  Future<File?> getFilePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> readFileContent(File file) async {
    try {
      final input = await file.readAsString();
      final result = jsonDecode(input);
      return result;
    } catch (exception) {
      log("message exception: $exception", name: "TranslateTool");
      return {};
    }
  }

  Future<void> translateFunc(File? inputFile, String inputCode, String outputCode) async {
    if (inputFile != null) {
      final data = await readFileContent(inputFile);
      log("message data: ${jsonEncode(data)} -- inputCode: $inputCode --outputCode: $outputCode ",
          name: "TranslateTool");
      final Map<String, String> result = {};

      for (var element in data.entries.toList()) {
        try {
          final translatorResult = await translator.translate(element.value, from: inputCode, to: outputCode);
          final valueTranslate = translatorResult.text;
          result.putIfAbsent(element.key, () => valueTranslate);
          log("message (${element.key}, ${element.value}) ==> (${element.key},$valueTranslate)", name: "TranslateTool");
        } catch (exception) {
          result.putIfAbsent(element.key, () => element.value);
          log("message exception: $exception", name: "TranslateTool");
        }
      }
      final outPut = await writeFile(result, outputCode);

      log("message valueTranslate outPut: $outPut}", name: "TranslateTool");
    } else {
      log("message file = null", name: "TranslateTool");
    }
  }

  Future<String> writeFile(Map<String, dynamic> outPut, String outputCode) async {
    final temp = inputFile!.path.split("/")..removeLast();
    final outPutPath = '${temp.join("/")}/output_$outputCode.json';
    final File file = File(outPutPath);
    final fileExists = await file.exists();
    if (!fileExists) {
      await file.create();
    }
    await file.writeAsString(jsonEncode(outPut));
    return file.path;
  }
}
