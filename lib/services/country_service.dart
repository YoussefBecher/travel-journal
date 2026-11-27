import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountryService {
  static const _apiKey = String.fromEnvironment('RC_API_KEY');

  Future<Country> fetchTunisia() async {
    if (_apiKey.isEmpty) {
      throw Exception('RC_API_KEY missing: la cle n est pas passee au lancement');
    }

    final url = Uri.https(
      'api.restcountries.com',
      '/countries/v5/codes.alpha_2/TN',
      {'response_fields': 'names.common,capitals,population'},
    );
    final res = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_apiKey'},
    ).timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw Exception('Server error ${res.statusCode}');
    }
    return Country.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }
}