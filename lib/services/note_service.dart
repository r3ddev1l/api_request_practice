import 'dart:convert';

import 'package:api_reqest_practice/models/api_response.dart';
import 'package:api_reqest_practice/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {'apiKey': 'a11143c8-4d55-4bd9-b44d-8a09d0786b7c'};

  Future<APIResponse<List<NoteForListing>>> getNoteList() {
    return http.get(API + '/notes', headers: headers).then(
      (response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final notes = <NoteForListing>[];
          for (var item in jsonData) {
            final note = NoteForListing(
              noteId: item['noteID'],
              noteTitle: item['noteTitle'],
              createDateTime: DateTime.parse(item['createDateTime']),
              lastestEditDateTime: item['latestEditDateTime'] != null
                  ? DateTime.parse(item['latestEditDateTime'])
                  : null,
            );
            notes.add(note);
          }
          return APIResponse<List<NoteForListing>>(data: notes);
        }
        return APIResponse<List<NoteForListing>>(
            error: true, errorMessage: 'An error occurred');
      },
    ).catchError(
      (_) => APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occurred'),
    );
  }
}