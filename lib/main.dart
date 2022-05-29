import 'package:flutter/material.dart';
import 'package:foglio_capitaneria/settings/preferences_service.dart';
import 'package:foglio_capitaneria/settings/settings_page.dart';
import 'package:foglio_capitaneria/theme/theme.dart';
import 'package:foglio_capitaneria/widget/date_picker_widget.dart';
import 'package:foglio_capitaneria/widget/luogo_widget.dart';
import 'package:foglio_capitaneria/widget/partecipanti_widget.dart';
import 'package:foglio_capitaneria/widget/staff_widget.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'settings/settings.dart';
import 'widget/barca_widget.dart';
import 'globals.dart' as globals;
import 'htmlconverter.dart';
//import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///pulire shared preferences
  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*theme: ThemeData(
        //primarySwatch: Colors.purple,
        //material design 3 ancora non supportato completamente
        useMaterial3: true,
        colorScheme: lightColorScheme,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: lightColorScheme.primary
        )
      ),*/
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      //darktheme brutto + problema cambio colore scritte
      //darkTheme: MyThemes.darkTheme,
      title: "Foglio Capitaneria" ,
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  final _preferencesService = PreferencesService();

  @override
  Widget build(BuildContext context) {
    globals.onBackgroundTheme = MediaQuery.of(context).platformBrightness==Brightness.light
        ? MyThemes.lightTheme.colorScheme.onBackground//lightColorScheme.onBackground
        : MyThemes.darkTheme.colorScheme.onBackground;//darkColorScheme.onBackground;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: const Text('Foglio Capitaneria'),
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => onSelectedPopupMenu(context, item),
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: const [
                            Icon(Icons.settings),
                            SizedBox(width: 8),
                            Text("Impostazioni"),
                          ],
                        )),
                  ])
        ],
      ),
      //SingleChildScrollView per renderlo scrollable
      body: SingleChildScrollView(
        child: Column(
          children: [
            //luogo,
            //if(firstTime)showDialog();
            DatePickerWidget(),
            LuogoWidget(),
            PartecipantiWidget(),
            StaffWidget(),
            BarcaWidget(),
          ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          if (globals.luogo == "Seleziona Luogo" || !globals.luogook) {
            globals.luogook=false;
            setState(() {
              globals.luogocolore=Theme.of(context).colorScheme.error;
            });
            print("LUOGO NON SELEZIONATO ERRORE");
          }
          if (globals.partecipanti == "Seleziona Partecipanti" || !globals.partecipantiok) {
            globals.partecipantiok=false;
            setState(() {
              globals.partecipanticolore=Theme.of(context).colorScheme.error;
            });
            print("PARTECIPANTI NON SELEZIONATO ERRORE");
          }
          if (globals.staff == "Seleziona Staff" || !globals.staffok ) {
            globals.staffok=false;
            setState(() {
              globals.staffcolore=Theme.of(context).colorScheme.error;
            });
            print("STAFF NON SELEZIONATO ERRORE");

          }
          if (globals.barca == "Seleziona Barca" || !globals.barcaok) {
            globals.barcaok=false;
            setState(() {
              globals.barcacolore=Theme.of(context).colorScheme.error;
            });
            print("BARCA NON SELEZIONATO ERRORE");
          }
          //se un campo non è selezionato non crea il pdf
          if(globals.luogook && globals.partecipantiok && globals.staffok && globals.barcaok) {
            final pdfFile = await HtmlConverter.generate(
                globals.societa,
                setOradata(),
                globals.luogo,
                globals.partecipanti,
                globals.staff,
                globals.barca,
                setDataAttuale(),
                setTimeAttuale());
            await OpenFile.open(pdfFile.path);
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }

  static String setDataAttuale() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  ///inizializza ora
  static String setTimeAttuale() {
    final ora = TimeOfDay.now().hour.toString().padLeft(2, '0');
    final minuti = TimeOfDay.now().minute.toString().padLeft(2, '0');
    return '$ora:$minuti';
  }

  static String setOradata() {
    if (globals.attuali) {
      return setTimeAttuale() + " " + setDataAttuale();
    } else {
      return globals.oradata;
    }
  }

  void saveSettings() {
    final settings = Settings(
        societa: globals.societa,
        luoghi: globals.luoghi,
        partecipantiMax: globals.partecipantiMax,
        staffL: globals.staffL,
        barche: globals.barche,
        firstTime: false, );
    globals.preferencesService.saveSettings(settings, false);
    //print(settings.staffL);
  }

  onSelectedPopupMenu(BuildContext context, int item) {
    switch (item) {
      //impostazioni
      case 0:
        Navigator.of(context)
            .push(
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        )
            .then((value) {
          setState(() {});
          saveSettings();
        });
        break;
    }
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      ///usare quando resetto shared preferences !settings.firstTime
      if (settings.firstTime) {
        _preferencesService.saveSettings(settings, true);
        settings.societa=globals.societa;
        settings.luoghi=globals.luoghi;
        settings.partecipantiMax=globals.partecipantiMax;
        settings.staffL=globals.staffL;
        settings.barche=globals.barche;
        _preferencesService.saveSettings(settings, false);
        //print(settings.staffL);

      } else {
        globals.societa=settings.societa;
        globals.luoghi = settings.luoghi;
        globals.partecipantiMax = settings.partecipantiMax;
        globals.staffL = settings.staffL;
        globals.barche = settings.barche;
        //print(settings.staffL);

      }
    });
  }
}