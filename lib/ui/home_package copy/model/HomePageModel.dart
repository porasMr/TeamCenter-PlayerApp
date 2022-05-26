import '../../menu_package/model/player_objective.dart';

class HomePageModel {
  int? status;
  String? message;
  HomeData? data;

  HomePageModel({this.status, this.message, this.data});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
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

class HomeData {
  List<Game>? game;
  List<Data>? nextTraining;
  List<GameStatastic>? gameState;
  List<ProfessionalKnowledge>? professionalKnowledge;
  NextGameObjective? nextGameObjective;

  LastGame? lastGame;

  HomeData(
      {this.game,
      this.nextTraining,
      this.lastGame,
      this.gameState,
      this.nextGameObjective,
      this.professionalKnowledge});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['commingGame'] != null) {
      game = new List.empty(growable: true);
      json['commingGame'].forEach((v) {
        game!.add(new Game.fromJson(v));
      });
    }

    if (json['nextTraining'] != null) {
      nextTraining = new List.empty(growable: true);
      json['nextTraining'].forEach((v) {
        nextTraining!.add(new Data.fromJson(v));
      });
    }
    lastGame = json['lastGame'] != null
        ? new LastGame.fromJson(json['lastGame'])
        : null;

    if (json['gameState'] != null) {
      gameState = new List.empty(growable: true);
      json['gameState'].forEach((v) {
        gameState!.add(new GameStatastic.fromJson(v));
      });
    }
    if (json['professionalKnowledge'] != null) {
      professionalKnowledge = <ProfessionalKnowledge>[];
      json['professionalKnowledge'].forEach((v) {
        professionalKnowledge!.add(new ProfessionalKnowledge.fromJson(v));
      });
    }
    nextGameObjective = json['nextGameObjective'] != null
        ? new NextGameObjective.fromJson(json['nextGameObjective'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.game != null) {
      data['commingGame'] = this.game!.map((v) => v.toJson()).toList();
    }

    if (this.lastGame != null) {
      data['lastGame'] = this.lastGame!.toJson();
    }
    if (this.nextTraining != null) {
      data['nextTraining'] = this.nextTraining!.map((v) => v.toJson()).toList();
    }
    if (this.gameState != null) {
      data['gameState'] = this.gameState!.map((v) => v.toJson()).toList();
    }
    if (this.professionalKnowledge != null) {
      data['professionalKnowledge'] =
          this.professionalKnowledge!.map((v) => v.toJson()).toList();
    }
    if (this.nextGameObjective != null) {
      data['nextGameObjective'] = this.nextGameObjective!.toJson();
    }
    return data;
  }
}

class Game {
  int? id;
  int? staffId;
  int? groupId;
  String? date;
  String? time;
  String? rival;
  String? matchType;
  String? gamePlace;
  int? keyGame;
  String? plan;
  String? lineUpImage;
  dynamic defensiveSummary;
  dynamic offensiveSummary;
  dynamic generalSummary;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? my_team_score;
  int? revel_team_score;
  String? club_comment;

  Game(
      {this.id,
      this.staffId,
      this.groupId,
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
      this.status,
      this.my_team_score,
      this.revel_team_score,
      this.club_comment});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    groupId = json['group_id'];
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
    status = json['status'];
    my_team_score = json['my_team_score'];
    revel_team_score = json['revel_team_score'];
    club_comment = json['club_comment'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['group_id'] = this.groupId;
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
    data['status'] = this.status;
    data['my_team_score'] = this.my_team_score;
    data['revel_team_score'] = this.revel_team_score;
    data['club_comment'] = this.club_comment;

    return data;
  }
}

class LastGame {
  int? id;
  int? groupId;
  String? date;
  String? time;
  String? rival;
  String? matchType;
  String? gamePlace;
  int? keyGame;
  String? status;
  int? myTeamScore;
  int? revelTeamScore;
  String? plan;

  LastGame(
      {this.id,
      this.groupId,
      this.date,
      this.time,
      this.rival,
      this.matchType,
      this.gamePlace,
      this.keyGame,
      this.status,
      this.myTeamScore,
      this.revelTeamScore,
      this.plan});

  LastGame.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    date = json['date'];
    time = json['time'];
    rival = json['rival'];
    matchType = json['match_type'];
    gamePlace = json['game_place'];
    keyGame = json['key_game'];
    status = json['status'];
    myTeamScore = json['my_team_score'];
    revelTeamScore = json['revel_team_score'];
    plan = json['plan'];
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
    data['status'] = this.status;
    data['my_team_score'] = this.myTeamScore;
    data['revel_team_score'] = this.revelTeamScore;
    data['plan'] = this.plan;
    return data;
  }
}

class GameStatastic {
  int? total;
  dynamic myTeamScore;
  dynamic revelTeamScore;
  dynamic win;
  dynamic loss;
  dynamic tie;

  GameStatastic(
      {this.total,
      this.myTeamScore,
      this.revelTeamScore,
      this.win,
      this.loss,
      this.tie});

  GameStatastic.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    myTeamScore = json['my_team_score'];
    revelTeamScore = json['revel_team_score'];
    win = json['win'];
    loss = json['loss'];
    tie = json['tie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['my_team_score'] = this.myTeamScore;
    data['revel_team_score'] = this.revelTeamScore;
    data['win'] = this.win;
    data['loss'] = this.loss;
    data['tie'] = this.tie;
    return data;
  }
}

class ProfessionalKnowledge {
  int? id;
  int? clubId;
  int? categoryId;
  int? status;
  String? canView;
  String? showToHome;
  String? title;
  String? mainImage;
  String? videoUrl;
  String? thumbnail_image;
  String? groupId;
  String? files;
  String? fileDescription;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? shortDescription;
  Category? category;

  ProfessionalKnowledge(
      {this.id,
      this.clubId,
      this.categoryId,
      this.status,
      this.canView,
      this.showToHome,
      this.title,
      this.mainImage,
      this.videoUrl,
      this.thumbnail_image,
      this.groupId,
      this.files,
      this.fileDescription,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.shortDescription,
      this.category});

  ProfessionalKnowledge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    categoryId = json['category_id'];
    status = json['status'];
    canView = json['can_view'];
    showToHome = json['show_to_home'];
    title = json['title'];
    mainImage = json['main_image'].toString();
    videoUrl = json['video_url'].toString();
    thumbnail_image = json['thumbnail_image'].toString();
    groupId = json['group_id'];
    files = json['files'].toString();
    fileDescription = json['file_description'].toString();
    description = json['description'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shortDescription = json['short_description'].toString();
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['can_view'] = this.canView;
    data['show_to_home'] = this.showToHome;
    data['title'] = this.title;
    data['main_image'] = this.mainImage;
    data['video_url'] = this.videoUrl;
    data['thumbnail_image'] = this.thumbnail_image;
    data['group_id'] = this.groupId;
    data['files'] = this.files;
    data['file_description'] = this.fileDescription;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['short_description'] = this.shortDescription;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  int? clubId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.clubId, this.name, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
