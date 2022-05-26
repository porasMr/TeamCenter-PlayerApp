class CountryModel {
  int? status;
  String? message;
  List<Data>? data;

  CountryModel({this.status, this.message, this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? countryEng;
  String? countryHb;

  Data({this.id, this.countryEng, this.countryHb});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryEng = json['country_eng'];
    countryHb = json['country_hb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_eng'] = this.countryEng;
    data['country_hb'] = this.countryHb;
    return data;
  }
}
