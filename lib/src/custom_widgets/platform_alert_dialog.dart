import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
      this.cancelActionText,
      @required this.defaultActionText})
      : assert(title != null),
        assert(content != null),
        assert(content != null);

  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            // user cannot close the dialog by clicking outside the dialog
            builder: (context) =>
                this, // 'this' is used here for object currently is being used which is platformAlertDialog
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {// Ios Platforom dialog
    return CupertinoAlertDialog(
      title: Text(
        title,
        textDirection: TextDirection.ltr,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        textDirection: TextDirection.ltr,
      ),
      actions: _buildAction(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) { //  android Platform Dialog
    return AlertDialog(
        title: Text(
          title,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          content,
          textDirection: TextDirection.ltr  ,
        ),
        actions: _buildAction(context));
  }

  List<Widget> _buildAction(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          child: Text(cancelActionText),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    );
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child, this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
