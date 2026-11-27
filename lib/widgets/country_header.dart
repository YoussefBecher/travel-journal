import 'package:flutter/material.dart';

import '../models/country.dart';
import '../services/country_service.dart';

class CountryHeader extends StatefulWidget {
  const CountryHeader({super.key});

  @override
  State<CountryHeader> createState() => _CountryHeaderState();
}

class _CountryHeaderState extends State<CountryHeader> {
  late Future<Country> _country;

  @override
  void initState() {
    super.initState();
    _country = CountryService().fetchTunisia();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Country>(
      future: _country,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LinearProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Could not load country info\n${snapshot.error}');
        }
        final c = snapshot.data!;
        return Text(
          'Tunisia · Capital: ${c.capital} · Population: ${c.population}',
        );
      },
    );
  }
}