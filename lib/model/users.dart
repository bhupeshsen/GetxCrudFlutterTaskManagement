class Users {
  String sk;
  String userId;
  String name;
  String number;
  String email;
  String photo;
  String city;
  bool status;
  String message;

  Users(
      {this.sk,
        this.userId,
        this.name,
        this.number,
        this.email,
        this.photo,
        this.city,
        this.status,
        this.message});

  Users.fromJson(Map<String, dynamic> json) {
    sk = json['sk'];
    userId = json['user_id'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    photo = json['photo'];
    city = json['city'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sk'] = this.sk;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['number'] = this.number;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['city'] = this.city;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
