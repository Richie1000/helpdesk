import 'package:flutter/material.dart';

import 'add_ticket_screen.dart';

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
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/we2stars.png'), // Placeholder for user profile image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                // Navigate to Dashboard
              },
            ),
            ListTile(
              leading: Icon(Icons.open_in_browser),
              title: Text('Open Tickets'),
              onTap: () {
                // Navigate to Open Tickets Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Closed Tickets'),
              onTap: () {
                // Navigate to Closed Tickets Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Overdue Tickets'),
              onTap: () {
                // Navigate to Overdue Tickets Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.incomplete_circle),
              title: Text('In Progress Tickets'),
              onTap: () {
                // Navigate to In Progress Tickets Screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout functionality
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
            children: <Widget>[
              // Search TextBox at the top
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

              // Dashboard Section with 2x2 Grid Layout
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),

              // Create a 2x2 Grid Layout for the dashboard indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GridView.count(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 16.0, // Space between columns
                  mainAxisSpacing: 16.0, // Space between rows
                  shrinkWrap: true, // Prevents GridView from taking all available space
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for the GridView itself
                  children: [
                    _buildDashboardIndicator(
                      title: 'Open Tickets',
                      color: Colors.red,
                      percentage: 0.3, // Example: 30% open tickets
                    ),
                    _buildDashboardIndicator(
                      title: 'Closed Tickets',
                      color: Colors.blue,
                      percentage: 0.4, // Example: 40% closed tickets
                    ),
                    _buildDashboardIndicator(
                      title: 'Overdue Tickets',
                      color: Colors.orange,
                      percentage: 0.2, // Example: 20% overdue tickets
                    ),
                    _buildDashboardIndicator(
                      title: 'In Progress',
                      color: Colors.purple,
                      percentage: 0.1, // Example: 10% in progress tickets
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.0), // Space between dashboard and recent tickets
              Text(
                'Recent Tickets',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),

              // List of Recent Tickets
              ListView.builder(
                itemCount: 10, // Replace with actual data count
                shrinkWrap: true, // Prevents ListView from taking all available space
                physics: NeverScrollableScrollPhysics(), // Disable scrolling for the ListView itself
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
          Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => AddTicketScreen()),
);
 
        },
        child: Icon(Icons.add),
        tooltip: 'Create New Ticket',
      ),
    );
  }

  // Helper Widget to Build the Circular Dashboard Indicator
  Widget _buildDashboardIndicator({
    required String title,
    required Color color,
    required double percentage,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0), // Add padding to separate indicators
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
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
              Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
