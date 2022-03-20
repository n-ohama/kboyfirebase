import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String? title;
  String? id;

  Book(QueryDocumentSnapshot data) {
    id = data.id;
    title = data['title'];
  }
}
