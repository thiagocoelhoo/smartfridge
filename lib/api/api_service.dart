import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<Map<String, dynamic>> fetchRecipeDetails(String mealId) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$mealId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'][0];
    } else {
      throw Exception('Erro ao buscar a receita');
    }
  }
}
