import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryDetailsPage extends StatefulWidget {
  final String countryName;

  CountryDetailsPage(this.countryName);

  @override
  _CountryDetailsPageState createState() => _CountryDetailsPageState();
}

class _CountryDetailsPageState extends State<CountryDetailsPage> {
  Map<String, dynamic>? countryData;

  @override
  void initState() {
    super.initState();
    fetchCountryData(widget.countryName);
  }

  Future<void> fetchCountryData(String countryName) async {
    String url = 'https://restcountries.com/v2/name/$countryName';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          countryData = data[0];
        });
      } else {
        print('Erreur : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Pays Details ${widget.countryName}'),
        backgroundColor: Colors.blue,
      ),
      body: countryData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      countryData!['flags']['png'],
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    countryData!['name'],
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    countryData!['nativeName'],
                    style: TextStyle(fontSize: 22, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10),
                  buildSectionTitle('Administration'),
                  buildInfoRow('Capitale', countryData!['capital']),
                  buildInfoRow(
                    'Langue(s)',
                    countryData!['languages']
                        .map((lang) => lang['nativeName'])
                        .join(', '),
                  ),
                  SizedBox(height: 10),
                  buildSectionTitle('Géographie'),
                  buildInfoRow('Région', countryData!['region']),
                  buildInfoRow('Superficie', '${countryData!['area']} km²'),
                  buildInfoRow(
                      'Fuseau Horaire', countryData!['timezones'].join(', ')),
                  SizedBox(height: 10),
                  buildSectionTitle('Démographie'),
                  buildInfoRow(
                    'Population',
                    countryData!['population'].toString(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label : ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
