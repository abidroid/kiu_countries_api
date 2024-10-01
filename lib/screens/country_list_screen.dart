import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiu_countries_api/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:kiu_countries_api/screens/country_detail_screen.dart';

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

      // convert map to country object
      // and save in countries list
      for (var jsonCountry in jsonCountryList)
      {
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
          backgroundColor: Colors.green,
          title: const Text('Country List', style: TextStyle(color: Colors.white),),
        ),
        body: FutureBuilder<List<Country>>(
            future: getAllCountries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Country> countries = snapshot.data!;

                return ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (BuildContext context, int index){

                      Country country = countries[index];

                      return GestureDetector(
                        onTap: (){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return CountryDetailScreen(country: country);
                          }));

                        },
                        child: Card(
                          color: Colors.amber[100],

                          child: Padding(
                            padding: const EdgeInsets.all( 16.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 100,
                                    height: 80,
                                    child: Hero(
                                        tag: country.name!,
                                        child: SvgPicture.network(country.flag!))),

                                const SizedBox(width: 16,),
                                Text(country.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              ],
                            ),
                          ),
                        ),
                      );

                    });
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
