import 'dart:math';

import 'package:user_details/model/detail.dart';
import 'package:user_details/model/user_data.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<UserData?> userData(int limit, int skip) async {
    var pathUrl = Uri.parse("https://dummyjson.com/users?limit=$limit");
    print("path url>>>>>>>$pathUrl");
    var response = await http.get(pathUrl);
    // print("response>>>>>>>>${response.body}");
    if (response.statusCode == 200) {
      print("status code>>>>>${response.statusCode}");
      UserData data = userDataFromJson(response.body);
      List<User> userList = data.users;
      print("data>>>>>>>>${userList}");

      return data;
    }
  }


  Future<UserDetails?> userDetails() async {
    var pathUrl = Uri.parse("https://dummyjson.com/users/1");
    var response = await http.get(pathUrl);
    // print("response>>>>>>>>${response.body}");
    if (response.statusCode == 200) {
      String responseString = response.body;
      // log(responseString);
      UserDetails data = userDetailsFromJson(responseString);
      return data;
    }
    return null;
  }
}
