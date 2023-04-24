import 'package:getup_csc450/models/goals.dart';
import 'package:getup_csc450/screens/challenge_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'dart:async';
final random = Random();



/// The challenge class is a subclass of Goal.
/// It requires the following parameters:
///
/// * [title]: the title of the challenge
/// * [description]: the description of the challenge
///
/// The class has a value called isCompleted that is set to false by default
/// The class has an unique id called id
/// The class has a value for the date it was accepted called dateCreated
///
/// Here are a list of Challenge methods:
///
/// * challengeTitle: gets the title of the challenge
/// * challengeDescription: gets the description of the challenge
/// * challengeStatus: gets the status of the challenge
/// * challengeId: get the challenge id
/// * challengeList: gets a list of sample challenges
/// * challengeAcceptedDate: gets the date teh challenge was accepted]]]
/// 
/// 

class Challenge extends Goal {
  ///the description of the challenge
  final String description;

  
  Challenge({required String title, 
             required this.description, 
             bool? isCompleted, 
             String? id,
             DateTime? dateCreated})
      
      : super(title: title, 
              isCompleted: isCompleted, 
              id: id ?? const Uuid().v4(),
              dateCreated: dateCreated ?? DateTime.now()
              );


   /// Gets the title of the challenge
  String get challengeTitle => title;

  /// Gets the description of the challenge
  String get challengeDescription => description;

  /// Gets the status of the challenged
  bool get challengeStatus => isCompleted;

  /// Gets the id of the challenge
  String get challengeId => id;

  /// Gets the date the challenge was accepted.
  DateTime get challengeAcceptedDate => dateCreated;




