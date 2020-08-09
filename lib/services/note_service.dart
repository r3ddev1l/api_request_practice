import 'dart:convert';

import 'package:api_reqest_practice/models/api_response.dart';
import 'package:api_reqest_practice/models/note.dart';
import 'package:api_reqest_practice/models/note_for_listing.dart';
import 'package:api_reqest_practice/models/note_insert.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apiKey': 'a11143c8-4d55-4bd9-b44d-8a09d0786b7c',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteForListing>>> getNoteList() {
    return http.get(API + '/notes', headers: headers).then(
      (response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final notes = <NoteForListing>[];
          for (var item in jsonData) {
            notes.add(
              NoteForListing.fromJson(item),
            );
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

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes/' + noteID, headers: headers).then(
      (response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          return APIResponse<Note>(data: Note.fromJson(jsonData));
        }
        return APIResponse<Note>(
            error: true, errorMessage: 'An error occurred');
      },
    ).catchError(
      (_) => APIResponse<Note>(error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(
      API + '/notes/',
      headers: headers,
      body: json.encode(
        item.toJson(),
      ),
    )
        .then(
      (response) {
        print(response.statusCode);
        if (response.statusCode == 201) {
          return APIResponse<bool>(data: true);
        }
        return APIResponse<bool>(
            error: true, errorMessage: 'An error occurred');
      },
    ).catchError(
      (_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http
        .put(
      API + '/notes/' + noteID,
      headers: headers,
      body: json.encode(
        item.toJson(),
      ),
    )
        .then(
      (response) {
        print(response.statusCode);
        if (response.statusCode == 204) {
          return APIResponse<bool>(data: true);
        }
        return APIResponse<bool>(
            error: true, errorMessage: 'An error occurred');
      },
    ).catchError(
      (_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'),
    );
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http
        .delete(
      API + '/notes/' + noteID,
      headers: headers,
    )
        .then(
      (response) {
        print(response.statusCode);
        if (response.statusCode == 204) {
          return APIResponse<bool>(data: true);
        }
        return APIResponse<bool>(
            error: true, errorMessage: 'An error occurred');
      },
    ).catchError(
      (_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'),
    );
  }
}
