import 'dart:math';

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

  double distanceTo(Location loc2){
    double xDiff = this.coordinates[0] - loc2.coordinates[0];
    double yDiff = this.coordinates[1] - loc2.coordinates[1];
    return sqrt(xDiff*xDiff + yDiff*yDiff);
  }
}