  /// This returns the challenge in a JSON format.
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': challengeTitle,
      'description': challengeDescription,
      'isCompleted': challengeStatus,
      'challengeId': challengeId,
      'dateCreated': challengeAcceptedDate,
    };
  }

  /// This returns the challenge from a JSON format.
  static Challenge fromJson(Map<String, dynamic> json) {
    return Challenge(
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        id: json['challlengId'],

        /// This ensures that the date is in the correct format.
        dateCreated: (json['dateCreated'] as Timestamp).toDate());
  }

  /// Gets the sample challenges.
  List<Challenge> get challengeList => _challenges;

  ChallengeDataState challengeDataState = ChallengeDataState.mainInstance;

  void generateNewChallenges() {
    for (int i = 0; i < 5; i++) {
        challengeDataState.addChallengeShown(_challenges[
            random.nextInt(_challenges.length)]);
    }

  }
  

  // @override
  // void initState() {
  //   initState();
  //   // Generate a new challenge when the widget is first created
  //   generateNewChallenges();
  //   // Set a timer to reset the completed challenges list every day at midnight
  //   timer = Timer.periodic(const Duration(days: 1), (timer) {
  //     // Generate a new challenge at the start of each day
  //     generateNewChallenges();
  //   });
  // }
}

  /// A list <of type Challenge> of sample challenges.
  /// static 
  final List<Challenge> _challenges = [
    Challenge(
        title: 'Do 50 pushups',
        description: 'They can be spaced out throughout the day, but do 50 in total'),
    Challenge(
        title: 'Chug a glass of water and then get another glass to sip',
        description: 'Get hydrated'),
    Challenge(
        title: 'Look up one word in a dictionary',
        description: 'We all have a word we don\'t know the meaning of. Find a new one and write it down, maybe try and use it today'),
    Challenge(
        title: 'Do 50 situps',
        description: 'They can be spaced out throughout the day, but do 50 in total'),
    Challenge(
        title: 'Walk a mile',
        description: 'Go for a walk around your neighborhood'),
    Challenge(
        title: '< 2 hours of screen time',
        description: 'Don\'t spend more than 2 hours on your phone or computer'),
    Challenge(
        title: 'Meditate for 10 minutes',
        description: 'Take a break and focus on your breath for 10 minutes'),
    Challenge(
        title: 'Write a poem',
        description: 'Let your creativity flow and write a poem'),
    Challenge(
        title: 'Take a cold shower',
        description: 'It may be uncomfortable at first, but it\'s great for your circulation'),
    Challenge(
        title: 'Do a random act of kindness',
        description: 'Make someone\'s day by doing something nice for them. For example: Complement them, or help them with a task.'),
    Challenge(
        title: 'Learn a new recipe',
        description: 'Expand your cooking skills and try making something new'),
    Challenge(
        title: 'No social media for a day',
        description: 'Disconnect from social media for a day, I reccomend actually deleting the apps from your phone. You can always redownload them'),
    Challenge(
        title: 'Make a vision board',
        description: 'Visualize your goals and aspirations by creating a vision board'),
    Challenge(
        title: 'Read a book',
        description: 'Get lost in a good book, read a chapter or for 30 minutes'),
    Challenge(
        title: 'Clean out your closet',
        description: 'Get rid of clothes you no longer wear'),
    Challenge(
        title: 'Organize your desk',
        description: 'Declutter and organize your workspace'),
    Challenge(
        title: 'Listen to a  podcast',
        description: 'Listen to a podcast on a subject you are unfamiliar with'),
    Challenge(
        title: 'Try a new hobby',
        description: 'Explore a new hobby and discover a new passion'),
    Challenge(
        title: 'Stretch for 10 minutes',
        description: 'Take a break and stretch your body'),
    Challenge(
        title: 'Call a friend or family member',
        description: 'Catch up with someone you haven\'t talked to in a while'),
    Challenge(
        title: 'Go for a bike ride',
        description: 'Take a ride on your bike and get some fresh air'),
    Challenge(
        title: 'Try a new cuisine',
        description: 'Step out of your comfort zone and try a new type of food'), 
    Challenge(
        title: 'Drink a cup of tea',
        description: 'Explore different tea flavors and find a new favorite, or enjoy tea if it\'s not something you usualy do'),
    Challenge(
        title: 'Create a gratitude list',
        description: 'Write down everything you\'re grateful for'),
    Challenge(
        title: 'Visit a new place in your town/city',
        description: 'Discover a new spot in your local area, could be a shop or a restaurrant or a park or anything'),
    Challenge(
        title: 'Spend a day without complaining',
        description: 'Practice gratitude by not complaining for a day'),
    Challenge(
        title: 'Learn a new language',
        description: 'Start learning a new language or counitinue with one you\re learning, you could start with Duolingo or ask a friend whose native in another language'),
    Challenge(
        title: 'Draw or paint a picture',
        description: 'Get creative and make a work of art, look up a tutorial online'),
    Challenge(
        title: 'Do a crossword or Sudoku puzzle',
        description: 'Challenge your brain with a puzzle'),
    Challenge(
        title: 'Create a morning routine',
        description: 'Make a list of how you want to start your day off for success, implement the routine tomorrow'),
    Challenge(
        title: 'Take a self-defense class',
        description: 'Learn how to protect yourself, if you don\'t have access to something in-person, watch a youtube video'),
    Challenge(
        title: 'Make a homemade gift for someone',
        description: 'Show someone you care by making them a gift. i.e. a bouquet of flowers, a card, a drawing it could be anything. Michael\'s has lot of crafts you could start with'),
    Challenge(
        title: 'Try a new type of exercise',
        description: 'Explore a new type of physical activity, i.e. lift, run, swim, or even rockclimb'),
    Challenge(
        title: 'Listen to a new album',
        description: 'Discover new music and expand your taste'),
    Challenge(
        title: 'Start a daily journal',
        description: 'Reflect on your thoughts and feelings in a daily journal, you don\'t have to write much, but look back on the day'),
    Challenge(
        title: 'Have a picnic',
        description: 'Pack a basket and enjoy a meal outside, I reccomend inviting a friend'),
    Challenge(
        title: 'Try a new hair or makeup style',
        description: 'Experiment with a new look, maybe wear hat if you don\'t normally'),
    Challenge(
        title: 'Checkout a book from the library',
        description: 'Sign up for a library card and checkout a book you find interesting'),
    Challenge(
        title: 'Make a homemade meal from scratch',
        description: 'Challenge yourself and make a meal entirely from scratch'),
    Challenge(
        title: 'Write a letter to someone you admire',
        description: 'Express your appreciation to someone you look up to'),
    Challenge(
        title: 'Take a dance class',
        description: 'Get moving and try a dance class, could be online'),
    Challenge(
        title: 'Go to a coffee shop',
        description: 'Bring a book or your work to a nearby coffee shop'),
    Challenge(
        title: 'Watch a classic movie',
        description: 'Experience a classic film you haven\'t seen before'),
    Challenge(
        title: 'Learn a new skill online',
        description: 'Find a tutorial online and learn a new skill, could be whisteling, could be origami, etc...'),
    Challenge(
        title: 'Attend a live event',
        description: 'Experience a live performance or show'),
    Challenge(
        title: 'Take a day trip',
        description: 'Explore a nearby town or attraction for the day'),
    Challenge(
        title: 'Try a new form of art',
        description: 'Experiment with a new type of art, such as sculpture or pottery'),
    Challenge(
        title: 'Learn a new instrument',
        description: 'Start learning to play a new instrument, there is a lot of software online where you can practice virtual instruments.'),
    Challenge(
        title: 'Volunteer at a local organization',
        description: 'Pick a local organization that does good for the comunity and spend a couple hours volunteering.'),
    Challenge(
        title: 'Catch-up with an old friend', 
        description: 'Message or cal a friend you haven\'t heard from in a while'),
    Challenge(
        title: 'Plank for 5 minutes', 
        description: 'Can be split up throughout the day and between side planks, front planks and other variations.'),
    Challenge(
        title: 'Get some fresh local produce', 
        description: 'Go to a local farmer\'s market or farm stand'),
    Challenge(
        title: 'Drink a gallon of water', 
        description: 'Drink a gallon of water throughout the day'),
    Challenge(
        title: 'Read a news article', 
        description: 'Read a news article and learn something new'),
    Challenge(
        title: 'Take a nap', 
        description: 'Take a 30-minute nap during the day',),
    Challenge(
        title: 'Take a different route', 
        description: 'Take a different route on your commute or walk'),
    Challenge(
        title: 'Watch a documentary', 
        description: 'Watch a documentary on a new topic'),
    Challenge(
        title: 'Clean your bathroom', 
        description: 'Clean and santizie your bathroom'),
    Challenge(
        title: 'Play a boardgame', 
        description: 'Relax and play a boardgame or cardgame with some friends'),
    Challenge(
        title: 'Go to the beach', 
        description: 'Go get some sun at the beach'),
    Challenge(
        title: '', 
        description: ''),
    Challenge(
        title: 'Make a family tree', 
        description: 'Ask your family about your family tree and see how far back you can trace it'),
    Challenge(
        title: 'Invest in the stock market', 
        description: 'Research about the stock market and invest in a stock, you don\'t have to spend much'),
    Challenge(
        title: 'Start a garden', 
        description: 'Plant something or add a potted plant to your home'),
    Challenge(
        title: 'Tell a joke', 
        description: 'Think of a joke or find one you like and tell it to someone'),
    Challenge(
        title: 'Go for a hike', 
        description: 'Walk a nearby trail in nature'),
    Challenge(
        title: 'Take a picture of something mundane', 
        description: 'Take a picture of something ordinary or mundane that doesn\'t get much attention and romanticize it'),
    Challenge(
        title: 'Play chess or checkers', 
        description: 'PLay on a board with a freind or battle an AI online'),
    Challenge(
        title: 'Organize your files', 
        description: 'Organize and declutter the files on your computer'),
    Challenge(
        title: 'Clean up the planet', 
        description: 'Spend 30 minutes picking up trash at the park, on your street, or along the beach'),
    Challenge(
        title: 'Take a yoga class', 
        description: 'Spend at least 20 minutes or however long you have and join a yoga class online or in-person'),
    Challenge(
        title: 'Go to a  museum', 
        description: 'Go to a museum and learn some history. You might be able to find a local one with fre admission'),
    Challenge(
        title: 'Take a break from caffeine', 
        description: 'Take a break from your normal coffee, tea, or energy drink routine and stay hyrdrated with water instead'),
    Challenge(
        title: 'Clean you bed sheets', 
        description: 'Nothings better than fresh warm sheets'),
    Challenge(
        title: 'Eat a salad', 
        description: 'Replace your normal diet with something a little fresher'),
    Challenge(
        title: 'Go vegetarian or vegan for the day', 
        description: 'Experiment with subtracting the meat and/or dairy prodcuts from your life'),
    Challenge(
        title: 'Watch the sunset', 
        description: 'Find a nice view of the horizon and watch the sunset'),
    Challenge(
        title: 'Donate food to someone in need', 
        description: 'Make or give a meal to someone living on the street'),
    Challenge(
        title: 'Write your future self a letter',
        description: 'Write a letter for yourself to open in 10 or even 25 years from now'),
    Challenge(
        title: 'Cut out the sugary drinks', 
        description: 'Replace the soda or juice you may normally drink with water or tea for the day'),
    Challenge(
        title: 'Donate', 
        description: 'Donate to a charity or non-profit organization you find interest in'),
    Challenge(
        title: 'Save some money', 
        description: 'Store away some money for a rainy day'),
    Challenge(
        title: 'Find a quote', 
        description: 'Look up a quote that inspires you and put it somewhere visible'),
    Challenge(
        title: 'Affirm yourself', 
        description: 'Say out loud or write down three positive affirmations'),
    Challenge(
        title: 'Wake up early', 
        description: 'Wake up an hour earlier tomorrow or before 8 am. Maybe catch the sunrise'),
    Challenge(
        title: 'Don\'t speak all day', 
        description: 'Take a vow of silence today and find other ways to communicate'),
    Challenge(
        title: 'Ask for advice', 
        description: 'Ask peer or mentor for advice or feedback'),
    Challenge(
        title: 'Dress up today', 
        description: 'Dress to impress even if your just going to the grocery store or post office. Put on a suit or a nice dress'),
    Challenge(
        title: 'Dress down today', 
        description: 'Ignore social expectation and confidently rock your sweats and other comfy clothes out'),
    Challenge(
        title: 'Talk to a stranger', 
        description: 'Introduce yourself to someone you\'ve never seen or met before'),
    Challenge(
        title: 'Go green on your commute', 
        description: 'Take a break from driving and bike or walk to work today'),
    Challenge(
        title: 'Carpool', 
        description: 'Carpool with your friends instead of driving seperate'),
    Challenge(
        title: 'Take public transportation', 
        description: 'Hitch a ride on your cities train or bus'),
    Challenge(
        title: 'Do 50 squats', 
        description: 'Tone your legs and get 50 total squats in today'),
    Challenge(
        title: 'Sleep for 8 hours', 
        description: 'Get a minimum of 8 hours rest tonight'),
    Challenge(
        title: 'Say "I love you"', 
        description: 'Tell someone close to you, you love them'),
    Challenge(
        title: 'Refrain from alcohol', 
        description: 'Don\'t drink any alcohol today'),
    Challenge(
        title: 'Take the stairs', 
        description: 'Choose to take the stairs instead of an elevator when possible today'),
    Challenge(
        title: 'Floss', 
        description: 'Have you flossed your teeth today?'),
  ];



