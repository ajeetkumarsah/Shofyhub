import 'package:clean_api/clean_api.dart';
import 'delivary_boy_model.dart';

abstract class IDelivaryBoyRepo {
  Future<Either<CleanFailure, List<DelivaryBoyModel>>> getDelivaryBoys();
}
