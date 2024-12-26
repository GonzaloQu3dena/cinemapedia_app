import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Api Constants
/// 
/// This class is used to store the api constants. [baseUrl] is the base url of the api and [apiKey] is the api key to access the api.
/// 
/// Properties:
/// * [apiKey]: Is a constant String that is used to access the api.
/// * [baseUrl]: Is a constant String that is the base url of the api.
/// 
/// Author: Gonzalo Quedena
class ApiConstants {
  static const String baseUrl = "";
  static String apiKey = dotenv.env["THE_MOVIEDB_API_KEY"] ?? "API Key not found";
}