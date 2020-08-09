import 'package:api_reqest_practice/models/note.dart';
import 'package:api_reqest_practice/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  final String noteId;
  NoteModify({this.noteId});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;

  NoteService get noteService => GetIt.I<NoteService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    noteService.getNote(widget.noteId).then((response) {
      setState(() {
        _isLoading = false;
      });
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      note = response.data;
      _titleController.text = note.noteTitle;
      _contentController.text = note.noteContent;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note Title'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration:
                        InputDecoration(hintText: 'Write your note here...'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
