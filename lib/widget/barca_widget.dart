import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../theme/theme.dart';


class BarcaWidget extends StatefulWidget {
  const BarcaWidget({Key? key}) : super(key: key);


  @override
  _BarcaWidgetState createState() => _BarcaWidgetState();
}

class _BarcaWidgetState extends State<BarcaWidget> {

  @override
  void initState() {
    super.initState();
  }

  final textController = TextEditingController();
  String ?nuovaBarca;
  static List<String> lista = globals.barche;
  int? _value;


  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Row(
              children: [
                Icon(
                  Icons.directions_boat,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  " Barca",
                  style: TextStyle(
                    color: globals.barcacolore,
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
  }



  List<ChoiceChip> crea() {
    lista=globals.barche;
    List<ChoiceChip> listaC = [];
    for (int i = 0; i < lista.length; i++) {
      listaC.add(ChoiceChip(
        label: Text(lista[i]),
        onSelected: (bool selected) {
          setState(() {
            globals.barca = lista[i];
            globals.barcaok=true;
            globals.barcacolore=Theme.of(context).colorScheme.onBackground;
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
          color: _value==i ? Theme.of(context).colorScheme.onSecondaryContainer
              : Theme.of(context).colorScheme.secondary,

        ),
      ));
    }
    return listaC;
  }
}
