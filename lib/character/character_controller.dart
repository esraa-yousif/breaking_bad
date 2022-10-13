import 'package:dio/dio.dart';
import 'character.dart';

class CharacterController{

  List<Character> characters = [];
  String? error;

  Future<void> getAllCharacter() async {
    try {
      final response = await Dio().get(
          'https://www.breakingbadapi.com/api/characters');
      for (var i in response.data) {
        characters.add(Character(
            name: i['name'],
            image: i['img'], // was image the correct is img due to json response :)
          id: i['char_id'],
        ));
      }
    } catch (e, s) {
      print('ERROR');
      print(e); // exception : error message
      print(s); // stacktrace : error location / position
    }
  }
}