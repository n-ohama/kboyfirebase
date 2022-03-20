import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';

  Future<void> add() async {
    if (bookTitle == '') {
      throw ('Type something whatever you want');
    }

    FirebaseFirestore.instance.collection('books').add({
      'title': bookTitle,
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> update(String id) async {
    if (bookTitle == '') {
      throw ('Type something whatever you want');
    }

    FirebaseFirestore.instance.collection('books').doc(id).update({
      'title': bookTitle,
      'updatedAt': Timestamp.now(),
    });
  }
}
