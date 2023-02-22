class User {
  /// User class to set a first name, last name, and user name with each user.

  final String firstName;
  final String lastName;
  final String userName;

  User(
      {required this.firstName,
      required this.lastName,
      required this.userName});

  set firstName(String nameF) {
    firstName = nameF;
  }

  set lastName(String nameL) {
    lastName = nameL;
  }

  set userName(String nameU) {
    userName = nameU;
  }

  String get firstname {
    return firstName;
  }

  String get lastname {
    return lastName;
  }

  String get username {
    return userName;
  }
}

List<User> sampleUsers = [
  User(firstName: 'Cole', lastName: 'Roberts', userName: 'CROB'),
  User(firstName: 'Cullin', lastName: 'Caps', userName: 'CCAP'),
  User(firstName: 'John', lastName: 'Doe', userName: 'JDOE')
];
