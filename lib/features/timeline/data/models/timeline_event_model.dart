import '../../domain/entities/timeline_event.dart';

class TimelineEventModel extends TimelineEvent {
  const TimelineEventModel({
    required String id,
    required String title,
    required String description,
    required DateTime startDate,
    DateTime? endDate,
    required EventType type,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
         id: id,
         title: title,
         description: description,
         startDate: startDate,
         endDate: endDate,
         type: type,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory TimelineEventModel.fromJson(Map<String, dynamic> json) {
    return TimelineEventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      type: EventType.values.firstWhere(
        (e) => e.toString() == 'EventType.${json['type']}',
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'type': type.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory TimelineEventModel.fromEntity(TimelineEvent entity) {
    return TimelineEventModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      startDate: entity.startDate,
      endDate: entity.endDate,
      type: entity.type,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  TimelineEventModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    EventType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TimelineEventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
