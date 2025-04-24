import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final int userId;
  final String username;
  final String email;

  const NotificationsPage({
    super.key,
    required this.userId,
    required this.username,
    required this.email,
  });

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Page Title
                  Text(
                    "Notifications for ${widget.username}",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Notifications List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10, // Replace with your notification count
                    itemBuilder: (context, index) {
                      return _buildNotificationItem(
                        icon: Icons.notifications,
                        title: "You have a new document request!",
                        description:
                            "Hello ${widget.username}, check your dashboard for details.",
                        time: "5 mins ago",
                        isNew: index < 3, // Mark first 3 notifications as new
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Back Button
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

  // Build Notification Item
  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: isNew ? Colors.lightBlue.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notification Icon
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 15),

          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
