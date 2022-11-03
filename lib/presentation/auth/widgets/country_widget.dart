import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/auth/country_code_provider.dart';

class CountryWidget extends ConsumerWidget {
  const CountryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final country = await showCountryPickerSheet(
          context,
        );
        if (country != null) {
          ref.read(countryCodeProvider).setCountry(country: country);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          ref.read(countryCodeProvider).getSelectedCountry(),
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
