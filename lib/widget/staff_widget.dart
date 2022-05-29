import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class StaffWidget extends StatefulWidget {
  const StaffWidget({Key? key}) : super(key: key);


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
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: Column(
        children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Row(
                children: [
                  Icon(
                    Icons.handyman,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(" Staff" ,
                    style: TextStyle(
                      color: globals.staffcolore,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 8,
              children: crea(),
            )
        ],
      crossAxisAlignment: CrossAxisAlignment.start,

    ),
  );

  List<FilterChip> crea(){
    lista=globals.staffL;
    for(int i=0; i<lista.length-_isSelected.length;i++){
      _isSelected.add(false);
    }
    List<FilterChip> listaC = [];
    for (int i = 0; i < lista.length; i++){
      listaC.add(FilterChip(
          label: Text(lista[i]),
          selected: _isSelected[i],
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
              globals.staffcolore=Theme.of(context).colorScheme.onBackground;
              if(globals.staff == ""){
                globals.staffok=false;
                globals.staffcolore=Theme.of(context).colorScheme.error;
              }
            });
          },
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedColor: Theme.of(context).colorScheme.secondaryContainer,
          shape: StadiumBorder(
              side: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.secondary,
              )
          ),
          labelStyle: TextStyle(
            color: _isSelected[i] ? Theme.of(context).colorScheme.onSecondaryContainer
                : Theme.of(context).colorScheme.secondary,
        ),
      ));
    }
    return listaC;
  }

}
