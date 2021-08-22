import 'package:flutter/material.dart';
import 'package:stockcodes/entity/code.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CordDetailView extends StatelessWidget {
  late Code code;
  late String title;
  late String overview;
  late IconData private;
  late String codeStr;
  late List<String> tags;
  late List<String> categories;
  late int likes;
  late String createat;
  late String fromCopiedID;

  CordDetailView(this.code) {
    this.title = (this.code.title == null ? "No title" : code.title)!;
    this.overview =
        (this.code.overview == null ? "No overview" : code.overview)!;

    if (this.code.private == null) {
      this.private = Icons.public;
    } else {
      this.private =
          (this.code.private == false ? Icons.public : Icons.public_off);
    }

    this.codeStr = (this.code.code == null ? "No code" : code.code)!;

    this.likes = (this.code.likes == null ? 0 : code.likes)!;

    initializeDateFormatting("ja_JP");
    DateFormat formatter = new DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");
    this.createat = (this.code.createat == null
        ? ""
        : formatter.format(this.code.createat!));

    this.fromCopiedID =
        (this.code.fromCopiedID == null ? "" : code.fromCopiedID)!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(this.private),
          Text(this.title),
          Text(this.overview),
          Text(this.likes.toString()),
          Text(this.codeStr),
          Text(this.createat),
          Text(this.fromCopiedID),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: const Text('編集'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {},
              ),
              ElevatedButton(
                child: const Text('削除'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
