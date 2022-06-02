import 'package:mongo_dart/mongo_dart.dart';

import 'Location.dart';

class User {
  final Location location;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String bio;
  final List<String> friends;
  final int preferredStatus;
  final String PFP; // <optional>
  final String college; // <optional>
  final String major; // <optional>
  final String job; // <optional>
  final String song; // <optional> -> Spotify API?

  /* ---- Socials ---- */
  final Map<String, String> socials;


  const User({
    required this.location,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.bio,
    required this.friends,
    required this.preferredStatus,
    this.PFP = "",
    this.college = "",
    this.major = "",
    this.job = "",
    this.song = "",
    required this.socials,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location.toMap(),
      'username': username,
      'password' : password,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber' : phoneNumber,
      'bio' : bio,
      'friends' : friends,
      'preferredStatus' : preferredStatus,
      'PFP' : PFP,
      'college' : college,
      'major' : major,
      'job' : job,
      'song' : song,
      'socials' : socials,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : location = Location.fromMap(map['location']),
        username = map['username'],
        password = map['password'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        phoneNumber = map["phoneNumber"],
        bio = map['bio'],
        friends = map['friends'].cast<String>(),
        preferredStatus = map['preferredStatus'],
        PFP = map['PFP'],
        college = map['college'],
        major = map['major'],
        job = map['job'],
        song = map['song'],
        socials = map['socials'].cast<String, String>();
}