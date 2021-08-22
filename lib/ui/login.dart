import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:stockcodes/model/code_model.dart';
import '../service/authentication_error.dart';
import 'registration.dart';
import 'home.dart';
import '../main.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  String loginEmail = ""; // 入力されたメールアドレス
  String loginPassword = ""; // 入力されたパスワード
  String infoText = ""; // ログインに関する情報を表示

  // Firebase Authenticationを利用するためのインスタンス
  final FirebaseAuth auth = FirebaseAuth.instance;

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
            // メールアドレスの入力フォーム
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: (String value) {
                    loginEmail = value;
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
                  loginPassword = value;
                },
              ),
            ),

            // ログイン失敗時のエラーメッセージ
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
                  child: Text(
                    'ログイン',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () async {
                    try {
                      // メール/パスワードでユーザー登録
                      UserCredential result =
                          await auth.signInWithEmailAndPassword(
                        email: loginEmail,
                        password: loginPassword,
                      );

                      // ログイン成功
                      // ユーザー情報を更新
                      userState.setUser(result.user!);
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return ChangeNotifierProvider<CodeModel>(
                            create: (context) => CodeModel(result.user!),
                            child: MaterialApp(
                              title: 'StockCodes',
                              theme: ThemeData(
                                primarySwatch: Colors.blue,
                              ),
                              //home: MyHomePage(title: 'MyPages'),
                              home: Home(),
                            ),
                          );
                        }),
                      );
                    } catch (e) {
                      // ログインに失敗した場合
                      setState(() {
                        infoText = authError.loginErrorMsg(e.toString());
                      });
                    }
                  }),
            ),
          ],
        ),
      ),

      // 画面下にボタンの配置
      bottomNavigationBar:
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(80.0),
          child: ButtonTheme(
            minWidth: 350.0,
            // height: 100.0,
            child: ElevatedButton(
                child: Text(
                  'アカウントを作成する',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.blue[50],
                ),
                // ボタンクリック後にアカウント作成用の画面の遷移する。
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) => Registration(),
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
