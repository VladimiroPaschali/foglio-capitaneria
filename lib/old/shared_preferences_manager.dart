import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesManager{

  static const String luoghiKey = "luoghi";
  static const String partecipantiKey = "partecipanti";
  static const String staffKey = "staff";
  static const String barcaKey = "barca";


  static Future<SharedPreferences> getSharedPreferencesInstance() async{
    return await SharedPreferences.getInstance();
  }

  static void save(String key, dynamic value) async{
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
    if(key == luoghiKey){
      sharedPreferences.setStringList(luoghiKey, value);
    }else if(key == partecipantiKey){
      sharedPreferences.setInt(partecipantiKey, value);
    }else if(key == staffKey){
      sharedPreferences.setStringList(staffKey, value);
    }else if(key == barcaKey){
      sharedPreferences.setStringList(barcaKey, value);
    }
  }
  static retrive(String key) async {
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
      return sharedPreferences.getStringList(key);

  }


  /*static void saveLuoghi(List<String> luoghi) async {
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
    sharedPreferences.setStringList(luoghiKey, luoghi);
  }

  static void savePartecipanti(int partecipanti) async{
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
    sharedPreferences.setInt(partecipantiKey, partecipanti);

  }
  static void saveStaff(List<String> staff) async {
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
    sharedPreferences.setStringList(staffKey, staff);
  }

  static void saveBarca(List<String> luoghi) async {
    SharedPreferences sharedPreferences = await getSharedPreferencesInstance();
    sharedPreferences.setStringList(barcaKey, luoghi);
  }*/

}