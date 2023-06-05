import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime registerDay;
  final String locale;
  final String themePreference;
  final List? principles;
  final List? values;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
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
        email: email,
        registerDay: registerDay,
        locale: locale ?? this.locale,
        themePreference: themePreference ?? this.themePreference,
        principles: principles ?? this.principles,
        values: values ?? this.values,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        email: json['email'],
        registerDay: DateTime.parse(json['registerDay']),
        locale: json['locale'],
        themePreference: json['themePreference'],
        principles: json['principles'],
        values: json['values'],
      );

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      email: doc['email'],
      registerDay: doc['registerDay'],
      locale: doc['locale'],
      themePreference: doc['themePreference'],
      principles: doc['principles'],
      values: doc['values'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
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
        email: "",
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
      email: user.email ?? '',
      firstName: splitName.first,
      lastName: splitName.last,
      registerDay: user.metadata.creationTime ?? DateTime.now(),
      locale: locale ?? '',
      themePreference: themePreference ?? '',
    );
  }
}
