import '../../professional_package/model/SelectedModel.dart';

class TrainingDetailModel {
  int? status;
  String? message;
  List<Data>? data;

  TrainingDetailModel({this.status, this.message, this.data});

  TrainingDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
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
  dynamic improvement;
  dynamic conservation;
  dynamic summary;
  dynamic images;
  String? club_comment;
  dynamic deletedBy;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  Field? field;
  List<Attendances>? attendances;
  List<TPlans>? plans;

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
      this.images,
      this.club_comment,
      this.deletedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.field,
      this.attendances,
      this.plans});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    staffId = json['staff_id'];
    groupId = json['group_id'];
    fieldId = json['field_id'];
    date = json['date'];
    fromTime = json['from_time'];
    untillTime = json['untill_time'];
    improvement = json['improvement'];
    conservation = json['conservation'];
    summary = json['summary'];
    images = json['images'];
    club_comment = json['club_comment'].toString();
    deletedBy = json['deleted_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    field = json['field'] != null ? new Field.fromJson(json['field']) : null;
    if (json['attendances'] != null) {
      attendances = <Attendances>[];
      json['attendances'].forEach((v) {
        attendances!.add(new Attendances.fromJson(v));
      });
    }
    if (json['plans'] != null) {
      plans = <TPlans>[];
      json['plans'].forEach((v) {
        plans!.add(new TPlans.fromJson(v));
      });
    }
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
    data['images'] = this.images;
    data['club_comment'] = this.club_comment;
    data['deleted_by'] = this.deletedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.field != null) {
      data['field'] = this.field!.toJson();
    }
    if (this.attendances != null) {
      data['attendances'] = this.attendances!.map((v) => v.toJson()).toList();
    }
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Field {
  int? id;
  String? name;
  int? clubId;
  String? color;
  String? status;

  Field({
    this.id,
    this.name,
    this.clubId,
    this.color,
    this.status,
  });

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clubId = json['club_id'];
    color = json['color'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['club_id'] = this.clubId;
    data['color'] = this.color;
    data['status'] = this.status;

    return data;
  }
}

class Attendances {
  int? id;
  int? staffId;
  int? allAttend;
  int? trainingId;
  int? playerId;
  String? isLate;
  String? isAttend;
  String? createdAt;
  String? updatedAt;
  Player? player;

  Attendances(
      {this.id,
      this.staffId,
      this.allAttend,
      this.trainingId,
      this.playerId,
      this.isLate,
      this.isAttend,
      this.createdAt,
      this.updatedAt,
      this.player});

  Attendances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    allAttend = json['allAttend'];
    trainingId = json['training_id'];
    playerId = json['player_id'];
    isLate = json['is_late'].toString();
    isAttend = json['is_attend'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    player =
        json['player'] != null ? new Player.fromJson(json['player']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['allAttend'] = this.allAttend;
    data['training_id'] = this.trainingId;
    data['player_id'] = this.playerId;
    data['is_late'] = this.isLate;
    data['is_attend'] = this.isAttend;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    return data;
  }
}

class Player {
  int? id;
  int? clubId;
  String? status;
  String? firstName;
  String? lastName;
  String? positionId;
  int? staffId;
  String? createdBy;
  String? groupId;
  String? shirtNumber;
  int? isCaptian;
  String? loginMobileNumber;
  String? height;
  String? weight;
  String? fat;
  String? muscle;
  String? profile;
  // int? country;
  // String? city;
  // int? yellowCard;
  // int? redCard;
  // String? address;
  // String? dob;
  // int? foot;
  // String? contactType;
  // String? otherContactType;
  // String? contactName;
  // String? phoneNumber;
  // dynamic deletedAt;
  // dynamic deletedBy;
  // String? createdAt;
  // String? updatedAt;
  Position? position;

