import 'package:frontend/models/Location.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:frontend/Constants.dart';
import 'package:frontend/models/User.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = await db.collection(USER_COLLECTION);
    // User user = await getUser("627dc87c37b37ad09147cda2");
    // return [user] +  await getNearbyUsers(user);
  }

  static Future<User?> getUser(String username) async{
    var result = await userCollection.findOne(where.eq("username",username));
    if (result == null) {
      return null;
    }
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

    List<User> temp =  List.from(result);
    for (User item in result){
      if(item.preferredStatus == 3){
        temp.remove(item);
      }
      if(item.preferredStatus == 2 && !user.friends.contains(item.username)){
        temp.remove(item);
      }
    }

    temp.sort((a,b) => (a.location.distanceTo(user.location)).compareTo(b.location.distanceTo(user.location)));
    if(temp.length == 1) return [];
    return temp.sublist(1, temp.length > 15 ? 15: temp.length);
  }

  static insert(User user) async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
    await userCollection.insertAll([user.toMap()]);
  }

  static update(User user) async {
    await userCollection.replaceOne(where.eq('username', user.username), user.toMap());
  }

  static test() {}
}
