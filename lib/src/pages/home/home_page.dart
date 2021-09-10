import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';

import 'package:my_crud/src/models/game.dart';
import 'package:my_crud/src/pages/info/info_videogame.dart';
import 'package:my_crud/src/pages/view/view_videogame.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_crud/src/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Game> items = [];
  StreamSubscription<Event>? addGames;
  StreamSubscription<Event>? changeGames;
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = new AuthProvider();
    items = [];

    addGames = gameRef.onChildAdded.listen(_addGames);
    changeGames = gameRef.onChildChanged.listen(_updateGames);
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      checkIfUserIsAuth(context);
    });
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
          actions: [
            GestureDetector(
              onTap: () async {
                await _authProvider.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false);
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.logout),
              ),
            )
          ],
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
                        child: Dismissible(
                          key: Key(items[position].id!),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (_) =>
                              _borrarGame(context, items[position], position),
                          background: Container(
                              padding: EdgeInsets.only(left: 8.0),
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Eliminar juego',
                                    style: TextStyle(color: Colors.white)),
                              )),
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
                            onTap: () => _verGame(context, items[position]),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => infoGame(context, items[position]),
                        icon: Icon(Icons.edit_rounded,
                            color: Colors.purpleAccent),
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

  void checkIfUserIsAuth(BuildContext context) {
    bool isSigned = _authProvider.isSignedIn();
    if (isSigned) {
      print('esta loggueado');
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }
  }
}
