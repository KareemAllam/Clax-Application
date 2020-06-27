class Message {
  String title;
  String body;

  Message({this.title, this.body});

  Message.fromJson(Map<String, dynamic> json) {
    title = json['notification']['title'] != null
        ? json['notification']['title']
        : "Untitled";
    body = json['notification']['body'] != null
        ? json['notification']['body']
        : "No Data";
  }
}
