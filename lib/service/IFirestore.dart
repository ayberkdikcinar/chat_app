import '../message_detail/model/message_model.dart';
import '../user_model.dart';

abstract class IFirestore {
  Future<bool> saveMessage(Message message);
  Stream<List<Message>> getAllMessagesBetween(String? to, String? from);
  Future<List<UserModel>> fetchAllUsers();
  Future<UserModel> findUser(String userId);
}
