import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database_demo/news.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<News> _list = [];

  @override
  void initState() {
    _initialNewsList();
    super.initState();
  }

  _initialNewsList() {
    _list = [];

    final collectionRef = _db.collection("news");
    collectionRef.orderBy("title", descending: true).get().then((querySnapshot) {
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> snapshot = docSnapshot.data() as Map<String, dynamic>;
        final News news = News(title: snapshot["title"] ?? "", context: snapshot["content"]);
        setState(() {
          _list.add(news);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: "標題"),
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(hintText: "內容"),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _createPost();
                },
                child: const Text("新增"),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("新聞列表"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_list[index].title),
                    subtitle: Text(_list[index].context),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: _list.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createPost() {
    // 新增一筆資料
    if (_titleController.text.isEmpty && _contentController.text.isEmpty) {
      return;
    }
    final News news = News(title: _titleController.text, context: _contentController.text);
    final collectionRef = _db.collection("news");
    int id = _list.length + 1;
    collectionRef.doc(id.toString()).set({"title": news.title, "content": news.context}).then((value) {
      setState(() {
        _list.insert(0, news);
      });
    }).catchError((error) {
      print(error.toString());
    });
  }
}
