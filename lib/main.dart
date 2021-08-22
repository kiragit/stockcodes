import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// 更新可能なデータ
class UserState extends ChangeNotifier {
  User? user;

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  // ユーザーの情報を管理するデータ
  final UserState userState = UserState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>(
      create: (context) => UserState(),
      child: MaterialApp(
        title: 'StockCodes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: MyHomePage(title: 'MyPages'),
        home: Login(),
      ),
    );
  }
}
