import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class StaffWidget extends StatefulWidget {

  @override
  _StaffWidgetState createState() => _StaffWidgetState();
}

class _StaffWidgetState extends State<StaffWidget> {

  @override
  void initState() {
    super.initState();
  }

  final textController = TextEditingController();
  String _staff="Inserisci Staff";
  List _staffL=[];
  static List<String> lista = globals.staffL;
  List<bool> _isSelected = List.generate(lista.length, (_) => false);
  String ?nuovoNome;
  String stampa="";


  @override
  Widget build(BuildContext context) =>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
        children: [

            Text("Staff : " +(globals.staff == "" ? "Seleziona Staff" : globals.staff),
              style: TextStyle(color: globals.staffcolore),),
            Wrap(
              spacing: 8,
              children: crea(),
            )

        ]
    ),
  );

  List<FilterChip> crea(){
    lista=globals.staffL;
    for(int i=0; i<lista.length-_isSelected.length;i++){
      _isSelected.add(false);
    }
    //_isSelected = List.generate(lista.length, (_) => false);
    List<FilterChip> listaC = [];
    for (int i = 0; i < lista.length; i++){
      listaC.add(FilterChip(
          label: Text(lista[i]),
          selected: _isSelected[i],
          selectedColor: Colors.purple.withOpacity(0.50),
          onSelected: (bool selected){
            setState(() {
              _isSelected[i]=selected;
              if(_staffL.contains(lista[i])){
                _staffL.remove(lista[i]);
              }else{
                _staffL.add(lista[i]);
              }
              _staff=_staffL.join(" - ");
              globals.staff=_staff;
              globals.staffok=true;
              globals.staffcolore=Colors.black;
              if(globals.staff == ""){
                globals.staffok=false;
                globals.staffcolore=Colors.red;
              };

            });
          }
      ));
    }
    return listaC;
  }

  /*Future showAlertDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Inserisci Nome"),
          content:buildText() ,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed:(){
                  nuovoNome="";
                  textController.clear();
                  Navigator.of(context).pop();
                }, child: Text("Annulla")),
                TextButton(
                    onPressed: () {
                      nuovoNome=textController.text;
                      textController.clear();
                      Navigator.of(context).pop();
                    }, child: Text("Inserisci")),
              ],
            )
          ],
        );
      }
  );

  Widget buildText() => TextField(
    controller: textController,
    decoration: const InputDecoration(
      labelText: 'Nome',
      border: OutlineInputBorder(),
    ),
    textInputAction: TextInputAction.done,
  );*/






}
