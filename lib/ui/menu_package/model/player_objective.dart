class PlayerObjectives {
  int? status;
  String? message;
  List<Data>? data;
  NextGameObjective? nextGameObjective;

  PlayerObjectives(
      {this.status, this.message, this.data, this.nextGameObjective});

  PlayerObjectives.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    nextGameObjective = json['nextGameObjective'] != null
        ? new NextGameObjective.fromJson(json['nextGameObjective'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.nextGameObjective != null) {
      data['nextGameObjective'] = this.nextGameObjective!.toJson();
    }
    return data;
  }
}

class Data {
  String? type;
  List<Ablities>? ablities;
  Ablities? goal;

  Data({this.type, this.ablities, this.goal});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['ablities'] != null) {
      ablities = <Ablities>[];
      json['ablities'].forEach((v) {
        ablities!.add(new Ablities.fromJson(v));
      });
    }
    goal = json['goal'] != null ? new Ablities.fromJson(json['goal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.ablities != null) {
      data['ablities'] = this.ablities!.map((v) => v.toJson()).toList();
    }
    if (this.goal != null) {
      data['goal'] = this.goal!.toJson();
    }
    return data;
  }
}

class Ablities {
  int? id;
  int? playerId;
  int? clubAblityId;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;
  ClubAblity? clubAblity;

  Ablities(
      {this.id,
      this.playerId,
      this.clubAblityId,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.clubAblity});

  Ablities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['player_id'];
    clubAblityId = json['club_ablity_id'];
    name = json['name'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    clubAblity = json['club_ablity'] != null
        ? new ClubAblity.fromJson(json['club_ablity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['player_id'] = this.playerId;
    data['club_ablity_id'] = this.clubAblityId;
    data['name'] = this.name;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.clubAblity != null) {
      data['club_ablity'] = this.clubAblity!.toJson();
    }
    return data;
  }
}

class ClubAblity {
  int? id;
  int? clubId;
  int? masterAblityId;
  int? typeId;
  String? name;
  String? hebrewName;
  int? active;
  String? createdAt;
  String? updatedAt;

  ClubAblity(
      {this.id,
      this.clubId,
      this.masterAblityId,
      this.typeId,
      this.name,
      this.hebrewName,
      this.active,
      this.createdAt,
      this.updatedAt});

  ClubAblity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    masterAblityId = json['master_ablity_id'];
    typeId = json['type_id'];
    name = json['name'];
    hebrewName = json['hebrew_name'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['master_ablity_id'] = this.masterAblityId;
    data['type_id'] = this.typeId;
    data['name'] = this.name;
    data['hebrew_name'] = this.hebrewName;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NextGameObjective {
  int? id;
  int? groupId;
  String? date;
  String? time;
  String? rival;
  String? matchType;
  String? gamePlace;
  int? keyGame;
  List<PlayerObjective>? playerObjective;

  NextGameObjective(
      {this.id,
      this.groupId,
      this.date,
      this.time,
      this.rival,
      this.matchType,
      this.gamePlace,
      this.keyGame,
      this.playerObjective});

  NextGameObjective.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    date = json['date'];
    time = json['time'];
    rival = json['rival'];
    matchType = json['match_type'];
    gamePlace = json['game_place'];
    keyGame = json['key_game'];
    if (json['player_objective'] != null) {
      playerObjective = <PlayerObjective>[];
      json['player_objective'].forEach((v) {
        playerObjective!.add(new PlayerObjective.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['rival'] = this.rival;
    data['match_type'] = this.matchType;
    data['game_place'] = this.gamePlace;
    data['key_game'] = this.keyGame;
    if (this.playerObjective != null) {
      data['player_objective'] =
          this.playerObjective!.map((v) => v.toJson()).toList();
    }
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

  PlayerObjective(
      {this.id,
      this.gameId,
      this.playerId,
      this.objective,
      this.createdAt,
      this.updatedAt});

  PlayerObjective.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['game_id'];
    playerId = json['player_id'];
    objective = json['objective'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_id'] = this.gameId;
    data['player_id'] = this.playerId;
    data['objective'] = this.objective;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
