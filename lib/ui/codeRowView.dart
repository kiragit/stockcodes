import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockcodes/Repository/code_repository.dart';
import 'package:stockcodes/entity/code.dart';
import 'package:stockcodes/model/codeModel.dart';
import 'package:stockcodes/model/codesModel.dart';
import 'package:stockcodes/ui/codeDetailView.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stockcodes/service/StringUtil.dart';

import '../main.dart';

class CordRowView extends StatelessWidget {
  late Code code;
  late String title;
  late String overview;
  late IconData private;
  late DateTime createat;
  late String createat_jp;

  final CodeRepository repo = CodeRepository();

  CordRowView(this.code) {
    initializeDateFormatting("ja");
    DateFormat formatter = new DateFormat.yMMMd('ja').add_Hms();

    this.title = (this.code.title == null ? "No title" : code.title)!;
    this.overview =
        (this.code.overview == null ? "No overview" : code.overview)!;
    this.createat =
        (this.code.createat == null ? DateTime.now() : code.createat)!;
    this.createat_jp = formatter.format(this.createat);
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
    final CodesModel codeModels = Provider.of<CodesModel>(context);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, // これで両端に寄せる
        children: <Widget>[
          Container(
              child: Expanded(
            child: ListTile(
                leading: Icon(this.private),
                title: Text(this.title),
                subtitle: Text(this.createat_jp +
                    "　" +
                    StringUtil.substringLt(
                        StringUtil.parseHtmlString(this.overview), 50)),
                //概要はhtmlをtext変換して50文字に
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return ChangeNotifierProvider<CodeModel>(
                            create: (context) => CodeModel(code),
                            child: CordDetailView(code, false),
                          );
                        }),
                  );
                }),
          )),
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
                        builder: (context) {
                          return ChangeNotifierProvider<CodeModel>(
                            create: (context) => CodeModel(code),
                            child: CordDetailView(code, true),
                          );
                        }),
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
        ]);
  }
}
