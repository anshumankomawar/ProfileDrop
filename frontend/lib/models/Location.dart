import 'package:mongo_dart/mongo_dart.dart';

class Location {
  final ObjectId id;
  final String type;
  final List<double> coordinates;

  const Location({
    required this.id,
    required this.type,
    required this.coordinates
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'type': type,
      'coordinates': coordinates
    };
  }

  Location.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        type = map['type'],
        coordinates = map['coordinates'];
}