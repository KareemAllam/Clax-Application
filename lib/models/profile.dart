class Profile {
  Name name;
  String mail;
  String phone;
  String pass;
  int avatarIndex;
  int passLength;
  bool mailVerified;
  bool phoneVerified;

  Profile(
      {this.name,
      this.mail,
      this.phone,
      this.pass,
      this.avatarIndex,
      this.passLength,
      this.mailVerified,
      this.phoneVerified});
  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    mail = json['mail'];
    phone = json['phone'];
    pass = json['pass'];
    avatarIndex = json['avatarIndex'];
    passLength = json['passLength'];
    mailVerified = json['mail_verified'];
    phoneVerified = json['phone_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['mail'] = this.mail;
    data['phone'] = this.phone;
    data['pass'] = this.pass;
    data['avatarIndex'] = this.avatarIndex;
    data['passLength'] = this.passLength;
    data['mail_verified'] = this.mailVerified;
    data['phone_verified'] = this.phoneVerified;
    return data;
  }
}

class Name {
  String first;
  String last;

  Name({this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}
