import 'package:mobx/mobx.dart';

import '../../message_detail/model/message_model.dart';
import '../../service/firestore_db_service.dart';
import '../../user_model.dart';

part 'home_view_model.g.dart';

enum ViewState { Idle, Busy }

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final FirestoreDBService _firestoreDBService = FirestoreDBService.instance;

  @observable
  ViewState? _state;

  List<UserModel>? _userList;
  Map<String, Message>? _lastMessagesList;
  _HomeViewModelBase() {
    _state = ViewState.Idle;
    _lastMessagesList = {};
    getAllUsers();
    //getLastMessage();
  }

  ViewState? get state => _state;

  @action
  void setState(ViewState value) {
    _state = value;
  }

  Future<void> getAllUsers() async {
    try {
      setState(ViewState.Busy);
      var users = await _firestoreDBService.fetchAllUsers();
      _userList = users;
      _userList?.removeAt(0);
      await getLastMessage();
    } finally {
      setState(ViewState.Idle);
    }
  }

  Future<void> findUser(userId) async {
    await _firestoreDBService.findUser(userId);
  }

  Future<void> getLastMessage() async {
    try {
      setState(ViewState.Busy);
      for (var item in _userList!) {
        var _lastMessage = await _firestoreDBService.getLastMessageBetween('0', item.id);
        _lastMessagesList?[item.id!] = _lastMessage;
      }
    } finally {
      setState(ViewState.Idle);
    }
  }

  Map<String, Message>? get lastMessageList => _lastMessagesList;
  List<UserModel>? get userList => _userList;
}
