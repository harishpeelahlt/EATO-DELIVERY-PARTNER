// // ignore_for_file: unused_field

// // import 'dart:async';

// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // class SecureStorage {
// //   SecureStorage._();

// //   factory SecureStorage() => _instance;

// //   static final SecureStorage _instance = SecureStorage._();

// //   late FlutterSecureStorage _flutterSecureStorage;

// //   FutureOr<void> loadSecureStorage(FlutterSecureStorage vars) =>
// //       _flutterSecureStorage = vars;

// //   Future<void> writeStringData({key, val}) async {
// //     await _flutterSecureStorage.write(key: key, value: val);
// //   }

// //   Future readData({key}) async {
// //     var data = await _flutterSecureStorage.read(key: key);
// //     return data;
// //   }

// //   void clearAll({required String key}) async {
// //     await _flutterSecureStorage.deleteAll();
// //   }

// //   static deleteAll() {}
// // }


// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesStorage {
//   SharedPreferencesStorage._();

//   factory SharedPreferencesStorage() => _instance;

//   static final SharedPreferencesStorage _instance = SharedPreferencesStorage._();

//   late SharedPreferences _sharedPreferences;

//   Future<void> loadSharedPreferences() async {
//     _sharedPreferences = await SharedPreferences.getInstance();
//   }

//   Future<void> writeStringData({required String key, required String val}) async {
//     await _sharedPreferences.setString(key, val);
//   }

//   Future<String?> readData({required String key}) async {
//     return _sharedPreferences.getString(key);
//   }

//   Future<void> clearAll() async {
//     await _sharedPreferences.clear();
//   }
// }