  Player(
      {this.id,
      this.clubId,
      this.status,
      this.firstName,
      this.lastName,
      this.positionId,
      this.staffId,
      this.createdBy,
      this.groupId,
      this.shirtNumber,
      this.isCaptian,
      this.loginMobileNumber,
      this.height,
      this.weight,
      this.fat,
      this.muscle,
      this.profile,
      // this.country,
      // this.city,
      // this.yellowCard,
      // this.redCard,
      // this.address,
      // this.dob,
      // this.foot,
      // this.contactType,
      // this.otherContactType,
      // this.contactName,
      // this.phoneNumber,
      // this.deletedAt,
      // this.deletedBy,
      // this.createdAt,
      // this.updatedAt,
      this.position});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    positionId = json['position_id'];
    staffId = json['staff_id'];
    createdBy = json['created_by'];
    groupId = json['group_id'];
    shirtNumber = json['shirt_number'];
    isCaptian = json['is_captian'];
    loginMobileNumber = json['login_mobile_number'];
    height = json['height'];
    weight = json['weight'];
    fat = json['fat'];
    muscle = json['muscle'];
    profile = json['profile'];
    // country = json['country'];
    // city = json['city'];
    // yellowCard = json['yellow_card'];
    // redCard = json['red_card'];
    // address = json['address'];
    // dob = json['dob'];
    // foot = json['foot'];
    // contactType = json['contact_type'];
    // otherContactType = json['other_contact_type'];
    // contactName = json['contact_name'];
    // phoneNumber = json['phone_number'];
    // deletedAt = json['deleted_at'];
    // deletedBy = json['deleted_by'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['status'] = this.status;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['position_id'] = this.positionId;
    data['staff_id'] = this.staffId;
    data['created_by'] = this.createdBy;
    data['group_id'] = this.groupId;
    data['shirt_number'] = this.shirtNumber;
    data['is_captian'] = this.isCaptian;
    data['login_mobile_number'] = this.loginMobileNumber;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['fat'] = this.fat;
    data['muscle'] = this.muscle;
    data['profile'] = this.profile;
    // data['country'] = this.country;
    // data['city'] = this.city;
    // data['yellow_card'] = this.yellowCard;
    // data['red_card'] = this.redCard;
    // data['address'] = this.address;
    // data['dob'] = this.dob;
    // data['foot'] = this.foot;
    // data['contact_type'] = this.contactType;
    // data['other_contact_type'] = this.otherContactType;
    // data['contact_name'] = this.contactName;
    // data['phone_number'] = this.phoneNumber;
    // data['deleted_at'] = this.deletedAt;
    // data['deleted_by'] = this.deletedBy;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    return data;
  }
}

class Position {
  int? id;
  String? name;
  String? hebrewName;
  dynamic createdAt;
  dynamic updatedAt;

  Position(
      {this.id, this.name, this.hebrewName, this.createdAt, this.updatedAt});

  Position.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hebrewName = json['hebrew_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hebrew_name'] = this.hebrewName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TPlans {
  int? id;
  int? trainingId;
  int? staffId;
  dynamic fromTime;
  dynamic untillTime;
  String? name;
  int? planTimeId;
  int? planLevelId;
  StaffMember? staffMember;
  int? sortOrder;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  Level? level;
  Time? time;
  List<Latest>? professionalData;
  String? managment_file;

  TPlans(
      {this.id,
      this.trainingId,
      this.staffId,
      this.fromTime,
      this.untillTime,
      this.name,
      this.planTimeId,
      this.planLevelId,
      this.staffMember,
      this.sortOrder,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.level,
      this.time,
      this.professionalData,
      this.managment_file});

  TPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainingId = json['training_id'];
    staffId = json['staff_id'];
    fromTime = json['from_time'];
    untillTime = json['untill_time'];
    name = json['name'];
    planTimeId = json['plan_time_id'];
    planLevelId = json['plan_level_id'];
    staffMember = json['staff_member'] != null
        ? new StaffMember.fromJson(json['staff_member'])
        : null;
    sortOrder = json['sort_order'];
    description = json['description'].toString();
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    managment_file = json['managment_file'].toString();
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    if (json['professionalData'] != null) {
      professionalData = <Latest>[];
      json['professionalData'].forEach((v) {
        professionalData!.add(new Latest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['training_id'] = this.trainingId;
    data['staff_id'] = this.staffId;
    data['from_time'] = this.fromTime;
    data['untill_time'] = this.untillTime;
    data['name'] = this.name;
    data['plan_time_id'] = this.planTimeId;
    data['plan_level_id'] = this.planLevelId;
    data['staff_member'] = this.staffMember;
    data['sort_order'] = this.sortOrder;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['managment_file'] = this.managment_file;
    if (this.level != null) {
      data['level'] = this.level!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    if (this.professionalData != null) {
      data['professionalData'] =
          this.professionalData!.map((v) => v.toJson()).toList();
    }
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

class StaffMember {
  int? id;
  String? firstName;
  String? lastName;
  String? positionId;

  StaffMember({this.id, this.firstName, this.lastName, this.positionId});

  StaffMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    positionId = json['position_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['position_id'] = this.positionId;
    return data;
  }
}
