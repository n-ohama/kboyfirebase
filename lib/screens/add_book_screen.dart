import 'package:flutter/material.dart';
import 'package:kboyfirestore/add_book_model.dart';
import 'package:provider/provider.dart';

import '../common/book.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({Key? key, this.book}) : super(key: key);
  final Book? book;

  @override
  Widget build(BuildContext context) {
    final isUpdate = book != null;
    TextEditingController txtController = TextEditingController();
    txtController.text = isUpdate ? book!.title! : '';

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(title: Text(isUpdate ? 'UPDATE' : 'ADD')),
        body: Consumer<AddBookModel>(
          builder: (_, model, __) => Column(
            children: [
              TextField(
                controller: txtController,
                onChanged: (text) {
                  model.bookTitle = text;
                },
              ),
              ElevatedButton(
                child: Text('Save Text'),
                onPressed: () async {
                  try {
                    if (isUpdate) {
                      await model.update(book!.id!);
                    } else {
                      await model.add();
                    }

                    await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Success'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                          ),
                        ],
                      ),
                    );

                    Navigator.of(context).pop();
                  } catch (err) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(err.toString()),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
