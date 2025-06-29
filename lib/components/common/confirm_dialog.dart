// lib/components/common/simple_confirm_dialog.dart
import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/paddings.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final Color? cancelColor;
  final Color? confirmColor;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = StringConstants.yes,
    this.cancelLabel = StringConstants.cancel,
    this.confirmColor = ColorConstants.kinglyCloud,
    this.cancelColor = ColorConstants.kinglyCloud,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = ButtonStyle(
        shape: WidgetStateProperty.all(const BeveledRectangleBorder()));
    final mq = MediaQuery.of(context);
    final double dialogElevation = 4;

    return AlertDialog(
      elevation: dialogElevation,
      actionsPadding: EdgeInsets.symmetric(
        horizontal: Paddings.lowHigh.value,
        vertical: Paddings.lowlow.value,
      ),
      shape: const BeveledRectangleBorder(),
      insetPadding: EdgeInsets.all(Paddings.lowHigh.value),
      title: (title != null) ? Text(title!) : null,
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
      actions: [
        SizedBox(
          width: mq.size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: textButtonStyle,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  cancelLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: cancelColor),
                ),
              ),
              TextButton(
                style: textButtonStyle,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  confirmLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: confirmColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}