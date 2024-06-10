// import 'package:spendifi/DatabaseConfig/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationField {
  static const String id = "_id";
  static const String title = "title";
  static const String description = "description";
  static const String datetime = "time";
  static const String media = "media";
  static final List<String> values = [
    id,
    title,
    description,
    datetime,
    media,
  ];
}

class Notification {
  final int? id;
  final String title;
  final String description;
  final String? media;
  final DateTime datetime;
  const Notification(
      {this.id,
      required this.title,
      required this.description,
      this.media,
      required this.datetime});
  Notification copy(
      {int? id,
      String? title,
      String? description,
      DateTime? datetime,
      String? media}) {
    return Notification(
      datetime: datetime ?? this.datetime,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      media: media ?? this.media,
    );
  }

  static Notification fromJson(Map<String, Object?> json) {
    try {
      return Notification(
        id: json[NotificationField.id] as int?,
        title: json[NotificationField.title] as String,
        datetime: DateTime.parse(json[NotificationField.datetime] as String),
        media: json[NotificationField.media] as String,
        description: json[NotificationField.description] as String,
      );
    } catch (e) {
      debugPrint(e.toString());
      return Notification(
        id: json[NotificationField.id] as int?,
        title: json[NotificationField.title] as String,
        datetime: DateTime.parse(json[NotificationField.datetime] as String),
        media: json[NotificationField.media] as String?,
        description: json[NotificationField.description] as String,
      );
    }
  }

  Map<String, Object?> toJson() {
    return {
      NotificationField.id: id,
      NotificationField.title: title,
      NotificationField.datetime: DateFormat('yyyy-MM-dd').format(datetime),
      NotificationField.media: media,
      NotificationField.description: description,
    };
  }
}
