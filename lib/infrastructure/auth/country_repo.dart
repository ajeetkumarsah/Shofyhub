import 'dart:convert';
import 'package:http/http.dart';
import 'package:zcart_seller/domain/auth/i_country_repo.dart';

class CountryRepository implements ICountryRepository {
  @override
  Future<String> getUserCountryCodeFromAPILookup() async {
    var result = await get(Uri.parse('https://www.iplocate.io/api/lookup'));
    var decodedJson = jsonDecode(result.body);
    return decodedJson["country_code"];
  }
}
