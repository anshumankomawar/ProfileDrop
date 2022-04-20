import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String name;
  final double lat;
  final double long;

  const User({required this.id, required this.name, required this.lat, required this.long});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'lat': lat,
      'long': long,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        lat = map['lat'],
        long = map['long'];
}