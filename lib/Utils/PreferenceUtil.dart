// import 'package:shared_preferences/shared_preferences.dart';
//
// class PreferenceUtil {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//   setItem(key, value, type) async {
//     final SharedPreferences prefs = await _prefs;
//     switch (type) {
//       case 'int':
//         return prefs.setInt(key, value).then((created) {
//           return created;
//         });
//       case 'string':
//         return prefs.setString(key, value).then((created) {
//           return created;
//         });
//       case 'double':
//         return prefs.setDouble(key, value).then((created) {
//           return created;
//         });
//       case 'bool':
//         return prefs.setBool(key, value).then((created) {
//           return created;
//         });
//       case 'string_list':
//         return prefs.setStringList(key, value).then((created) {
//           return created;
//         });
//     }
//   }
//
//   getItem(key, type) async {
//     final SharedPreferences prefs = await _prefs;
//     switch (type) {
//       case 'int':
//         return prefs.getInt(key);
//       case 'string':
//         return prefs.getString(key);
//       case 'double':
//         return prefs.getDouble(key);
//       case 'bool':
//         return prefs.getBool(key);
//       case 'string_list':
//         return prefs.getStringList(key);
//     }
//   }
//
//   removeItem(key) async {
//     final SharedPreferences prefs = await _prefs;
//     prefs.remove(key).then((value) {
//       print('Removed value ${value}');
//       return value;
//     });
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setItem(key, value, type) async {
    final SharedPreferences prefs = await _prefs;
    switch (type) {
      case 'int':
        return prefs.setInt(key, value).then((created) {
          return created;
        });
      case 'string':
        return prefs.setString(key, value).then((created) {
          return created;
        });
      case 'double':
        return prefs.setDouble(key, value).then((created) {
          return created;
        });
      case 'bool':
        return prefs.setBool(key, value).then((created) {
          return created;
        });
      case 'string_list':
        return prefs.setStringList(key, value).then((created) {
          return created;
        });
    }
  }

  getItem(key, type) async {
    final SharedPreferences prefs = await _prefs;
    switch (type) {
      case 'int':
        return prefs.getInt(key);
      case 'string':
        return prefs.getString(key);
      case 'double':
        return prefs.getDouble(key);
      case 'bool':
        return prefs.getBool(key);
      case 'string_list':
        return prefs.getStringList(key);
    }
  }

  removeItem(key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key).then((value) {
      print('Removed value ${value}');
      return value;
    });
  }
}
