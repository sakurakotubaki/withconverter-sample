import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:withconverter_app/model/user_data.dart';

void getUser() async {
  final user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid;
  final ref = await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, _) => user.toFirestore(),
      );
  final docSnap = await ref.get();
  final userRef = docSnap.data();
  if (user != null) {
    print('FireStoreから値を取得✋✋✋✋✋');
    print(user);
  } else {
    print("usersコレクションの取得に失敗しました!.");
  }
}
