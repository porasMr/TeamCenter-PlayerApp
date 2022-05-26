class TotalGameStatModel {
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

  int? myTeamScore;
  int? revelTeamScore;
  String? status;

  String? createdAt;
  String? updatedAt;
  List<Stats>? stats;

  TotalGameStatModel(
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
      this.myTeamScore,
      this.revelTeamScore,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.stats});

  TotalGameStatModel.fromJson(Map<String, dynamic> json) {
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

    myTeamScore = json['my_team_score'];
    revelTeamScore = json['revel_team_score'];
    status = json['status'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['stats'] != null) {
      stats = new List.empty(growable: true);
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

    data['my_team_score'] = this.myTeamScore;
    data['revel_team_score'] = this.revelTeamScore;
    data['status'] = this.status;

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
