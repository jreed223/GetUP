import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getup_csc450/models/goals.dart';
import 'package:intl/intl.dart';

/// This class is used to control the Firestore database.
/// It is a singleton class, so only one instance of it can be created.

class FirestoreController {
  /// This is the only instance of the class.
  /// It is created when the class is first called.
  static final FirestoreController _mainInstance =
      FirestoreController._mainInstanceCreator();

  /// This is the Firestore database instance.
  /// It is used to access the database.
  static final _db = FirebaseFirestore.instance;

  /// This is the constructor for the class.
  /// It is private, so it can only be called from within the class.
  FirestoreController._mainInstanceCreator();

  /// This is the factory constructor for the class.
  /// It is used to return the "main instance" of the class.
  factory FirestoreController() {
    return _mainInstance;
  }

  /// This method saves the user's email, username, and fullname to the database.
  static Future<void> saveUserInfo(
      String email, String username, String fullname, String id) async {
    /// This is the user's account document in the database.
    final userAccount = _db.collection('Users').doc(id);

    /// Saving the users information to the database.
    await userAccount.set({
      'email': email,
      'username': username,
      'fullname': fullname,
    });
  }

  /// Adding a goal to the user's goals subcollection.
  static Future<void> pushGoal(Goal goal, bool isLongTerm, String id) async {
    final userCollection = _db.collection('Users').doc(id);

    final goals = userCollection.collection('goals').doc(goal.goalId);

    await goals.set(goal.toJson());
  }

  /// Used to get the user's goals by date created from the database.
  Stream<List<QueryDocumentSnapshot>> getGoalsByDate(
      String id, DateTime selectedDate) {
    /// Formatting the date to match the format in the database.
    DateFormat formatter = DateFormat.yMMMMd('en_US');
    String formattedTimestamp = formatter.format(selectedDate);

    CollectionReference goalsRef =
        _db.collection('Users').doc(id).collection('goals');

    // Create a query that filters goals by their createdAt field
    Query query = goalsRef.where('dateCreated', isEqualTo: formattedTimestamp);

    // Return a stream of the query snapshots
    return query.snapshots().map((querySnapshot) => querySnapshot.docs);
  }
}
