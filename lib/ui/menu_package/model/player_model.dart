class PlayerModel {
  int? status;
  String? message;
  Data? data;

  PlayerModel({this.status, this.message, this.data});

  PlayerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? clubId;
  String? status;
  String? firstName;
  String? lastName;
  String? positionId;
  int? staffId;
  String? groupId;
  String? shirtNumber;
  int? isCaptian;
  String? loginMobileNumber;
  String? height;
  String? weight;
  String? fat;
  String? muscle;
  String? profile;
  Country? country;
  String? city;
  int? yellowCard;
  int? redCard;
  String? address;
  String? dob;
  Foot? foot;

  String? phoneNumber;
  String? applicationVersion;
  String? oneSignalId;
  String? appLanguage;
  String? device;

  String? contact_type;
  String? other_contact_type;
  String? contact_name;
  String? phone_number;

  int? age;
  ClubLogo? clubLogo;

  Data(
      {this.id,
      this.clubId,
      this.status,
      this.firstName,
      this.lastName,
      this.positionId,
      this.staffId,
      this.groupId,
      this.shirtNumber,
      this.isCaptian,
      this.loginMobileNumber,
      this.height,
      this.weight,
      this.fat,
      this.muscle,
      this.profile,
      this.country,
      this.city,
      this.yellowCard,
      this.redCard,
      this.address,
      this.dob,
      this.foot,
      this.phoneNumber,
      this.applicationVersion,
      this.oneSignalId,
      this.appLanguage,
      this.device,
      this.age,
      this.clubLogo,
      this.contact_type,
      this.other_contact_type,
      this.contact_name,
      this.phone_number});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    positionId = json['position_id'];
    staffId = json['staff_id'];
    groupId = json['group_id'];
    shirtNumber = json['shirt_number'].toString();
    isCaptian = json['is_captian'];
    loginMobileNumber = json['login_mobile_number'];
    height = json['height'];
    weight = json['weight'];
    fat = json['fat'];
    muscle = json['muscle'];
    profile = json['profile'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'];
    yellowCard = json['yellow_card'];
    redCard = json['red_card'];
    address = json['address'].toString();
    dob = json['dob'].toString();
    foot = json['foot'] != null ? new Foot.fromJson(json['foot']) : null;

    phoneNumber = json['phone_number'];
    applicationVersion = json['applicationVersion'];
    oneSignalId = json['oneSignalId'];
    appLanguage = json['app_language'];
    device = json['device'];

    contact_name = json['contact_name'].toString();
    contact_type = json['contact_type'].toString();
    other_contact_type = json['other_contact_type'].toString();
    phone_number = json['phone_number'].toString();

    age = json['age'];
    clubLogo = json['club_logo'] != null
        ? new ClubLogo.fromJson(json['club_logo'])
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
    data['group_id'] = this.groupId;
    data['shirt_number'] = this.shirtNumber;
    data['is_captian'] = this.isCaptian;
    data['login_mobile_number'] = this.loginMobileNumber;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['fat'] = this.fat;
    data['muscle'] = this.muscle;
    data['profile'] = this.profile;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['city'] = this.city;
    data['yellow_card'] = this.yellowCard;
    data['red_card'] = this.redCard;
    data['address'] = this.address;
    data['dob'] = this.dob;
    if (this.foot != null) {
      data['foot'] = this.foot!.toJson();
    }

    data['phone_number'] = this.phoneNumber;
    data['applicationVersion'] = this.applicationVersion;
    data['oneSignalId'] = this.oneSignalId;
    data['app_language'] = this.appLanguage;
    data['device'] = this.device;

    data['age'] = this.age;
    if (this.clubLogo != null) {
      data['club_logo'] = this.clubLogo!.toJson();
    }

    data['contact_name'] = this.contact_name;
    data['contact_type'] = this.contact_type;
    data['other_contact_type'] = this.other_contact_type;
    data['phone_number'] = this.phone_number;

    return data;
  }
}

class Country {
  int? id;
  String? countryEng;
  String? countryHb;

  Country({this.id, this.countryEng, this.countryHb});

  Country.fromJson(Map<String, dynamic> json) {
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

class Foot {
  int? id;
  String? hebrewName;
  String? englishName;
  String? createdAt;
  String? updatedAt;

  Foot(
      {this.id,
      this.hebrewName,
      this.englishName,
      this.createdAt,
      this.updatedAt});

  Foot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hebrewName = json['hebrew_name'];
    englishName = json['english_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hebrew_name'] = this.hebrewName;
    data['english_name'] = this.englishName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ClubLogo {
  int? id;
  String? clubLogo;

  ClubLogo({this.id, this.clubLogo});

  ClubLogo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubLogo = json['club_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_logo'] = this.clubLogo;
    return data;
  }
}
