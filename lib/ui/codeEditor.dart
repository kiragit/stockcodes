import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
// Import the language & theme
import 'package:highlight/languages/dart.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodeEditor extends StatefulWidget {
  String source = "";
  late bool editflag;
  CodeController? _codeController;

  CodeEditor(String? source, bool editflag) {
    this.editflag = !editflag;
    if (source != null) {
      this.source = source;
    } else {
      this.source = "";
    }

    // Instantiate the CodeController
    _codeController = CodeController(
      text: this.source,
      language: dart,
      theme: monokaiSublimeTheme,
    );
  }

  @override
  _CodeEditorState createState() => _CodeEditorState(_codeController, editflag);

  getSource() {
    return _codeController!.text;
  }
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;

  bool? _editflag;

  _CodeEditorState(CodeController? codeController, bool editflag) {
    this._codeController = codeController;
    this._editflag = editflag;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        absorbing: _editflag!,
        child: CodeField(
          controller: _codeController!,
          textStyle: TextStyle(fontFamily: 'SourceCode'),
        ));
  }
}
