class GameDetailModel {
  int? status;
  String? message;
  GameDetail? gameDetail;
  PlayerStat? playerStat;

  GameDetailModel(
      {this.status, this.message, this.gameDetail, this.playerStat});

  GameDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    gameDetail = json['game_detail'] != null
        ? new GameDetail.fromJson(json['game_detail'])
        : null;
    playerStat = json['player_stat'] != null
        ? new PlayerStat.fromJson(json['player_stat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.gameDetail != null) {
      data['game_detail'] = this.gameDetail!.toJson();
    }
    if (this.playerStat != null) {
      data['player_stat'] = this.playerStat!.toJson();
    }
    return data;
  }
}

class GameDetail {
  int? id;
  int? clubId;
  int? staffId;
  int? groupId;
  int? fieldId;
  String? date;
  String? time;
  String? rival;
  String? matchType;
  String? gamePlace;
  int? keyGame;
  String? plan;
  String? status;

  String? lineUpImage;

  int? myTeamScore;
  int? revelTeamScore;
  String? clubComment;
  String? createdAt;
  String? updatedAt;
  List<PlayerObjective>? playerObjective;

  GameDetail(
      {this.id,
      this.clubId,
      this.staffId,
      this.groupId,
      this.fieldId,
      this.date,
      this.time,
      this.rival,
      this.matchType,
      this.gamePlace,
      this.keyGame,
      this.plan,
      this.status,
      this.lineUpImage,
      this.myTeamScore,
      this.revelTeamScore,
      this.clubComment,
      this.createdAt,
      this.updatedAt,
      this.playerObjective});

  GameDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    staffId = json['staff_id'];
    groupId = json['group_id'];
    fieldId = json['field_id'];
    date = json['date'];
    time = json['time'];
    rival = json['rival'];
    matchType = json['match_type'];
    gamePlace = json['game_place'];
    keyGame = json['key_game'];
    plan = json['plan'].toString();
    status = json['status'].toString();

    lineUpImage = json['line_up_image'];

    myTeamScore = json['my_team_score'];
    revelTeamScore = json['revel_team_score'];
    clubComment = json['club_comment'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['club_id'] = this.clubId;
    data['staff_id'] = this.staffId;
    data['group_id'] = this.groupId;
    data['field_id'] = this.fieldId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['rival'] = this.rival;
    data['match_type'] = this.matchType;
    data['game_place'] = this.gamePlace;
    data['key_game'] = this.keyGame;
    data['plan'] = this.plan;
    data['line_up_image'] = this.lineUpImage;

    data['my_team_score'] = this.myTeamScore;
    data['revel_team_score'] = this.revelTeamScore;
    data['club_comment'] = this.clubComment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  Player? player;

  PlayerObjective({
    this.id,
    this.gameId,
    this.playerId,
    this.objective,
    this.createdAt,
    this.updatedAt,
    // this.player
  });

  PlayerObjective.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['game_id'];
    playerId = json['player_id'];
    objective = json['objective'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    player =
        json['player'] != null ? new Player.fromJson(json['player']) : null;
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

class Player {
  int? id;
  String? firstName;
  String? lastName;
  String? profile;

  Player({this.id, this.firstName, this.lastName, this.profile});

  Player.fromJson(Map<String, dynamic> json) {
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

class PlayerStat {
  List<PlayerStats>? playerStats;
  List<PlayerGameStateAvg>? playerGameStateAvg;

  PlayerStat({this.playerStats, this.playerGameStateAvg});

  PlayerStat.fromJson(Map<String, dynamic> json) {
    if (json['playerStats'] != null) {
      playerStats = <PlayerStats>[];
      json['playerStats'].forEach((v) {
        playerStats!.add(new PlayerStats.fromJson(v));
      });
    }
    if (json['playerGameStateAvg'] != null) {
      playerGameStateAvg = <PlayerGameStateAvg>[];
      json['playerGameStateAvg'].forEach((v) {
        playerGameStateAvg!.add(new PlayerGameStateAvg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playerStats != null) {
      data['playerStats'] = this.playerStats!.map((v) => v.toJson()).toList();
    }
    if (this.playerGameStateAvg != null) {
      data['playerGameStateAvg'] =
          this.playerGameStateAvg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerStats {
  int? id;
  int? clubId;
  int? staffId;
  int? groupId;
  int? fieldId;
  String? date;
  String? time;
  String? rival;
  String? matchType;
  String? gamePlace;
  int? keyGame;
  String? plan;
  String? lineUp;
  String? lineUpImage;
  String? defensiveSummary;
  String? offensiveSummary;
  String? generalSummary;
  int? myTeamScore;
  int? revelTeamScore;
  String? status;
  Null? clubComment;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Stats>? stats;

  PlayerStats(
      {this.id,
      this.clubId,
      this.staffId,
      this.groupId,
      this.fieldId,
      this.date,
      this.time,
      this.rival,
      this.matchType,
      this.gamePlace,
      this.keyGame,
      this.plan,
      this.lineUp,
      this.lineUpImage,
      this.defensiveSummary,
      this.offensiveSummary,
      this.generalSummary,
      this.myTeamScore,
      this.revelTeamScore,
      this.status,
      this.clubComment,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.stats});

  PlayerStats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    staffId = json['staff_id'];
    groupId = json['group_id'];
    fieldId = json['field_id'];
    date = json['date'];
    time = json['time'];
    rival = json['rival'];
    matchType = json['match_type'];
    gamePlace = json['game_place'];
    keyGame = json['key_game'];
    plan = json['plan'];
    lineUp = json['line_up'];
    lineUpImage = json['line_up_image'];
    defensiveSummary = json['defensive_summary'];
    offensiveSummary = json['offensive_summary'];
    generalSummary = json['general_summary'];
    myTeamScore = json['my_team_score'];
    revelTeamScore = json['revel_team_score'];
    status = json['status'];
    clubComment = json['club_comment'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(new Stats.fromJson(v));
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
    data['time'] = this.time;
    data['rival'] = this.rival;
    data['match_type'] = this.matchType;
    data['game_place'] = this.gamePlace;
    data['key_game'] = this.keyGame;
    data['plan'] = this.plan;
    data['line_up'] = this.lineUp;
    data['line_up_image'] = this.lineUpImage;
    data['defensive_summary'] = this.defensiveSummary;
    data['offensive_summary'] = this.offensiveSummary;
    data['general_summary'] = this.generalSummary;
    data['my_team_score'] = this.myTeamScore;
    data['revel_team_score'] = this.revelTeamScore;
    data['status'] = this.status;
    data['club_comment'] = this.clubComment;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.stats != null) {
      data['stats'] = this.stats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  String? statName;
  String? value;

  Stats({this.statName, this.value});

  Stats.fromJson(Map<String, dynamic> json) {
    statName = json['stat_name'];
    value = json['value'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stat_name'] = this.statName;
    data['value'] = this.value;
    return data;
  }
}

class PlayerGameStateAvg {
  List<Stats>? stats;

  PlayerGameStateAvg({this.stats});

  PlayerGameStateAvg.fromJson(Map<String, dynamic> json) {
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(new Stats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['stats'] = this.stats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
