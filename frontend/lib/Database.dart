import 'package:frontend/models/Location.dart';
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

  static Future<User> getUser(String userId) async{
    print("hi");
    var result = await userCollection.findOne(where.id(ObjectId.parse(userId)));
    print(result['_id']);
    return User.fromMap(result);
  }

  static Future<List> getDocuments() async {
    await db.createIndex('users', keys: {'location': '2dsphere'});
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
    return result;
  }

  static Future<List> getNearbyUsers(User user) async {
    await db.createIndex('users', keys: {'location': '2dsphere'});
    var _loc = {'type': 'Point', 'coordinates': user.location.coordinates};
    var result = [];
    await userCollection
        .find(where.near("location", _loc, 2000))
        .forEach((data) {
      print(data);
      result.add(data);
    });

    result.sort((a,b) => (a.location.distanceTo(user.location)).compareTo(b.location.distanceTo(user.location)));
    if(result.length > 15){
      return result.sublist(15);
    }

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
