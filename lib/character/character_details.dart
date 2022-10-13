
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatefulWidget {
  const CharacterDetails({Key? key, required this.charID,}) : super(key: key);

 final int charID;

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {

  bool isLoading = true;

  @override
  void initState() {
   getData();
    super.initState();
  }
void getData() async {
    final response = await Dio().get('https://www.breakingbadapi.com/api/characters/${widget.charID}');
    isLoading = false;
    setState((){});
    print(response.data);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Image.network(''),
          Text('Name'),
          Text('Nickname'),
          Text('Birthday'),
          Text('Status'),
        ],
      ),
    );
  }
}
