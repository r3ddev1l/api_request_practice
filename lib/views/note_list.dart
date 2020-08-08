import 'package:api_reqest_practice/models/note_for_listing.dart';
import 'package:api_reqest_practice/views/note_delete.dart';
import 'package:api_reqest_practice/views/note_modify.dart';
import 'package:flutter/material.dart';

class NoteList extends StatelessWidget {
  final notes = [
    NoteForListing(
        noteId: "1",
        noteTitle: "Title 1",
        createDateTime: DateTime.now(),
        lastestEditDateTime: DateTime.now()),
    NoteForListing(
        noteId: "2",
        noteTitle: "Title 2",
        createDateTime: DateTime.now(),
        lastestEditDateTime: DateTime.now()),
    NoteForListing(
        noteId: "3",
        noteTitle: "Title 3",
        createDateTime: DateTime.now(),
        lastestEditDateTime: DateTime.now()),
  ];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoteList'),
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
      body: ListView.separated(
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
              key: ValueKey(notes[index].noteId),
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
                        noteId: notes[index].noteId,
                      ),
                    ),
                  );
                },
                title: Text(
                  '${notes[index].noteTitle}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                  'Created on ${formatDateTime(notes[index].lastestEditDateTime)}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: notes.length),
    );
  }
}
