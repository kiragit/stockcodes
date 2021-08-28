import 'package:flutter/material.dart';
import 'package:stockcodes/entity/code.dart';
import 'package:stockcodes/model/code_model.dart';
import 'package:stockcodes/ui/codeRegistUpdate.dart';
import 'package:stockcodes/ui/codeRowView.dart';
import '../main.dart';
import 'package:provider/provider.dart';

// [Themelist] インスタンスにおける処理。
class Home extends StatelessWidget {
  Home();

  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);
    final CodeModel codeModel = Provider.of<CodeModel>(context);
    List<Code> codes = codeModel.allCodeList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Codes'),
      ),
      body: ListView.builder(
        itemCount: codes.length,
        itemBuilder: (BuildContext context, int index) {
          return CordRowView(codes[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) => CodeRegistUpdate(),
              ),
            );
          },
        ),
      ),
    );
  }
}
