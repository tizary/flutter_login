import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:typed_data';
import 'dart:convert';

String convertImageToBase64(Uint8List image) {
  return base64Encode(image);
}

class MongoDatabase {
  static var usersCollection;
  static var infoUserCollection;

  static connect() async {
    try {
      var db = await Db.create(
          'mongodb+srv://test:test@cluster0.wm6sokd.mongodb.net/?retryWrites=true&w=majority');
      await db.open();
      inspect(db);
      usersCollection = db.collection('users');
      infoUserCollection = db.collection('info');
    } catch (e) {
      print(e);
    }
  }

  static getUsersFromInfoUsers(id) async {
    return await infoUserCollection.find({'userID': id}).toList();
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

  static loginUser(email, password) async {
    var user = await usersCollection.findOne({'email': email});
    if (user != null && user['password'] == password) {
      return user;
    } else {
      return null;
    }
  }

  static addUserImage(email, image) async {
    try {
      await usersCollection.updateOne(
          where.eq('email', email), modify.set('imageSrc', image));
    } catch (e) {
      print('Error adding image: $e');
    }
  }
}
