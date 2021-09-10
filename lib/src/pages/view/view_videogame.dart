import 'package:my_crud/src/models/game.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:my_crud/src/utils/colors.dart' as utils;

class ScreenGame extends StatefulWidget {
  final Game game;
  const ScreenGame({Key? key, required this.game}) : super(key: key);

  @override
  _ScreenGameState createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame> {
  List<Game> items = [];
  TextEditingController? nameController;
  TextEditingController? devController;
  TextEditingController? priceController;
  TextEditingController? detailsController;
  TextEditingController? ageController;
  late final gameRef;

  @override
  void initState() {
    super.initState();
    gameRef = FirebaseDatabase.instance.reference().child('game');
    nameController = TextEditingController(text: widget.game.gamename);
    devController = TextEditingController(text: widget.game.gamedev);
    priceController = TextEditingController(text: widget.game.price);
    detailsController = TextEditingController(text: widget.game.details);
    ageController = TextEditingController(text: widget.game.age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videojuegos en la base de datos'),
        backgroundColor: utils.Colors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.subtitles),
                      labelText: 'Titulo del juego'),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: devController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.business_outlined),
                      labelText: 'Compañia desarrolladora'),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: priceController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.price_check), labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: detailsController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.description), labelText: 'Detalles'),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: ageController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today_sharp),
                      labelText: 'Año de lanzamiento'),
                  keyboardType: TextInputType.datetime,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextButton(
                    onPressed: () async {
                      if (widget.game.id != null) {
                        await gameRef.child(widget.game.id!).set({
                          "gamename": nameController!.text,
                          "gamedev": devController!.text,
                          "price": priceController!.text,
                          "details": detailsController!.text,
                          "age": ageController!.text,
                        }).then((_) => {Navigator.pop(context)});
                      } else {
                        await gameRef.push().set({
                          "gamename": nameController!.text,
                          "gamedev": devController!.text,
                          "price": priceController!.text,
                          "details": detailsController!.text,
                          "age": ageController!.text,
                        }).then((_) => {Navigator.pop(context)});
                      }
                    },
                    child: (widget.game.id != null)
                        ? Text('Actualizar',
                            style: TextStyle(color: utils.Colors.primaryColor))
                        : Text('Agregar',
                            style:
                                TextStyle(color: utils.Colors.primaryColor))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
