import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Priority {
  low(Colors.green),
  medium(Colors.orange),
  high(Colors.red);

  final Color color;
  const Priority(this.color);
}

class Task {
  final int? id;
  final String title;
  final String description;
  final String category;
  final Priority priority;
  final DateTime dueDate;
  final LatLng? location;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    this.location,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority.name,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'locationLat': location?.latitude,
      'locationLng': location?.longitude,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      priority: Priority.values.firstWhere((p) => p.name == map['priority']),
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'] == 1,
      location: map['locationLat'] != null && map['locationLng'] != null
          ? LatLng(map['locationLat'], map['locationLng'])
          : null,
    );
  }
}
