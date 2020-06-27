// {
//   "userId": 1,
//   "id": 1,
//   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//   "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
// }
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}

void initt() async {
  http.Response response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');
  // {
  //    "body":'{
  //             "userId": 1,
  //             "id": 1,
  //              "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  //             "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  //          }',
  //
  //    "statusCode":200
  // }
  print('fetched');
  var result = json.decode(response.body);
  //           {
  //             "userId": 1,
  //             "id": 1,
  //              "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  //             "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  //          }
  print(Post.fromJson(result));
}

void main() {
  initt();
}
