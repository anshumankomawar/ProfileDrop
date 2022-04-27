import 'package:mongo_dart/mongo_dart.dart';

import 'Location.dart';

class User {
  final ObjectId id;
  final Location location;
  // final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;


  const User({
    required this.id,
    required this.location,
    // required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'location': location,
      // 'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber' : phoneNumber
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        location = map['location'],
        // username = map['username'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        phoneNumber = map["phoneNumber"];
}