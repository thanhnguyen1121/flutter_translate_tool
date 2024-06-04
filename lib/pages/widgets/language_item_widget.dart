import 'dart:developer';

import 'package:demo_deep_link/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageItemWidget extends StatefulWidget {
  final LanguageModel model;
  final ValueChanged<LanguageModel>? onPressed;

  const LanguageItemWidget({
    Key? key,
    required this.model,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<LanguageItemWidget> createState() => _LanguageItemWidgetState();
}

class _LanguageItemWidgetState extends State<LanguageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        widget.model.selected = !widget.model.selected;
        setState(() {});
        widget.onPressed?.call(widget.model);
      },
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Text(widget.model.flag),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.model.englishName,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 8),
            Icon(widget.model.selected ? Icons.check_circle : Icons.circle_outlined),
          ],
        ),
      ),
    );
  }
}
