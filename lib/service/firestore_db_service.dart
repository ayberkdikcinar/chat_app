import 'IFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../message_detail/model/message_model.dart';
import '../user_model.dart';

class FirestoreDBService implements IFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _userRefer = FirebaseFirestore.instance.collection('users');

  static FirestoreDBService? _instance;
  static FirestoreDBService get instance {
    _instance ??= FirestoreDBService._init();
    return _instance!;
  }

  FirestoreDBService._init();

  @override
  Future<UserModel> findUser(String userid) async {
    var _doc = await _userRefer.doc(userid).get();
    if (_doc.exists) {
      var _userMap = _doc.data()!;
      return UserModel().fromJson(_userMap);
    } else {
      return UserModel();
    }
  }

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    var _doc = await _userRefer.get();
    var _user = _doc.docs.map((e) => UserModel().fromJson(e.data())).toList();
    if (_user.isNotEmpty) {
      return _user;
    } else {
      print('User list is empty');
      return [];
    }
  }

  @override
  Future<bool> saveMessage(Message mssg) async {
    try {
      await _firestore.collection('conversation').doc('${mssg.from}-${mssg.to}').collection('messages').doc().set(mssg.toJson());
      await _firestore.collection('conversation').doc('${mssg.from}-${mssg.to}').set({'sender': '${mssg.from}', 'receiver': '${mssg.to}'});
      mssg.isOwner = false;
      await _firestore.collection('conversation').doc('${mssg.to}-${mssg.from}').collection('messages').doc().set(mssg.toJson());
      await _firestore.collection('conversation').doc('${mssg.to}-${mssg.from}').set({'sender': '${mssg.to}', 'receiver': '${mssg.from}'});
      return true;
    } catch (e) {
      print('an error has been occurred while saving message' + e.toString());
      return false;
    }
  }

  @override
  Stream<List<Message>> getAllMessagesBetween(String? to, String? from) {
    var _snapshots = _firestore.collection('conversation').doc('${from!}-${to!}').collection('messages').orderBy('date', descending: true).snapshots();
    return _snapshots.map((event) => event.docs.map((e) => Message().fromJson(e.data())).toList());
  }

  Future<Message> getLastMessageBetween(String? to, String? from) async {
    var _snapshots = await _firestore.collection('conversation').doc('${from!}-${to!}').collection('messages').orderBy('date', descending: true).get();
    if (_snapshots.docs.isEmpty) {
      return Message();
    }
    return Message().fromJson(_snapshots.docs.first.data());
  }
}
