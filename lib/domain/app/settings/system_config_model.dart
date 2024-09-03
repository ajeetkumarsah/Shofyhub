import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/settings/currency_model.dart';

class SystemConfigModel extends Equatable {
  final bool maintenanceMode;
  final String installVerion;
  final String installVersion;
  final String compatibleAppVersion;
  final String name;
  final dynamic slogan;
  final String legalName;
  final String platformLogo;
  final String email;
  final bool worldwideBusinessArea;
  final int timezoneId;
  final int currencyId;
  final String defaultLanguage;
  final bool askCustomerForEmailSubscription;
  final int canCancelOrderWithin;
  final String supportPhone;
  final dynamic supportPhoneTollFree;
  final String supportEmail;
  final String facebookLink;
  final String googlePlusLink;
  final String twitterLink;
  final String pinterestLink;
  final String instagramLink;
  final String youtubeLink;
  final String lengthUnit;
  final String weightUnit;
  final String valumeUnit;
  final String decimals;
  final bool showCurrencySymbol;
  final bool showSpaceAfterSymbol;
  final int maxImgSizeLimitKb;
  final bool showItemConditions;
  final int addressDefaultCountry;
  final int addressDefaultState;
  final bool showAddressTitle;
  final bool addressShowCountry;
  final bool addressShowMap;
  final bool allowGuestCheckout;
  final bool enableChat;
  final bool vendorGetPaid;
  final CurrencyModel currency;

  const SystemConfigModel({
    required this.maintenanceMode,
    required this.installVerion,
    required this.installVersion,
    required this.compatibleAppVersion,
    required this.name,
    required this.slogan,
    required this.legalName,
    required this.platformLogo,
    required this.email,
    required this.worldwideBusinessArea,
    required this.timezoneId,
    required this.currencyId,
    required this.defaultLanguage,
    required this.askCustomerForEmailSubscription,
    required this.canCancelOrderWithin,
    required this.supportPhone,
    required this.supportPhoneTollFree,
    required this.supportEmail,
    required this.facebookLink,
    required this.googlePlusLink,
    required this.twitterLink,
    required this.pinterestLink,
    required this.instagramLink,
    required this.youtubeLink,
    required this.lengthUnit,
    required this.weightUnit,
    required this.valumeUnit,
    required this.decimals,
    required this.showCurrencySymbol,
    required this.showSpaceAfterSymbol,
    required this.maxImgSizeLimitKb,
    required this.showItemConditions,
    required this.addressDefaultCountry,
    required this.addressDefaultState,
    required this.showAddressTitle,
    required this.addressShowCountry,
    required this.addressShowMap,
    required this.allowGuestCheckout,
    required this.enableChat,
    required this.vendorGetPaid,
    required this.currency,
  });

