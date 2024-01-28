import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> articles;

  SearchScreen({required this.articles});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> getSearchResults(String query) {
  return widget.articles
      .where((article) {
        final title = article['title']?.toString() ?? '';

        return title.toLowerCase().contains(query.toLowerCase());
      })
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for news...',
              ),
              onChanged: (query) {
                setState(() {
                });
              },
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
              itemCount: getSearchResults(_searchController.text).length,
                itemBuilder: (context, index) {
                  final searchResults = getSearchResults(_searchController.text);

                  return  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                    title: Text(searchResults[index]['title'] ?? ''),
                    subtitle: Text(searchResults[index]['description']?.toString() ?? ''),
                    ),
                    // Add any other details or widgets you want to display for each search result
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 82, 235, 110),
    );
  }
}
