class Story {
  final String id;
  final String name;
  final String imageUrl;
  final String time;
  final bool isViewed;
  final bool isMyStory;

  const Story({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.isViewed,
    required this.isMyStory,
  });
}
