import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


// this overrides createState so we need to extend Stateful Widget
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

final _randomWordPairs = <WordPair>[];

final _savedWordPairs = Set<WordPair>();


  Widget _buildList() {


    // a set is a collection of objects where each 
    // object can appear once

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

    final alreadySaved = _savedWordPairs.contains(pair);


    return ListTile(title: Text(pair.asPascalCase, style:
      TextStyle(fontSize: 18.0)),
      trailing: Icon(alreadySaved ? Icons.favorite : 
        Icons.favorite_border, 
          color: alreadySaved ? Colors.red : null),
          onTap: () {
            setState(() {
              if(alreadySaved){
                _savedWordPairs.remove(pair);
              } else {
                _savedWordPairs.add(pair);
              }

            });
          }
      );
  }

  // When we tap the icon in the top right it will call this function
  // we can use the navigator class to add a route 
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = 
          _savedWordPairs.map((WordPair pair){
            return ListTile(
              title: Text(pair.asPascalCase, style: TextStyle
              (fontSize: 16.0)));
          });

          final List<Widget> divided = ListTile.divideTiles(context: context,
          tiles: tiles
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved WordPairs')
            ),
            body: ListView(children: divided)
          );

        }
        
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list),
          onPressed: _pushSaved
          )
        ]
        ),
      body: _buildList());
  }
}