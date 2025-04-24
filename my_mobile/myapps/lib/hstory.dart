import 'package:flutter/material.dart';
import 'package:queuing/sidebar.dart';

class HistoryPage extends StatelessWidget {
  final String username;
  final int userId; 

  const HistoryPage({
    super.key,
    required this.username,
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
            
            },
          ),
        ],
      ),
      drawer: SideBar(username: username, email: '', userId: userId), // Pass userId to SideBar
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      'History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 'delete_all',
                          child: Text('Delete All'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 'delete_all') {
                        
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              
              Container(
                height: 3.0,
                color: Colors.grey[800],
                width: double.infinity,
              ),
              const SizedBox(height: 20),

              
              Text(
                'Logged in as: $username',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 9, 10),
                ),
              ),
              const SizedBox(height: 20),

              // Empty claimed document area
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
