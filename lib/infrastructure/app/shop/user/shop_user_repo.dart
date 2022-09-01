import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/shop/user/create_shop_user_model.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';
import 'package:zcart_seller/domain/app/shop/user/i_shop_user_repo.dart';

class ShopUserRepo extends IShopUserRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<GetShopUsersModel>>> getShopUser() async {
    return cleanApi.get(
      fromData: ((json) => GetShopUsersModel.from(
          json['data'].map((e) => GetShopUsersModel.fromMap(e)))),
      endPoint: 'users',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> createShopUser(
      {required CreateShopUserModel createShopUser}) async {
    return cleanApi.post(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'user/create?shop_id=${createShopUser.shopId}&role_id=${createShopUser.roleId}&name=${createShopUser.name}&nice_name=${createShopUser.niceName}&email=${createShopUser.email}&password=${createShopUser.password}&dob=${createShopUser.dob}&sex=${createShopUser.sex}&description=${createShopUser.description}',
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
      required String password,
      required String dob,
      required String sex,
      required String description}) async {
    return cleanApi.put(
      fromData: (json) => unit,
      body: null,
      endPoint:
          'user/$userId/update?shop_id=$shopId&role_id=$roleId&name=$name&nice_name=$niceName&email=$email&password=$password&dob=$dob&sex=$sex&description=$description',
    );
  }
}
