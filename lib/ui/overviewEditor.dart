import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class OverviewEditor extends StatefulWidget {
  final String title;
  late bool _editflag;
  late String _overview;
  final HtmlEditorController controller = HtmlEditorController();

  OverviewEditor(
      {Key? key,
      required this.title,
      required bool editflag,
      required String overview})
      : super(key: key) {
    this._editflag = editflag;
    this._overview = overview;
    this.controller.setText(overview);
  }

  @override
  _OverviewEditorState createState() =>
      _OverviewEditorState(controller, _editflag, _overview);

  Future<String> getText() async {
    return await controller.getText();
  }
}

class _OverviewEditorState extends State<OverviewEditor> {
  String result = '';
  late HtmlEditorController htmlController;
  late bool _editflag;
  late String _overview;

  _OverviewEditorState(
      HtmlEditorController controller, bool editflag, String overview) {
    this.htmlController = controller;
    this._editflag = editflag;
    this._overview = overview;
  }

  @override
  Widget build(BuildContext context) {
    if (_editflag) {
      return HtmlEditor(
        controller: htmlController, //required
        htmlEditorOptions: HtmlEditorOptions(
          hint: "Your text here...",
          initialText: this._overview,
          autoAdjustHeight: true,
          adjustHeightForKeyboard: true,
        ),
        otherOptions: OtherOptions(),
      );
    } else {
      /// sanitize or query document here
      return Html(
        data: this._overview,
      );
    }
  }
}
