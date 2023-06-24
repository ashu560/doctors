import 'package:flutter/material.dart';

class ArticleDetailsPage extends StatelessWidget {
  final dynamic articleData;

  const ArticleDetailsPage({Key? key, required this.articleData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the articleData to display the details of the selected article
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              articleData['articleTitle'].toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16),
            Text(
              articleData['articleDescription'].toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            // Add other article details as needed
          ],
        ),
      ),
    );
  }
}
