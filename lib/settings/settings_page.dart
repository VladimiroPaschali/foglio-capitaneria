import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foglio_capitaneria/settings/staff_settings.dart';
import 'package:settings_ui/settings_ui.dart';
import 'barca_settings.dart';
import 'luoghi_settings.dart';
import '../globals.dart' as globals;


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    super.initState();
  }

  final textControllerpartecipanti = TextEditingController();
  final textControllerSocieta = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //salva
        //saveSettings();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Impostazioni")),
        body: SafeArea(
          child: SettingsList(
            sections: [
              SettingsSection(
                tiles: <SettingsTile>[
                  buildSocieta(),
                  buildLuoghi(),
                  buildPartecipanti(),
                  buildStaff(),
                  buildBarca(),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  String stampaLista(List<String> lista) {
    if (lista.isEmpty) {
      return "";
    } else {
      String s = "";
      for (int i = 0; i < lista.length - 1; i++) {
        s = s + lista[i] + " - ";
      }
      s = s + lista.last;

      return s;
    }
  }

  SettingsTile buildLuoghi() {
    return SettingsTile.navigation(
        title: const Text("Punti d'immersione"),
        description: Text(stampaLista(globals.luoghi)),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onPressed: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LuoghiSettings(),
          )).then((value) {
            setState(() {});
          });
        }
    );
  }

  SettingsTile buildStaff() {
    return SettingsTile.navigation(
        title: const Text("Membri Staff"),
        description: Text(stampaLista(globals.staffL)),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onPressed: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const StaffSettings(),
          )).then((value) {
            setState(() {});
          });
        }
    );
  }

  SettingsTile buildBarca() {
    return SettingsTile.navigation(
        title: const Text("Barche"),
        description: Text(stampaLista(globals.barche)),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onPressed: (context) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const BarcaSettings(),
          )).then((value) {
            setState(() {});
          });
        }
    );
  }

  SettingsTile buildPartecipanti() {
    return SettingsTile.navigation(
        title: const Text("Numero Massimo Partecipanti"),
        description: Text(globals.partecipantiMax),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onPressed: (context) {
          showAlertDialogPartecipanti(context);
        }
    );
  }

  Future showAlertDialogPartecipanti(BuildContext context) =>
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Inserisci Partecipanti"),
              content: buildTextPartecipanti(),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: () {
                      textControllerpartecipanti.clear();
                      Navigator.of(context).pop();
                    }, child: const Text("Annulla")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            globals.partecipantiMax = textControllerpartecipanti.text;
                          });
                          textControllerpartecipanti.clear();
                          Navigator.of(context).pop();
                        }, child: const Text("Inserisci")),
                  ],
                )
              ],
            );
          }
      );

  Widget buildTextPartecipanti() =>
      TextField(
        controller: textControllerpartecipanti,
        decoration: const InputDecoration(
          labelText: 'Numero massimo Partecipanti',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly],
      );

  SettingsTile buildSocieta() {
    return SettingsTile.navigation(
        title: const Text("Nome Società"),
        description: Text(globals.societa),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onPressed: (context) {
          showAlertDialogSocieta(context);
        }
    );
  }

  Future showAlertDialogSocieta(BuildContext context) =>
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Inserisci Società"),
              content: buildTextSocieta(),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: () {
                      textControllerSocieta.clear();
                      Navigator.of(context).pop();
                    }, child: const Text("Annulla")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            globals.societa = textControllerSocieta.text;
                          });
                          textControllerSocieta.clear();
                          Navigator.of(context).pop();
                        }, child: const Text("Inserisci")),
                  ],
                )
              ],
            );
          }
      );

  Widget buildTextSocieta() =>
      TextField(
        controller: textControllerSocieta,
        decoration: const InputDecoration(
          labelText: 'Nome Società',
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.done,
      );

}
