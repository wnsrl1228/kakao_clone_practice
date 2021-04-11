import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kakao_clone_practice/src/model/user_model.dart';

class FirebaseUserRepository {
  static Future<String> signup(UserModel user) async {
    //파이어베이스 repository폴더 집입해서 추가시키는 과정
    //map방식으로 넣어줘야함
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    DocumentReference drf = await users.add(user.toMap());
    return drf.id;
  }

  static Future<UserModel> findUserByUid(String uid) async {
    //동일한 유저의 repository중복저장 접근 방지
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot data = await users.where("uid", isEqualTo: uid).get();
    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(
          data.docs[0].data(), data.docs[0].id); //현재 저장된 레파지토리가 많아서 배열형식임.
    }
  }

  static void updateLastLoginDate(String docId, DateTime time) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"data_last_login": time});
  }

  static void updateImageUrl(String docId, String url, String fieldName) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({fieldName: url});
  }

  static void updateData(String docId, UserModel user) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update(user.toMap());
  }
}
