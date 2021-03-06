class NoteForListing {
  String noteId;
  String noteTitle;
  DateTime createDateTime;
  DateTime lastestEditDateTime;

  NoteForListing(
      {this.noteId,
      this.noteTitle,
      this.createDateTime,
      this.lastestEditDateTime});
  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      noteId: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      lastestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
