import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpdesk/models/company.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  CompanyType? _selectedType;

  Future<void> _submitCompany() async {
    if (_formKey.currentState!.validate()) {
      try {
        final company = Company(
          name: _nameController.text.trim(),
          type: _selectedType!,
        );

        await FirebaseFirestore.instance
            .collection('settings')
            .doc('companies')
            .set({
          'companies': FieldValue.arrayUnion([company.toJson()])
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Company added successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Widget _buildForm(bool isDesktop) {
    final formFields = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Company Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
          value == null || value.trim().isEmpty ? 'Name required' : null,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownButtonFormField<CompanyType>(
          value: _selectedType,
          items: CompanyType.values.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type.name[0].toUpperCase() + type.name.substring(1)),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: 'Type',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => _selectedType = value),
          validator: (value) => value == null ? 'Please select a type' : null,
        ),
      ),
    ];

    return isDesktop
        ? Row(
      children: [Expanded(child: Column(children: formFields))],
    )
        : Column(children: formFields);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 600;
        return Scaffold(
          appBar: AppBar(title: const Text('Add Company')),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      _buildForm(isDesktop),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _submitCompany,
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
