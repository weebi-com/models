import 'dart:convert';
import 'package:http/http.dart' as http;

extension CleanBodyDecode on http.Response {
  List<dynamic> get cleanBodyDecode {
    final cleanBody =
        body.substring(1, body.length - 1); //clean " " returned by mongorealm
    final cleanBodyDecoded =
        json.decode(cleanBody.replaceAll(r'\', '')) as List;
    return cleanBodyDecoded;
  }
}