  SystemConfigModel copyWith({
    bool? maintenanceMode,
    String? installVerion,
    String? installVersion,
    String? compatibleAppVersion,
    String? name,
    dynamic slogan,
    String? legalName,
    String? platformLogo,
    String? email,
    bool? worldwideBusinessArea,
    int? timezoneId,
    int? currencyId,
    String? defaultLanguage,
    bool? askCustomerForEmailSubscription,
    int? canCancelOrderWithin,
    String? supportPhone,
    dynamic supportPhoneTollFree,
    String? supportEmail,
    String? facebookLink,
    String? googlePlusLink,
    String? twitterLink,
    String? pinterestLink,
    String? instagramLink,
    String? youtubeLink,
    String? lengthUnit,
    String? weightUnit,
    String? valumeUnit,
    String? decimals,
    bool? showCurrencySymbol,
    bool? showSpaceAfterSymbol,
    int? maxImgSizeLimitKb,
    bool? showItemConditions,
    int? addressDefaultCountry,
    int? addressDefaultState,
    bool? showAddressTitle,
    bool? addressShowCountry,
    bool? addressShowMap,
    bool? allowGuestCheckout,
    bool? enableChat,
    bool? vendorGetPaid,
    CurrencyModel? currency,
  }) {
    return SystemConfigModel(
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      installVerion: installVerion ?? this.installVerion,
      installVersion: installVersion ?? this.installVersion,
      compatibleAppVersion: compatibleAppVersion ?? this.compatibleAppVersion,
      name: name ?? this.name,
      slogan: slogan ?? this.slogan,
      legalName: legalName ?? this.legalName,
      platformLogo: platformLogo ?? this.platformLogo,
      email: email ?? this.email,
      worldwideBusinessArea:
          worldwideBusinessArea ?? this.worldwideBusinessArea,
      timezoneId: timezoneId ?? this.timezoneId,
      currencyId: currencyId ?? this.currencyId,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      askCustomerForEmailSubscription: askCustomerForEmailSubscription ??
          this.askCustomerForEmailSubscription,
      canCancelOrderWithin: canCancelOrderWithin ?? this.canCancelOrderWithin,
      supportPhone: supportPhone ?? this.supportPhone,
      supportPhoneTollFree: supportPhoneTollFree ?? this.supportPhoneTollFree,
      supportEmail: supportEmail ?? this.supportEmail,
      facebookLink: facebookLink ?? this.facebookLink,
      googlePlusLink: googlePlusLink ?? this.googlePlusLink,
      twitterLink: twitterLink ?? this.twitterLink,
      pinterestLink: pinterestLink ?? this.pinterestLink,
      instagramLink: instagramLink ?? this.instagramLink,
      youtubeLink: youtubeLink ?? this.youtubeLink,
      lengthUnit: lengthUnit ?? this.lengthUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      valumeUnit: valumeUnit ?? this.valumeUnit,
      decimals: decimals ?? this.decimals,
      showCurrencySymbol: showCurrencySymbol ?? this.showCurrencySymbol,
      showSpaceAfterSymbol: showSpaceAfterSymbol ?? this.showSpaceAfterSymbol,
      maxImgSizeLimitKb: maxImgSizeLimitKb ?? this.maxImgSizeLimitKb,
      showItemConditions: showItemConditions ?? this.showItemConditions,
      addressDefaultCountry:
          addressDefaultCountry ?? this.addressDefaultCountry,
      addressDefaultState: addressDefaultState ?? this.addressDefaultState,
      showAddressTitle: showAddressTitle ?? this.showAddressTitle,
      addressShowCountry: addressShowCountry ?? this.addressShowCountry,
      addressShowMap: addressShowMap ?? this.addressShowMap,
      allowGuestCheckout: allowGuestCheckout ?? this.allowGuestCheckout,
      enableChat: enableChat ?? this.enableChat,
      vendorGetPaid: vendorGetPaid ?? this.vendorGetPaid,
      currency: currency ?? this.currency,
    );
  }

  factory SystemConfigModel.fromMap(Map<String, dynamic> map) =>
      SystemConfigModel(
        maintenanceMode: map["maintenance_mode"] ?? false,
        installVerion: map["install_verion"] ?? '',
        installVersion: map["install_version"] ?? '',
        compatibleAppVersion: map["compatible_app_version"] ?? '',
        name: map["name"] ?? '',
        slogan: map["slogan"] ?? '',
        legalName: map["legal_name"] ?? '',
        platformLogo: map["platform_logo"] ?? '',
        email: map["email"] ?? '',
        worldwideBusinessArea: map["worldwide_business_area"] ?? false,
        timezoneId: map["timezone_id"] ?? 0,
        currencyId: map["currency_id"] ?? 0,
        defaultLanguage: map["default_language"] ?? '',
        askCustomerForEmailSubscription:
            map["ask_customer_for_email_subscription"] ?? false,
        canCancelOrderWithin: map["can_cancel_order_within"] ?? 0,
        supportPhone: map["support_phone"] ?? '',
        supportPhoneTollFree: map["support_phone_toll_free"] ?? false,
        supportEmail: map["support_email"] ?? '',
        facebookLink: map["facebook_link"] ?? '',
        googlePlusLink: map["google_plus_link"] ?? '',
        twitterLink: map["twitter_link"] ?? '',
        pinterestLink: map["pinterest_link"] ?? '',
        instagramLink: map["instagram_link"] ?? '',
        youtubeLink: map["youtube_link"] ?? '',
        lengthUnit: map["length_unit"] ?? '',
        weightUnit: map["weight_unit"] ?? '',
        valumeUnit: map["valume_unit"] ?? '',
        decimals: map["decimals"] ?? '',
        showCurrencySymbol: map["show_currency_symbol"] ?? false,
        showSpaceAfterSymbol: map["show_space_after_symbol"] ?? false,
        maxImgSizeLimitKb: map["max_img_size_limit_kb"] ?? 0,
        showItemConditions: map["show_item_conditions"] ?? false,
        addressDefaultCountry: map["address_default_country"] ?? 0,
        addressDefaultState: map["address_default_state"] ?? 0,
        showAddressTitle: map["show_address_title"] ?? false,
        addressShowCountry: map["address_show_country"] ?? false,
        addressShowMap: map["address_show_map"] ?? false,
        allowGuestCheckout: map["allow_guest_checkout"] ?? false,
        enableChat: map["enable_chat"] ?? false,
        vendorGetPaid: map["vendor_get_paid"] ?? false,
        currency: map["currency"] != null
            ? CurrencyModel.fromMap(map["currency"])
            : CurrencyModel.init(),
      );

