import 'package:api_reqest_practice/models/api_response.dart';
import 'package:api_reqest_practice/models/note_for_listing.dart';
import 'package:api_reqest_practice/services/note_service.dart';
import 'package:api_reqest_practice/views/note_delete.dart';
import 'package:api_reqest_practice/views/note_modify.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NoteService get service => GetIt.I<NoteService>();

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNoteList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoteLists'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext contex) => NoteModify(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_apiResponse.error) {
            return Center(
              child: Text(_apiResponse.errorMessage),
            );
          } else
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    background: Container(
                        color: Colors.red,
                        child: Align(
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.black,
                          ),
                        )),
                    key: ValueKey(_apiResponse.data[index].noteId),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final deleteDecision = await showDialog(
                        context: context,
                        builder: (BuildContext context) => NoteDelete(),
                      );
                      print(deleteDecision);
                      return deleteDecision;
                    },
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext contex) => NoteModify(
                              noteId: _apiResponse.data[index].noteId,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        '${_apiResponse.data[index].noteTitle}',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                        'Last edited on ${formatDateTime(_apiResponse.data[index].lastestEditDateTime ?? _apiResponse.data[index].createDateTime)}',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: _apiResponse.data.length);
        },
      ),
    );
  }
}
