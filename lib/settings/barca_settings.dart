import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class BarcaSettings extends StatefulWidget {
  const BarcaSettings({Key? key}) : super(key: key);

  @override
  _BarcaSettingsState createState() => _BarcaSettingsState();
}

class _BarcaSettingsState extends State<BarcaSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modifica Barche")),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 30.0),
              child: Wrap(
                  spacing: 8.0,
                  children: crea()
              ),
            ),
          ),
          aggiungi(),
        ],
      ),
    );
  }

  static List<String> lista = globals.barche;
  final textController = TextEditingController();
  String ?nuovaBarca;

  List<InputChip> crea() {
    List<InputChip> listaC = [];
    for (int i = 0; i < lista.length; i++) {
      listaC.add(InputChip(
        label: Text(lista[i]),
        onDeleted: (){
          setState(() {
            globals.barche.removeAt(i);
          });
        },
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: StadiumBorder(
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
      ));
    }
    return listaC;
  }

  ElevatedButton aggiungi() {
    return ElevatedButton(
      onPressed: () async{
        await showAlertDialog(context);
        setState(() {
          if(nuovaBarca!="") {
            globals.barche.add(nuovaBarca!);
          }
        });
      },
      child: const Text("Aggiungi Barca"),
    );
  }


  Future showAlertDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Inserisci Barca"),
          content:buildText() ,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                TextButton(onPressed:(){
                  nuovaBarca="";
                  textController.clear();
                  Navigator.of(context).pop();
                }, child: const Text("Annulla")),
                TextButton(
                    onPressed: () {
                      nuovaBarca=textController.text;
                      textController.clear();
                      Navigator.of(context).pop();
                    }, child: const Text("Inserisci")),
              ],
            )
          ],
        );
      }
  );


  Widget buildText() => TextField(

    controller: textController,
    decoration: const InputDecoration(
      labelText: 'Barca',
      border: OutlineInputBorder(),
    ),
    textInputAction: TextInputAction.done,
  );


}
