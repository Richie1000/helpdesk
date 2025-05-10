import 'package:helpdesk/models/company.dart';
import 'package:helpdesk/models/user.dart';

class Ticket {
  final int id;
  final String title;
  final String description;
  final String status;
  final LoggedUser? assignedTo;
  final String priority;
  final int score;
  final Company company;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.assignedTo,
    required this.priority,
    required this.score,
    required this.company,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      assignedTo: json['assignedTo'] != null
          ? LoggedUser.fromJson(json['assignedTo'])
          : null,
      priority: json['priority'],
      score: json['score'],
      company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'assignedTo': assignedTo?.toJson(),
      'priority': priority,
      'score': score,
      'company': company.toJson(),
    };
  }
}
