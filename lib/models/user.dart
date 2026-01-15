class UserId {
  final String value;
  UserId(this.value);

  @override
  bool operator ==(Object other) => other is UserId && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class User {
  UserId uid;
  String displayName;
  String email;

  User({required this.uid, required this.displayName, required this.email});
}
