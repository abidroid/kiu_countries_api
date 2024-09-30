import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kiu_countries_api/models/country.dart';
import 'package:http/http.dart' as http;

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  Future<List<Country>> getAllCountries() async {
    String url = 'https://countriesnow.space/api/v0.1/countries/flag/images';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Country> countries = [];

      var jsonResponse = json.decode(response.body);
      var jsonCountryList = jsonResponse['data'];

      for (var jsonCountry in jsonCountryList) {
        Country country = Country.fromJson(jsonCountry);
        countries.add(country);
      }

      return countries;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Country List'),
        ),
        body: FutureBuilder<List<Country>>(
            future: getAllCountries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Country> countries = snapshot.data!;

                return Center(
                  child: Text('${countries.length}'),
                );
              } else {
                return const Center(
                  child: SpinKitDualRing(
                    color: Colors.amber,
                  ),
                );
              }
            }));
  }
}
