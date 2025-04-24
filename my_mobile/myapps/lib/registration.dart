import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:queuing/login.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _passwordsMatch = true;

  // Function to validate email format
  bool isEmailValid(String email) {
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  // Registration function
  void register() async {
    String url = "http://192.168.1.11/mybackend/register.php"; // Update with your server's URL

    final Map<String, dynamic> body = {
      
      'FNAME': firstNameController.text,
      'LNAME': lastNameController.text,
      'username': usernameController.text,
      'email': emailController.text,
      'contact': contactController.text,
      'address': addressController.text,
      'password': passwordController.text,
       
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          _showSuccessDialog(); // Show success dialog on successful registration
        } else {
          _showDialog(data['message'] ?? 'Registration failed.');
        }
      } else {
        _showDialog("Failed to connect to the server.");
      }
    } catch (error) {
      _showDialog("Error: $error");
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Sign up successfully"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog first
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyApp()), // Navigate to login page
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2396AA),
                  Color(0xFFCBECFD),
                  Color(0xFF8ADAFE),
                  Color(0xFFAEE1E9),
                  Color(0xFF2396AA),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text("SIGN UP", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 50),
                  buildNameFields(),
                  buildTextField(usernameController, 'Username'),
                  buildTextField(emailController, 'Email Address'),
                  buildTextField(contactController, 'Contact Number'),
                  buildTextField(addressController, 'Address'),
                  buildPasswordFields(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Validation checks before registration
                      if ([firstNameController, lastNameController, usernameController, emailController, contactController, addressController, passwordController, rePasswordController].any((c) => c.text.isEmpty)) {
                        _showDialog("Fill out all fields.");
                      } else if (!isEmailValid(emailController.text)) {
                        _showDialog("Please enter a valid email address.");
                      } else if (passwordController.text != rePasswordController.text) {
                        setState(() => _passwordsMatch = false);
                        _showDialog("Passwords do not match.");
                      } else {
                        register(); // Call the register function here
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp())),
                    child: const Text('Already have an account? Sign In', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNameFields() => Row(
        children: [
          Expanded(child: buildTextField(firstNameController, 'First Name')),
          const SizedBox(width: 10),
          Expanded(child: buildTextField(lastNameController, 'Last Name')),
        ],
      );

  Widget buildTextField(TextEditingController controller, String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          ),
        ),
      );

  Widget buildPasswordFields() => Column(
        children: [
          buildPasswordField(passwordController, 'Password', true),
          buildPasswordField(rePasswordController, 'Re-enter Password', false),
        ],
      );

  Widget buildPasswordField(TextEditingController controller, String label, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : !_passwordsMatch,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          suffixIcon: IconButton(
            icon: Icon(isPassword ? (_obscurePassword ? Icons.visibility : Icons.visibility_off) : Icons.clear, color: Colors.red),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        onChanged: (text) {
          setState(() {
            _passwordsMatch = (text == passwordController.text);
          });
        },
      ),
    );
  }
}
