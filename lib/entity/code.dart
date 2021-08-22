import 'package:cloud_firestore/cloud_firestore.dart';

class Code {
  //ID
  String? id;
  //タイトル
  String? title;
  //概要
  String? overview;
  //コード
  String? code;
  //タグ
  List<String>? tags;
  //カテゴリ
  List<String>? categories;
  //いいね
  int? likes;
  //非公開フラグ
  bool? private;
  //作成日時
  DateTime? createat;
  //コピー元コードID
  String? fromCopiedID;

  Code(
      {this.id,
      this.title,
      this.overview,
      this.code,
      this.tags,
      this.categories,
      this.likes,
      this.private,
      this.createat,
      this.fromCopiedID});

  Code.fromMap(Map snapshot, String id)
      : id = id,
        title = snapshot['title'],
        overview = snapshot['overview'],
        code = snapshot['code'],
        tags = snapshot['tags'],
        categories = snapshot['categories'],
        likes = snapshot['likes'],
        private = snapshot['private'],
        createat = snapshot['createat'],
        fromCopiedID = snapshot['fromCopiedID'];

  factory Code.fromDatabaseJson(Map<String, dynamic> data) => Code(
      id: data['id'],
      title: data['title'],
      overview: data['overview'],
      code: data['code'],
      tags: data['tags'],
      categories: data['categories'],
      likes: data['likes'],
      private: data['private'],
      createat: data['createat'],
      fromCopiedID: data['fromCopiedID']);

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "title": this.title,
        "overview": this.overview,
        "code": this.code,
        "tags": this.tags,
        "categories": this.categories,
        "likes": this.likes,
        "private": this.private,
        "createat": this.createat,
        "fromCopiedID": this.fromCopiedID
      };
}
