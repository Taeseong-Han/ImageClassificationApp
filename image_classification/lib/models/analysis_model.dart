class AnalysisModel {
  final List<dynamic>? predict, probability;

  AnalysisModel.fromJson(Map<String, dynamic> json)
      : predict = json['top3_label'],
        probability = json['top3_probability'];
}
