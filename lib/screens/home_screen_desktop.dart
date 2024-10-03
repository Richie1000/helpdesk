import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:helpdesk/screens/ticket_screen_desktop.dart';

import 'add_ticket_screen_desktop.dart';

class HomeScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helpdesk Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search tickets...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'Recent Tickets',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10, // Replace with actual data count
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(Icons.assignment),
                            title: Text('Ticket #$index'),
                            subtitle: Text('Description of ticket #$index'),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              // Handle ticket tap

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TicketScreenDesktop(
                                          title: "Ticket Title",
                                          number: index,
                                          description: "Ticket Description",
                                          partnerName: "Partner ",
                                          dateCreated: DateTime(2024, 08, 2),
                                          createdBy: "Richmond")));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 32.0),
            Expanded(
              child: Dashboard(), // Replace Placeholder with Dashboard widget
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle new ticket creation
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTicketScreenDesktop()));
        },
        child: Icon(Icons.add),
        tooltip: 'Create New Ticket',
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dashboard',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoCard(
                  label: 'Open Tickets Today',
                  value: '10', // Replace with actual value
                  color: Colors.blue,
                ),
                InfoCard(
                  label: 'Closed Tickets Today',
                  value: '5', // Replace with actual value
                  color: Colors.red,
                ),
                InfoCard(
                  label: 'Unassigned Tickets',
                  value: '2', // Replace with actual value
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularIndicator(
                  label: 'Open Tickets',
                  percentage: 0.57,
                  color: Colors.blue,
                ),
                CircularIndicator(
                  label: 'Closed Tickets',
                  percentage: 0.76,
                  color: Colors.red,
                ),
                CircularIndicator(
                  label: 'Unassigned Tickets',
                  percentage: 0.21,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CircularIndicator extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  CircularIndicator({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: percentage,
                strokeWidth: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            Text('${(percentage * 100).toInt()}'),
          ],
        ),
        SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  InfoCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(
              fontSize: 24.0, color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
