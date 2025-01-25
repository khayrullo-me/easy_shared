// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easy_shared.dart';

// **************************************************************************
// EasySharedGenerator
// **************************************************************************


class SharedGen {
  static final SharedGen _instance = SharedGen._internal();
  SharedGen._internal();
  static SharedGen get instance => _instance;
  SharedPreferences? _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get a => _prefs?.getString('a') ?? '';
  set a(String value) {
    _prefs?.setString('a', value);
  }
}
