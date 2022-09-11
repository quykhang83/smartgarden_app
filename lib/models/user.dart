class User{
  final int id;
  final String username;
  final String displayname;
  final String phone;
  final String avatar;
  final String? updatedAt;

  User({
    required this.id,
    required this.username,
    required this.displayname,
    required this.phone,
    required this.avatar,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json)
      :id=json['id'],
        username=json['username'],
        displayname=json['displayname'],
        phone=json['phone'],
        avatar=json['avatar'],
        updatedAt=json['updatedAt'];
  Map<String, dynamic> toJson() => {
      'id':id,
      'username':username,
      'displayname':displayname,
      'phone':phone,
      'avatar':avatar,
      'updated_at':updatedAt,
    };
}