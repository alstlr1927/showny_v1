class GoodsQnaModel {
  String sno;
  String goodsImgUrl;
  String nickNm;
  String goodsNm;
  String brandNm;
  String subject;
  String contents;
  String isSecret;
  String replyStatus;
  String answerModDt;
  String answerSubject;
  String answerContents;
  String regDt;

  GoodsQnaModel({
    this.sno = "",
    this.goodsImgUrl = "",
    this.nickNm = "",
    this.goodsNm = "",
    this.brandNm = "",
    this.subject = "",
    this.contents = "",
    this.isSecret = "",
    this.replyStatus = "",
    this.answerModDt = "",
    this.answerSubject = "",
    this.answerContents = "",
    this.regDt = "",
  });

  factory GoodsQnaModel.fromJson(Map<String, dynamic> json) {
    return GoodsQnaModel(
      sno: json['sno'] as String? ?? "",
      goodsImgUrl: json['goodsImgUrl'] as String? ?? "",
      nickNm: json['nickNm'] as String? ?? "",
      goodsNm: json['goodsNm'] as String? ?? "",
      brandNm: json['brandNm'] as String? ?? "",
      subject: json['subject'] as String? ?? "",
      contents: json['contents'] as String? ?? "",
      isSecret: json['isSecret'] as String? ?? "",
      replyStatus: json['replyStatus'] as String? ?? "",
      answerModDt: json['answerModDt'] as String? ?? "",
      answerSubject: json['answerSubject'] as String? ?? "",
      answerContents: json['answerContents'] as String? ?? "",
      regDt: json['regDt'] as String? ?? "",
    );
  }
}
