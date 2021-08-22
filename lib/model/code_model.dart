import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockcodes/Repository/code_repository.dart';
import 'package:stockcodes/entity/code.dart';

class CodeModel with ChangeNotifier {
  User user;

  List<Code> _allCodeList = [];

  List<Code> get allCodeList => _allCodeList;

  final CodeRepository repo = CodeRepository();

  CodeModel(this.user) {
    _fetchAll();
  }

  void _fetchAll() async {
    _allCodeList = await repo.getAllCades(user);
    notifyListeners();
  }

  void add(Code code) async {
    await repo.insertCode(user, code);
    _fetchAll();
  }
}
