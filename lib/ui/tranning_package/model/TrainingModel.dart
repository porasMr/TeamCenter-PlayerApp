class TrainingModel {
  int? status;
  String? message;
  List<Data>? data;

  TrainingModel({this.status, this.message, this.data});

  TrainingModel.fromJson(Map<String, dynamic> json) {
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
  int? clubId;
  int? staffId;
  int? groupId;
  int? fieldId;
  String? date;
  String? fromTime;
  String? untillTime;
  String? improvement;
  String? conservation;
  String? summary;

  String? createdAt;
  String? updatedAt;
  String? club_comment;
  Field? field;

  Data(
      {this.id,
      this.clubId,
      this.staffId,
      this.groupId,
      this.fieldId,
      this.date,
      this.fromTime,
      this.untillTime,
      this.improvement,
      this.conservation,
      this.summary,
      this.createdAt,
      this.updatedAt,
      this.club_comment,
      this.field});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    staffId = json['staff_id'];
    groupId = json['group_id'];
    fieldId = json['field_id'];
    date = json['date'];
    fromTime = json['from_time'];
    untillTime = json['untill_time'];
    improvement = json['improvement'].toString();
    conservation = json['conservation'].toString();
    summary = json['summary'].toString();
    club_comment = json['club_comment'].toString();

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    field = json['field'] != null ? new Field.fromJson(json['field']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['staff_id'] = this.staffId;
    data['group_id'] = this.groupId;
    data['field_id'] = this.fieldId;
    data['date'] = this.date;
    data['from_time'] = this.fromTime;
    data['untill_time'] = this.untillTime;
    data['improvement'] = this.improvement;
    data['conservation'] = this.conservation;
    data['summary'] = this.summary;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.field != null) {
      data['field'] = this.field!.toJson();
    }
    return data;
  }
}

class Field {
  int? id;
  String? name;
  String? color;
  String? status;
  String? createdAt;
  String? updatedAt;

  Field(
      {this.id,
      this.name,
      this.color,
      this.status,
      this.createdAt,
      this.updatedAt});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
