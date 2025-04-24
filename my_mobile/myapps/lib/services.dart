import 'package:flutter/material.dart';
import 'package:queuing/certificateform.dart' ;
import 'package:queuing/clearanceform.dart' ;
import 'package:queuing/idform.dart';
import 'package:queuing/indigencyform.dart';
import 'package:queuing/sidebar.dart';

class Services extends StatelessWidget {
  final String username;
  final String email;
  final int userId; // Ensure userId is an int

  const Services({
    super.key,
    required this.username,
    required this.email,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Notification function here
            },
          ),
        ],
      ),
      drawer: SideBar(
        username: username,
        email: email,
        userId: userId, // Pass userId to SideBar
      ),
      body: Container(
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 36.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                border: Border.all(
                  color: Colors.blue,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Services',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 6,
              width: double.infinity,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 14),
            const Text(
              'Note: Barangay Permit is not available in these services',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 61, 56, 56),
              ),
            ),
            const SizedBox(height: 16),
            serviceButton(
              context,
              'Barangay ID',
              'assets/pictures/id.png',
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BarangayIdForm(
                      userId: userId,
                      username: username,
                      email: email,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            serviceButton(
              context,
              'Barangay Indigency',
              'assets/pictures/cert.png',
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => IndigencyForm(
                      userId: userId,
                      username: username,
                      email: email,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            serviceButton(
              context,
              'Barangay Certificate',
              'assets/pictures/cert.png',
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CertificateForm(
                      userId: userId,
                      username: username,
                      email: email
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            serviceButton(
              context,
              'Barangay Clearance',
              'assets/pictures/cert.png',
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ClearanceForm(
                     
                      username: username,
                      email: email,
                      userId: userId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceButton(BuildContext context, String serviceName,
      String imagePath, Function onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        backgroundColor: const Color(0xFFEEEEEE),
        side: const BorderSide(color: Colors.blue, width: 1),
        shadowColor: const Color.fromARGB(255, 14, 13, 13),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            serviceName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Image.asset(
            imagePath,
            height: 50,
            width: 107,
          ),
        ],
      ),
    );
  }
}


