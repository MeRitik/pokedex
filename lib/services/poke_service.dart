import 'package:http/http.dart' as http;
import 'dart:convert';

class Pokemon {
  Future<void> makeGetRequest() async {
    // The URL of the endpoint you want to send a GET request to
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/pikachu');

    try {
      // Send the GET request
      final response = await http.get(url);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the response body
        final responseBody = jsonDecode(response.body);

        // Print the response body
        print('Response body: $responseBody');
      } else {
        // If the request failed, print the status code
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // If there was an error, print it
      print('Error: $e');
    }
  }
}
