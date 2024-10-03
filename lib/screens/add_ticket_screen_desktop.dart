import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart'; // Import the lottie package

class AddTicketScreenDesktop extends StatefulWidget {
  @override
  _AddTicketScreenDesktopState createState() => _AddTicketScreenDesktopState();
}

class _AddTicketScreenDesktopState extends State<AddTicketScreenDesktop> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _partnerNameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedSeverity;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/success.json', // Path to your Lottie file
                width: 100,
                height: 100,
              ),
              SizedBox(height: 16.0),
              Text('Ticket added successfully!'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the AddTicketScreenDesktop
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add a New Ticket',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                // Left section
                Expanded(
                  // Adjust the flex value to control the width ratio
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: screenWidth *
                            0.75, // Text field width is 75% of screen width
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Title of Ticket',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the title of the ticket';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: screenWidth *
                            0.75, // Text field width is 75% of screen width
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4, // Allows multi-line input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: screenWidth *
                            0.75, // Text field width is 75% of screen width
                        child: TextFormField(
                          controller: _partnerNameController,
                          decoration: InputDecoration(
                            labelText: 'Partner Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the partner name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Card(
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Date of Ticket',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDate == null
                                          ? 'No date chosen'
                                          : 'Date: ${DateFormat.yMd().format(_selectedDate!)}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  ElevatedButton(
                                    onPressed: () => _selectDate(context),
                                    child: Text('Select date'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedTime == null
                                          ? 'No time chosen'
                                          : 'Time: ${_selectedTime!.format(context)}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  ElevatedButton(
                                    onPressed: () => _selectTime(context),
                                    child: Text('Select time'),
                                  ),
                                ],
                              ),
                              if (_selectedDate != null &&
                                  _selectedTime != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    'Selected Date and Time: ${DateFormat.yMd().format(_selectedDate!)} ${_selectedTime!.format(context)}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: screenWidth *
                            0.75, // Dropdown button width is 75% of screen width
                        child: DropdownButtonFormField<String>(
                          value: _selectedSeverity,
                          decoration: InputDecoration(
                            labelText: 'Severity',
                            border: OutlineInputBorder(),
                          ),
                          items: ['Level 1', 'Level 2', 'Level 3']
                              .map((severity) => DropdownMenuItem(
                                    value: severity,
                                    child: Text(severity),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSeverity = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select the severity level';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Center(
                        child: SizedBox(
                          width: screenWidth *
                              0.25, // Button width is 25% of screen width
                          child: ElevatedButton(
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              //   // Display success dialog
                              //   _showSuccessDialog();
                              // }
                              _showSuccessDialog();
                            },
                            child: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Right section
                Expanded(
                  flex: 1, // Adjust the flex value to control the width ratio
                  child: Container(
                      // Optionally, add content or leave as empty space

                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
