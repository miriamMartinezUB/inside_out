class UserPreferences {
  final String userId;
  final String locale;
  final String theme;

  UserPreferences({
    required this.userId,
    required this.locale,
    required this.theme,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) => UserPreferences(
        userId: json['userId'],
        locale: json['locale'],
        theme: json['theme'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'locale': locale,
        'lastName': theme,
      };
}
