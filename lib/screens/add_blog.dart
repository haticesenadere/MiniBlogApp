import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/blocs/article%20blocs/article_bloc.dart';
import 'package:miniblog/blocs/detail_bloc/article_detail_event.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/repository/article_repository.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  String title = "";
  String content = '';
  String author = '';

  openImagePicker() async {
    XFile? selectedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = selectedFile;
    });
  }

  /* submitForm() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    if (selectedImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath("File", selectedImage!.path));
    }

    request.fields['Title'] = title;
    request.fields['Content'] = content;
    request.fields['Author'] = author;

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 230, 197),
        title: const Text("Blog Ekle",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        key: _formKey,
        child: Form(
          key: _formKey,
          child: ListView(children: [
            if (selectedImage != null)
              Image.file(
                File(selectedImage!.path),
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ElevatedButton(
              onPressed: () {
                openImagePicker();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(232, 189, 111, 0.612),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                "Resim Seç",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 252, 225, 183), width: 5),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 188, 135, 56))),
                labelText: "Başlık",
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 210, 142, 23),
                ),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen Başlık Giriniz";
                }
                return null;
              },
              onSaved: (newValue) => title = newValue!,
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 252, 225, 183), width: 5),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 188, 135, 56))),
                labelText: "Blog İçeriği",
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 210, 142, 23),
                ),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen İçerik Giriniz";
                }
                return null;
              },
              onSaved: (newValue) => content = newValue!,
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 252, 225, 183), width: 5),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.orange)),
                labelText: "Ad Soyad",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 210, 142, 23),
                ),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen Ad Soyad Giriniz";
                }
                return null;
              },
              onSaved: (newValue) => author = newValue!,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(232, 189, 111, 0.612),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (selectedImage == null) {
                    return;
                  }
                  _formKey.currentState!.save();

                  context
                      .read<ArticleBloc>()
                      .add(ArticleAdd(blogadd: Blog(), context: context));
                }
              },
              child: const Text("Gönder",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ]),
        ),
      ),
    );
  }
}
