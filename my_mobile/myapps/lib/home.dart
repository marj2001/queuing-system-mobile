import 'package:flutter/material.dart';
import 'package:queuing/sidebar.dart';
import 'notification.dart'; // Import the new NotificationPage

class HomePage extends StatelessWidget {
  final String username;
  final String email;
  final int userId;

  const HomePage({
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationsPage(
          userId: userId,
          username: username,
          email: email,
        ),
      ),
    );
  },
),

        ],
        title: const Text(""),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: SideBar(username: username, email: email, userId: userId),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFAFE1E9),
              Color(0xFF87CEEA),
              Color(0xFFAFE1E9),
              Color(0xFF68ADB8),
            ],
            stops: [0.0, 0.08, 0.24, 0.93],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "WELCOME TO",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montaga',
                ),
              ),
              const Text(
                "QUEUING",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montaga',
                ),
              ),
              const Text(
                "SYSTEM",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montaga',
                ),
              ),
              const Text(
                "A Better Queue for a Better Community",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montaga',
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/pictures/el.png',
                  height: 350,
                  width: 360,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: List.generate(4, (index) => buildMenuItem(index)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(int index) {
    final List<String> titles = ["ID", "INDIGENCY", "CERTIFICATE", "RESIDENCY"];
    return GestureDetector(
      onTap: () {
        // Define what happens on tap (navigation logic, etc.)
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: Image.asset('assets/pictures/logo.png', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'BARANGAY',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    titles[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
