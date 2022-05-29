library html_converter.globals;
import 'package:flutter/material.dart';
import 'package:foglio_capitaneria/settings/preferences_service.dart';
import 'package:foglio_capitaneria/theme/theme.dart';
import 'package:intl/intl.dart';

/// Si non sapevo dell'esistenza del provider e ora non mi va di aggiornare tutto

///variabile globale oradata
bool attuali = true;
String oradata = "$ora $data";
String ora = setTimeAttuale();
String data= DateFormat('dd/MM/yyyy').format(DateTime.now());
///inizializza ora
String setTimeAttuale(){
  final ora = TimeOfDay.now().hour.toString().padLeft(2, '0');
  final minuti = TimeOfDay.now().minute.toString().padLeft(2, '0');
  return '$ora:$minuti';
}
///Luogo immersione
String luogo = "Seleziona Luogo";
String partecipanti ="Seleziona Partecipanti";
//String partecipantiMax = "12";
String partecipantiMax = "10";
String staff="Seleziona Staff";
String barca = "Seleziona Barca";
//List<String> luoghi = ["Molara","S.Stefano","Sconciglie","Mamma Bianca","Secchitella","Semaforo"];
List<String> luoghi = ["Modificami", "Nelle" ,"Impostazioni"];
//List<String> staffL =["Antonio","Ludovica","Matteo","Melissa","Vladimiro"];
List<String> staffL =["Modificami", "Nelle", "Impostazioni"];
PreferencesService preferencesService = PreferencesService();
List<String> barche=["Modificami", "Nelle", "Impostazioni"];
//String societa= "VENTOTENE DIVING ACADEMY";
String societa= "Modificami nelle impostazioni";


//controlla se tutti i campi sono inizializzati
bool luogook = false;
bool partecipantiok = false;
bool staffok = false;
bool barcaok = false;
//imposta i colori delle scritte
bool darkTheme = false;
Color onBackgroundTheme = MyThemes.lightTheme.colorScheme.onBackground;
Color luogocolore = onBackgroundTheme;
Color partecipanticolore =onBackgroundTheme ;
Color staffcolore = onBackgroundTheme;
Color barcacolore = onBackgroundTheme;




