import '../../domain/entities/story.dart';

class StoryModel extends Story {
  const StoryModel({
    required String id,
    required String name,
    required String imageUrl,
    required String time,
    required bool isViewed,
    required bool isMyStory,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          time: time,
          isViewed: isViewed,
          isMyStory: isMyStory,
        );

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      time: json['time'],
      isViewed: json['isViewed'],
      isMyStory: json['isMyStory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'time': time,
      'isViewed': isViewed,
      'isMyStory': isMyStory,
    };
  }
}
