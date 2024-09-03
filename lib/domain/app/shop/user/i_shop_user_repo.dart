import 'package:clean_api/clean_api.dart';
import 'package:alpesportif_seller/domain/app/shop/user/create_shop_user_model.dart';
import 'package:alpesportif_seller/domain/app/shop/user/get_shop_users_model.dart';

abstract class IShopUserRepo {
  Future<Either<CleanFailure, List<ShopUsersModel>>> getShopUser(
      {required String filter});

  Future<Either<CleanFailure, Unit>> createShopUser(
      {required CreateShopUserModel user});

  Future<Either<CleanFailure, CreateShopUserModel>> shopUserDetails(
      {required int userId});

  Future<Either<CleanFailure, Unit>> updateShopUser({
    required int userId,
    required int shopId,
    required int roleId,
    required String name,
    required String niceName,
    required String email,
    required int active,
    // required String dob,
    // required String sex,
    required String description,
  });

  Future<Either<CleanFailure, Unit>> trashShopUser({required int userId});
  Future<Either<CleanFailure, Unit>> restoreShopUser({required int userId});
  Future<Either<CleanFailure, Unit>> deleteShopUser({required int userId});
}
