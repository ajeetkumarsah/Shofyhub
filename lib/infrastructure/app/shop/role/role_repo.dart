import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/shop/roles/create_update_role_model.dart';
import 'package:zcart_seller/domain/app/shop/roles/i_roles_repo.dart';
import 'package:zcart_seller/domain/app/shop/roles/permission_list_model.dart';
import 'package:zcart_seller/domain/app/shop/roles/role_details_model.dart';
import 'package:zcart_seller/domain/app/shop/roles/role_model.dart';

class RoleRepo extends IRolesRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, List<RoleModel>>> getRoles() {
    return cleanApi.get(
      failureHandler:
          <RoleModel>(int statusCode, Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'roles', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'roles',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'roles',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'roles', error: responseBody.toString()));
        }
      },
      fromData: (json) =>
          List<RoleModel>.from(json.map((e) => RoleModel.fromMap(e))),
      endPoint: 'data/roles',
    );
  }

  @override
  Future<Either<CleanFailure, List<PermissionListModel>>> getPermissions() {
    return cleanApi.get(
      failureHandler: <PermissionListModel>(int statusCode,
          Map<String, dynamic> responseBody) {
        if (responseBody['errors'] != null) {
          final errors =
              Map<String, dynamic>.from(responseBody['errors']).values.toList();
          final error = List.from(errors.first);
          return left(CleanFailure(tag: 'permissions', error: error.first));
        } else if (responseBody['message'] != null) {
          return left(CleanFailure(
              tag: 'permissions',
              error: responseBody['message'],
              statusCode: statusCode));
        } else if (responseBody['error'] != null) {
          return left(CleanFailure(
              tag: 'permissions',
              error: responseBody['error'],
              statusCode: statusCode));
        } else {
          return left(
              CleanFailure(tag: 'permissions', error: responseBody.toString()));
        }
      },
      fromData: (json) => List<PermissionListModel>.from(
          json['data'].map((e) => PermissionListModel.fromMap(e))),
      endPoint: 'permissions',
    );
  }

  @override
  Future<Either<CleanFailure, CreateUpdateRoleModel>> createRole(
      {required CreateUpdateRoleModel createRoleModel}) async {
    return await cleanApi.post(
        failureHandler: <CreateUpdateRoleModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'role details', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'role details',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'role details',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'role details', error: responseBody.toString()));
          }
        },
        fromData: (data) => createRoleModel,
        body: null,
        endPoint:
            'role?description=${createRoleModel.description}&level=${createRoleModel.level}&name=${createRoleModel.name}&${createRoleModel.permissions})');
  }

  @override
  Future<Either<CleanFailure, CreateUpdateRoleModel>> updateRole(
      {required int roleId,
      required CreateUpdateRoleModel updateRoleModel}) async {
    return await cleanApi.post(
        failureHandler: <CreateUpdateRoleModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'role', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'role',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'role',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'role', error: responseBody.toString()));
          }
        },
        fromData: (data) => updateRoleModel,
        body: null,
        endPoint:
            'role/$roleId?description=${updateRoleModel.description}&level=${updateRoleModel.level}&name=${updateRoleModel.name}&${updateRoleModel.permissions})');
  }

  @override
  Future<Either<CleanFailure, Unit>> trashRole({required int roleId}) {
    return cleanApi.delete(
        failureHandler:
            <Unit>(int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'role', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'role',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'role',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'role', error: responseBody.toString()));
          }
        },
        body: null,
        fromData: (json) => unit,
        endPoint: 'role/$roleId/trash');
  }

  @override
  Future<Either<CleanFailure, RoleDetailsModel>> getRoleDetails(
      {required int id}) {
    return cleanApi.get(
        failureHandler: <RoleDetailsModel>(int statusCode,
            Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'role', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'role',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'role',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'role', error: responseBody.toString()));
          }
        },
        fromData: (json) => RoleDetailsModel.fromMap(json['data']),
        endPoint: 'role/$id');
  }
}
