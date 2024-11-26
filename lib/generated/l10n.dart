// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login Later`
  String get login_later {
    return Intl.message(
      'Login Later',
      name: 'login_later',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `please enter email`
  String get please_enter_email {
    return Intl.message(
      'please enter email',
      name: 'please_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `please enter password`
  String get please_enter_password {
    return Intl.message(
      'please enter password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `please enter confirm password`
  String get please_enter_confirm_password {
    return Intl.message(
      'please enter confirm password',
      name: 'please_enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `confirm password does not match`
  String get confirm_password_does_not_match {
    return Intl.message(
      'confirm password does not match',
      name: 'confirm_password_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `please enter phone`
  String get please_enter_phone {
    return Intl.message(
      'please enter phone',
      name: 'please_enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up account`
  String get sign_up {
    return Intl.message(
      'Sign up account',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `please enter first name`
  String get please_enter_first_name {
    return Intl.message(
      'please enter first name',
      name: 'please_enter_first_name',
      desc: '',
      args: [],
    );
  }

  /// `please enter last name`
  String get please_enter_last_name {
    return Intl.message(
      'please enter last name',
      name: 'please_enter_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Contact request already sent`
  String get contact_request_already_sent {
    return Intl.message(
      'Contact request already sent',
      name: 'contact_request_already_sent',
      desc: '',
      args: [],
    );
  }

  /// `All Offers`
  String get all_offers {
    return Intl.message(
      'All Offers',
      name: 'all_offers',
      desc: '',
      args: [],
    );
  }

  /// `Special Offers`
  String get special_offers {
    return Intl.message(
      'Special Offers',
      name: 'special_offers',
      desc: '',
      args: [],
    );
  }

  /// `Request Contact`
  String get request_contact {
    return Intl.message(
      'Request Contact',
      name: 'request_contact',
      desc: '',
      args: [],
    );
  }

  /// `Add Property`
  String get add_property {
    return Intl.message(
      'Add Property',
      name: 'add_property',
      desc: '',
      args: [],
    );
  }

  /// `Add Main Photo`
  String get add_main_photo {
    return Intl.message(
      'Add Main Photo',
      name: 'add_main_photo',
      desc: '',
      args: [],
    );
  }

  /// `Add Property Photos`
  String get add_property_photos {
    return Intl.message(
      'Add Property Photos',
      name: 'add_property_photos',
      desc: '',
      args: [],
    );
  }

  /// `Ad Name`
  String get ad_name {
    return Intl.message(
      'Ad Name',
      name: 'ad_name',
      desc: '',
      args: [],
    );
  }

  /// `please enter ad name`
  String get please_enter_ad_name {
    return Intl.message(
      'please enter ad name',
      name: 'please_enter_ad_name',
      desc: '',
      args: [],
    );
  }

  /// `Ad Description`
  String get ad_description {
    return Intl.message(
      'Ad Description',
      name: 'ad_description',
      desc: '',
      args: [],
    );
  }

  /// `please enter ad description`
  String get please_enter_ad_description {
    return Intl.message(
      'please enter ad description',
      name: 'please_enter_ad_description',
      desc: '',
      args: [],
    );
  }

  /// `Ad Price`
  String get ad_price {
    return Intl.message(
      'Ad Price',
      name: 'ad_price',
      desc: '',
      args: [],
    );
  }

  /// `please enter ad price`
  String get please_enter_ad_price {
    return Intl.message(
      'please enter ad price',
      name: 'please_enter_ad_price',
      desc: '',
      args: [],
    );
  }

  /// `Ad type`
  String get ad_type {
    return Intl.message(
      'Ad type',
      name: 'ad_type',
      desc: '',
      args: [],
    );
  }

  /// `please enter ad type`
  String get please_enter_ad_type {
    return Intl.message(
      'please enter ad type',
      name: 'please_enter_ad_type',
      desc: '',
      args: [],
    );
  }

  /// `Ad Phone`
  String get ad_phone {
    return Intl.message(
      'Ad Phone',
      name: 'ad_phone',
      desc: '',
      args: [],
    );
  }

  /// `please enter ad phone`
  String get please_enter_ad_phone {
    return Intl.message(
      'please enter ad phone',
      name: 'please_enter_ad_phone',
      desc: '',
      args: [],
    );
  }

  /// `Ad Region`
  String get ad_region {
    return Intl.message(
      'Ad Region',
      name: 'ad_region',
      desc: '',
      args: [],
    );
  }

  /// `please enter ad region`
  String get please_enter_ad_region {
    return Intl.message(
      'please enter ad region',
      name: 'please_enter_ad_region',
      desc: '',
      args: [],
    );
  }

  /// `Ad Address`
  String get ad_address {
    return Intl.message(
      'Ad Address',
      name: 'ad_address',
      desc: '',
      args: [],
    );
  }

  /// `please enter ad address`
  String get please_enter_ad_address {
    return Intl.message(
      'please enter ad address',
      name: 'please_enter_ad_address',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `you have to add property_photos`
  String get you_have_to_add_property_photos {
    return Intl.message(
      'you have to add property_photos',
      name: 'you_have_to_add_property_photos',
      desc: '',
      args: [],
    );
  }

  /// `No more`
  String get no_more {
    return Intl.message(
      'No more',
      name: 'no_more',
      desc: '',
      args: [],
    );
  }

  /// `You are not logged in`
  String get you_are_not_logged_in {
    return Intl.message(
      'You are not logged in',
      name: 'you_are_not_logged_in',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Photo Gallery`
  String get photo_gallery {
    return Intl.message(
      'Photo Gallery',
      name: 'photo_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Extra Services`
  String get extra_services {
    return Intl.message(
      'Extra Services',
      name: 'extra_services',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
