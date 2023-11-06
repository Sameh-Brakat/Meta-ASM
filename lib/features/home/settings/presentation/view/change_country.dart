import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';

class CountrySearchPage extends StatefulWidget {
  @override
  _CountrySearchPageState createState() => _CountrySearchPageState();
}

class _CountrySearchPageState extends State<CountrySearchPage> {
  List<CountryCode> countries = [];
  List<CountryCode> filteredCountries = [];

  @override
  void initState() {
    super.initState();
    // Define your list of countries manually here.
    countries = [
      CountryCode(
        code: 'US',
        name: 'United States',
      ),
      CountryCode(
        code: 'CA',
        name: 'Canada',
      ),
      // Add more countries as needed.
    ];
    filteredCountries.addAll(countries);
  }

  void _filterCountries(String query) {
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country.name!.toLowerCase().contains(query.toLowerCase()) ||
              country.code!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterCountries,
              decoration: InputDecoration(
                labelText: 'Search Country',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                return ListTile(
                  title: Text(country.name!),
                  subtitle: Text(country.code!),
                  leading: CountryListPick(
                    initialSelection: country.code,
                    onChanged: (CountryCode? code) {
                      print('Selected country: ${code!.name}');
                    },
                    // Use the countryFilter parameter to filter countries by their codes.
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
