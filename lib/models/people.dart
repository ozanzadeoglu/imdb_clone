import 'package:imdb_app/constants/hive_adapters.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:hive/hive.dart';

part 'people.g.dart';

@HiveType(typeId: HiveAdapters.people)
class People {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? knownForDepartment;

  @HiveField(3)
  final String? birthday;

  @HiveField(4)
  final String? deathDay;

  @HiveField(5)
  final String? biography;

  @HiveField(6)
  final String? imagePath;

  @HiveField(7)
  final String? gender;

  @HiveField(8)
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
