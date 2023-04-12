import 'package:flutter/material.dart';
import 'package:image_classification/widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Classify your image!!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/경아트리스.png',
              height: 220,
              width: 270,
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HomeCard(
                  text: 'Find photos',
                  color: Color(0xFFFFCA28),
                  icon: Icon(
                    Icons.photo_camera_back,
                    size: 60,
                  ),
                ),
                HomeCard(
                  text: 'Check Label',
                  color: Colors.cyan.shade100,
                  icon: const Icon(
                    Icons.checklist_rounded,
                    size: 60,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
