import '../model/message_model.dart';
import '../../service/firestore_db_service.dart';
import 'package:mobx/mobx.dart';
part 'message_viewmodel.g.dart';

class MessageViewModel = _MessageViewModelBase with _$MessageViewModel;

abstract class _MessageViewModelBase with Store {
  final _dbService = FirestoreDBService.instance;

  String _userMessage = '';

  void setUserMessage(val) {
    _userMessage = val;
  }

  String get userMessage => _userMessage;

  Stream<List<Message>> getAllMessagesBetween(to, from) {
    return _dbService.getAllMessagesBetween(to, from);
  }

  Future<bool> saveMessage(Message message) async {
    return await _dbService.saveMessage(message);
  }
}
