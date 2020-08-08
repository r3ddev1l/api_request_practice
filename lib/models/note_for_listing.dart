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
}
