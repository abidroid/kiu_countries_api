
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiu_countries_api/models/country.dart';

class CountryDetailScreen extends StatelessWidget {

  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('${country.name!}'),
      ),
      
      body: SizedBox(
        width: double.infinity,
        height: 300,
        child: Hero(
            tag: country.name!,
            child: SvgPicture.network(country.flag!, fit: BoxFit.cover,)),
      ),
    );
  }
}