/// This class stores the state of the challenge data
/// It extends ChangeNotifier so that it can notify its listener when the challenge data changes
/// It provides methods to modify the challenge data
/// It also provides getters to access the challenge data
class ChallengeDataState extends ChangeNotifier {
  /// This is the only instance of the ChallengeDataState class
  static final ChallengeDataState mainInstance =
      ChallengeDataState._mainInstanceCreator();

  /// This is the constructor for the ChallengeDataState class
  /// It is private so that it can only be called by the getInstance method
  /// This ensures that there is only one instance of the ChallengeDataState class
  ChallengeDataState._mainInstanceCreator();

  /// This method returns the only instance of the ChallengeDataState class
  /// If the instance has not been created yet, it will create the instance
  factory ChallengeDataState() {
    return mainInstance;
  }

  /// This is flag to denote if the challenges have already been loaded from Firebase
  /// It is set to false by default
  /// It is set to true once the challenges have been loaded from Firebase
  /// This ensures that the challenges are only loaded from Firebase once
  bool _challengesLoaded = false;

  /// This is the list that stores all the challenges.
  List<Challenge> challenges = [];
  List<Challenge> challengesShown = [];

  /// This method loads the challenges from Firebase
  Future<void> loadChallengeFromFirebase() async {
    /// If the challenges have already been loaded, return
    if (_challengesLoaded) {
      return;
    }

    /// This is the reference to the challenges collection in Firebase
    final CollectionReference challengesCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('challenges');

    /// This is the reference to the challengesShown collection in Firebase
    final CollectionReference challengesShownCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('challengesShown');

    // Retrieve all the challenges from the Firestore collection
    QuerySnapshot querySnapshot = await challengesCollection.get();

    // Retrieve all the challenges shown from the Firestore collection
    QuerySnapshot queryShownSnapshot = await challengesShownCollection.get();

    // Iterate over each document in the collection
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      challenges.add(Challenge.fromJson(data));
    }