  Map<String, dynamic> toJson() => {
        "maintenance_mode": maintenanceMode,
        "install_verion": installVerion,
        "install_version": installVersion,
        "compatible_app_version": compatibleAppVersion,
        "name": name,
        "slogan": slogan,
        "legal_name": legalName,
        "platform_logo": platformLogo,
        "email": email,
        "worldwide_business_area": worldwideBusinessArea,
        "timezone_id": timezoneId,
        "currency_id": currencyId,
        "default_language": defaultLanguage,
        "ask_customer_for_email_subscription": askCustomerForEmailSubscription,
        "can_cancel_order_within": canCancelOrderWithin,
        "support_phone": supportPhone,
        "support_phone_toll_free": supportPhoneTollFree,
        "support_email": supportEmail,
        "facebook_link": facebookLink,
        "google_plus_link": googlePlusLink,
        "twitter_link": twitterLink,
        "pinterest_link": pinterestLink,
        "instagram_link": instagramLink,
        "youtube_link": youtubeLink,
        "length_unit": lengthUnit,
        "weight_unit": weightUnit,
        "valume_unit": valumeUnit,
        "decimals": decimals,
        "show_currency_symbol": showCurrencySymbol,
        "show_space_after_symbol": showSpaceAfterSymbol,
        "max_img_size_limit_kb": maxImgSizeLimitKb,
        "show_item_conditions": showItemConditions,
        "address_default_country": addressDefaultCountry,
        "address_default_state": addressDefaultState,
        "show_address_title": showAddressTitle,
        "address_show_country": addressShowCountry,
        "address_show_map": addressShowMap,
        "allow_guest_checkout": allowGuestCheckout,
        "enable_chat": enableChat,
        "vendor_get_paid": vendorGetPaid,
        "currency": currency.toJson(),
      };

  factory SystemConfigModel.init() => SystemConfigModel(
        maintenanceMode: false,
        installVerion: '',
        installVersion: '',
        compatibleAppVersion: '',
        name: '',
        slogan: '',
        legalName: '',
        platformLogo: '',
        email: '',
        worldwideBusinessArea: false,
        timezoneId: 0,
        currencyId: 0,
        defaultLanguage: '',
        askCustomerForEmailSubscription: false,
        canCancelOrderWithin: 0,
        supportPhone: '',
        supportPhoneTollFree: '',
        supportEmail: '',
        facebookLink: '',
        googlePlusLink: '',
        twitterLink: '',
        pinterestLink: '',
        instagramLink: '',
        youtubeLink: '',
        lengthUnit: '',
        weightUnit: '',
        valumeUnit: '',
        decimals: '',
        showCurrencySymbol: false,
        showSpaceAfterSymbol: false,
        maxImgSizeLimitKb: 0,
        showItemConditions: false,
        addressDefaultCountry: 0,
        addressDefaultState: 0,
        showAddressTitle: false,
        addressShowCountry: false,
        addressShowMap: false,
        allowGuestCheckout: false,
        enableChat: false,
        vendorGetPaid: false,
        currency: CurrencyModel.init(),
      );

  @override
  List<Object?> get props => [
        maintenanceMode,
        installVerion,
        installVersion,
        compatibleAppVersion,
        name,
        slogan,
        legalName,
        platformLogo,
        email,
        worldwideBusinessArea,
        timezoneId,
        currencyId,
        defaultLanguage,
        askCustomerForEmailSubscription,
        canCancelOrderWithin,
        supportPhone,
        supportPhoneTollFree,
        supportEmail,
        facebookLink,
        googlePlusLink,
        twitterLink,
        pinterestLink,
        instagramLink,
        youtubeLink,
        lengthUnit,
        weightUnit,
        valumeUnit,
        decimals,
        showCurrencySymbol,
        showSpaceAfterSymbol,
        maxImgSizeLimitKb,
        showItemConditions,
        addressDefaultCountry,
        addressDefaultState,
        showAddressTitle,
        addressShowCountry,
        addressShowMap,
        allowGuestCheckout,
        enableChat,
        vendorGetPaid,
        currency
      ];
}
