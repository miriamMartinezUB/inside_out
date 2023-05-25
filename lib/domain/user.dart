import 'package:firebase_auth/firebase_auth.dart' as auth;

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime registerDay;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.registerDay,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        email: json['email'],
        registerDay: DateTime.parse(json['registerDay']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'registerDay': registerDay.toString(),
      };

  factory User.empty() => User(
        id: "",
        firstName: "",
        lastName: "",
        email: "",
        registerDay: DateTime.now(),
      );

  factory User.fromAuthUser(auth.User? user, {String? name}) {
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
    );
  }
}
