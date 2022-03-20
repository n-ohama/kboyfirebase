import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'common/book.dart';

class BookListModel extends ChangeNotifier {
  List<Book> fire = [];

  Future<void> fetch() async {
    final list = await FirebaseFirestore.instance.collection('books').get();
    final bookList = list.docs.map((e) => Book(e)).toList();

    fire = bookList;
    notifyListeners();
  }
}
