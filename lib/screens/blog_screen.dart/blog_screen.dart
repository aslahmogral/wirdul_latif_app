import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/api/wirdul_latif_api.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/blog_screen_model.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/webview.dart';
import 'package:wirdul_latif/widgets/firebase_analytics.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlogScreenModel(),
      child: Consumer<BlogScreenModel>(
        builder: (context, model, child) {
          dynamic blogs = WirdulLatifApi.blogs;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Blogs'),
              centerTitle: true,
            ),
            body: Center(
              child: ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebView(
                                    url: blogs[index]['url'],
                                    title: blogs[index]['title'],
                                  )));
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.arrow_right),
                        title: Text(blogs[index]['title']),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
