import 'dart:async';

import 'package:my_crud/src/models/game.dart';
import 'package:my_crud/src/pages/info/info_videogame.dart';
import 'package:my_crud/src/pages/view/view_videogame.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ListViewPerson extends StatefulWidget {
  const ListViewPerson({Key? key}) : super(key: key);

  @override
  _ListViewPersonState createState() => _ListViewPersonState();
}

final gameRef = FirebaseDatabase.instance.reference().child('game');

class _ListViewPersonState extends State<ListViewPerson> {
  List<Game> items = [];
  StreamSubscription<Event>? addGames;
  StreamSubscription<Event>? changeGames;

  @override
  void initState() {
    super.initState();
    items = [];

    addGames = gameRef.onChildAdded.listen(_addGames);
    changeGames = gameRef.onChildChanged.listen(_updateGames);
  }

  @override
  void dispose() {
    super.dispose();
    addGames!.cancel();
    changeGames!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listado Agenda'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: [
                  Divider(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            '${items[position].gamename}',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            '${items[position].gamedev}',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18.0,
                            ),
                          ),
                          leading: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.amberAccent,
                                radius: 17.0,
                                child: Text(
                                  '${position + 1}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () => infoGame(context, items[position]),
                        ),
                      ),
                      IconButton(
                        // onPressed: () => _showDialog(context, position),
                        onPressed: () =>
                            _borrarGame(context, items[position], position),
                        icon: Icon(Icons.delete, color: Colors.purpleAccent),
                      ),
                      IconButton(
                        onPressed: () => _verGame(context, items[position]),
                        icon: Icon(Icons.info, color: Colors.purpleAccent),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.red[100]),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => agregarGame(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _addGames(Event event) {
    setState(() {
      items.add(Game.fromSnapShot(event.snapshot));
    });
  }

  void _updateGames(Event event) {
    var oldGame = items.singleWhere((game) => game.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldGame)] = Game.fromSnapShot(event.snapshot);
    });
  }

  void _borrarGame(BuildContext context, Game game, int position) async {
    await gameRef.child(game.id!).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void infoGame(BuildContext context, Game game) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScreenGame(game: game),
      ),
    );
  }

  void _verGame(BuildContext context, Game game) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InfoGame(game: game),
      ),
    );
  }

  void agregarGame(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScreenGame(game: Game()),
      ),
    );
  }
}
