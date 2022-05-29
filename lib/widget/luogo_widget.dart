import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class LuogoWidget extends StatefulWidget {
  const LuogoWidget({Key? key}) : super(key: key);


  @override
  _LuogoWidgetState createState() => _LuogoWidgetState();


}


class _LuogoWidgetState extends State<LuogoWidget> {

  @override
  void initState() {
    super.initState();
  }

  final textController = TextEditingController();
  String ?nuovoLuogo;
  static List<String> lista = globals.luoghi;
  int? _value;

  @override
  Widget build(BuildContext context) =>Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primary,
                //size: 30,
              ),
              Text(
                  " Luogo Immersione",
                  style: TextStyle(
                    color: globals.luogocolore,
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

  List<ChoiceChip> crea()  {
    lista=globals.luoghi;
    List<ChoiceChip> listaC = [];
    for (int i = 0; i < lista.length; i++) {
      listaC.add(ChoiceChip(
        label: Text(lista[i]),
        onSelected: (bool selected) {
          setState(() {
            globals.luogo = lista[i];
            globals.luogook=true;
            globals.luogocolore=Theme.of(context).colorScheme.onBackground;
            _value=i;
          });
        }, selected: _value == i,
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
        ),
      ));
    }
    return listaC;
  }

}