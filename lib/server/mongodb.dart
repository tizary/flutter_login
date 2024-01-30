import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:typed_data';
import 'dart:convert';

import '../utils/network_util.dart';

String convertImageToBase64(Uint8List image) {
  return base64Encode(image);
}

class MongoDatabase {
  static const String connectionUrl =
      'mongodb+srv://test:test@cluster0.wm6sokd.mongodb.net/?retryWrites=true&w=majority';
  static late DbCollection usersCollection;
  static late DbCollection infoUserCollection;

  static Db _db = Db('');

  static Future<void> connect() async {
    try {
      if (!await NetworkUtil.hasConnection()) {
        return;
      }

      _db = await Db.create(connectionUrl);
      await _db.open();
      usersCollection = _db.collection('users');
      infoUserCollection = _db.collection('info');
    } catch (e) {
      throw const ConnectionException('Failed to connect to MongoDB');
    }
  }

  static Future<void> _checkConnection() async {
    try {
      await _db.runCommand({'ping': 1});
    } catch (e) {
      await _reconnect();
    }
  }

  static Future<void> _reconnect() async {
    _db.close();

    _db = await Db.create(connectionUrl);
    await _db.open();
    usersCollection = _db.collection('users');
    infoUserCollection = _db.collection('info');
  }

  static getUsersFromInfoUsers(id) async {
    if (!await NetworkUtil.hasConnection()) {
      return <Map<String, Object?>>[];
    }
    await _checkConnection();

    try {
      return await infoUserCollection.find({'userID': id}).toList();
    } catch (e) {
      throw Exception('Error get users from MongoDB: $e');
    }
  }

  static insertUser(data) async {
    if (!await NetworkUtil.hasConnection()) {
      return;
    }
    await _checkConnection();

    try {
      var user = await infoUserCollection.findOne({'email': data['email']});
      if (user == null) {
        return await infoUserCollection.insertOne(data);
      }
      return false;
    } catch (e) {
      throw Exception('Error inserting user into infoUserCollection: $e');
    }
  }

  static updateUser(email, data) async {
    if (!await NetworkUtil.hasConnection()) {
      return;
    }
    await _checkConnection();

    try {
      var user = await infoUserCollection.findOne({'email': email});
      if (user != null) {
        var filter = {'email': email};
        return await infoUserCollection.replaceOne(filter, data);
      }
      return false;
    } catch (e) {
      throw Exception('Error updating user in infoUserCollection: $e');
    }
  }

  static deleteUser(email) async {
    if (!await NetworkUtil.hasConnection()) {
      return null;
    }

    await _checkConnection();

    try {
      var user = await infoUserCollection.findOne({'email': email});
      if (user != null) {
        return await infoUserCollection.deleteOne({'email': email});
      }
      return false;
    } catch (e) {
      throw Exception('Error deleting user from infoUserCollection: $e');
    }
  }

  static Future<List<Map>> getUsers() async {
    if (!await NetworkUtil.hasConnection()) {
      return [];
    }
    await _checkConnection();

    try {
      return await usersCollection.find().toList();
    } catch (e) {
      throw Exception('Error retrieving users from usersCollection: $e');
    }
  }

  static registerUser(data) async {
    if (!await NetworkUtil.hasConnection()) {
      return;
    }
    await _checkConnection();

    try {
      var user = await usersCollection.findOne({'email': data['email']});
      if (user == null) {
        return await usersCollection.insertOne(data);
      }
      return false;
    } catch (e) {
      throw Exception('Error registering user in usersCollection: $e');
    }
  }

  static loginUser(email, password) async {
    if (!await NetworkUtil.hasConnection()) {
      return;
    }
    await _checkConnection();

    try {
      var user = await usersCollection.findOne({'email': email});
      if (user != null && user['password'] == password) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error logging in user: $e');
    }
  }

  static addUserImage(email, image) async {
    if (!await NetworkUtil.hasConnection()) {
      return;
    }
    await _checkConnection();

    try {
      try {
        await usersCollection.updateOne(
            where.eq('email', email), modify.set('imageSrc', image));
      } catch (e) {
        throw Exception('Error adding image: $e');
      }
    } catch (e) {
      throw Exception('Error adding image to user: $e');
    }
  }
}
