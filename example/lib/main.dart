import 'package:flutter/material.dart';
import 'package:stringr/stringr.dart';

void main() {
  runApp(MyApp());
}

/// Example app for Stringr
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stringr Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _MyHomePage(title: 'Stringr Demo Home Page'),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  _MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          cardWidget(
              "camelCase", "XMLHttpRequest", "XMLHttpRequest".camelCase()),
          cardWidget("camelCase", "/home/Kb/code/stringr",
              "/home/Kb/code/stringr".camelCase()),
          cardWidget('capitalize', 'яблоко', 'яблоко'.capitalize()),
          cardWidget("codePointAt", "\uD835\uDC00\uD835\uDC01",
              "\uD835\uDC00\uD835\uDC01".codePointAt(2).toString()),
          cardWidget(
              "graphemeAt",
              "foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar\uD834\uDF06\u0303\u035C\u035D",
              "foo\uD834\uDF06\u0303\u035C\u035D\u035Ebar\uD834\uDF06\u0303\u035C\u035D"
                  .graphemeAt(3)),
          cardWidget("prune", "Привет как дела", "Привет как дела".prune(10)),
          cardWidget("prune", "La variété la plus fréquente est la blanche",
              "La variété la plus fréquente est la blanche".prune(12)),
          cardWidget("truncate", "Is this where you wanna go",
              "Is this where you wanna go".truncate(10)),
        ],
      ),
    );
  }

  Widget cardWidget(String libFunc, String input, String output) => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Function - $libFunc"),
            Text("Input - $input"),
            Text("Output - $output")
          ],
        ),
      );
}
