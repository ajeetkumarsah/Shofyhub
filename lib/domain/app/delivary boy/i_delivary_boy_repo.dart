import 'package:clean_api/clean_api.dart';
import 'delivary_boy_model.dart';

abstract class IDelivaryRepo {
  Future<Either<CleanFailure, List<DelivaryBoy>>> getDelivaryBoys();
}
