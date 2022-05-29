import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class StaffSettings extends StatefulWidget {
  const StaffSettings({Key? key}) : super(key: key);

  @override
  _StaffSettingsState createState() => _StaffSettingsState();
}

class _StaffSettingsState extends State<StaffSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modifica Staff")),
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

  static List<String> lista = globals.staffL;
  final textController = TextEditingController();
  String ?nuovoStaff;

  List<InputChip> crea() {
    List<InputChip> listaC = [];
    for (int i = 0; i < lista.length; i++) {
      listaC.add(InputChip(
        label: Text(lista[i]),
        onDeleted: (){
          setState(() {
            globals.staffL.removeAt(i);
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
          if(nuovoStaff!="") {
            //_lung++;
            globals.staffL.add(nuovoStaff!);
          }
        });
      },
      child: const Text("Aggiungi Staff"),
    );
  }


  Future showAlertDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Inserisci Staff"),
          content:buildText() ,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                TextButton(onPressed:(){
                  nuovoStaff="";
                  textController.clear();
                  Navigator.of(context).pop();
                }, child: const Text("Annulla")),
                TextButton(
                    onPressed: () {
                      nuovoStaff=textController.text;
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
      labelText: 'Staff',
      border: OutlineInputBorder(),
    ),
    textInputAction: TextInputAction.done,
  );

}
