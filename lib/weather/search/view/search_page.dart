import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const SearchPage._(),
    );
  }

  const SearchPage._({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();
  String get _text => _textController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('City Search')),
      body: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'City',
                hintText: 'Chicago',
              ),
            ),
          )),
          IconButton(
            key: const Key('searchPage_search_iconButton'),
            onPressed: () => Navigator.of(context).pop(_text),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }
}
