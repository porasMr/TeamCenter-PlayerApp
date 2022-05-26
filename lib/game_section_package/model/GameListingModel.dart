class GameListingModel {
  int? status;
  String? message;
  List<GameData>? data;

  GameListingModel({this.status, this.message, this.data});

  GameListingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List.empty(growable: true);
      ;
      json['data'].forEach((v) {
        data!.add(new GameData.fromJson(v));
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

class GameData {
  int? id;
  int? staffId;
  String? date;
  String? time;
  String? rival;
  String? matchType;
  String? gamePlace;
  int? keyGame;
  String? plan;
  String? lineUpImage;
  String? defensiveSummary;
  String? offensiveSummary;
  String? generalSummary;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  List<PlayerObjective>? playerObjective;
  String? status;
  int? my_team_score;
  int? revel_team_score;
  String? club_comment;

  GameData(
      {this.id,
      this.staffId,
      this.date,
      this.time,
      this.rival,
      this.matchType,
      this.gamePlace,
      this.keyGame,
      this.plan,
      this.lineUpImage,
      this.defensiveSummary,
      this.offensiveSummary,
      this.generalSummary,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.playerObjective,
      this.status,
      this.my_team_score,
      this.revel_team_score,
      this.club_comment});

  GameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    date = json['date'];
    time = json['time'];
    rival = json['rival'];
    matchType = json['match_type'];
    gamePlace = json['game_place'];
    keyGame = json['key_game'];
    plan = json['plan'];

    lineUpImage = json['line_up_image'];
    defensiveSummary = json['defensive_summary'];
    offensiveSummary = json['offensive_summary'];
    generalSummary = json['general_summary'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    club_comment = json['club_comment'].toString();
    if (json['player_objective'] != null) {
      playerObjective = new List.empty(growable: true);
      ;
      json['player_objective'].forEach((v) {
        playerObjective!.add(new PlayerObjective.fromJson(v));
      });
    }
    status = json['status'];
    my_team_score = json['my_team_score'];
    revel_team_score = json['revel_team_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['rival'] = this.rival;
    data['match_type'] = this.matchType;
    data['game_place'] = this.gamePlace;
    data['key_game'] = this.keyGame;
    data['plan'] = this.plan;

    data['line_up_image'] = this.lineUpImage;
    data['defensive_summary'] = this.defensiveSummary;
    data['offensive_summary'] = this.offensiveSummary;
    data['general_summary'] = this.generalSummary;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.playerObjective != null) {
      data['player_objective'] =
          this.playerObjective!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['my_team_score'] = this.my_team_score;
    data['revel_team_score'] = this.revel_team_score;
    return data;
  }
}

class LineUp {
  String? playerId;
  String? postion;
  Player? player;

  LineUp({this.playerId, this.postion, this.player});

  LineUp.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    postion = json['postion'];
    player =
        json['player'] != null ? new Player.fromJson(json['player']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId.toString();
    data['postion'] = this.postion.toString();
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    return data;
  }
}

class Player {
  int? id;
  String? status;
  String? firstName;
  dynamic lastName;
  String? positionId;
  dynamic staffId;
  dynamic createdBy;
  String? groupId;
  String? shirtNumber;
  int? isCaptian;
  String? loginMobileNumber;
  String? height;
  String? weight;
  String? fat;
  String? muscle;
  String? profile;
  String? country;
  String? city;
  String? address;
  String? dob;
  String? foot;
  String? contactType;
  String? otherContactType;
  String? contactName;
  String? phoneNumber;
  dynamic deletedAt;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  Player(
      {this.id,
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
      this.address,
      this.dob,
      this.foot,
      this.contactType,
      this.otherContactType,
      this.contactName,
      this.phoneNumber,
      this.deletedAt,
      this.deletedBy,
      this.createdAt,
      this.updatedAt});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    positionId = json['position_id'];
    staffId = json['staff_id'];
    createdBy = json['created_by'];
    groupId = json['group_id'].toString();
    shirtNumber = json['shirt_number'];
    isCaptian = json['is_captian'];
    loginMobileNumber = json['login_mobile_number'];
    height = json['height'];
    weight = json['weight'];
    fat = json['fat'];
    muscle = json['muscle'];
    profile = json['profile'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    dob = json['dob'];
    foot = json['foot'].toString();
    contactType = json['contact_type'].toString();
    otherContactType = json['other_contact_type'].toString();
    contactName = json['contact_name'].toString();
    phoneNumber = json['phone_number'].toString();
    deletedAt = json['deleted_at'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['country'] = this.country;
    data['city'] = this.city;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['foot'] = this.foot;
    data['contact_type'] = this.contactType;
    data['other_contact_type'] = this.otherContactType;
    data['contact_name'] = this.contactName;
    data['phone_number'] = this.phoneNumber;
    data['deleted_at'] = this.deletedAt;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PlayerObjective {
  int? id;
  int? gameId;
  int? playerId;
  String? objective;
  String? createdAt;
  String? updatedAt;
  PlayerObj? player;

  PlayerObjective(
      {this.id,
      this.gameId,
      this.playerId,
      this.objective,
      this.createdAt,
      this.updatedAt,
      this.player});

  PlayerObjective.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['game_id'];
    playerId = json['player_id'];
    objective = json['objective'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    player =
        json['player'] != null ? new PlayerObj.fromJson(json['player']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_id'] = this.gameId;
    data['player_id'] = this.playerId;
    data['objective'] = this.objective;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    return data;
  }
}

class PlayerObj {
  int? id;
  String? firstName;
  String? lastName;
  String? profile;

  PlayerObj({this.id, this.firstName, this.lastName, this.profile});

  PlayerObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile'] = this.profile;
    return data;
  }
}
