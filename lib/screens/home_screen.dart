import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk/screens/add_company_screen.dart';
import 'package:helpdesk/screens/add_ticket_screen.dart';
import 'package:helpdesk/screens/add_ticket_screen_desktop.dart';
import 'package:helpdesk/screens/ticket_detail_screen.dart';
import 'package:helpdesk/screens/ticket_screen_desktop.dart';
import 'package:fl_chart/fl_chart.dart';

import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 600) {
      return HomeScreenDesktop();
    } else {
      return HomeScreenMobile();
    }
  }
}

class HomeScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helpdesk Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/we2stars.png'),
                  ),
                  SizedBox(height: 10),
                  Text('User Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text('user@example.com',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
            ListTile(
                leading: Icon(Icons.add_business),
                title: Text('Add Company'),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCompanyScreen()));
                },
            ),
            ListTile(
                leading: Icon(Icons.open_in_browser),
                title: Text('Open Tickets')),
            ListTile(
                leading: Icon(Icons.check_circle),
                title: Text('Closed Tickets')),
            ListTile(
                leading: Icon(Icons.warning), title: Text('Overdue Tickets')),
            ListTile(
                leading: Icon(Icons.incomplete_circle),
                title: Text('In Progress Tickets')),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                context.read<AuthBloc>().add(SignOutUserEvent());
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()), // or LoginScreenDesktop based on screen size
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search tickets...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Dashboard',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildDashboardIndicator(
                        title: 'Open Tickets',
                        color: Colors.red,
                        percentage: 0.3),
                    _buildDashboardIndicator(
                        title: 'Closed Tickets',
                        color: Colors.blue,
                        percentage: 0.4),
                    _buildDashboardIndicator(
                        title: 'Overdue Tickets',
                        color: Colors.orange,
                        percentage: 0.2),
                    _buildDashboardIndicator(
                        title: 'In Progress',
                        color: Colors.purple,
                        percentage: 0.1),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text('Recent Tickets',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.assignment),
                      title: Text('Ticket #$index'),
                      subtitle: Text('Description of ticket #$index'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TicketDetailScreen(
                                      title: 'Network Issue',
                                      description:
                                          'User is experiencing connectivity issues.',
                                      timeAssigned: '10:30 AM, Oct 2, 2024',
                                      timeCompleted: '1:00 PM, Oct 2, 2024',
                                      workedOnBy: 'Gilbert Awuah',
                                      createdBy: '',
                                    )));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTicketScreen()));
        },
        child: Icon(Icons.add),
        tooltip: 'Create New Ticket',
      ),
    );
  }

  Widget _buildDashboardIndicator({
    required String title,
    required Color color,
    required double percentage,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 8,
                  color: color,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
              Text('${(percentage * 100).toInt()}%',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class HomeScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Helpdesk Home')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text('Recent Tickets',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(Icons.assignment),
                            title: Text('Ticket #$index'),
                            subtitle: Text('Description of ticket #$index'),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
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
            Expanded(child: Dashboard()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTicketScreen()));
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
        Text('Dashboard',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoCard(
                    label: 'Open Tickets Today',
                    value: '10',
                    color: Colors.blue),
                InfoCard(
                    label: 'Closed Tickets Today',
                    value: '5',
                    color: Colors.red),
                InfoCard(
                    label: 'Unassigned Tickets',
                    value: '2',
                    color: Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  InfoCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.bold, color: color)),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }
}
