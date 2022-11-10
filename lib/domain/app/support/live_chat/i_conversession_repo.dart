import 'package:clean_api/clean_api.dart';
import 'package:clean_api/models/clean_failure.dart';
import 'package:zcart_seller/domain/app/support/live_chat/conversation_model.dart';
import 'package:zcart_seller/domain/app/support/live_chat/conversession_details_model.dart';

abstract class IConversessionRepo {
  Future<Either<CleanFailure, List<ConversessionModel>>> getAllConversessions();
  Future<Either<CleanFailure, ConversessionDetailsModel>>
      getConversessionDetails({required int customerId});
  Future<Either<CleanFailure, Unit>> replyConversession(
      {required int customerId, required String message});
}
