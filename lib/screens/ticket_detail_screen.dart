import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class TicketDetailScreen extends StatelessWidget {
  final String title;
  final int? number;
  final String description;
  final String? partnerName;
  final DateTime? dateCreated;
  final String createdBy;
  final String? timeAssigned;
  final String? timeCompleted;
  final String? workedOnBy;

  const TicketDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.createdBy,
    this.number,
    this.partnerName,
    this.dateCreated,
    this.timeAssigned,
    this.timeCompleted,
    this.workedOnBy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Details')),
      body: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 800;

            final items = <Widget>[
              TicketDetailCard(label: 'Title', value: title),
              if (number != null) TicketDetailCard(label: 'Ticket Number', value: '#$number'),
              TicketDetailCard(label: 'Description', value: description),
              if (partnerName != null) TicketDetailCard(label: 'Partner', value: partnerName!),
              if (dateCreated != null)
                TicketDetailCard(
                  label: 'Date Created',
                  value: DateFormat('yyyy-MM-dd HH:mm').format(dateCreated!),
                ),
              if (timeAssigned != null)
                TicketDetailCard(label: 'Time Assigned', value: timeAssigned!),
              if (timeCompleted != null)
                TicketDetailCard(label: 'Time Completed', value: timeCompleted!),
              if (workedOnBy != null)
                TicketDetailCard(label: 'Worked On By', value: workedOnBy!),
              TicketDetailCard(label: 'Created By', value: createdBy),
            ];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: isDesktop
                  ? Wrap(
                spacing: 16,
                runSpacing: 16,
                children: items.map((item) {
                  return SizedBox(
                    width: (constraints.maxWidth / 2) - 24,
                    child: item,
                  );
                }).toList(),
              )
                  : ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) => items[i],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TicketDetailCard extends StatelessWidget {
  final String label;
  final String value;

  const TicketDetailCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: theme.labelLarge?.copyWith(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            Text(value, style: theme.bodyMedium),
          ],
        ),
      ),
    );
  }
}