import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../service/authentication_error.dart';
import 'home.dart';
import '../main.dart';
import 'package:provider/provider.dart';

// アカウント登録ページ
class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // Firebase Authenticationを利用するためのインスタンス
  final FirebaseAuth auth = FirebaseAuth.instance;

  String newEmail = ""; // 入力されたメールアドレス
  String newPassword = ""; // 入力されたパスワード
  String infoText = ""; // 登録に関する情報を表示
  bool pswdOK = false; // パスワードが有効な文字数を満たしているかどうか

  // エラーメッセージを日本語化するためのクラス
  final authError = AuthenticationError();

  @override
  Widget build(BuildContext context) {
    // ユーザー情報を受け取る
    final UserState userState = Provider.of<UserState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Codes"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Text('新規アカウントの作成',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Padding(
              padding: EdgeInsets.all(16.0),
            ),

            // メールアドレスの入力フォーム
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: (String value) {
                    newEmail = value;
                  },
                )),

            // パスワードの入力フォーム
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: TextFormField(
                  decoration: InputDecoration(labelText: "パスワード（8～20文字）"),
                  obscureText: true, // パスワードが見えないようRにする
                  maxLength: 20, // 入力可能な文字数
                  maxLengthEnforcement:
                      MaxLengthEnforcement.enforced, // 入力可能な文字数の制限を超える場合の挙動の制御
                  onChanged: (String value) {
                    if (value.length >= 8) {
                      newPassword = value;
                      pswdOK = true;
                    } else {
                      pswdOK = false;
                    }
                  }),
            ),

            // 登録失敗時のエラーメッセージ
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
              child: Text(
                infoText,
                style: TextStyle(color: Colors.red),
              ),
            ),

            ButtonTheme(
              minWidth: 350.0,
              // height: 100.0,
              child: ElevatedButton(
                child: Text('登録'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  if (pswdOK) {
                    try {
                      // メール/パスワードでユーザー登録
                      UserCredential result =
                          await auth.createUserWithEmailAndPassword(
                        email: newEmail,
                        password: newPassword,
                      );

                      // 登録成功
                      // 登録したユーザー情報
                      // ユーザー情報を更新
                      userState.setUser(result.user!);
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return Home();
                        }),
                      );
                    } catch (e) {
                      // 登録に失敗した場合
                      setState(() {
                        infoText = authError.registerErrorMsg(e.toString());
                      });
                    }
                  } else {
                    setState(() {
                      infoText = 'パスワードは8文字以上です。';
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
