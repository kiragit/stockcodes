import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockcodes/entity/code.dart';

class CodeDao {
  final db = FirebaseFirestore.instance;
  String collection = "users";
  String subCollection = "codes";

  create(user, Code code) async {
    try {
      await db
          .collection(collection)
          .doc(user.uid)
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
          .doc(user.uid)
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
          .doc(user.uid)
          .collection(subCollection)
          .doc(codeID)
          .update(code.toDatabaseJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future selectByUser(user) async {
    List<Code> codes = [];
    try {
      QuerySnapshot snapshot = await db
          .collection(collection)
          .doc(user.uid)
          .collection(subCollection)
          .get();
      snapshot.docs.forEach((element) {
        String id = element.id;
        String title = element.get('title'); //.cast<String>() as String;
        String overview = element.get('overview'); //.cast<String>() as String;
        String code = element.get('code'); //.cast<String>() as String;
        List<String> tags = element.get('tags').cast<String>() as List<String>;
        List<String> categories =
            element.get('categories').cast<String>() as List<String>;
        int likes = element.get('likes'); //.cast<int>() as int;
        bool private = element.get('private'); //.cast<bool>() as bool;
        var createataTmp = element.get('createat');
        DateTime createat;
        if (createataTmp is Timestamp) {
          // toDate()でDateTimeに変換
          createat = createataTmp.toDate();
        } else {
          createat = DateTime.now();
        }
        String fromCopiedID =
            element.get('fromCopiedID'); //.cast<String>() as String;

        codes.add(Code.fromDatabaseJson({
          'id': id,
          'title': title,
          'overview': overview,
          'code': code,
          'tags': tags,
          'categories': categories,
          'likes': likes,
          'private': private,
          'createat': createat,
          'fromCopiedID': fromCopiedID,
        }));
      });
      return codes;
    } catch (e) {
      print(e.toString());
    }
  }
}
