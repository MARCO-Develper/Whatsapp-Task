import '../../domain/entities/call.dart';

class CallModel extends Call {
  const CallModel({
    required String id,
    required String name,
    required String avatarUrl,
    required String time,
    required CallType type,
    required CallStatus status,
  }) : super(
          id: id,
          name: name,
          avatarUrl: avatarUrl,
          time: time,
          type: type,
          status: status,
        );

  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      time: json['time'],
      type: CallType.values.firstWhere(
        (e) => e.toString() == 'CallType.${json['type']}',
      ),
      status: CallStatus.values.firstWhere(
        (e) => e.toString() == 'CallStatus.${json['status']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'time': time,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
    };
  }
}