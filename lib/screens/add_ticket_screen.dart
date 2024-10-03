import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class AddTicketScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedPriority;
  final List<String> _priorities = ['High', 'Medium', 'Low'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Ticket'),
      ),
      body: FadeInUp(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Ticket Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Ticket Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4, // Allows for multiline input
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                hint: Text('Select Priority'),
                items: _priorities.map((String priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (String? value) {
                  _selectedPriority = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle ticket submission
                  String title = _titleController.text;
                  String description = _descriptionController.text;

                  if (title.isNotEmpty &&
                      description.isNotEmpty &&
                      _selectedPriority != null) {
                    // Process the ticket data (e.g., save to a database or API)
                    print('Ticket Title: $title');
                    print('Ticket Description: $description');
                    print('Ticket Priority: $_selectedPriority');

                    // Clear the fields after submission
                    _titleController.clear();
                    _descriptionController.clear();
                    _selectedPriority = null;

                    // Optionally, navigate back or show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ticket added successfully!')),
                    );
                  } else {
                    // Show error message if fields are empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
