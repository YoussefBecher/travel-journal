class Country {
  const Country({required this.capital, required this.population});

  final String capital;
  final int population;

  factory Country.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final country =
    (data['objects'] as List).first as Map<String, dynamic>;
    final capitals =
    (country['capitals'] as List).cast<Map<String, dynamic>>();
    final primary = capitals.firstWhere(
          (c) => (c['attributes'] as Map<String, dynamic>?)?['primary'] == true,
      orElse: () => capitals.first,
    );

    return Country(
      capital: primary['name'] as String,
      population: (country['population'] as num).toInt(),
    );
  }
}