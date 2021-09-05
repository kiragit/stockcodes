import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

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
  late HtmlEditorController controller;
  late bool editflag;
  late String _overview;

  _OverviewEditorState(
      HtmlEditorController controller, bool editflag, String overview) {
    this.controller = controller;
    this.editflag = editflag;
    this._overview = overview;
  }

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: controller, //required
      htmlEditorOptions: HtmlEditorOptions(
        hint: "Your text here...",
        initialText: this._overview,
      ),
      otherOptions: OtherOptions(
        height: 400,
      ),
    );
  }
}
