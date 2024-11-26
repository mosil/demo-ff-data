import 'package:firebase_database_demo/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _version = "0.0.1";

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _version = remoteConfig.getString("version");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Flutter x Firebase",
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: [
                Text("版本： $_version"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text("共 $_counter 瀏覽次數"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _increaseCounter();
        },
        child: Text("自主\n增加"),
      ),
    );
  }

  _increaseCounter() {
    setState(() {
      _counter++;
    });
  }
}
