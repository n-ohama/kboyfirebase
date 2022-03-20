import 'package:flutter/material.dart';
import 'package:kboyfirestore/book_list_model.dart';
import 'package:kboyfirestore/screens/add_book_screen.dart';
import 'package:provider/provider.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetch(),
      child: Scaffold(
          appBar: AppBar(title: Text('Book List')),
          floatingActionButton: Consumer<BookListModel>(
            builder: (_, model, __) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (_) => AddBookScreen(),
                    ),
                  );
                  model.fetch();
                },
              );
            },
          ),
          body: Consumer<BookListModel>(
            builder: (_, model, __) {
              final listTileList = model.fire
                  .map((e) => ListTile(
                        title: Text(e.title ?? 'Nothing'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => AddBookScreen(book: e)),
                            );

                            model.fetch();
                          },
                        ),
                      ))
                  .toList();
              return ListView(
                children: listTileList,
              );
            },
          )),
    );
  }
}
