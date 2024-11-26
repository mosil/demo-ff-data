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

  List<News> _list = [];

  @override
  void initState() {
    _initialNewsList();
    super.initState();
  }

  _initialNewsList() {
    _list = [];
    for (int i = 0; i < 10; i++) {
      setState(() {
        _list.add(News(title: "title$i", context: "context$i"));
      });
    }
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
  }
}
