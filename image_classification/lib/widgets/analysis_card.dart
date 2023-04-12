import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  final String text;
  final IconData icon;
  const AnalysisCard({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      height: 160,
      decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          Icon(
            icon,
            size: 70,
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
