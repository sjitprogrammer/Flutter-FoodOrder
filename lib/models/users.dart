class Users {
  final bool status;
  final String msg;
  final int id;
  final String username;
  final String type;

  Users({this.status, this.msg,this.id,this.type,this.username});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      status: json['status'],
      msg: json['msg'],
      id: json['id'],
      username: json['username'],
      type: json['type'],
    );
  }
}