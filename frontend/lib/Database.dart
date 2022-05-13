import 'package:frontend/models/Location.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:frontend/Constants.dart';
import 'package:frontend/models/User.dart';

class MongoDatabase {
  static var db, userCollection;

  static Future<List<User>> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = await db.collection(USER_COLLECTION);
    User user = await getUser("627dc87c37b37ad09147cda2");
    return [user] +  await getNearbyUsers(user);
  }

  static Future<User> getUser(String userId) async{
    var result = await userCollection.findOne(where.id(ObjectId.parse(userId)));
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
      result.add(data);
    });
    return result;
  }

  static Future<List<User>> getNearbyUsers(User user) async {
    await db.createIndex('users', keys: {'location': '2dsphere'});
    var _loc = {'type': 'Point', 'coordinates': user.location.coordinates};
    List<User> result = [];
    await userCollection
        .find(where.near("location", _loc, 2000))
        .forEach((data) {
      result.add(User.fromMap(data));
    });


    result.sort((a,b) => (a.location.distanceTo(user.location)).compareTo(b.location.distanceTo(user.location)));
    if(result.length == 1) return [];
    return result.sublist(1, result.length > 15 ? 15: result.length);
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
