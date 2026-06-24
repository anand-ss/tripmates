class ActivityModel {
  final String id;
  final String title;
  final DateTime date;
  final String? time;
  final String? location;
  final String? notes;
  final bool isDone;
  final String createdBy;

  ActivityModel({
    required this.id,
    required this.title,
    required this.date,
    this.time,
    this.location,
    this.notes,
    required this.isDone,
    required this.createdBy,
  });

  factory ActivityModel.fromMap(Map<String, dynamic> map, String id) {
    return ActivityModel(
      id: id,
      title: map['title'] ?? '',
      date: (map['date'] as dynamic)?.toDate() ?? DateTime.now(),
      time: map['time'],
      location: map['location'],
      notes: map['notes'],
      isDone: map['isDone'] ?? false,
      createdBy: map['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'notes': notes,
      'isDone': isDone,
      'createdBy': createdBy,
    };
  }
}
