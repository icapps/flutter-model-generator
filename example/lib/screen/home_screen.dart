import 'package:drift/drift.dart' hide Column;
import 'package:drift/native.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:model_generator_example/database/model_generator_example_database.dart';
import 'package:model_generator_example/database/tables/book/book_dao_storage.dart';
import 'package:model_generator_example/model/book/book.dart';
import 'package:model_generator_example/util/book_util.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ModelGeneratorExampleDatabase _database;
  late final BookDaoStorage _daoStorage;

  @override
  void initState() {
    super.initState();
    _database = ModelGeneratorExampleDatabase(DatabaseConnection(NativeDatabase.memory()));
    _daoStorage = BookDaoStorage(_database);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DriftDbViewer(_database))),
            child: const Text('Show Database'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder(
              stream: _daoStorage.getAllBooksStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData && !snapshot.hasError) {
                  return const Center(child: Text('Loading...'));
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                final data = snapshot.data as List<Book>;
                return ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (context, index) => BookWidget(book: data[index]),
                  separatorBuilder: (context, index) => const Divider(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _daoStorage.createBook(BookUtil.getBook()),
      ),
    );
  }
}

class BookWidget extends StatelessWidget {
  final Book book;

  const BookWidget({
    required this.book,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(book.name),
        Text('author: ${book.author.firstName} ${book.author.lastName}'),
        Text('publisher: ${book.publisher?.firstName} ${book.publisher?.lastName}'),
        Text('category: ${book.category.jsonValue}'),
        const Text('editors:'),
        ...book.editors.map((translator) => Text('${translator.firstName} ${translator.lastName}')),
        const Text('translators:'),
        ...?book.translators?.map((translator) => Text('${translator.firstName} ${translator.lastName}')),
        const SizedBox(height: 8),
      ],
    );
  }
}
