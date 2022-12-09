import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/roles/roles_state.dart';
import 'package:zcart_seller/domain/app/shop/roles/create_update_role_model.dart';
import 'package:zcart_seller/domain/app/shop/roles/i_roles_repo.dart';
import 'package:zcart_seller/infrastructure/app/shop/role/roles_repo.dart';

final roleProvider = StateNotifierProvider<RoleNotifier, RolesState>(
    (ref) => RoleNotifier(RoleRepo()));

class RoleNotifier extends StateNotifier<RolesState> {
  final IRolesRepo rolesRepo;
  RoleNotifier(this.rolesRepo) : super(RolesState.init());

  getRoles() async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.getRoles(filter: 'null');
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), roleList: r));
  }

  getTrashRoles() async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.getRoles(filter: 'trash');
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), trashRoleList: r));
  }

  getPermissions() async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.getPermissions();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), permissionList: r));
  }

  getRoleDetails({required int roleId}) async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.getRoleDetails(id: roleId);
    Logger.i(data);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), roleDetails: r));
  }

  createNewRole({required CreateUpdateRoleModel roleModel}) async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.createRole(createRoleModel: roleModel);
    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      getRoles();
      return state.copyWith(loading: false, failure: CleanFailure.none());
    });
  }

  updateRole(
      {required CreateUpdateRoleModel roleModel, required int roleId}) async {
    state = state.copyWith(loading: true);
    final data =
        await rolesRepo.updateRole(roleId: roleId, updateRoleModel: roleModel);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getRoles();
  }

  trashRole({required int roleId}) async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.trashRole(roleId: roleId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getRoles();
    getTrashRoles();
  }

  restoreRole({required int roleId}) async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.restoreRole(roleId: roleId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getRoles();
    getTrashRoles();
  }

  deleteRole({required int roleId}) async {
    state = state.copyWith(loading: true);
    final data = await rolesRepo.deleteRole(roleId: roleId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getRoles();
    getTrashRoles();
  }
}
