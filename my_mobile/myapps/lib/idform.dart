import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BarangayIdForm extends StatefulWidget { 
  final int userId;
  final String username;
  final String email;

  const BarangayIdForm({
    super.key,
    required this.userId,
    required this.username,
    required this.email,
  });

  @override
  BarangayIdFormState createState() => BarangayIdFormState();
}

class BarangayIdFormState extends State<BarangayIdForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _emergencyContactNumberController = TextEditingController();

  String? _civilStatus;
  String? _registeredVoter;
  DateTime? _selectedDate;
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage1;
  XFile? _selectedImage2;
  XFile? _selectedImage3;
  bool _isLoading = false; // For loading indicator

  Future<void> _pickImage(ImageSource source, int imageIndex) async {
  try {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null && mounted) { // Check if widget is still mounted
      setState(() {
        if (imageIndex == 1) {
          _selectedImage1 = image;
        } else if (imageIndex == 2) {
          _selectedImage2 = image;
        } else if (imageIndex == 3) {
          _selectedImage3 = image;
        }
      });
    }
  } catch (e) {
    if (mounted) { // Check if widget is still mounted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }
}

// Inside BarangayIdFormState class
Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedDate ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  
  if (picked != null && picked != _selectedDate && mounted) {
    setState(() {
      _selectedDate = picked;
      _dobController.text = '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';
    });
  }
}

Future<void> _showLoadingDialog() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Submitting, please wait..."),
          ],
        ),
      );
    },
  );
}

Future<void> _submitForm() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _isLoading = true; // Set loading state to true
  });

  _showLoadingDialog();

  try {
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.40.39/mybackend/submit_barangayid.php'));
    request.fields['user_id'] = widget.userId.toString();
    request.fields['first_name'] = _firstNameController.text;
    request.fields['middle_name'] = _middleNameController.text;
    request.fields['last_name'] = _lastNameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['date_of_birth'] = _dobController.text;
    request.fields['address'] = _addressController.text;
    request.fields['contact_number'] = _contactNumberController.text;
    request.fields['civil_status'] = _civilStatus ?? '';
    request.fields['registered_voter'] = _registeredVoter ?? '';
    request.fields['emergency_contact_name'] = _emergencyContactController.text;
    request.fields['emergency_contact_number'] = _emergencyContactNumberController.text;

    if (_selectedImage1 != null) {
      request.files.add(await http.MultipartFile.fromPath('valid_id_image', _selectedImage1!.path));
    }
    if (_selectedImage2 != null) {
      request.files.add(await http.MultipartFile.fromPath('passport_size_image', _selectedImage2!.path));
    }
    if (_selectedImage3 != null) {
      request.files.add(await http.MultipartFile.fromPath('signature_image', _selectedImage3!.path));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseData);

    if (mounted) {
      Navigator.pop(context); // Close loading dialog
    }

    if (response.statusCode == 200 && jsonResponse['success'] == true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${jsonResponse['message']}')),
        );
      }
    }
  } catch (e) {
    if (mounted) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission failed: $e')),
      );
    }
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }
}




  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'BARANGAY ID APPLICATION FORM',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                _buildTextField('First Name', _firstNameController),
                const SizedBox(height: 10),
                _buildTextField('Middle Name', _middleNameController),
                const SizedBox(height: 10),
                _buildTextField('Last Name', _lastNameController),
                const SizedBox(height: 10),
                _buildTextField('Email', _emailController, TextInputType.emailAddress),
                const SizedBox(height: 10),

                const Text('Date of Birth:', style: TextStyle(fontFamily: 'Lexend')),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of birth',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildTextField('Address', _addressController),
                const SizedBox(height: 10),
                _buildTextField('Contact Number', _contactNumberController, TextInputType.phone),
                const SizedBox(height: 10),

                const Text('Civil Status:', style: TextStyle(fontFamily: 'Lexend')),
                const SizedBox(height: 5),
                _buildDropdownField(
                  'Select Civil Status',
                  ['Single', 'Married', 'Widow', 'Separated'],
                  (String? newValue) {
                    setState(() {
                      _civilStatus = newValue;
                    });
                  },
                  _civilStatus,
                ),
                const SizedBox(height: 10),

                const Text('Registered Voter:', style: TextStyle(fontFamily: 'Lexend')),
                const SizedBox(height: 5),
                _buildDropdownField(
                  'Select Voter Status',
                  ['Yes', 'No'],
                  (String? newValue) {
                    setState(() {
                      _registeredVoter = newValue;
                    });
                  },
                  _registeredVoter,
                ),
                const SizedBox(height: 20),

                _buildUploadField('Upload Valid ID for Verification', 1),
                if (_selectedImage1 != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Selected File: ${_selectedImage1!.name}',
                      style: const TextStyle(color: Colors.blue, fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ),
                const SizedBox(height: 10),

                _buildUploadField('Upload Photo (PASSPORT SIZE or 2x2)', 2),
                if (_selectedImage2 != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Selected File: ${_selectedImage2!.name}',
                      style: const TextStyle(color: Colors.blue, fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ),
                const SizedBox(height: 10),

                _buildUploadField('Upload Photo of Signature (White Background)', 3),
                if (_selectedImage3 != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Selected File: ${_selectedImage3!.name}',
                      style: const TextStyle(color: Colors.blue, fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ),
                const SizedBox(height: 30),
                
                _buildTextField('Emergency Contact Person', _emergencyContactController),
                const SizedBox(height: 10),
                _buildTextField('Emergency Contact Number', _emergencyContactNumberController, TextInputType.phone),
                const SizedBox(height: 20),

                _buildSubmitButton(),
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
      ],
    ),
  );
}


  Widget _buildTextField(String label, TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String label, List<String> options, Function(String?) onChanged, String? selectedValue) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildUploadField(String label, int imageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text('Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery, imageIndex);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Camera'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera, imageIndex);
                      },
                    ),
                  ],
                );
              },
            );
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black, width: 1.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: const Text(
            'Add File',
            style: TextStyle(color: Colors.blue, fontFamily: 'Lexend'),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: _isLoading ? null : _submitForm,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Submit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}


