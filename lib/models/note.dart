class Note {
  String noteId;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime lastestEditDateTime;

  Note(
      {this.noteId,
      this.noteTitle,
      this.noteContent,
      this.createDateTime,
      this.lastestEditDateTime});

  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      noteId: item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
