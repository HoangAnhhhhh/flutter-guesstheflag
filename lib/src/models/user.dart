class User {
  String id;
  String name;
  String email;
  String photoURL;
  int score;
  DateTime dateCreated;
  String ref;

  User(this.id, this.name, this.email, this.photoURL, this.score,
      this.dateCreated, this.ref);
  
  Map<String, dynamic> toJSON(){
    Map<String, dynamic> user = {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'photoURL': this.photoURL,
      'score': this.score,
      'dateCreated': this.dateCreated,
      'ref': this.ref,
    };
    return user;
  }
}
