import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextPage extends StatefulWidget {
  static const routeName = 'SpeechToTextPage';

  const SpeechToTextPage({Key? key}) : super(key: key);

  @override
  State<SpeechToTextPage> createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  String localId = "en_US";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    log("message _startListening",name: "SpeechToTextPage");
    bool available = await _speech.initialize(
      onStatus: _statusListener,
      onError: _errorListener,
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        localeId: localId,
        onResult: (val) => setState(() {
          _text = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            _confidence = val.confidence;
          }
        }),
      );
    }
  }

  void _stopListening() async {
    log("message stopListening",name: "SpeechToTextPage");
    setState(() => _isListening = false);
    await _speech.stop();
  }

  void _statusListener(String status) {
    if (status == 'notListening' && _isListening) {
      _startListening(); // Restart listening if it stops
    }
  }

  void _errorListener(SpeechRecognitionError error) {
    // Handle errors if necessary
    if (kDebugMode) {
      print('Error: ${error.errorMsg}');
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech to Text Continuous Listening'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
            ),
            const SizedBox(height: 10),
            Text(
              _text,
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: _isListening ? _stopListening : _startListening,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              setState(() {
                localId = localId == "en_US" ? "vi_VN" : "en_US";
              });
            },
            child: const Icon(Icons.change_circle),
          )
        ],
      ),
    );
  }
}
