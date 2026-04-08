import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  static Future<String> getReply(String message) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.143.11.48:5000/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["reply"];
      } else {
        return "Server error. Please try again.";
      }
    } catch (e) {
      return "Unable to connect to chatbot server.";
    }
  }
}
