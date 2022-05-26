class GernealStringModel {
  int? status;
  String? message;
  Data? data;

  GernealStringModel({this.status, this.message, this.data});

  GernealStringModel.fromJson(Map<String, dynamic> json) {
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
  GeneralSetting? generalSetting;
  List<AppScreen>? appScreen;

  Data({this.generalSetting, this.appScreen});

  Data.fromJson(Map<String, dynamic> json) {
    generalSetting = json['generalSetting'] != null
        ? new GeneralSetting.fromJson(json['generalSetting'])
        : null;
    if (json['appScreen'] != null) {
      appScreen = new List.empty(growable: true);
      json['appScreen'].forEach((v) {
        appScreen!.add(new AppScreen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generalSetting != null) {
      data['generalSetting'] = this.generalSetting!.toJson();
    }
    if (this.appScreen != null) {
      data['appScreen'] = this.appScreen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneralSetting {
  int? id;
  String? officeLogo;
  String? favicon;
  String? appName;
  String? andriodLink;
  String? iosLink;
  String? diposit;
  String? payment;
  String? creater;
  String? termsCondition;
  String? messageData;
  String? createdAt;
  String? updatedAt;
  String? appLogo;
  String? businessCardLogo;
  String? ios_latest_version;
  String? android_latest_version;

  GeneralSetting(
      {this.id,
      this.officeLogo,
      this.favicon,
      this.appName,
      this.andriodLink,
      this.iosLink,
      this.diposit,
      this.payment,
      this.creater,
      this.termsCondition,
      this.messageData,
      this.createdAt,
      this.updatedAt,
      this.appLogo,
      this.businessCardLogo,
      this.android_latest_version,
      this.ios_latest_version});

  GeneralSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    officeLogo = json['office_logo'];
    favicon = json['favicon'];
    appName = json['app_name'];
    andriodLink = json['andriod_link'];
    iosLink = json['ios_link'];
    diposit = json['diposit'];
    payment = json['payment'];
    creater = json['creater'];
    termsCondition = json['terms_condition'];
    messageData = json['message_data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appLogo = json['app_logo'];
    businessCardLogo = json['business_card_logo'];
    android_latest_version = json['android_latest_version'];
    ios_latest_version = json['ios_latest_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['office_logo'] = this.officeLogo;
    data['favicon'] = this.favicon;
    data['app_name'] = this.appName;
    data['andriod_link'] = this.andriodLink;
    data['ios_link'] = this.iosLink;
    data['diposit'] = this.diposit;
    data['payment'] = this.payment;
    data['creater'] = this.creater;
    data['terms_condition'] = this.termsCondition;
    data['message_data'] = this.messageData;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['app_logo'] = this.appLogo;
    data['business_card_logo'] = this.businessCardLogo;
    data['android_latest_version'] = this.android_latest_version;
    data['ios_latest_version'] = this.ios_latest_version;

    return data;
  }
}

class AppScreen {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<TextPage>? text;

  AppScreen({this.id, this.name, this.createdAt, this.updatedAt, this.text});

  AppScreen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['text'] != null) {
      text = new List.empty(growable: true);
      json['text'].forEach((v) {
        text!.add(new TextPage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.text != null) {
      data['text'] = this.text!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TextPage {
  int? id;
  String? label;
  String? text;
  int? appScreenId;
  String? language;
  String? createdAt;
  String? updatedAt;

  TextPage(
      {this.id,
      this.label,
      this.text,
      this.appScreenId,
      this.language,
      this.createdAt,
      this.updatedAt});

  TextPage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    text = json['text'];
    appScreenId = json['app_screen_id'];
    language = json['language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['text'] = this.text;
    data['app_screen_id'] = this.appScreenId;
    data['language'] = this.language;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
