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
    // final wordPair = WordPair.random();

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      home: RandomWords()   
    );
  }
}

// this overrides createState so we need to extend Stateful Widget
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  Widget _buildList() {

    final _randomWordPairs = <WordPair>[];

    // a ListView is one of the most common scrolling widgets
    // this is the basic layout, from documentation here:
    // https://api.flutter.dev/flutter/widgets/ListView-class.html
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, item) {
        if(item.isOdd) return Divider();

        final index = item ~/ 2;

        if(index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]); 
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(title: Text(pair.asPascalCase, style:
      TextStyle(fontSize: 18.0)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WordPair Generator')),
      body: _buildList());
  }
}