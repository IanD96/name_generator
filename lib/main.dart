import 'package:flutter/material.dart';
import 'names.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Name Generator',
      home: new RandomNames(),
      theme: new ThemeData(
        primaryColor: Colors.green,
      )
    );
  }
}

// creates its State class, RandomNameState. The State class will eventually
// maintain the proposed and favorite names for the widget.
class RandomNames extends StatefulWidget {
  @override
  createState() => new RandomNamesState();
}

// This class will save the generated names, which grow infinitely as the
// user scrolls, and also favorite names, as the user adds or removes them
// from the list by toggling the heart icon.
class RandomNamesState extends State<RandomNames> {
  final _suggestions = <Names>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<Names>();

  void _pushedSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (name) {
              return new ListTile(
                title: new Text(
                  name.asString,
                  style: _biggerFont,
                ),
              );
            }
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
              centerTitle: true,
            ),
          body: new ListView(children: divided),
          );
        }
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name Generator'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushedSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  // This method builds the ListView that displays the suggested names.
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // The itemBuilder callback is called once per suggested names,
      // and places each suggestion into a ListTile row.
      // For even rows, the function adds a ListTile row for the names.
      // For odd rows, the function adds a Divider widget to visually
      // separate the entries. Note that the divider may be difficult
      // to see on smaller devices.
      itemBuilder: (context, i) {
        // Add a one-pixel-high divider widget before each row in theListView.
        if (i.isOdd) return new Divider();

        // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of names in the ListView,
        // minus the divider widgets.
        final index = i ~/ 2;
        // If you've reached the end of the available names...
        if (index >= _suggestions.length) {
          // ...then generate 10 more and add them to the suggestions list.
          _suggestions.addAll(generateNames().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  // This function displays each new name in a ListTile, which allows you to
  // make the rows more attractive in the next step.
  Widget _buildRow(Names name) {
    final alreadySaved = _saved.contains(name);
    
    return new ListTile(
      title: new Text(
        name.asString,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
           if (alreadySaved) {
             _saved.remove(name);
           } else {
             _saved.add(name);
           }       
        });
      },
    );
  }
}