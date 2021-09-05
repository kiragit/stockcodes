import 'package:flutter/material.dart';
import 'package:stockcodes/entity/code.dart';
import 'package:stockcodes/model/codeModel.dart';
import 'package:stockcodes/model/codesModel.dart';
import 'package:stockcodes/ui/codeDetailView.dart';
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
    final CodesModel codeModel = Provider.of<CodesModel>(context);
    List<Code> codes = codeModel.allCodeList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Codes'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                codeModel.reload();
              }),
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text("リストの並び替え"),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          codeModel.sortByTitle();
                          Navigator.pop(context, 1);
                        },
                        child: Text("タイトル"),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          codeModel.sortByCreateat();
                          Navigator.pop(context, 1);
                        },
                        child: Text("作成日"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
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
                  builder: (context) {
                    return ChangeNotifierProvider<CodeModel>(
                      create: (context) => CodeModel(new Code()),
                      child: CordDetailView(new Code(), true),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
