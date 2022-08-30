import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zcart_seller/domain/auth/i_auth_repo.dart';
import 'package:zcart_seller/domain/auth/log_in_body.dart';
import 'package:zcart_seller/domain/auth/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends IAuthRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, UserModel>> logIn(
      {required LogInBody body}) async {
    Logger.i("email = ${body.email}, pass ${body.password}");
    final data = await cleanApi.post(
        fromData: (json) => UserModel.fromMap(json["data"]),
        body: null,
        endPoint: "auth/login?email=${body.email}&password=${body.password}");
    return data.fold((l) => left(l), (r) async {
      await FirebaseFirestore.instance
          .collection('setting')
          .doc('app-setting')
          .set({'token': r.api_token});
      final preferences = await SharedPreferences.getInstance();
      listenForTokenChange();
      preferences.setString('token', r.api_token);
      cleanApi.setToken({'Authorization': 'Bearer ${r.api_token}'});
      return right(r);
    });
  }

  listenForTokenChange() {
    Stream documentStream = FirebaseFirestore.instance
        .collection('setting')
        .doc('app-setting')
        .snapshots();

    documentStream.listen((event) {
      final data = (event as DocumentSnapshot).data() as Map;
      Logger.i("token changed: ${data['token']}");
      cleanApi.setToken({'Authorization': "Bearer ${data['token']}"});
    });
  }
}