    // Iterate over each document in the collection
    for (var doc in queryShownSnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      challengesShown.add(Challenge.fromJson(data));
    }
    _challengesLoaded = true;
    notifyListeners();
  }

  /// This will add a new challenge to the list of challenges.
  void addChallenge(dynamic newchallenge) {
    challenges.add(newchallenge);
    notifyListeners();
  }

  void addChallengeShown(dynamic newchallenge) {
    challengesShown.add(newchallenge);
    notifyListeners();
  }


  /// This will delete a challenge from the list of challenges.
  Future<void> deleteChallenge(String challengeId) async {
    for (Challenge challenge in challenges) {
      if (challenge.challengeId == challengeId) {
        challenges.remove(challenge);

        /// This is the reference to the goals collection in Firebase
        /// This is used to delete the goal from Firebase
        final CollectionReference challengesCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('challenges');

        await challengesCollection.doc(challengeId).delete();
        notifyListeners();
        break;
      }
    }
  }


  /// This will delete a challenge from the list of challenges Shown.
  Future<void> deleteChallengeShown(String challengeId) async {
    for (Challenge challenge in challengesShown) {
      if (challenge.challengeId == challengeId) {
        challengesShown.remove(challenge);

        /// This is the reference to the goals collection in Firebase
        /// This is used to delete the goal from Firebase
        final CollectionReference challengesShownCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('challengesShown');

        await challengesShownCollection.doc(challengeId).delete();
        notifyListeners();
        break;
      }
    }
  }


  /// This will set the new status of the challenge that is being edited.
  void setStatus(String challengeId, bool newStatus) {
    for (dynamic challenge in challenges) {
      if (challenge.challengeId == challengeId) {
        challenge.setStatus(newStatus);
        notifyListeners();
        break;
      }
    }
  }


  /// This will set the new date completed of the goal that is being edited.
  // void setDateCompleted(String goalId, DateTime newDateCompleted) {
  //   for (Goal goal in _shortTermGoals) {
  //     if (goal.goalId == goalId) {
  //       goal.dateCompleted = newDateCompleted;
  //       notifyListeners();
  //       break;
  //     }
  //   }
  // }

  /// This will return the title of the goal that is being edited.
  String? getTitle(String challengeId) {
    String title = '';
    for (dynamic challenge in challenges) {
      if (challenge.challengeId == challengeId) {
        title = challenge.title;
        break;
      }
    }

    if (title == '') {
      print('** getTitle ** => challenge not found');
    } else {
      return title;
    }
  }

  /// This will return the status of the challenge that is being edited.
  bool? getStatus(String challengeId) {
    bool? status;
    for (dynamic challenge in challenges) {
      if (challenge.challengeId == challengeId) {
        status = challenge.isCompleted;
        break;
      }
    }
    if (status == null) {
      print('** getStatus ** => challenge not found');
    } else {
      print('** getStatus ** => challenge found');
      return status;
    }
  }



  /// This will update the challenge status in Firebase.
  Future<void> updateStatus(String challengeId) async {
    for (dynamic challenge in challenges) {
      if (challenge.challengeId == challengeId) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('challenges')
            .doc(challengeId)
            .update({'isCompleted': challenge.isCompleted});

      }
    }
  }
}
