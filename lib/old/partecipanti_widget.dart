import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class PartecipantiWidget extends StatefulWidget {

  @override
  _PartecipantiWidgetState createState() => _PartecipantiWidgetState();
}

class _PartecipantiWidgetState extends State<PartecipantiWidget> {

  @override
  void initState() {
    super.initState();
  }


  //static int _max = 12;
  //List<bool> _isSelected = List.generate(_max, (_) => false);
  int? _value;
  //bool _selectedp = false;
  //bool _selectedm = false;




  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
            children: [
              Text("Numero Partecipanti : " + globals.partecipanti,
                  style: TextStyle(
                color: globals.partecipanticolore,
                ),
              ),
          Wrap(
            spacing: 4,
                children: crea(),
              )
            ]
        ),
      );

  List<ChoiceChip> crea(){
    int _max =int.parse(globals.partecipantiMax);
    List<bool> _isSelected = List.generate(_max, (_) => false);

    List<ChoiceChip> listaC =[];
    for(int i=0; i<_max; i++){
      listaC.add(ChoiceChip(
        label: Text((i+1).toString()),
        selected: _value ==i,
        selectedColor: Colors.purple.withOpacity(0.50),
        onSelected: (bool selected){
          setState(() {
            globals.partecipanti = (i+1).toString();
            globals.partecipantiok=true;
            globals.partecipanticolore=Colors.black;
            _value=i;
          });
        },
      ));
    }

    /*listaC.add(ChoiceChip(
        label: Icon(Icons.add),
        selected: _selectedp,
        onSelected: (bool selected){
          setState(() {
            _max++;
            _isSelected.add(false);
          });
          },
    ));

    listaC.add(ChoiceChip(
        label: Icon(Icons.remove),
        onSelected:(bool selected){
          setState(() {
            _max--;
            _isSelected.removeLast();
            //_isSelected.removeAt(_isSelected.length-1);
          });
        },
        selected: _selectedm));*/
    return listaC;
  }

}