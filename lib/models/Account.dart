class AccountModel {
  int id;
  String firstname;
  String lastname;
  String avatar;
  AccountModel({this.id, this.firstname, this.lastname, this.avatar});
  factory AccountModel.fromJson(Map<String, dynamic> account) {
    return AccountModel(
      id: account['id'],
      firstname: account['firstname'],
      lastname: account['lastname'],
      avatar: account['avatar'],
    );
  }
}
