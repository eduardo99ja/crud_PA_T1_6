import 'package:my_crud/src/models/game.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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
        backgroundColor: Colors.green[100],
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
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: devController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: priceController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: detailsController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 8.0)),
                Divider(),
                TextField(
                  controller: ageController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                  keyboardType: TextInputType.text,
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
                        ? Text('Actualizar')
                        : Text('Agregar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
