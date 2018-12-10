import '../general/phones.dart';

class UserInfo {
  String status;
  String message;
  UserInfoResult result;

  UserInfo({this.status, this.message, this.result});

  UserInfo.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    result = json['Result'] != null
        ? new UserInfoResult.fromJson(json['Result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class UserInfoResult {
  String userId;
  String fullName;
  String firstName;
  String lastName;
  String email;
  String title;
  String licenseNumber;
  String losLicenseInfo;
  String companyImageUrl;
  String profileImageUrl;
  List<Phones> phones;
  String companyId;
  String kalturaId;
  List<String> kalturaTags;

  UserInfoResult(
      {this.userId,
      this.fullName,
      this.firstName,
      this.lastName,
      this.email,
      this.title,
      this.licenseNumber,
      this.losLicenseInfo,
      this.companyImageUrl,
      this.profileImageUrl,
      this.phones,
      this.companyId,
      this.kalturaId,
      this.kalturaTags});

  UserInfoResult.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    title = json['title'];
    licenseNumber = json['license_number'];
    losLicenseInfo = json['los_license_info'];
    companyImageUrl = json['company_image_url'];
    profileImageUrl = json['profile_image_url'];
    if (json['phones'] != null) {
      phones = new List<Phones>();
      json['phones'].forEach((v) {
        phones.add(new Phones.fromJson(v));
      });
    }
    companyId = json['company_id'];
    kalturaId = json['kaltura_id'];
    kalturaTags = json['kaltura_tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['title'] = this.title;
    data['license_number'] = this.licenseNumber;
    data['los_license_info'] = this.losLicenseInfo;
    data['company_image_url'] = this.companyImageUrl;
    data['profile_image_url'] = this.profileImageUrl;
    if (this.phones != null) {
      data['phones'] = this.phones.map((v) => v.toJson()).toList();
    }
    data['company_id'] = this.companyId;
    data['kaltura_id'] = this.kalturaId;
    data['kaltura_tags'] = this.kalturaTags;
    return data;
  }
}
