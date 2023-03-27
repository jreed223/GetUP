class User {
  /// User class to set a first name, last name, and user name with each user.

  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String passWord;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.userName,
      required this.passWord});

  set firstName(String nameF) {
    firstName = nameF;
  }

  set lastName(String nameL) {
    lastName = nameL;
  }

  set email(String email) {
    email = email;
  }

  set userName(String nameU) {
    userName = nameU;
  }

  set password(String pass) {
    password = pass;
  }

  String get firstname {
    return firstName;
  }

  String get lastname {
    return lastName;
  }

  String get email_ {
    return email;
  }

  String get username {
    return userName;
  }

  String get password {
    return passWord;
  }
}

List<User> sampleUsers = [
  User(
      firstName: 'Cole',
      lastName: 'Roberts',
      email: 'crob@gmail.com',
      userName: 'CROB',
      passWord: '1234'),
  User(
      firstName: 'Cullin',
      lastName: 'Caps',
      email: 'ccap@gamil.com',
      userName: 'CCAP',
      passWord: '5678'),
  User(
      firstName: 'John',
      lastName: 'Doe',
      email: 'jdoe@yahoo.com',
      userName: 'JDOE',
      passWord: 'password')
];
