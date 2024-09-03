import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/support/live_chat/conversation_model.dart';
import 'package:alpesportif_seller/domain/app/support/live_chat/conversession_details_model.dart';
import 'package:alpesportif_seller/domain/app/support/live_chat/i_conversession_repo.dart';

class ConversessionRepo implements IConversessionRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<ConversessionModel>>>
      getAllConversessions() {
    return cleanApi.get(
        fromData: ((json) => List<ConversessionModel>.from(
            json['data'].map((e) => ConversessionModel.fromMap(e)))),
        endPoint: 'conversations');
  }

  @override
  Future<Either<CleanFailure, ConversessionDetailsModel>>
      getConversessionDetails({required int customerId}) {
    return cleanApi.get(
        fromData: ((json) => ConversessionDetailsModel.fromMap(json['data'])),
        endPoint: 'chat/$customerId');
  }

  @override
  Future<Either<CleanFailure, Unit>> replyConversession(
      {required int customerId, required String message}) {
    return cleanApi.post(
      fromData: (josn) => unit,
      body: null,
      endPoint: 'chat/$customerId/reply?message=$message',
    );
  }
}
