import 'user_controller.dart';

/// Represents a user profile containing user details, bio and interests.
class Profile {
  late User _user; // The user of the profile
  late String _userBio; // The bio of the user
  late String _userInterests; // The interests of the user

  static List<Profile> _profiles = []; // The list of profiles created

  /// Constructor for creating a new profile
  ///
  /// [user] is the user of the profile.
  /// [userBio] is the bio of the user.
  /// [userInterests] is the interests of the user.
  Profile({
    required User user,
    required String userBio,
    required String userInterests,
  }) {
    _user = user;
    _userBio = userBio;
    _userInterests = userInterests;
    _profiles.add(this);
  }

  User get user {
    return _user;
  }

  set user(User value) {
    _user = value;
  }

  String get userBio {
    return _userBio;
  }

  set userBio(String value) {
    _userBio = value;
  }

  String get userInterests {
    return _userInterests;
  }

  set userInterests(String value) {
    _userInterests = value;
  }

  static List<Profile> get profiles {
    return _profiles;
  }

  static set profiles(List<Profile> value) {
    _profiles = value;
  }

  /// Creates sample data for the profiles.
  ///
  /// Uses sample users from `UserController` to create a new `Profile` for each user.
  static void createSampleData() {
    for (var user in sampleUsers) {
      //sampleUsers comes from User which at the time is part of a pull request and is not fully merged into main yet
      final profile = Profile(
        user: user,
        userBio: "I don't want to procrastinate anymore",
        userInterests: "Working out, Art, Beer",
      );
    }
  }
}


// Used for testing
// void main() {
//   Profile.createSampleData();

//   // Get the list of profiles and print the first user's first name
//   print(Profile.profiles[0].user.firstName); // Outputs "Cole"

//   // Update the first user's bio and print the updated bio
//   Profile.profiles[0].userBio = "I need help.";
//   print(Profile.profiles[0].userBio); // Outputs "I need help."
// }
