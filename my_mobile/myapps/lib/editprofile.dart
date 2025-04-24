import 'package:flutter/material.dart';
import 'package:queuing/profile.dart';

class EditProfile extends StatefulWidget {
  final int userId; // Expect an int for userId

  const EditProfile({super.key, required this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  bool _isBackButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isBackButtonVisible = _scrollController.offset <= 0;
      });
    });
  }

  void saveProfile() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        contactController.text.isEmpty ||
        addressController.text.isEmpty) {
      _showDialog("Please fill in all fields");
      return;
    }

    _showSuccessDialog();
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

 void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Success"),
      content: const Text("Profile updated successfully"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Profile(
                  username: '', 
                  email: '', 
                  userId: widget.userId, // Pass userId as int
                ),
              ),
            );
          },
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity, // Ensure background covers full screen
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
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Circle Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          // Add logic to update profile picture
                        },
                        backgroundColor: Colors.lightBlueAccent,
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Edit Your Profile Text
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Input Section inside a card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                            controller: firstNameController,
                            label: "First Name",
                            icon: Icons.person_outline),
                        const SizedBox(height: 20),
                        _buildTextField(
                            controller: lastNameController,
                            label: "Last Name",
                            icon: Icons.person),
                        const SizedBox(height: 20),
                        _buildTextField(
                            controller: emailController,
                            label: "Email Address",
                            icon: Icons.email_outlined),
                        const SizedBox(height: 20),
                        _buildTextField(
                            controller: contactController,
                            label: "Contact Number",
                            icon: Icons.phone_iphone),
                        const SizedBox(height: 20),
                        _buildTextField(
                            controller: addressController,
                            label: "Address",
                            icon: Icons.location_on),
                      ],
                    ),
                  ),

                  const SizedBox(height: 45),

                  // Save Button with reduced width and padding
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            if (_isBackButtonVisible)
              Positioned(
                top: 45,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 6, 9, 12),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(icon, color: Colors.lightBlueAccent),
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        hintStyle: const TextStyle(color: Color.fromARGB(255, 94, 88, 88)),
        labelStyle: const TextStyle(color: Color.fromARGB(221, 0, 0, 0)),
      ),
    );
  }
}
