import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpdesk/models/ticket.dart';
import 'package:helpdesk/models/user.dart';
import 'package:helpdesk/models/company.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({super.key});

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _statusController = TextEditingController();
  final _priorityController = TextEditingController();
  final _scoreController = TextEditingController();

  List<Company> _companies = [];
  Company? _selectedCompany;

  List<LoggedUser> _users = [];
  LoggedUser? _selectedUser;

  @override
  void initState() {
    super.initState();
    _fetchCompanies();
    _fetchUsers();
  }

  Future<void> _fetchCompanies() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('settings')
        .doc('companies')
        .get();

    final List<dynamic> companyList = snapshot.data()?['companies'] ?? [];
    setState(() {
      _companies = companyList.map((c) => Company.fromJson(c)).toList();
    });
  }

  Future<void> _fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      _users = snapshot.docs
          .map((doc) => LoggedUser.fromJson(doc.data()))
          .toList();
    });
  }

  Future<void> _submitTicket() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCompany == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a company.')),
        );
        return;
      }

      try {
        final docRef = FirebaseFirestore.instance.collection('tickets').doc();

        final ticket = Ticket(
          id: DateTime.now().millisecondsSinceEpoch,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          status: _statusController.text.trim(),
          assignedTo: _selectedUser,
          priority: _priorityController.text.trim(),
          score: int.parse(_scoreController.text.trim()),
          company: _selectedCompany!,
        );

        await docRef.set({
          ...ticket.toJson(),
          'firebaseId': docRef.id,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket submitted successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Required';
          if (isNumber && int.tryParse(value.trim()) == null) return 'Invalid number';
          return null;
        },
      ),
    );
  }

  Widget _buildDropdowns() {
    return Column(
      children: [
        DropdownButtonFormField<Company>(
          value: _selectedCompany,
          decoration: const InputDecoration(labelText: 'Select Company'),
          items: _companies.map((company) {
            return DropdownMenuItem(
              value: company,
              child: Text('${company.name} (${company.type.name})'),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedCompany = value),
          validator: (value) => value == null ? 'Please select a company' : null,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<LoggedUser>(
          value: _selectedUser,
          decoration: const InputDecoration(labelText: 'Assign to (optional)'),
          items: _users.map((user) {
            return DropdownMenuItem(
              value: user,
              child: Text(user.name),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedUser = value),
        ),
      ],
    );
  }

  Widget _buildFormFields(bool isDesktop) {
    final fields = [
      _buildTextField(_titleController, 'Title'),
      _buildTextField(_descriptionController, 'Description'),
      _buildTextField(_statusController, 'Status'),
      _buildTextField(_priorityController, 'Priority'),
      _buildTextField(_scoreController, 'Score', isNumber: true),
    ];

    if (!isDesktop) {
      return Column(children: [
        ...fields,
        const SizedBox(height: 16),
        _buildDropdowns(),
      ]);
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              ...fields.sublist(0, (fields.length / 2).ceil()),
              const SizedBox(height: 16),
              _buildDropdowns(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: fields.sublist((fields.length / 2).ceil()),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(title: const Text('Add Ticket')),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      _buildFormFields(isDesktop),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _submitTicket,
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
