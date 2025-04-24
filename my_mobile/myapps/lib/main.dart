import 'package:flutter/material.dart';
import 'package:queuing/login.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft, // Start from left
            end: Alignment.centerRight, // End at right
            colors: [
              Color.fromRGBO(35, 150, 170, 1), // rgba(35,150,170,1) 1%
              Color.fromRGBO(203, 226, 253, 1), // rgba(203,226,253,1) 26%
              Color.fromRGBO(138, 218, 255, 1), // rgba(138,218,255,1) 50%
              Color.fromRGBO(174, 225, 233, 1), // rgba(174,225,233,1) 76%
              Color.fromRGBO(35, 150, 170, 1), // rgba(35,150,170,1) 100%
            ],
            stops: [
              0.01,
              0.26,
              0.50,
              0.76,
              1.0
            ], // Adjust color stops to match percentages
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Picture placeholder
                    Image.asset(
                        'assets/pictures/logo.png'), // Replace with your image
                    const SizedBox(height: 20),

                    // Text below the picture
                    const Text(
                      'Barangay San Jose',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montaga'),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Queuing System',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montaga'),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Get Started button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyApp(), // Your login page class
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color.fromARGB(
                          255, 29, 136, 224), // Button color
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                      height:
                          40), // Adjust this value to move button further down
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
