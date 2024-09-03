import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/infrastructure/app/plugin/plugin_repo.dart';

final checkAppleLoginPluginProvider = FutureProvider<bool>((ref) async {
  final res = await PluginRepo().checkPlugin(slug: "apple-login");
  return res;
});

//Google Login Plugin Check
final checkGoogleLoginPluginProvider = FutureProvider<bool>((ref) async {
  final res = await PluginRepo().checkPlugin(slug: "google-login");
  return res;
});

//Facebook Login Plugin Check
final checkFacebookLoginPluginProvider = FutureProvider<bool>((ref) async {
  final res = await PluginRepo().checkPlugin(slug: "facebook-login");
  return res;
});

final checkPharmacyPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "pharmacy");
  return result;
});

final checkWalletPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "wallet");
  return result;
});

final checkOneCheckoutPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "checkout");
  return result;
});

//Check Guest Checkout Plugin
final checkGuestCheckoutPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "guestCheckout");
  return result;
});

//Check wishlist Plugin
final checkWishlistPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "wishlist");
  return result;
});

//Coupon Plugin Check
final checkCouponPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "coupons");
  return result;
});

//live chat plugin check
final checkLiveChatPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "livechat");
  return result;
});

//Otp login plugin check
final checkOtpLoginPluginProvider = FutureProvider<bool>((ref) async {
  final result = await PluginRepo().checkPlugin(slug: "otp-login");
  return result;
});
