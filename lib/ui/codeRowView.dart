import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockcodes/Repository/code_repository.dart';
import 'package:stockcodes/entity/code.dart';
import 'package:stockcodes/model/code_model.dart';
import 'package:stockcodes/ui/codeDetailView.dart';
import 'package:stockcodes/ui/codeDetailView.dart';

import '../main.dart';

class CordRowView extends StatelessWidget {
  late Code code;
  late String title;
  late String overview;
  late IconData private;
  final CodeRepository repo = CodeRepository();

  CordRowView(this.code) {
    this.title = (this.code.title == null ? "No title" : code.title)!;
    this.overview =
        (this.code.overview == null ? "No overview" : code.overview)!;
    if (this.code.private == null) {
      this.private = Icons.public;
    } else {
      this.private =
          (this.code.private == false ? Icons.public : Icons.public_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final CodeModel codeModels = Provider.of<CodeModel>(context);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
              leading: Icon(this.private),
              title: Text(this.title),
              subtitle: Text(this.overview),
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) =>
                        CordDetailView(code, false),
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: const Text('編集'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) =>
                          CordDetailView(code, true),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('削除'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('警告'),
                        content: Text('データを削除しますか'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text("キャンセル"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
                              child: Text("OK"),
                              onPressed: () {
                                repo.deleteCodeById(userState.user, code.id!);
                                codeModels.reload();
                                Navigator.pop(context);
                              }),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
