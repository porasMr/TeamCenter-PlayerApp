class InstructionModel {
  int? status;
  String? message;
  Data? data;

  InstructionModel({this.status, this.message, this.data});

  InstructionModel.fromJson(Map<String, dynamic> json) {
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
  List<GameInstructions>? gameInstructions;
  List<TrainingInstructions>? trainingInstructions;

  Data({this.gameInstructions, this.trainingInstructions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['gameInstructions'] != null) {
      gameInstructions = new List.empty(growable: true);
      json['gameInstructions'].forEach((v) {
        gameInstructions!.add(new GameInstructions.fromJson(v));
      });
    }
    if (json['trainingInstructions'] != null) {
      trainingInstructions = new List.empty(growable: true);
      json['trainingInstructions'].forEach((v) {
        trainingInstructions!.add(new TrainingInstructions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gameInstructions != null) {
      data['gameInstructions'] =
          this.gameInstructions!.map((v) => v.toJson()).toList();
    }
    if (this.trainingInstructions != null) {
      data['trainingInstructions'] =
          this.trainingInstructions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GameInstructions {
  int? id;
  int? clubId;
  String? title;
  String? groupId;
  String? files;
  int? showToPlayer;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? images;
  String? short_description;
  String? file_description;
  List<String>? imageFile = [];
  List<String>? fileFile = [];
  List<bool>? selectedFile = [];

  int? status;

  GameInstructions(
      {this.id,
      this.clubId,
      this.title,
      this.groupId,
      this.files,
      this.showToPlayer,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.images,
      this.short_description,
      this.file_description,
      this.status});

  GameInstructions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    title = json['title'];
    groupId = json['group_id'];
    files = json['files'];
    showToPlayer = json['show_to_player'];
    description = json['description'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    images = json['images'];
    status = json['message_status'];
    file_description = json['file_description'];

    short_description = json['short_description'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['title'] = this.title;
    data['group_id'] = this.groupId;
    data['files'] = this.files;
    data['show_to_player'] = this.showToPlayer;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['images'] = this.images;
    data['status'] = this.status;
    data['file_description'] = this.file_description;

    data['short_description'] = this.short_description;
    return data;
  }
}

class TrainingInstructions {
  int? id;
  int? clubId;
  String? title;
  String? groupId;
  String? files;
  int? showToPlayer;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? images;
  String? short_description;
  String? file_description;
  List<String>? imageFile = [];
  List<String>? fileFile = [];
  List<bool>? selectedFile = [];

  int? status;

  TrainingInstructions(
      {this.id,
      this.clubId,
      this.title,
      this.groupId,
      this.files,
      this.showToPlayer,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.images,
      this.status,
      this.file_description,
      this.short_description});

  TrainingInstructions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clubId = json['club_id'];
    title = json['title'].toString();
    groupId = json['group_id'];
    files = json['files'];
    showToPlayer = json['show_to_player'];
    description = json['description'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    images = json['images'];
    status = json['status'];
    file_description = json['file_description'];
    short_description = json['short_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['club_id'] = this.clubId;
    data['title'] = this.title;
    data['group_id'] = this.groupId;
    data['files'] = this.files;
    data['show_to_player'] = this.showToPlayer;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['images'] = this.images;
    data['status'] = this.status;
    data['file_description'] = this.file_description;

    data['short_description'] = this.short_description;
    return data;
  }
}
