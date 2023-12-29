class ReportTypeModel {
  String title;
  String description;

  ReportTypeModel({
    this.title = "",
    this.description = ""
  });

  factory ReportTypeModel.fromJson(Map<String, dynamic> json) {
    return ReportTypeModel(
      title: json['title'] as String,
      description: json['description'] as String
    );
  }
}