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
      theme: ThemeData(primarySwatch: Colors.red),
      home: NoteList(),
    ),
  );
}
