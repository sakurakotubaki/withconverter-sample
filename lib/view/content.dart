import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:withconverter_app/repository/user_data.dart';
import 'package:withconverter_app/view/login.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    print('initStateを実行しました😄😄😄😄😄😄');
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('成功'),
        actions: [
          IconButton(
            //ステップ２
            onPressed: () async {
              await _auth.signOut();
              if (_auth.currentUser == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('ログアウトしました'),
                  ),
                );
                print('ログアウトしました！');
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserLogin()));
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Center(
        child: Text('ログイン成功！'),
      ),
    );
  }
}
