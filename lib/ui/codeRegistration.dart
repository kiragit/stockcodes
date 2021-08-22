import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockcodes/entity/code.dart';
import 'package:stockcodes/model/code_model.dart';
import 'package:stockcodes/ui/home.dart';

import '../main.dart';

class CodeRegistration extends StatelessWidget {
  CodeRegistration();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user!;
    final CodeModel codeModel = CodeModel(user);
    final titleController = TextEditingController();
    final overviewController = TextEditingController();
    final codeController = TextEditingController();
    final tagsController = TextEditingController();
    final categoriesController = TextEditingController();
    final Controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Codes'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text('タイトル'),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: titleController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            )),
                        SizedBox(height: 20),
                        Text('概要'),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: overviewController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            )),
                        SizedBox(height: 20),
                        Text('コード'),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: codeController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            )),
                        SizedBox(height: 20),
                        Text("タグ"),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: tagsController,
                              ),
                            )),
                        SizedBox(height: 20),
                        Text("カテゴリ"),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: categoriesController,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
      // 画面下にボタンの配置
      bottomNavigationBar:
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ButtonTheme(
            minWidth: 350.0,
            // height: 100.0,
            child: ElevatedButton(
                child: Text(
                  '登録する',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.blue[50],
                ),
                // ボタンクリック後にデータを登録して、一覧画面へ戻る。
                onPressed: () {
                  try {
                    DateTime _now = DateTime.now();
                    Code code = new Code.fromDatabaseJson({
                      'id': null,
                      'title': titleController.text,
                      'overview': overviewController.text,
                      'code': codeController.text,
                      'tags': [tagsController.text],
                      'categories': [categoriesController.text],
                      'likes': 0,
                      'private': false,
                      'createat': _now,
                      'fromCopiedID': ""
                    });
                    codeModel.add(code);
                  } catch (e) {
                    print(e.toString());
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (BuildContext context) => Home(),
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
