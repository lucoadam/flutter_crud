import 'package:meta/meta.dart';

class User {
  final String name;
  final String email;
  final String access;
  final String refresh;

  User({@required this.name, @required this.email,this.access,this.refresh});

  @override
  String toString() => 'User { name: $name, email: $email}';

  static User fromJson(Map<String,dynamic>json) {
    return User(
      name: json['username'],
      email: json['roleName'],
      refresh: json['refresh'],
      access: json['access'],
    );
  }
}