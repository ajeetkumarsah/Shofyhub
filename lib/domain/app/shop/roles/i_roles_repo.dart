import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/shop/roles/create_update_role_model.dart';
import 'package:zcart_seller/domain/app/shop/roles/permission_list_model.dart';
import 'package:zcart_seller/domain/app/shop/roles/role_details_model.dart';
import 'package:zcart_seller/domain/app/shop/roles/role_model.dart';

abstract class IRolesRepo {
  Future<Either<CleanFailure, List<RoleModel>>> getRoles();
  Future<Either<CleanFailure, List<PermissionListModel>>> getPermissions();
  Future<Either<CleanFailure, RoleDetailsModel>> getRoleDetails(
      {required int id});
  Future<Either<CleanFailure, CreateUpdateRoleModel>> createRole(
      {required CreateUpdateRoleModel createRoleModel});
  Future<Either<CleanFailure, CreateUpdateRoleModel>> updateRole(
      {required int roleId, required CreateUpdateRoleModel updateRoleModel});
  Future<Either<CleanFailure, Unit>> trashRole({required int roleId});
}
