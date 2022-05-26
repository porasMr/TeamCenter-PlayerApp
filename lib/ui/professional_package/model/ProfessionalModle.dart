class ProfessionalModle {
  int? status;
  String? message;
  List<Data>? data;
  List<Latest>? latest;

  ProfessionalModle({this.status, this.message, this.data, this.latest});

  ProfessionalModle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['latest'] != null) {
      latest = <Latest>[];
      json['latest'].forEach((v) {
        latest!.add(new Latest.fromJson(v));
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
    if (this.latest != null) {
      data['latest'] = this.latest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  bool? isSelected = false;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
    files = json['files'];
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
    data['main_image'] = this.mainImage.toString();
    data['video_url'] = this.videoUrl.toString();
    data['thumbnail_image'] = this.thumbnail_image;
    data['group_id'] = this.groupId;
    data['files'] = this.files.toString();
    data['file_description'] = this.fileDescription.toString();
    data['description'] = this.description.toString();
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['short_description'] = this.shortDescription.toString();
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

class Latest {
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

  Latest(
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

  Latest.fromJson(Map<String, dynamic> json) {
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
