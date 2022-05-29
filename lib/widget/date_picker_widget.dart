import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../globals.dart' as globals;

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);



  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();

}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime date=DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  List<bool>isSelected=[false,false,true];
  //List<bool>isSelected=[false,false,false];


 /* static String setTimeAttualestatic(){
    String data = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final ora = TimeOfDay.now().hour.toString().padLeft(2, '0');
    final minuti = TimeOfDay.now().minute.toString().padLeft(2, '0');
    globals.oradata='$ora:$minuti $data';
    return '$ora:$minuti $data';
  }*/

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(8,16,8,0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: Row(
            children: [
              Icon(
                Icons.access_time,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                " Ora e data immersione : ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                globals.oradata,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
            //crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        ToggleButtons(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Imposta data',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Imposta ora',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ora e Data attuali',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
          onPressed:(int index) {
              setState(() {
                for (int buttonIndex = 0; buttonIndex <
                    isSelected.length; buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
              switch(index){
                case 0:
                  globals.attuali=false;
                  pickDate(context);
                  break;
                case 1:
                  globals.attuali=false;
                  pickHour(context);
                  break;
                case 2:
                  globals.attuali=true;
                  setTimeAttuale();
                  break;
              }
            },
          renderBorder: false,
          isSelected :isSelected,
          fillColor:Theme.of(context).colorScheme.secondaryContainer,
        ),
      ],
      //allinea a sinistra
      //crossAxisAlignment: CrossAxisAlignment.start,

    ),
  );

  /// Trasforma la data in stringa
  String getDate() {
    return DateFormat('dd/MM/yyyy').format(date);
    // return '${date.month}/${date.day}/${date.year}';
  }

  Future pickDate(BuildContext context) async{
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate:initialDate,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month -1),
      lastDate: DateTime(DateTime.now().year,DateTime.now().month +2),
    );

    if (newDate == null) return;
    setState((){
      date = newDate;
      setOraData();
    });

  }

  Future pickHour(BuildContext context) async{

    final initialTime= TimeOfDay.now();
    final newTime =await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, childWidget){
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: childWidget!);
        }
    );
    if (newTime == null) return;
    setState((){
      time = newTime;
      setOraData();
    });
  }

  /// Trasforma il tempo in stringa
  String getTimeSelected() {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return '$hours:$minutes';
  }

  /// Imposta Data e Ora attuali
  void setTimeAttuale() {
    setState(() {
      date = DateTime.now();
      time = TimeOfDay.now();
      setOraData();
    });
  }


  /// Crea la stringa oradata
  //String setOraData(){
  void setOraData(){
    setState(() {
      String finale = getTimeSelected()+" "+getDate();
      //print(finale);
      globals.data=getDate();
      globals.ora =getTimeSelected();
      globals.oradata = finale;
    });
    /*String finale = getTimeSelected()+" "+getDate();
    //print(finale);
    globals.data=getDate();
    globals.ora =getTimeSelected();
    globals.oradata = finale;
    //return finale;*/
  }

  /*String getOraData(){
    return oradata;
  }*/

}