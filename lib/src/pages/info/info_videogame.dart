import 'package:my_crud/src/models/game.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:my_crud/src/utils/colors.dart' as utils;

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
        backgroundColor: utils.Colors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 400.0,
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Center(
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Titulo del juego:\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '${widget.game.gamename}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Compañia desarrolladora:\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '${widget.game.gamedev}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Precio:\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '${widget.game.price}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Detalles:\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '${widget.game.details}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Año de lanzamiento:\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '${widget.game.age}',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
