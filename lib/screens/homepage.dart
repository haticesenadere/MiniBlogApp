import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/screens/blog_detail.dart';
import 'package:miniblog/widgets/blog_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Blog> blogs = [];
  @override
  void initState() {
    // verileri getirmek için
    super.initState();
    fetchBlogs();
  }

  fetchBlogs() async {
    //backend'e istek aıyorum
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url); //asycn bir işlem
    final List jsonData = json
        .decode(response.body); //gelen  cevabon body'sini jsona çeviriyoruz.

    setState(() {
      blogs = jsonData.map((json) => Blog.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrangeAccent]),
          ),
        ),
        title: const Text(
          "Blog",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () async {
                bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddBlog()));
                if (result == true) {
                  fetchBlogs();
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: blogs.isEmpty //liste eğer  boşsa bekle,
          ? const Center(
              child: CircularProgressIndicator(), //yükleme efekti
            )
          : RefreshIndicator(
              //yeni veriler yüklememizi sağlıyyor.
              onRefresh: () async {
                fetchBlogs();
              },
              child: ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (blogs[index].id != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlogDetail(blogId: blogs[index].id!),
                          ),
                        );
                      }
                    },
                    child: BlogItem(blog: blogs[index])),
              )),
    );
  }
}
