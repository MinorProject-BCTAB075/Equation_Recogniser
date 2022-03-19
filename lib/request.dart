import 'dart:typed_data';
import 'package:http/http.dart' as http;

class HttpService {
  static final _Url = Uri.parse('https://kuu-first-flask.herokuapp.com/predict');
  static Future<String> predict(Uint8List img) async {
    late String answer="LOADING...";

    try {
      var request = http.MultipartRequest('POST', _Url);
      request.files.add(
          http.MultipartFile.fromBytes(
              'file',
              img,
              filename: "predictImage.png"
          )
      );
      request.send()
          .then((result) async {
        http.Response.fromStream(result)
            .then((response) {
          answer = response.body;
          print("Answer: " + answer);
          return answer;
        });
      });
    } on Exception catch(e){
      print('error: $e');
    }
    return answer;
  }
}