import 'package:equatable/equatable.dart';

enum EventType { vivienda, trabajo }

class TimelineEvent extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final EventType type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TimelineEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  TimelineEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    EventType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TimelineEvent(
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

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    startDate,
    endDate,
    type,
    createdAt,
    updatedAt,
  ];
}
