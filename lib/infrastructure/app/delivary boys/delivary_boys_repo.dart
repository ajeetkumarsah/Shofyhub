import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/delivary%20boy/delivary_boy_model.dart';
import 'package:zcart_seller/domain/app/delivary%20boy/i_delivary_boy_repo.dart';

class DelivaryRepo extends IDelivaryRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<DelivaryBoy>>> getDelivaryBoys() async {
    return cleanApi.get(
        fromData: (json) => List<DelivaryBoy>.from(json
            .map((key, value) =>
                MapEntry(key, DelivaryBoy(id: key, name: value)))
            .values),
        endPoint: 'data/delivery_boys');
  }
}
