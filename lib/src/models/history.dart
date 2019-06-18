class History {
  String userID;
  String dateCreated;
  int score;
  String level;

  History(this.userID, this.dateCreated, this.score, this.level);

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> history = {
      'userID': this.userID,
      'dateCreated': this.dateCreated,
      'score': this.score,
      'level': this.level,
    };
    return history;
  }
}
