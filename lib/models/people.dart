import 'package:imdb_app/constants/string_constants.dart';

class People {
  final int? id;
  final String? name;
  final String? knownForDepartment;
  final String? birthday;
  final String? deathDay;
  final String? biography;
  final String? imagePath;
  final String? gender;
  final String? placeOfBirth;

  People(
      {required this.id,
      required this.name,
      required this.knownForDepartment,
      required this.birthday,
      required this.deathDay,
      required this.biography,
      required this.imagePath,
      required this.gender,
      required this.placeOfBirth});

  factory People.fromJson(Map<String, dynamic> json) {
    String? genderNumToString(int? num) {
      switch (num) {
        case 0:
          return StringConstants.peopleGenderNotSpecified;
        case 1:
          return StringConstants.peopleGenderFemale;
        case 2:
          return StringConstants.peopleGenderMale;
        case 3:
          return StringConstants.peopleGenderFemale;
      }
      return null;
    }

    return People(
        id: json['id'] as int?,
        name: json['name'] as String?,
        knownForDepartment: json['known_for_department'] as String?,
        birthday: json['birthday'] as String?,
        deathDay: json['deathday'] as String?,
        biography: json['biography'] as String?,
        imagePath: json['profile_path'] as String?,
        gender: genderNumToString(json['gender'] as int?),
        placeOfBirth: json['place_of_birth'] as String?,
        );
      
  }
}
