import 'package:mongo_dart/mongo_dart.dart';
import 'package:frontend/Constants.dart';
import 'package:frontend/models/User.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List> getDocuments() async {
    await db.createIndex('users', keys: {'location': '2dsphere'});
    // print("Created index");
    // await userCollection.insertOne({
    //   "location": {
    //     "type": "Point",
    //     "coordinates":  [-130, 47]
    //   },
    //   "username": "First User",
    //   "firstName": "Anshu",
    //   "lastName": "Black",
    //   "phoneNumber" : "8057561111"
    // });
    // print("Inserted User");
    var _loc = {
      'type': 'Point',
      'coordinates': [-130.01, 47]
    };
    var result = [];
    await userCollection
        .find(where.near("location", _loc, 2000))
        .forEach((data) {
      print(data);
      result.add(data);
    });

    // final users = await userCollection.find({
    //   "location": {
    //     "\$near": {
    //       {
    //         "\$geometry": {
    //           "type": "Point",
    //           "coordinates": [47, 122.33]
    //         },
    //         "\$maxDistance": 15000,
    //         "\$minDistance": 0
    //
    //       }
    //     }
    //   }
    // }).toList();
    return result;
  }

  static insert(User user) async {
    await userCollection.insertAll([user.toMap()]);
  }

  static update(User user) async {
    var u = await userCollection.findOne({"_id": user.id});
    u["location"] = user.location;
    // u["username"] = user.username;
    u["firstName"] = user.firstName;
    u["lastName"] = user.lastName;
    u["phoneNumber"] = user.phoneNumber;
    await userCollection.save(u);
  }

  static delete(User user) async {
    await userCollection.remove(where.id(user.id));
  }
}