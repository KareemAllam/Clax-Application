class Account {
  int id;
  String firstname;
  String lastname;
  String avatar;
  Account({this.id, this.firstname, this.lastname, this.avatar});
  factory Account.fromJson(Map<String, dynamic> account) {
    return Account(
      id: account['id'],
      firstname: account['firstname'],
      lastname: account['lastname'],
      avatar: account['avatar'],
    );
  }
}
