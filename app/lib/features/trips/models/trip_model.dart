enum TripStatus { planning, active, completed }

class TripModel {
  final String id;
  final String name;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String? coverPhotoUrl;
  final TripStatus status;
  final String organizerId;
  final String inviteCode;
  final bool inviteLinkActive;
  final DateTime createdAt;

  TripModel({
    required this.id,
    required this.name,
    required this.destination,
    required this.startDate,
    required this.endDate,
    this.coverPhotoUrl,
    required this.status,
    required this.organizerId,
    required this.inviteCode,
    required this.inviteLinkActive,
    required this.createdAt,
  });

  factory TripModel.fromMap(Map<String, dynamic> map, String id) {
    return TripModel(
      id: id,
      name: map['name'] ?? '',
      destination: map['destination'] ?? '',
      startDate: (map['startDate'] as dynamic)?.toDate() ?? DateTime.now(),
      endDate: (map['endDate'] as dynamic)?.toDate() ?? DateTime.now(),
      coverPhotoUrl: map['coverPhotoUrl'],
      status: TripStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TripStatus.planning,
      ),
      organizerId: map['organizerId'] ?? '',
      inviteCode: map['inviteCode'] ?? '',
      inviteLinkActive: map['inviteLinkActive'] ?? true,
      createdAt: (map['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'destination': destination,
      'startDate': startDate,
      'endDate': endDate,
      'coverPhotoUrl': coverPhotoUrl,
      'status': status.name,
      'organizerId': organizerId,
      'inviteCode': inviteCode,
      'inviteLinkActive': inviteLinkActive,
      'createdAt': createdAt,
    };
  }

  int get durationDays => endDate.difference(startDate).inDays + 1;
}
