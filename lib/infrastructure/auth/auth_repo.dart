import 'package:clean_api/clean_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alpesportif_seller/domain/auth/i_auth_repo.dart';
import 'package:alpesportif_seller/domain/auth/log_in_body.dart';
import 'package:alpesportif_seller/domain/auth/registration_body.dart';
import 'package:alpesportif_seller/domain/auth/user_model.dart';

class AuthRepo extends IAuthRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, UserModel>> logIn(
      {required LogInBody body}) async {
    Logger.i("email = ${body.email}, pass ${body.password}");

    final data = await cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'login',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'login',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'login', error: responseBody.toString()));
          }
        },
        fromData: (json) => UserModel.fromMap(json["data"]),
        body: null,
        endPoint: "auth/login?email=${body.email}&password=${body.password}");
    return data.fold((l) => left(l), (r) async {
      final preferences = await SharedPreferences.getInstance();
      listenForTokenChange();
      preferences.setString('token', r.api_token);
      cleanApi.setToken({'Authorization': 'Bearer ${r.api_token}'});
      return right(r);
    });
  }

  listenForTokenChange() {
    // Stream documentStream = FirebaseFirestore.instance
    //     .collection('setting')
    //     .doc('app-setting')
    //     .snapshots();

    // documentStream.listen((event) {
    //   final data = (event as DocumentSnapshot).data() as Map;
    //   Logger.i("token changed: ${data['token']}");
    //   cleanApi.setToken({'Authorization': "Bearer ${data['token']}"});
    // });
  }

  @override
  Future<Either<CleanFailure, UserModel>> registration(
      {required RegistrationBody body}) async {
    final data = await cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'registration', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'registation',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'registation',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'registration', error: responseBody.toString()));
          }
        },
        fromData: (json) => UserModel.fromMap(json["data"]),
        body: null,
        endPoint:
            "auth/register?email=${body.email}&phone=${body.phone}&shop_name=${body.shopName}&plan=${body.planId}&password=${body.password}&password_confirmation=${body.confirmPassword}&agree=${body.agree}");
    return data.fold((l) => left(l), (r) async {
      final preferences = await SharedPreferences.getInstance();
      listenForTokenChange();
      preferences.setString('token', r.api_token);
      cleanApi.setToken({'Authorization': 'Bearer ${r.api_token}'});
      return right(r);
    });
  }

  @override
  Future<Either<CleanFailure, Unit>> forgetPassword(
      {required String email}) async {
    return cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(
                CleanFailure(tag: 'Forget Password', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Forget Password',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Forget Password',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'Forget Password', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'auth/forgot?email=$email');
  }

  @override
  Future<Either<CleanFailure, Unit>> otpLogin({required String phoneNumber}) {
    return cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'Otp Login', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Otp Login',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Otp Login',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(
                CleanFailure(tag: 'Otp Login', error: responseBody.toString()));
          }
        },
        fromData: (json) => unit,
        body: null,
        endPoint: 'auth/login?phone=$phoneNumber');
  }

  @override
  Future<Either<CleanFailure, UserModel>> otpVerify(
      {required String phoneNumber, required String code}) async {
    final data = await cleanApi.post(
        failureHandler: (int statusCode, Map<String, dynamic> responseBody) {
          if (responseBody['errors'] != null) {
            final errors = Map<String, dynamic>.from(responseBody['errors'])
                .values
                .toList();
            final error = List.from(errors.first);
            return left(CleanFailure(tag: 'Otp Verify', error: error.first));
          } else if (responseBody['message'] != null) {
            return left(CleanFailure(
                tag: 'Otp Verify',
                error: responseBody['message'],
                statusCode: statusCode));
          } else if (responseBody['error'] != null) {
            return left(CleanFailure(
                tag: 'Otp Verify',
                error: responseBody['error'],
                statusCode: statusCode));
          } else {
            return left(CleanFailure(
                tag: 'Otp Verify', error: responseBody.toString()));
          }
        },
        fromData: (json) => UserModel.fromMap(json["data"]),
        body: null,
        endPoint:
            'auth/user/phone/verify?phone_number=$phoneNumber&verification_code=$code');

    return data.fold((l) => left(l), (r) async {
      final preferences = await SharedPreferences.getInstance();
      listenForTokenChange();
      preferences.setString('token', r.api_token);
      cleanApi.setToken({'Authorization': 'Bearer ${r.api_token}'});
      return right(r);
    });
  }
}
