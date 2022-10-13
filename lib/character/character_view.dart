import 'package:final_project/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'character_card.dart';
import 'character_controller.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({Key? key}) : super(key: key);

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {

  bool isLoading = true;

  CharacterController characterController = CharacterController();

  @override
  void initState() {
    characterController.getAllCharacter().then((value) {
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: () async {
            final sp = await SharedPreferences.getInstance();
            sp.remove('token');
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginView()));
          },
          icon: Icon(Icons.login),)
        ],
      ),
      body: characterController.error != null ? Center(child: Text(characterController.error! ),)
          :isLoading
          ? Center(child: CircularProgressIndicator(strokeWidth: 1.5))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1/1.5,
      ),
          itemCount:characterController.characters.length ,
          itemBuilder: (context, index) => CharacterCard(
            character: characterController.characters[index],
          ),
      ),
    );
  }
}
