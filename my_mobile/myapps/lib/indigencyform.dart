import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class IndigencyForm extends StatefulWidget {
  final int userId;
  final String username;
  final String email;

  const IndigencyForm({
    super.key,
    required this.userId,
    required this.username,
    required this.email,
  });

  @override
  IndigencyFormState createState() => IndigencyFormState();
}

class IndigencyFormState extends State<IndigencyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _birthDateController.text = '';
  }

  void _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _birthDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _confirmAndSubmitForm() async {
    if (_formKey.currentState!.validate()) {
      final bool? confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm Submission"),
          content: const Text("Are you sure you want to submit this form?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Submit"),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await _submitForm();
      }
    }
  }

  void clearForm() {
    _firstNameController.clear();
    _middleNameController.clear();
    _lastNameController.clear();
    _birthDateController.clear();
    _addressController.clear();
    _purposeController.clear();
  }

  Future<void> _submitForm() async {
    final url = Uri.parse('http://192.168.1.11/mybackend/submit_indigency.php');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'user_id': widget.userId,
        'service_id': 2,
        'first_name': _firstNameController.text,
        'middle_name': _middleNameController.text,
        'last_name': _lastNameController.text,
        'birth_date': _birthDateController.text,
        'address': _addressController.text,
        'purpose': _purposeController.text,
      }),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success']) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Request Successful"),
            content: const Text("Your request has been submitted successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  clearForm();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: ${result['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'BARANGAY INDIGENCY APPLICATION FORM',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField('First Name', _firstNameController),
                const SizedBox(height: 10),
                _buildTextField('Middle Name', _middleNameController),
                const SizedBox(height: 10),
                _buildTextField('Last Name', _lastNameController),
                const SizedBox(height: 10),
                _buildTextField(
                  'Birth Date',
                  _birthDateController,
                  keyboardType: TextInputType.datetime,
                  isDateField: true,
                ),
                const SizedBox(height: 10),
                _buildTextField('Address', _addressController),
                const SizedBox(height: 10),
                _buildPurposeField(),
                const SizedBox(height: 20),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool isDateField = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: isDateField,
      onTap: () {
        if (isDateField) _selectBirthDate(context);
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 1.8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildPurposeField() {
    return TextFormField(
      controller: _purposeController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'What is the Purpose of the Document?',
        labelStyle: const TextStyle(fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 1.8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the purpose';
        }
        return null;
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _confirmAndSubmitForm,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Submit'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
