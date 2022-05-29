import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class BarcaWidget extends StatefulWidget {
  const BarcaWidget({Key? key}) : super(key: key);


  @override
  _BarcaWidgetState createState() => _BarcaWidgetState();
}

class _BarcaWidgetState extends State<BarcaWidget> {

  @override
  void initState() {
    super.initState();
    //caricaLista();
  }

  final textController = TextEditingController();
  String ?nuovaBarca;
  static List<String> lista = globals.barche;
  bool _selectedp = false;
  bool _selectedm = false;
  int? _value;


  @override
  Widget build(BuildContext context) =>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
        children: [
          Text("Barca: "+globals.barca,
          style: TextStyle(color: globals.barcacolore),),
          Wrap(
            spacing: 8,
            children: crea(),
          )
        ]
    ),
  );



  List<ChoiceChip> crea() {
    lista=globals.barche;
    List<bool> _isSelected = List.generate(lista.length, (_) => false);
    List<ChoiceChip> listaC = [];
    for (int i = 0; i < lista.length; i++) {
      listaC.add(ChoiceChip(
        label: Text(lista[i]),
        onSelected: (bool selected) {
          setState(() {
            globals.barca = lista[i];
            globals.barcaok=true;
            globals.barcacolore=Colors.black;
            _value=i;
          });
          print(lista[i]);
        }, selected: _value == i,
        selectedColor: Colors.purple.withOpacity(0.50),
      ));
    }


    /*listaC.add(ChoiceChip(
      label: const Icon(Icons.add),
      onSelected: (bool selected) async {
        await showAlertDialog(context);
        setState(() {
          if(nuovaBarca!=""){
            _lung++;
            lista.add(nuovaBarca!);
            _isSelected.add(false);
          }
        });
        SharedPreferencesManager.save("barca",lista);
      }, selected: _selectedp,
    ));

    listaC.add(ChoiceChip(
        label: const Icon(Icons.remove),
        onSelected:(bool selected){
          setState(() {
            lista.removeAt(lista.length-1);
            _lung--;
            _isSelected.removeAt(_isSelected.length-1);
          });
          SharedPreferencesManager.save("barca",lista);
        },
        selected: _selectedm));*/

    return listaC;
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
                }, child: Text("Annulla")),
                TextButton(
                    onPressed: () {
                      nuovaBarca=textController.text;
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
      labelText: 'Barca',
      border: OutlineInputBorder(),
    ),
    textInputAction: TextInputAction.done,
  );







}
