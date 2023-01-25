import 'package:dokudoku/model/quotes.dart';
import 'package:dokudoku/remote/ApiConstants.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<TextModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<TextModel> _model = textModelFromJson(response.body);
        return _model;
      }
    } catch (e) {}
  }
}
