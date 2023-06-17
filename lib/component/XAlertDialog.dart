import 'dart:io';

import 'package:fani_wedding/util/XColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../util/constants.dart';

class XAlertButton {
  final String? title;
  final dynamic key;
  XAlertButton(this.title, {this.key});
  XAlertButton.close({this.title, this.key});
}

class XAlertDialog extends StatelessWidget {
  const XAlertDialog({
    this.title,
    this.content,
    this.titleWidget,
    this.contentWidget,
    this.actions = const [],
    Key? key,
  }) : super(key: key);
  final String? title;
  final String? content;
  final Widget? titleWidget;
  final Widget? contentWidget;
  final List<XAlertButton> actions;

  @override
  Widget build(BuildContext context) {
    final xActions = actions.isEmpty ? [XAlertButton.close()] : actions;
    if (kIsWeb || Platform.isAndroid) {
      return AlertDialog(
        title: titleWidget ?? (title == null ? null : Text(title!)),
        titleTextStyle: Theme.of(context).textTheme.headline5,
        content: contentWidget ?? (content == null ? null : Text(content!)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.kRadiusXL),
        ),
        actions: <Widget>[
          for (int i = 0; i < xActions.length; i++)
            _buildButton(context, xActions[i], i, (xActions.length == (i + 1)))
        ],
      );
    }
    return CupertinoAlertDialog(
      title: titleWidget ?? (title == null ? null : Text(title!)),
      content: contentWidget ?? (content == null ? null : Text(content!)),
      actions: <Widget>[
        for (int i = 0; i < xActions.length; i++)
          _buildButton(context, xActions[i], i, (xActions.length == (i + 1)))
      ],
    );
  }

  Widget _buildButton(
      BuildContext context, XAlertButton item, int index, bool isLastItem) {
    if (kIsWeb || Platform.isAndroid) {
      return TextButton(
        key: Key('XAlertButton-$index-${item.key}'),
        onPressed: () {
          Navigator.of(context).pop(item.key);
        },
        child: Text(
          item.title ?? 'Close',
          style: !isLastItem
              ? const TextStyle(
                  color: XColors.grey_60,
                  fontWeight: FontWeight.normal,
                )
              : null,
        ),
      );
    }
    return CupertinoDialogAction(
      key: Key('XAlertButton-$index-${item.key}'),
      onPressed: () {
        Navigator.of(context).pop(item.key);
      },
      child: Text(item.title ?? 'Close'),
    );
  }
}
