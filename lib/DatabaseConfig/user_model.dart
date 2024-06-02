import 'package:flutter/material.dart' show debugPrint;
import 'package:streamit/DatabaseConfig/storagemanager.dart';

class UserField {
  static const String id = "id";
  static const String username = "username";
  static const String firstname = "first_name";
  static const String lastname = "last_name";
  static const String email = "email";
  static const String phone = "phone";
  static const String avatar = "avatar";
  static const String dob = "date_of_birth";
  static const String address = "address";
  static final List<String> values = [
    id,
    firstname,
    lastname,
    email,
    phone,
    username,
    avatar,
    dob,
    address,
  ];
}

class UserMedia {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String avatar;
  final String email;
  final String phone;
  final String address;
  final DateTime dob;
  const UserMedia({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.address,
    required this.dob,
  });
  static UserMedia fromJson(data) {
    return UserMedia(
      id: data[UserField.id],
      firstName: data[UserField.firstname],
      lastName: data[UserField.lastname],
      username: data[UserField.username],
      avatar: data[UserField.avatar],
      email: data[UserField.email],
      phone: data[UserField.phone],
      address: data[UserField.address],
      dob: DateTime.parse(data[UserField.dob]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserField.id: id,
      UserField.firstname: firstName,
      UserField.lastname: lastName,
      UserField.username: username,
      UserField.avatar: avatar,
      UserField.email: email,
      UserField.phone: phone,
      UserField.address: address,
      UserField.dob: dob.toString(),
    };
  }

  bool save() {
    try {
      StorageManager.saveData(UserField.id, id);
      StorageManager.saveData(UserField.username, username);
      StorageManager.saveData(UserField.firstname, firstName);
      StorageManager.saveData(UserField.lastname, lastName);
      StorageManager.saveData(UserField.avatar, avatar);
      StorageManager.saveData(UserField.dob, dob.toString());
      StorageManager.saveData(UserField.address, address);
      StorageManager.saveData(UserField.email, email);
      StorageManager.saveData(UserField.phone, phone);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<UserMedia> read() async {
    try {
      return UserMedia(
        id: await StorageManager.readData(UserField.id),
        firstName: await StorageManager.readData(UserField.firstname),
        lastName: await StorageManager.readData(UserField.lastname),
        username: await StorageManager.readData(UserField.username),
        avatar: await StorageManager.readData(UserField.avatar),
        email: await StorageManager.readData(UserField.email),
        phone: await StorageManager.readData(UserField.phone),
        address: await StorageManager.readData(UserField.address),
        dob: DateTime.parse(await StorageManager.readData(UserField.dob)),
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
