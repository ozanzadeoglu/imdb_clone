//used in getting credits of a movie or tw show.
//api returns everything; actors to cameramans,
//in client, only actors will be created as a SimpleCredit class
//to used in PosterCards.
class SimpleCredit {
  final int? id;
  final String? actorName;
  final String? characterName;
  final String? profilePath;

  SimpleCredit({
    required this.id,
    required this.actorName,
    required this.characterName,
    required this.profilePath
  });

  factory SimpleCredit.fromJson(Map<String, dynamic> json) {
    return SimpleCredit(
      id: json['id'],
      //returns empty string
      actorName: json['name'].toString().isEmpty ?  null : json['name'],
      characterName: json['character'].toString().isEmpty ?  null : json['character'],
      profilePath: json['profile_path']
    );
  }
}
