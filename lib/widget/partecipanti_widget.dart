import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class PartecipantiWidget extends StatefulWidget {
  const PartecipantiWidget({Key? key}) : super(key: key);


  @override
  _PartecipantiWidgetState createState() => _PartecipantiWidgetState();
}

class _PartecipantiWidgetState extends State<PartecipantiWidget> {

  @override
  void initState() {
    super.initState();
  }

  int? _value;

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(" Numero Partecipanti",
                        style: TextStyle(
                          color: globals.partecipanticolore,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
          Wrap(
            spacing: 4,
                children: crea(),
              )
            ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );

  List<ChoiceChip> crea(){
    int _max =int.parse(globals.partecipantiMax);
    List<ChoiceChip> listaC =[];
    for(int i=0; i<_max; i++){
      listaC.add(ChoiceChip(
        label: Text((i+1).toString()),
        selected: _value ==i,
        onSelected: (bool selected){
          setState(() {
            globals.partecipanti = (i+1).toString();
            globals.partecipantiok=true;
            globals.partecipanticolore=Theme.of(context).colorScheme.onBackground;
            _value=i;
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
            color: _value==i ? Theme.of(context).colorScheme.onSecondaryContainer : Theme.of(context).colorScheme.secondary,
      )));
    }
    return listaC;
  }

}