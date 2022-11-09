import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/support/live_chat/conversation_model.dart';
import 'package:zcart_seller/domain/app/support/live_chat/i_conversession_repo.dart';

class ConversessionRepo implements IConversessionRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<ConversessionModel>>>
      getAllConversessions() {
    return cleanApi.get(
        fromData: ((json) => List<ConversessionModel>.from(
            json['data'].map((e) => ConversessionModel.fromJson(e)))),
        endPoint: 'conversations');
  }

  @override
  Future<Either<CleanFailure, ConversessionModel>> getConversessionDetails(
      {required int customerId}) {
    return cleanApi.get(
        fromData: ((json) => ConversessionModel.fromJson(json['data'])),
        endPoint: 'chat/$customerId');
  }

  @override
  Future<Either<CleanFailure, Unit>> replyConversession(
      {required int customerId, required String message}) {
    return cleanApi.put(
      fromData: (josn) => unit,
      body: null,
      endPoint: 'chat/$customerId/reply?message=$message',
    );
  }
}
