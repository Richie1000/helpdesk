import 'package:flutter/material.dart';

class TicketScreenDesktop extends StatelessWidget {
  final String title;
  final int number;
  final String description;
  final String partnerName;
  final DateTime dateCreated;
  final String createdBy;

  TicketScreenDesktop({
    required this.title,
    required this.number,
    required this.description,
    required this.partnerName,
    required this.dateCreated,
    required this.createdBy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: $title',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Ticket Number: #$number',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Partner: $partnerName',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date Created: ${dateCreated.toLocal()}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Created By: $createdBy',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
