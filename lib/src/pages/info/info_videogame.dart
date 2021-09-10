import 'package:my_crud/src/models/game.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InfoGame extends StatefulWidget {
  final Game game;

  InfoGame({Key? key, required this.game}) : super(key: key);

  @override
  _InfoGameState createState() => _InfoGameState();
}

final gameRef = FirebaseDatabase.instance.reference().child('game');

class _InfoGameState extends State<InfoGame> {
  List<Game>? items;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Informacion Game'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        height: 400.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Titulo del juego: ${widget.game.gamename}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                Text(
                  'Compañia desarrolladora: ${widget.game.gamedev}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                Text(
                  'Precio: ${widget.game.price}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                Text(
                  'Detalles: ${widget.game.details}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                Text(
                  'Año de lanzamiento: ${widget.game.age}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
