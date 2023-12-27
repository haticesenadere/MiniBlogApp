import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/blog.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({Key? key, required this.blogId}) : super(key: key);

  final String blogId;

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late Map<String, dynamic> blogDetay = {};
  late Blog blogItem;

  @override
  void initState() {
    super.initState();
    fetchBlogDetay();
  }

  fetchBlogDetay() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        blogDetay = jsonData;

        blogItem = Blog.fromJson(blogDetay);
      });
    }
  }

// ... (your existing code)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blog İçeriği",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrangeAccent]),
          ),
        ),
      ),
      body: blogDetay == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          blogItem.thumbnail!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      blogItem.title ?? "",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      children: [
                        Text(
                          "${blogItem.author ?? " "}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " ${blogItem.content ?? ""}",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
