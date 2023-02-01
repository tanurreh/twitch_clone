import 'dart:convert';

class LiveStream {
  final String title;
  final String image;
  final String uid;
  final String username;
  final dynamic startedAt;
  final int viewers;
  final String channelId;

  LiveStream({
    required this.title,
    required this.image,
    required this.uid,
    required this.username,
    required this.viewers,
    required this.channelId,
    required this.startedAt,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'title': title});
    result.addAll({'image': image});
    result.addAll({'uid': uid});
    result.addAll({'username': username});
    result.addAll({'startedAt': startedAt});
    result.addAll({'viewers': viewers});
    result.addAll({'channelId': channelId});
  
    return result;
  }

  factory LiveStream.fromMap(Map<String, dynamic> map) {
    return LiveStream(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      startedAt: map['startedAt'] ?? '',
      viewers: map['viewers']?.toInt() ?? 0,
      channelId: map['channelId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveStream.fromJson(String source) => LiveStream.fromMap(json.decode(source));
}
