import 'goals.dart';

/// The challenge class is a subclass of Goal.
/// It requires the following parameters:
///
/// * [title]: the title of the challenge
/// * [description]: the description of the challenge
///
/// The class has a value called isActive that is set to false by default.
///
/// Here are a list of Challenge methods:
///
/// * challengeTitle: gets the title of the challenge
/// * challengeDescription: gets the description of the challenge
/// * challengeStatus: gets the status of the challenge
/// * sampleChallengeList: gets a list of sample challenges

class DailyChallenge extends Goal {
  final String description;
  late bool isActive;

  DailyChallenge({required String title, required this.description})
      : super(title: title);

  /// A list <of type Challenge> of sample challenges.
  final List<DailyChallenge> _sampleChallenges = [
    DailyChallenge(
        title: 'Do 50 pushups',
        description:
            'They can be spaced out throughout the day, but do 50 in total'),
    DailyChallenge(
        title: 'Drink a glass of water...with no hands',
        description: 'Drink a glass of water without using your hands'),
    DailyChallenge(
        title: 'Look up one word in a dictionary',
        description: 'We all have a word we don\'t know the meaning of'),
    DailyChallenge(
        title: 'Do 50 situps',
        description:
            'They can be spaced out throughout the day, but do 50 in total'),
    DailyChallenge(
        title: 'Walk a mile',
        description: 'Go for a walk around your neighborhood'),
    DailyChallenge(
        title: '< 2 hours of screen time',
        description:
            'Don\'t spend more than 2 hours on your phone or computer'),
    DailyChallenge(
        title: 'Comment all of your code',
        description: 'Comment all of your code in your projects'),
  ];

  /// Gets the title of the challenge.
  String get challengeTitle => title;

  /// Gets the description of the challenge.
  String get challengeDescription => description;

  /// Gets the status of the challenge.
  bool get challengeStatus => isActive;

  /// Gets the sample challenges.
  List<DailyChallenge> get sampleChallengeList => _sampleChallenges;
}
