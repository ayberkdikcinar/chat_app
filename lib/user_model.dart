import 'core/base/base_model.dart';

class UserModel extends BaseModel {
  String? id;
  String? username;
  String? name;
  String? photo;
  String? email;

  UserModel({
    this.id,
    this.username,
    this.name,
    this.photo,
    this.email,
  });

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    photo = json['photo'] ?? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg';
    username = json['username'] ?? '';
    email = json['email'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name ?? '';
    data['photo'] = photo ?? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg';
    data['username'] = username ?? '';
    data['email'] = email;
    return data;
  }
}
