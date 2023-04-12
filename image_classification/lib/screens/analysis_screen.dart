import 'package:flutter/material.dart';
import 'package:image_classification/services/api_service.dart';
import 'package:image_classification/widgets/analysis_card.dart';
import 'package:photo_manager/photo_manager.dart';

class AnalysisScreen extends StatelessWidget {
  final AssetEntity file;

  const AnalysisScreen({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiService.getAnalysis(file: file),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      AnalysisCard(
                        text:
                            '${snapshot.data!.predict![0]}\n확률: ${snapshot.data!.probability![0]}',
                        icon: Icons.looks_one_rounded,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AnalysisCard(
                        text:
                            '${snapshot.data!.predict![1]}\n확률: ${snapshot.data!.probability![1]}',
                        icon: Icons.looks_two_rounded,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AnalysisCard(
                        text:
                            '${snapshot.data!.predict![2]}\n확률: ${snapshot.data!.probability![2]}',
                        icon: Icons.looks_3_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
