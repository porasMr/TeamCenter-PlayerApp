import 'TotalGameStatModel.dart';

class StatsModel {
  int? status;
  String? message;
  List<StatsData>? data;
  List<TotalGameStatModel>? playerStat;

  StatsModel({this.status, this.message, this.data, this.playerStat});

  StatsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(new StatsData.fromJson(v));
      });
    }
    if (json['player_stat'] != null) {
      playerStat = new List.empty(growable: true);
      json['player_stat'].forEach((v) {
        playerStat!.add(new TotalGameStatModel.fromJson(v));
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
    if (this.playerStat != null) {
      data['player_stat'] = this.playerStat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatsData {
  int? minSum;
  int? goalsSum;
  int? assistsSum;
  int? stealsSum;
  int? rescueSum;
  int? foulSum;
  int? ballLossSum;
  int? yellow;
  int? red;
  int? id;
  String? date;
  String? time;
  int? myTeamScore;
  int? revelTeamScore;
  String? status;

  StatsData(
      {this.minSum,
      this.goalsSum,
      this.assistsSum,
      this.stealsSum,
      this.rescueSum,
      this.foulSum,
      this.ballLossSum,
      this.yellow,
      this.red,
      this.id,
      this.date,
      this.time,
      this.myTeamScore,
      this.revelTeamScore,
      this.status});

  StatsData.fromJson(Map<String, dynamic> json) {
    minSum = json['min_sum'];
    goalsSum = json['goals_sum'];
    assistsSum = json['assists_sum'];
    stealsSum = json['steals_sum'];
    rescueSum = json['rescue_sum'];
    foulSum = json['foul_sum'];
    ballLossSum = json['ball_loss_sum'];
    yellow = json['yellow'];
    red = json['red'];
    id = json['id'];
    date = json['date'];
    time = json['time'];
    myTeamScore = json['my_team_score'];
    revelTeamScore = json['revel_team_score'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_sum'] = this.minSum;
    data['goals_sum'] = this.goalsSum;
    data['assists_sum'] = this.assistsSum;
    data['steals_sum'] = this.stealsSum;
    data['rescue_sum'] = this.rescueSum;
    data['foul_sum'] = this.foulSum;
    data['ball_loss_sum'] = this.ballLossSum;
    data['yellow'] = this.yellow;
    data['red'] = this.red;
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['my_team_score'] = this.myTeamScore;
    data['revel_team_score'] = this.revelTeamScore;
    data['status'] = this.status;
    return data;
  }
}
