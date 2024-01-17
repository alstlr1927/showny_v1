class BattleModel {
  String styleupBattleNo;
  String title;
  String thumbnailUrl;
  String recruitmentStart;
  String recruitmentEnd;
  String participationStart;
  String participationEnd;
  String status;
  String progress;

  BattleModel({
    this.styleupBattleNo = "",
    this.title = "",
    this.thumbnailUrl = "",
    this.recruitmentStart = "",
    this.recruitmentEnd = "",
    this.participationStart = "",
    this.participationEnd = "",
    this.status = "",
    this.progress = "",
  });

  factory BattleModel.fromJson(Map<String, dynamic> json) {
    return BattleModel(
      styleupBattleNo: json['styleupBattleNo'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      recruitmentStart: json['recruitmentStart'] as String,
      recruitmentEnd: json['recruitmentEnd'] as String,
      participationStart: json['participationStart'] as String,
      participationEnd: json['participationEnd'] as String,
      status: json['status'] as String,
      progress: json['progress'] as String,
    );
  }

  BattleModel copyWith({
    String? styleupBattleNo,
    String? title,
    String? thumbnailUrl,
    String? recruitmentStart,
    String? recruitmentEnd,
    String? participationStart,
    String? participationEnd,
    String? status,
    String? progress,
  }) =>
      BattleModel(
        styleupBattleNo: styleupBattleNo ?? this.styleupBattleNo,
        title: title ?? this.title,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        recruitmentStart: recruitmentStart ?? this.recruitmentStart,
        recruitmentEnd: recruitmentEnd ?? this.recruitmentEnd,
        participationStart: participationStart ?? this.participationStart,
        participationEnd: participationEnd ?? this.participationEnd,
        status: status ?? this.status,
        progress: progress ?? this.progress,
      );
}
