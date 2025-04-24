import 'package:flutter/material.dart';
import 'package:queuing/login.dart'; // Import your login page

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  CreateNewPasswordPageState createState() => CreateNewPasswordPageState();
}

class CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to show success dialog and navigate to login page
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Password reset successfully"),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and navigate to login page
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(35, 150, 170, 1),
                  Color.fromRGBO(203, 226, 253, 1),
                  Color.fromRGBO(138, 218, 255, 1),
                  Color.fromRGBO(174, 225, 233, 1),
                  Color.fromRGBO(35, 150, 170, 1),
                ],
                stops: [0.01, 0.26, 0.50, 0.76, 1.0],
              ),
            ),
          ),

          Positioned(
            top: 45,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigates back
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle, // Makes the background circular
                ),
                child: const Icon(
                  Icons.arrow_back, // Back arrow icon
                  color: Color.fromARGB(255, 6, 9, 12), // Icon color
                ),
              ),
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create New Password',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your new password must be unique from',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const Text(
                    'those previously used.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 40),

                  // New Password field
                  TextField(
                    controller: _newPasswordController,
                    obscureText:
                        _obscureNewPassword, // Toggle password visibility
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      floatingLabelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      suffixIcon: _newPasswordController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                _obscureNewPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureNewPassword =
                                      !_obscureNewPassword; // Toggle the eye icon
                                });
                              },
                            )
                          : null, // Show eye icon only when there is text
                    ),
                    onChanged: (value) {
                      setState(
                          () {}); // Trigger UI update to show/hide the eye icon
                    },
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password field
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText:
                        _obscureConfirmPassword, // Toggle password visibility
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      floatingLabelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      suffixIcon: _confirmPasswordController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword; // Toggle the eye icon
                                });
                              },
                            )
                          : null, // Show eye icon only when there is text
                    ),
                    onChanged: (value) {
                      setState(
                          () {}); // Trigger UI update to show/hide the eye icon
                    },
                    style: const TextStyle(color: Colors.blueGrey),
                    cursorColor: Colors.blue,
                  ),

                  const SizedBox(height: 40),

                  // Reset Password Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Show success dialog when button is pressed
                        _showSuccessDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
