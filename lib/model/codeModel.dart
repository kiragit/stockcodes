import 'package:flutter/material.dart';
import 'package:stockcodes/entity/code.dart';

class CodeModel with ChangeNotifier {
  Code? _code;

  Code? get code => _code;

  void update() {
    notifyListeners();
  }

  CodeModel(Code code) {
    this._code = code;
  }
}
