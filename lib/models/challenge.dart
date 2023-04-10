import 'package:getup_csc450/models/goals.dart';


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

  DailyChallenge({required String title, required this.description})
      : super(title: title);

  /// A list <of type Challenge> of sample challenges.
   static final List<DailyChallenge> _sampleChallenges = [
    DailyChallenge(
        title: 'Do 50 pushups',
        description: 'They can be spaced out throughout the day, but do 50 in total'),
    DailyChallenge(
        title: 'Drink a glass of water...with no hands',
        description: 'Drink a glass of water without using your hands'),
    DailyChallenge(
        title: 'Look up one word in a dictionary',
        description: 'We all have a word we don\'t know the meaning of'),
    DailyChallenge(
        title: 'Do 50 situps',
        description: 'They can be spaced out throughout the day, but do 50 in total'),
    DailyChallenge(
        title: 'Walk a mile',
        description: 'Go for a walk around your neighborhood'),
    DailyChallenge(
        title: '< 2 hours of screen time',
        description: 'Don\'t spend more than 2 hours on your phone or computer'),
    DailyChallenge(
        title: 'Meditate for 10 minutes',
        description: 'Take a break and focus on your breath for 10 minutes'),
    DailyChallenge(
        title: 'Write a poem',
        description: 'Let your creativity flow and write a poem'),
    DailyChallenge(
        title: 'Take a cold shower',
        description: 'It may be uncomfortable at first, but it\'s great for your circulation'),
    DailyChallenge(
        title: 'Do a random act of kindness',
        description: 'Make someone\'s day by doing something nice for them. For example: Complement them, or help them with a task.'),
    DailyChallenge(
        title: 'Learn a new recipe',
        description: 'Expand your cooking skills and try making something new'),
    DailyChallenge(
        title: 'No social media for a day',
        description: 'Disconnect from social media for a day'),
    DailyChallenge(
        title: 'Make a vision board',
        description: 'Visualize your goals and aspirations by creating a vision board'),
    DailyChallenge(
        title: 'Try a new workout',
        description: 'Switch up your exercise routine and try something new'),
    DailyChallenge(
        title: 'Read a book',
        description: 'Get lost in a good book'),
    DailyChallenge(
        title: 'Clean out your closet',
        description: 'Get rid of clothes you no longer wear'),
    DailyChallenge(
        title: 'Organize your desk',
        description: 'Declutter and organize your workspace'),
    DailyChallenge(
        title: 'Listen to a new podcast',
        description: 'Discover a new podcast and learn something new'),
    DailyChallenge(
        title: 'Try a new hobby',
        description: 'Explore a new hobby and discover a new passion'),
    DailyChallenge(
        title: 'Have a technology-free day',
        description: 'Disconnect from technology for a day'),
    DailyChallenge(
        title: 'Stretch for 10 minutes',
        description: 'Take a break and stretch your body'),
    DailyChallenge(
        title: 'Call a friend or family member',
        description: 'Catch up with someone you haven\'t talked to in a while'),
    DailyChallenge(
        title: 'Go for a bike ride',
        description: 'Take a ride on your bike and get some fresh air'),
    DailyChallenge(
        title: 'Try a new cuisine',
        description: 'Step out of your comfort zone and try a new type of food'), 
    DailyChallenge(
        title: 'Try a new type of tea',
        description: 'Explore different tea flavors and find a new favorite'),
    DailyChallenge(
        title: 'Create a gratitude list',
        description: 'Write down everything you\'re grateful for'),
    DailyChallenge(
        title: 'Visit a new place in your town/city',
        description: 'Discover a new spot in your local area'),
    DailyChallenge(
        title: 'Spend a day without complaining',
        description: 'Practice gratitude by not complaining for a day'),
    DailyChallenge(
        title: 'Learn a new language',
        description: 'Start learning a new language'),
    DailyChallenge(
        title: 'Draw or paint a picture',
        description: 'Get creative and make a work of art'),
    DailyChallenge(
        title: 'Do a crossword or Sudoku puzzle',
        description: 'Challenge your brain with a puzzle'),
    DailyChallenge(
        title: 'Create a morning routine',
        description: 'Start your day off with a routine that sets you up for success'),
    DailyChallenge(
        title: 'Take a self-defense class',
        description: 'Learn how to protect yourself'),
    DailyChallenge(
        title: 'Attend a virtual event',
        description: 'Join an online event and connect with others'),
    DailyChallenge(
        title: 'Make a homemade gift for someone',
        description: 'Show someone you care by making them a gift'),
    DailyChallenge(
        title: 'Try a new type of exercise',
        description: 'Explore a new type of physical activity'),
    DailyChallenge(
        title: 'Listen to a new album',
        description: 'Discover new music and expand your taste'),
    DailyChallenge(
        title: 'Start a daily journal',
        description: 'Reflect on your thoughts and feelings in a daily journal'),
    DailyChallenge(
        title: 'Have a picnic',
        description: 'Pack a basket and enjoy a meal outside'),
    DailyChallenge(
        title: 'Try a new hair or makeup style',
        description: 'Experiment with a new look'),
    DailyChallenge(
        title: 'Attend a free class or workshop',
        description: 'Learn something new without spending any money'),
    DailyChallenge(
        title: 'Make a homemade meal from scratch',
        description: 'Challenge yourself and make a meal entirely from scratch'),
    DailyChallenge(
        title: 'Spend a day in nature',
        description: 'Disconnect and spend the day outside'),
    DailyChallenge(
        title: 'Write a letter to someone you admire',
        description: 'Express your appreciation to someone you look up to'),
    DailyChallenge(
        title: 'Take a dance class',
        description: 'Get moving and try a dance class'),
    DailyChallenge(
        title: 'Try a new type of coffee',
        description: 'Explore different coffee flavors and find a new favorite'),
    DailyChallenge(
        title: 'Watch a classic movie',
        description: 'Experience a classic film you haven\'t seen before'),
    DailyChallenge(
        title: 'Learn a new skill online',
        description: 'Find a tutorial online and learn a new skill'),
    DailyChallenge(
        title: 'Attend a live event',
        description: 'Experience a live performance or show'),
    DailyChallenge(
        title: 'Take a day trip',
        description: 'Explore a nearby town or attraction for the day'),
    DailyChallenge(
        title: 'Try a new form of art',
        description: 'Experiment with a new type of art, such as sculpture or pottery'),
    DailyChallenge(
        title: 'Learn a new instrument',
        description: 'Start learning to play a new instrument'),
    DailyChallenge(
        title: 'Volunteer at a local organization',
        description: 'Pick a local organization that does good for the comunity and spend a couple hours volunteering.')
  ];

  /// Gets the title of the challenge.
  String get challengeTitle => title;

  /// Gets the description of the challenge.
  String get challengeDescription => description;

  /// Gets the sample challenges.
  List<DailyChallenge> get sampleChallengeList => _sampleChallenges;

  
}
