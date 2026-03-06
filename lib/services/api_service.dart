import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class ApiService {
  // MUST match Flask IP exactly
  static const String baseUrl = AppConfig.backendUrl;

  static Future<Map<String, dynamic>> predict(Map<String, dynamic> data) async {
    final response = await http
        .post(
          Uri.parse("$baseUrl/predict"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        )
        .timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  }
}
