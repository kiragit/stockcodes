import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockcodes/Repository/code_repository.dart';
import 'package:stockcodes/entity/code.dart';
import 'package:stockcodes/ui/codeDetailView.dart';

import '../main.dart';

class CordListView extends StatelessWidget {
  late Code code;
  late String title;
  late String overview;
  late IconData private;
  final CodeRepository repo = CodeRepository();

  CordListView(this.code) {
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

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
              leading: Icon(this.private),
              title: Text(this.title),
              subtitle: Text(this.overview),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CordDetailView(code);
                    });
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
                onPressed: () {},
              ),
              ElevatedButton(
                child: const Text('削除'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  repo.deleteCodeById(userState.user, code.id!);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
