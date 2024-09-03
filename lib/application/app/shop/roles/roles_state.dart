import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/shop/roles/permission_list_model.dart';
import 'package:alpesportif_seller/domain/app/shop/roles/role_details_model.dart';
import 'package:alpesportif_seller/domain/app/shop/roles/role_model.dart';

class RolesState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<RoleModel> roleList;
  final List<RoleModel> trashRoleList;
  final List<PermissionListModel> permissionList;
  final RoleDetailsModel roleDetails;
  const RolesState({
    required this.loading,
    required this.failure,
    required this.roleList,
    required this.trashRoleList,
    required this.permissionList,
    required this.roleDetails,
  });

  RolesState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<RoleModel>? roleList,
    List<RoleModel>? trashRoleList,
    List<PermissionListModel>? permissionList,
    RoleDetailsModel? roleDetails,
  }) {
    return RolesState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      roleList: roleList ?? this.roleList,
      trashRoleList: trashRoleList ?? this.trashRoleList,
      permissionList: permissionList ?? this.permissionList,
      roleDetails: roleDetails ?? this.roleDetails,
    );
  }

  @override
  String toString() {
    return 'RolesState(loading: $loading, failure: $failure, roleList: $roleList,trashRoleList: $trashRoleList, permissionList: $permissionList, roleDetails: $roleDetails)';
  }

  @override
  List<Object> get props => [
        loading,
        failure,
        roleList,
        permissionList,
        roleDetails,
        trashRoleList,
      ];

  factory RolesState.init() => RolesState(
        loading: false,
        failure: CleanFailure.none(),
        roleList: const [],
        trashRoleList: const [],
        permissionList: const [],
        roleDetails: RoleDetailsModel.init(),
      );
}
