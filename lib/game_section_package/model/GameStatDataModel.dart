class GameStatDataModel {
  Player? player;
  List<GameStat>? gameStat;

  GameStatDataModel({this.player, this.gameStat});

  GameStatDataModel.fromJson(Map<String, dynamic> json) {
    player =
        json['player'] != null ? new Player.fromJson(json['player']) : null;
    if (json['gameStat'] != null) {
      gameStat = new List.empty(growable: true);
      json['gameStat'].forEach((v) {
        gameStat!.add(new GameStat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    if (this.gameStat != null) {
      data['gameStat'] = this.gameStat!.map((v) => v.toJson()).toList();
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
  Country? country;
  String? city;
  int? yellowCard;
  int? redCard;
  String? address;
  String? dob;
  Foot? foot;
  String? contactType;
  String? otherContactType;
  String? contactName;
  String? phoneNumber;
 
  String? createdAt;
  String? updatedAt;
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
      this.country,
      this.city,
      this.yellowCard,
      this.redCard,
      this.address,
      this.dob,
      this.foot,
      this.contactType,
      this.otherContactType,
      this.contactName,
      this.phoneNumber,
    
      this.createdAt,
      this.updatedAt,
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
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'];
    yellowCard = json['yellow_card'];
    redCard = json['red_card'];
    address = json['address'];
    dob = json['dob'];
    foot = json['foot'] != null ? new Foot.fromJson(json['foot']) : null;
    contactType = json['contact_type'];
    otherContactType = json['other_contact_type'];
    contactName = json['contact_name'];
    phoneNumber = json['phone_number'];
  
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['contact_type'] = this.contactType;
    data['other_contact_type'] = this.otherContactType;
    data['contact_name'] = this.contactName;
    data['phone_number'] = this.phoneNumber;
    
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
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
 

  Foot(
      {this.id,
      this.hebrewName,
      this.englishName,
      });

  Foot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hebrewName = json['hebrew_name'];
    englishName = json['english_name'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hebrew_name'] = this.hebrewName;
    data['english_name'] = this.englishName;
   
    return data;
  }
}

class Position {
  int? id;
  String? name;
  String? hebrewName;
  

  Position(
      {this.id, this.name, this.hebrewName});

  Position.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hebrewName = json['hebrew_name'];
 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hebrew_name'] = this.hebrewName;
  
    return data;
  }
}

class GameStat {
  int? id;
  int? playerId;
  int? gameId;
  int? statId;
  String? statName;
  String? value;


  GameStat(
      {this.id,
      this.playerId,
      this.gameId,
      this.statId,
      this.statName,
      this.value,
     });

  GameStat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['player_id'];
    gameId = json['game_id'];
    statId = json['stat_id'];
    statName = json['stat_name'];
    value = json['value'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['player_id'] = this.playerId;
    data['game_id'] = this.gameId;
    data['stat_id'] = this.statId;
    data['stat_name'] = this.statName;
    data['value'] = this.value;
    
    return data;
  }
}