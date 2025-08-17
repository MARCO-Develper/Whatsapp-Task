class Call {
  final String id;
  final String name;
  final String avatarUrl;
  final String time;
  final CallType type;
  final CallStatus status;

  const Call({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.time,
    required this.type,
    required this.status,
  });
}

enum CallType { voice, video }
enum CallStatus { incoming, outgoing, missed }
