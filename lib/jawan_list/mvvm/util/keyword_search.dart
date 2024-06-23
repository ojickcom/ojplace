import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class KeywordSearch extends StatefulWidget {
  const KeywordSearch({super.key});

  @override
  _KeywordSearchState createState() => _KeywordSearchState();
}

class _KeywordSearchState extends State<KeywordSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _results = [];
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(_searchController.text);
    });
  }

  void _search(String query) async {
    if (query.isEmpty) {
      setState(() {
        _results = [];
      });
      return;
    }

    final results = await FirebaseFirestore.instance
        .collection('blog')
        .where('blogTitle', isGreaterThanOrEqualTo: query)
        .where('blogTitle', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    setState(() {
      _results = results.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search keywords'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Enter keyword',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _search('');
                },
              ),
            ),
            onChanged: (text) => _onSearchChanged(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _results.isEmpty
                ? const Text('No results found')
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_results[index]['title']),
                        subtitle: Text(_results[index]['content']),
                      );
                    },
                  ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
