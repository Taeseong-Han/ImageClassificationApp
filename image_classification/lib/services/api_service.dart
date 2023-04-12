import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_classification/models/analysis_model.dart';
import 'package:photo_manager/photo_manager.dart';

class ApiService {
  static const String baseUrl =
      'https://29e5-163-152-158-198.ngrok-free.app/classify';

  static Future<AnalysisModel> getAnalysis({required AssetEntity file}) async {
    final url = Uri.parse(baseUrl);
    var file_ = await file.file;
    var request = http.MultipartRequest(
      'POST',
      url,
    );

    request.files.add(await http.MultipartFile.fromPath('file', file_!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final jsonBody = await response.stream.bytesToString();
      return AnalysisModel.fromJson(jsonDecode(jsonBody));
    }
    throw Error();
  }
}
