import 'dart:convert';
import 'package:http/http.dart' as http;
import 'bop_models.dart';

class ApiService {
  final String apiKey = "b994cda1"; // API Key proporcionada
  final String baseUrl = "https://www.omdbapi.com/";

  Future<List<BoP>> fetchMovies(String query, int page) async {
    final response = await http.get(
      Uri.parse("$baseUrl?s=$query&page=$page&apikey=$apiKey"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data["Response"] == "True") {
        List<dynamic> results = data['Search'];
        return results.map((json) => BoP.fromJson(json)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Error al cargar las películas");
    }
  }
}
