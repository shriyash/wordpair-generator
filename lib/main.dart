import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    // final is similar to const in javascript, can't be reassigned
    //  you can assign a list / change the values but just can't reassign the variable
    // can be something dynamic

    // below, we generate a random wordpair using WordPair from the english words library we imported
    final wordPair = WordPair.random();

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      home: Scaffold(
        appBar: AppBar(
          title: Text('WordPair Generator')),
          body: Center(child: Text(wordPair.asPascalCase))

      )   
    );
  }
}