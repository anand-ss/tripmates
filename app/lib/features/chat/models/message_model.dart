class MessageModel {
  final String id;
  final String senderId;
  final String? text;
  final String? photoUrl;
  final String? replyTo;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.senderId,
    this.text,
    this.photoUrl,
    this.replyTo,
    required this.createdAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map, String id) {
    return MessageModel(
      id: id,
      senderId: map['senderId'] ?? '',
      text: map['text'],
      photoUrl: map['photoUrl'],
      replyTo: map['replyTo'],
      createdAt: (map['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'photoUrl': photoUrl,
      'replyTo': replyTo,
      'createdAt': createdAt,
    };
  }
}
