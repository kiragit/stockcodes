import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockcodes/entity/code.dart';

class CodeSQLHelper {
  static final db = FirebaseFirestore.instance;
  static const String collection = "users";
  static const String subCollection = "codes";

  create(user, Code code) async {
    try {
      await db
          .collection(collection)
          .doc(user.id)
          .collection(subCollection)
          .add(
            code.toDatabaseJson(),
          );
    } catch (e) {
      print(e.toString());
    }
  }

  deleteByID(user, codeID) async {
    try {
      await db
          .collection(collection)
          .doc(user.id)
          .collection(subCollection)
          .doc(codeID)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  updateByID(user, codeID, Code code) async {
    try {
      await db
          .collection(collection)
          .doc(user.id)
          .collection(subCollection)
          .doc(codeID)
          .update(code.toDatabaseJson());
    } catch (e) {
      print(e.toString());
    }
  }

  selectByUser(user) async {
    try {
      await db
          .collection(collection)
          .doc(user.id)
          .collection(subCollection)
          .get();
    } catch (e) {
      print(e.toString());
    }
  }
}
