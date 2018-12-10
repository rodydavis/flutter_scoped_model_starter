class User {
  final String fullName, email, profileImage;

  User({
    this.fullName,
    this.email,
    this.profileImage,
  });

  @override
  String toString() {
    final String _user = "$fullName";
    return _user.toString();
  }
}

