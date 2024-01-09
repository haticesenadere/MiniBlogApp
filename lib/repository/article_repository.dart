import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart ' as http;

class ArtcileRepository {
  Future<List<Blog>> fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url); //asycn bir işlem
    final List jsonData = json
        .decode(response.body); //gelen  cevabon body'sini jsona çeviriyoruz.

    return jsonData.map((json) => Blog.fromJson(json)).toList();
  }

  fetchBlogDetay(String blogID) {}
}

Future<Blog> fetchBlogDetay(
  String blogId,
) async {
  Uri url =

      // ignore: unnecessary_brace_in_string_interps
      Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/${blogId}");
  final response = await http.get(url);
  final jsonData = json.decode(response.body);

  return Blog.fromJson(jsonData);
}

submitForm(Blog blogAdd, BuildContext context) async {
  Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
  var request = http.MultipartRequest("POST", url);

  if (blogAdd.thumbnail != null) {
    request.files.add(await http.MultipartFile.fromPath(
        "File", blogAdd.thumbnail!.toString()));
  }

  request.fields['Title'] = blogAdd.title.toString();
  request.fields['Content'] = blogAdd.content.toString();
  request.fields['Author'] = blogAdd.author.toString();

  final response = await request.send();

  if (response.statusCode == 201) {
    Navigator.pop(context, true);
  }
}
