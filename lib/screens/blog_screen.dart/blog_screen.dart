import 'package:flutter/material.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/webview.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewExample()));
              },
              child: Card(
                child: ListTile(
                  title: Text('Blog Post ${index + 1}'),
                  subtitle: Text('This is a blog post'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
