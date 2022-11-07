import 'package:country_calling_code_picker/country.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/domain/auth/i_country_repo.dart';
import 'package:zcart_seller/infrastructure/auth/country_repo.dart';

final countryCodeProvider = ChangeNotifierProvider(
    (_) => CountryCodeNotifier(countryRepository: CountryRepository()));

class CountryCodeNotifier extends ChangeNotifier {
  final ICountryRepository countryRepository;

  Country _selectedCountry = const Country('Bangladesh', 'BD', 'BD', '+880');

  CountryCodeNotifier({required this.countryRepository});

  String getSelectedCountry() => _selectedCountry.callingCode;

  Future<String> getIPCountry() async {
    try {
      final ipCountry =
          await countryRepository.getUserCountryCodeFromAPILookup();
      return ipCountry;
    } on Exception {
      return 'something_went_wrong'.tr();
    }
  }

  setCountry({required Country country}) {
    _selectedCountry = country;
    notifyListeners();
  }
}
