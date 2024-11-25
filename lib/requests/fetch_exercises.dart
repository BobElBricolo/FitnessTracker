import 'dart:convert';
import 'package:fitness_tracker/helpers/creation_helper.dart';
import 'package:fitness_tracker/models/exercise.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      "https://exercise-db-fitness-workout-gym.p.rapidapi.com";
  static const Map<String, String> _headers = {
    "x-rapidapi-key": "77e80d79damshe8dc9a159f35815p15bedejsn088abb3dc312",
    "x-rapidapi-host": "exercise-db-fitness-workout-gym.p.rapidapi.com",
  };

  static Future<List<Exercise>> fetchAllExercises() async {
    final url = Uri.parse("$_baseUrl/exercises");

    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((exerciseJson) => Exercise.fromJson(exerciseJson))
            .toList();
      } else {
        print("Erreur : ${response.statusCode}, retour des exercices de base.");
        return getDefaultExercise();
      }
    } catch (e) {
      print("Erreur de connexion : $e, retour des exercices de base.");
      return loadExercisesFromJson();
    }
  }
}
