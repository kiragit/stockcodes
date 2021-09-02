import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
// Import the language & theme
import 'package:highlight/languages/dart.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodeEditor extends StatefulWidget {
  String source = "";
  CodeController? _codeController;

  CodeEditor(String? source) {
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
  _CodeEditorState createState() => _CodeEditorState(_codeController);

  getSource() {
    return _codeController!.text;
  }
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;

  _CodeEditorState(CodeController? codeController) {
    this._codeController = codeController;
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
    return CodeField(
      controller: _codeController!,
      textStyle: TextStyle(fontFamily: 'SourceCode'),
    );
  }
}
