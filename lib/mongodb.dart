import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var usersCollection;
  static var infoUserCollection;

  static connect() async {
    var db = await Db.create(
        'mongodb+srv://test:test@cluster0.wm6sokd.mongodb.net/?retryWrites=true&w=majority');
    await db.open();
    inspect(db);
    usersCollection = db.collection('users');
    infoUserCollection = db.collection('info');
  }

  static getUsersFromInfoUsers() async {
    return await infoUserCollection.find().toList();
  }

  static insertUser(data) async {
    var user = await infoUserCollection.findOne({'email': data['email']});
    if (user == null) {
      return await infoUserCollection.insertOne(data);
    }
    print('User with email ${data["email"]} already exists');
    return null;
  }

  static updateUser(email, data) async {
    var user = await infoUserCollection.findOne({'email': email});
    if (user != null) {
      var filter = {'email': email};
      return await infoUserCollection.replaceOne(filter, data);
    }
    return null;
  }

  static deleteUser(email) async {
    var user = await infoUserCollection.findOne({'email': email});
    if (user != null) {
      return await infoUserCollection.deleteOne({'email': email});
    }
    return null;
  }

  static Future<List<Map>> getUsers() async {
    return await usersCollection.find().toList();
  }

  static registerUser(data) async {
    var user = await usersCollection.findOne({'email': data['email']});
    if (user == null) {
      return await usersCollection.insertOne(data);
    }
    print('User with email ${data["email"]} already exists');
    return null;
  }
}
