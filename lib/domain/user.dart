import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:inside_out/encryptor.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime registerDay;
  final String locale;
  final String themePreference;
  final List? principles;
  final List? values;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.registerDay,
    required this.locale,
    required this.themePreference,
    this.principles,
    this.values,
  });

  User copyWith({String? locale, String? themePreference, List? principles, List? values}) => User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        registerDay: registerDay,
        locale: locale ?? this.locale,
        themePreference: themePreference ?? this.themePreference,
        principles: principles ?? this.principles,
        values: values ?? this.values,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: Encryptor.decrypt64(json['firstName'] ?? ""),
        lastName: Encryptor.decrypt64(json['lastName'] ?? ""),
        registerDay: DateTime.parse(json['registerDay']),
        locale: json['locale'],
        themePreference: json['themePreference'],
        principles: json['principles'],
        values: json['values'],
      );

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      firstName: Encryptor.decrypt64(doc['firstName']),
      lastName: Encryptor.decrypt64(doc['lastName']),
      registerDay: DateTime.parse(doc['registerDay']),
      locale: doc['locale'],
      themePreference: doc['themePreference'],
      principles: doc['principles'],
      values: doc['values'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstName': Encryptor.encrypt64(firstName),
        'lastName': Encryptor.encrypt64(lastName),
        'registerDay': registerDay.toString(),
        'locale': locale,
        'themePreference': themePreference,
        'principles': principles,
        'values': values,
      };

  factory User.empty() => User(
        id: "",
        firstName: "",
        lastName: "",
        registerDay: DateTime.now(),
        locale: "",
        themePreference: "",
      );

  factory User.fromAuthUser(auth.User? user, {String? name, String? locale, String? themePreference}) {
    if (user == null) {
      return User.empty();
    }

    List<String> splitName = ['', ''];

    if (name != null) {
      splitName = name.split(' ');
    }

    if (user.displayName != null) {
      splitName = user.displayName!.split(' ');
    }

    return User(
      id: user.uid,
      firstName: splitName.first,
      lastName: splitName.last,
      registerDay: user.metadata.creationTime ?? DateTime.now(),
      locale: locale ?? '',
      themePreference: themePreference ?? '',
    );
  }
}
