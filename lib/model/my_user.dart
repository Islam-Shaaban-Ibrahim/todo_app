class MyUser {
  String id;
  String name;
  String email;
  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
        );

  Map<String, dynamic> toJson(MyUser myUser) {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
