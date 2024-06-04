import 'package:demo_deep_link/models/language_model.dart';
import 'package:demo_deep_link/pages/widgets/language_item_widget.dart';
import 'package:flutter/material.dart';

class LanguageListWidget extends StatefulWidget {
  final List<LanguageModel> models;
  final List<LanguageModel> selectedModels;
  final ScrollController controller;
  final bool selectMultiple;
  final ValueChanged<LanguageModel>? onPressed;

  const LanguageListWidget({
    Key? key,
    required this.selectedModels,
    required this.models,
    required this.controller,
    this.selectMultiple = false,
    this.onPressed,
  }) : super(key: key);

  static Future<void> show({
    required BuildContext context,
    required List<LanguageModel> models,
    required List<LanguageModel> selectedModel,
    bool selectMultiple = false,
    ValueChanged<LanguageModel>? onPressed,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: DraggableScrollableSheet(
            maxChildSize: 1.0,
            initialChildSize: 0.9,
            minChildSize: 0.8,
            builder: (context, scrollController) {
              return LanguageListWidget(
                models: models,
                selectedModels: selectedModel,
                controller: scrollController,
                selectMultiple: selectMultiple,
                onPressed: onPressed,
              );
            },
          ),
        );
      },
    );
  }

  @override
  State<LanguageListWidget> createState() => _LanguageListWidgetState();
}

class _LanguageListWidgetState extends State<LanguageListWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        children: widget.models.map(
          (e) {
            final model = e.copyWith(selected: widget.selectedModels.any((element) => element.code == e.code));
            return LanguageItemWidget(
              model: model,
              onPressed: (value) {
                for (var element in widget.models) {
                  element.selected = false;
                }
                widget.models
                    .firstWhere(
                      (element) => e.code == value.code,
                    )
                    .selected = true;
                widget.onPressed?.call(value);
                setState(() {});
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
