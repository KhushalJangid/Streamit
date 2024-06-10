class CourseField {
  static const String id = "id";
  static const String title = "title";
  static const String thumbnail = "thumbnail";
  static const String uniqueName = "uniqueName";
  static const String description = "description";
  static const String type = "type";
  static const String price = "price";
  static const String uploaded = "uploadDate";
  static final List<String> values = [
    id,
    thumbnail,
    uniqueName,
    description,
    title,
    type,
    price,
    uploaded,
  ];
}

class CourseMedia {
  final int id;
  final String title;
  final String thumbnail;
  final String type;
  final String description;
  final String uniqueName;
  final int price;
  final DateTime uploaded;
  const CourseMedia({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.type,
    required this.uniqueName,
    required this.price,
    required this.uploaded,
  });
  static CourseMedia fromJson(data) {
    return CourseMedia(
      id: data[CourseField.id],
      title: data[CourseField.title],
      thumbnail: data[CourseField.thumbnail],
      description: data[CourseField.description],
      type: data[CourseField.type],
      uniqueName: data[CourseField.uniqueName],
      price: data[CourseField.price],
      uploaded: DateTime.parse(data[CourseField.uploaded]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CourseField.id: id,
      CourseField.title: title,
      CourseField.thumbnail: thumbnail,
      CourseField.description: description,
      CourseField.type: type,
      CourseField.uniqueName: uniqueName,
      CourseField.price: price,
      CourseField.uploaded: uploaded.toString(),
    };
  }
}

class VideoMedia {
  final int id;
  final String title;
  final String thumbnail;
  final String uniqueName;
  final DateTime uploaded;
  const VideoMedia({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.uniqueName,
    required this.uploaded,
  });
  static VideoMedia fromJson(data) {
    return VideoMedia(
      id: data[CourseField.id],
      title: data[CourseField.title],
      thumbnail: data[CourseField.thumbnail],
      uniqueName: data[CourseField.uniqueName],
      uploaded: DateTime.parse(data[CourseField.uploaded]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CourseField.id: id,
      CourseField.title: title,
      CourseField.thumbnail: thumbnail,
      CourseField.uniqueName: uniqueName,
      CourseField.uploaded: uploaded,
    };
  }
}
