class PlayerTest {
  int? status;
  String? message;
  List<Data>? data;
  List<PlayerConversations>? playerConversations;
  List<CoachOpinions>? coachOpinions;

  PlayerTest(
      {this.status,
      this.message,
      this.data,
      this.playerConversations,
      this.coachOpinions});

  PlayerTest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['playerConversations'] != null) {
      playerConversations = <PlayerConversations>[];
      json['playerConversations'].forEach((v) {
        playerConversations!.add(new PlayerConversations.fromJson(v));
      });
    }
    if (json['coachOpinions'] != null) {
      coachOpinions = <CoachOpinions>[];
      json['coachOpinions'].forEach((v) {
        coachOpinions!.add(new CoachOpinions.fromJson(v));
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
    if (this.playerConversations != null) {
      data['playerConversations'] =
          this.playerConversations!.map((v) => v.toJson()).toList();
    }
    if (this.coachOpinions != null) {
      data['coachOpinions'] =
          this.coachOpinions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? clubId;
  int? groupId;
  int? staffId;
  String? name;
  String? unitTypeEn;
  String? unitTypeHe;
  String? goodResultType;
  String? createdAt;
  String? updatedAt;
  List<TestResult>? testResult;

  Data(
      {this.id,
      this.clubId,
      this.groupId,
      this.staffId,
      this.name,
      this.unitTypeEn,
      this.unitTypeHe,
      this.goodResultType,
      this.createdAt,
      this.updatedAt,
      this.testResult});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    groupId = json['group_id'];
    staffId = json['staff_id'];
    name = json['name'];
    unitTypeEn = json['unit_type_en'];
    unitTypeHe = json['unit_type_he'];
    goodResultType = json['good_result_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['test_result'] != null) {
      testResult = new List.empty(growable: true);
      json['test_result'].forEach((v) {
        testResult!.add(new TestResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['group_id'] = this.groupId;
    data['staff_id'] = this.staffId;
    data['name'] = this.name;
    data['unit_type_en'] = this.unitTypeEn;
    data['unit_type_he'] = this.unitTypeHe;
    data['good_result_type'] = this.goodResultType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.testResult != null) {
      data['test_result'] = this.testResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestResult {
  int? id;
  int? staffId;
  int? testId;
  int? playerId;
  String? number;
  String? date;
  String? createdAt;
  String? updatedAt;

  TestResult(
      {this.id,
      this.staffId,
      this.testId,
      this.playerId,
      this.number,
      this.date,
      this.createdAt,
      this.updatedAt});

  TestResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    testId = json['test_id'];
    playerId = json['player_id'];
    number = json['number'].toString();
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['test_id'] = this.testId;
    data['player_id'] = this.playerId;
    data['number'] = this.number;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PlayerConversations {
  int? id;
  int? groupId;
  int? staffId;
  int? clubId;
  int? playerId;
  String? date;
  String? subject;
  String? attending;
  String? coachComments;
  String? playerComments;
  String? summary;
  String? createdAt;
  String? updatedAt;

  PlayerConversations(
      {this.id,
      this.groupId,
      this.staffId,
      this.clubId,
      this.playerId,
      this.date,
      this.subject,
      this.attending,
      this.coachComments,
      this.playerComments,
      this.summary,
      this.createdAt,
      this.updatedAt});

  PlayerConversations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    staffId = json['staff_id'];
    clubId = json['club_id'];
    playerId = json['player_id'];
    date = json['date'];
    subject = json['subject'];
    attending = json['attending'];
    coachComments = json['coach_comments'];
    playerComments = json['player_comments'];
    summary = json['summary'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['staff_id'] = this.staffId;
    data['club_id'] = this.clubId;
    data['player_id'] = this.playerId;
    data['date'] = this.date;
    data['subject'] = this.subject;
    data['attending'] = this.attending;
    data['coach_comments'] = this.coachComments;
    data['player_comments'] = this.playerComments;
    data['summary'] = this.summary;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CoachOpinions {
  int? id;
  int? groupId;
  int? playerId;
  int? clubId;
  String? description;
  String? createdAt;
  String? updatedAt;

  CoachOpinions(
      {this.id,
      this.groupId,
      this.playerId,
      this.clubId,
      this.description,
      this.createdAt,
      this.updatedAt});

  CoachOpinions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    playerId = json['player_id'];
    clubId = json['club_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['player_id'] = this.playerId;
    data['club_id'] = this.clubId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
