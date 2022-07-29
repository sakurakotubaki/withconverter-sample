import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:withconverter_app/view/content.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 入力されたユーザーの名前
  String newUser = "";
  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";

  // ユーザー情報を登録する関数を定義
  Future<void> createAuth() async {
    // FirebaseAuthが用意しているメールアドレスとパスワードを登録する関数を定義
    final FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential result = await auth.createUserWithEmailAndPassword(
      email: newUserEmail,
      password: newUserPassword,
    );
    // 上のFirebaseAuthから、uidを取得する変数を定義
    final user = result.user;
    final uuid = user?.uid;
    // usersコレクションを作成して、uidとドキュメントidを一致させるプログラムを定義
    final users = FirebaseFirestore.instance.collection('users').doc(uuid).set({
      'uid': uuid,
      'name': newUser,
      'email': newUserEmail,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー登録'),
      ),
      // キーボードで隠れて、黄色エラーが出るので
      // SingleChildScrollViewで、Centerウイジットをラップする
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // かっこよくしたいので、画像を配置した!
                const CircleAvatar(
                  radius: 75,
                  // images.unsplash.comの画像のパスを貼り付ける
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1658033014478-cc3b36e31a5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMDR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  // テキスト入力のラベルを設定
                  decoration: InputDecoration(labelText: "ユーザー名"),
                  onChanged: (String value) {
                    setState(() {
                      newUser = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  // テキスト入力のラベルを設定
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: (String value) {
                    setState(() {
                      newUserEmail = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                  // パスワードが見えないようにする
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      newUserPassword = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // 作成した関数を実行する
                      createAuth();
                    } catch (e) {
                      print('登録に失敗しました!: $e');
                    }
                  },
                  child: Text("ユーザー登録"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
