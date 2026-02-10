import 'package:flutter/material.dart';

class TitleDescriptionTextWidget extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final bool extend;
  const TitleDescriptionTextWidget({
    super.key,
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
    this.extend = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: extend ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          '$title ',
          style: titleStyle
        ),
        extend ? Expanded(
          child: Text(
            description,
            style: descriptionStyle,
          ),
        ) : Text(
          description,
          style: descriptionStyle,
        ),
      ],
    );
  }
}