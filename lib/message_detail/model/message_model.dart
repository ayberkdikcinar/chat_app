import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/base/base_model.dart';

class Message extends BaseModel {
  String? id;
  String? to;
  String? from; //user
  String? body;
  Timestamp? date;
  bool? isOwner;
  Message({
    this.id,
    this.to,
    this.from,
    this.body,
    this.isOwner,
    this.date,
  });

  @override
  Message fromJson(Map<String, dynamic> json) {
    id = json['id'];
    to = json['to'];
    from = json['from'];
    body = json['body'];
    date = json['date'] ?? DateTime.now();
    isOwner = json['isOwner'] ?? true;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['to'] = to;
    data['from'] = from;
    data['body'] = body;
    data['date'] = date ?? DateTime.now();
    data['isOwner'] = isOwner ?? true;
    return data;
  }
}
