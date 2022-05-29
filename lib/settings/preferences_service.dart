import 'package:foglio_capitaneria/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService{

  Future saveSettings(Settings settings, bool firstTime) async{

    final preferences = await SharedPreferences.getInstance();
    if (!firstTime) {
      await preferences.setString("societa", settings.societa);
      await preferences.setStringList("luoghi", settings.luoghi);
      await preferences.setString("partecipanti", settings.partecipantiMax);
      await preferences.setStringList("staff", settings.staffL);
      await preferences.setStringList("barche", settings.barche);
    }else{
      await preferences.setBool("firstTime", false);

    }

  }

  Future<Settings> getSettings() async{
    final preferences = await SharedPreferences.getInstance();
    final societa = preferences.getString("societa")??"";
    final luoghi = preferences.getStringList("luoghi")??["errore"];
    final partecipantiMax = preferences.getString("partecipanti")??"0";
    final staffL = preferences.getStringList("staff")??["errore"];
    final barche = preferences.getStringList("barche")??["errore"];
    final firstTime = preferences.getBool("firstTime")??true;


    return Settings(societa: societa,luoghi: luoghi, partecipantiMax: partecipantiMax,staffL: staffL, barche: barche,firstTime: firstTime);
  }

}