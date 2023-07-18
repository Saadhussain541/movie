
import 'package:http/http.dart' as http;
var base_url = "https://www.episodate.com/api/";
class MySaadService
{
  static Future<dynamic> fetch(int page)async{
    var request = http.Request('GET', Uri.parse('${base_url}'+'most-popular?page=$page'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return res;
    }
    else {
      print(response.reasonPhrase);
    }

  }

  static Future<dynamic> desc(int id)async{
    var request = http.Request('GET', Uri.parse('${base_url}'+'show-details?q=$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return res;
    }
    else {
      print(response.reasonPhrase);
    }

  }
}