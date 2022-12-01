import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/shop/user/create_shop_user_model.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';
import 'package:zcart_seller/domain/app/shop/user/i_shop_user_repo.dart';

class ShopUserRepo extends IShopUserRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<ShopUsersModel>>> getShopUser(
      {required String filter}) async {
    return cleanApi.get(
      fromData: ((json) => List<ShopUsersModel>.from(
          json['data'].map((e) => ShopUsersModel.fromMap(e)))),
      endPoint: 'users?filter=$filter',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> createShopUser(
      {required CreateShopUserModel user}) async {
    return cleanApi.post(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'user/create?shop_id=${user.shopId}&role_id=${user.roleId}&name=${user.name}&nice_name=${user.niceName}&email=${user.email}&password=${user.password}&password_confirmation=${user.confirmPassword}&dob=${user.dob}&sex=${user.sex}&description=${user.description}&active=${user.active}',
    );
  }

  @override
  Future<Either<CleanFailure, CreateShopUserModel>> shopUserDetails(
      {required int userId}) async {
    return cleanApi.get(
      fromData: ((json) => CreateShopUserModel.from(
          json['data'].map((e) => CreateShopUserModel.fromMap(e)))),
      endPoint: 'user/$userId',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> trashShopUser(
      {required int userId}) async {
    return cleanApi.delete(
      fromData: (json) => unit,
      body: null,
      endPoint: 'user/$userId/trash',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> updateShopUser(
      {required int userId,
      required int shopId,
      required int roleId,
      required String name,
      required String niceName,
      required String email,
      required int active,
      // required String dob,
      // required String sex,
      required String description}) async {
    return cleanApi.put(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'user/$userId/update?shop_id=$shopId&role_id=$roleId&name=$name&nice_name=$niceName&email=$email&description=$description&active=$active',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteShopUser({required int userId}) {
    return cleanApi.delete(
      fromData: (json) => unit,
      body: null,
      endPoint: 'user/$userId/delete',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> restoreShopUser({required int userId}) {
    return cleanApi.put(
      fromData: (json) => unit,
      body: null,
      endPoint: 'user/$userId/restore',
    );
  }
}
