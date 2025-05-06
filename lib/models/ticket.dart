import 'package:helpdesk/models/user.dart';

class Ticket {
  final int id;
  final String title;
  final String description;
  final String status;
  final LoggedUser assignedTo;
  final String priority;
  final int score;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.assignedTo,
    required this.priority,
    required this.score,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      assignedTo: LoggedUser.fromJson(json['assignedTo']),
      priority: json['priority'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'assignedTo': assignedTo.toJson(),
      'priority': priority,
      'score': score,
    };
  }
}
