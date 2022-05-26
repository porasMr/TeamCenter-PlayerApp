class TimeSlotModel {
  int? status;
  String? message;
  List<Time>? time;
  List<Level>? level;

  TimeSlotModel({this.status, this.message, this.time, this.level});

  TimeSlotModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['time'] != null) {
      time = <Time>[];
      json['time'].forEach((v) {
        time!.add(new Time.fromJson(v));
      });
    }
    if (json['level'] != null) {
      level = <Level>[];
      json['level'].forEach((v) {
        level!.add(new Level.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.time != null) {
      data['time'] = this.time!.map((v) => v.toJson()).toList();
    }
    if (this.level != null) {
      data['level'] = this.level!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Time {
  int? id;
  String? time;
  String? createdAt;
  String? updatedAt;

  Time({this.id, this.time, this.createdAt, this.updatedAt});

  Time.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Level {
  int? id;
  String? engName;
  String? hebName;
  String? createdAt;
  String? updatedAt;

  Level({this.id, this.engName, this.hebName, this.createdAt, this.updatedAt});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engName = json['eng_name'];
    hebName = json['heb_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eng_name'] = this.engName;
    data['heb_name'] = this.hebName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
