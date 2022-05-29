import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class LuoghiSettings extends StatefulWidget {
  const LuoghiSettings({Key? key}) : super(key: key);

  @override
  _LuoghiSettingsState createState() => _LuoghiSettingsState();
}

class _LuoghiSettingsState extends State<LuoghiSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aggiungi punto d'immersione")),
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
  static List<String> lista = globals.luoghi;
  //List<bool> _isSelected = List.generate(lista.length, (_) => false);
  final textController = TextEditingController();
  String ?nuovoLuogo;




  List<InputChip> crea() {
    //List<bool> _isSelected = List.generate(lista.length, (_) => false);
    List<InputChip> listaC = [];
    for (int i = 0; i < lista.length; i++) {
      listaC.add(InputChip(
        label: Text(lista[i]),
        onDeleted: (){
          setState(() {
            globals.luoghi.removeAt(i);
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
            if(nuovoLuogo!="") {
              //_lung++;
              globals.luoghi.add(nuovoLuogo!);
            }
          });
        },
        child: const Text("Aggiungi Luogo"),
    );
  }


  Future showAlertDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Inserisci Luogo"),
          content:buildText() ,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                TextButton(onPressed:(){
                  nuovoLuogo="";
                  textController.clear();
                  Navigator.of(context).pop();
                }, child: const Text("Annulla")),
                TextButton(
                    onPressed: () {
                      nuovoLuogo=textController.text;
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
      labelText: 'Luogo',
      border: OutlineInputBorder(),
    ),
    textInputAction: TextInputAction.done,
  );


}
