class GetMemberMinishopProductSheetModel {
  bool? success;
  List<Data>? data;

  GetMemberMinishopProductSheetModel({this.success, this.data});

  GetMemberMinishopProductSheetModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? reportTypeNo;
  String? title;
  String? description;

  Data({this.reportTypeNo, this.title, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    reportTypeNo = json['reportTypeNo'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportTypeNo'] = this.reportTypeNo;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
