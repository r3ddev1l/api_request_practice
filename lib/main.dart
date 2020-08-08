import 'package:api_reqest_practice/services/note_service.dart';
import 'package:api_reqest_practice/views/note_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  // I => instance
  GetIt.I.registerLazySingleton(
    () => NoteService(),
  );
}

void main() {
  setupLocator();
  runApp(
    MaterialApp(
      home: NoteList(),
    ),
  );
}

//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  Future getData() async {
//    http.Response response = await http.get(
//      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
//      headers: {
//        "Accept": "application/json",
//      },
//    );
//    print(response.body);
//    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//    List data = json.decode(response.body);
//    print(data[1]['title']);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: RaisedButton(
//          onPressed: getData,
//          child: Text('Get Data'),
//        ),
//      ),
//    );
//  }
//}
