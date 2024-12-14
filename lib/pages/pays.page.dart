import 'package:atelier6/pages/pays-details.page.dart';
import 'package:flutter/material.dart';

class Pays extends StatelessWidget {
  TextEditingController txt_Keyword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Page Pays',
            style: TextStyle(fontSize: 22),
          ),
          backgroundColor: Colors.teal[200],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_Keyword,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.villa),
                    hintText: "Keyword",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.teal[300]),
                onPressed: () {
                  _onGetPaysDetails(context);
                },
                child: const Text(
                  'Recherche',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }

  void _onGetPaysDetails(BuildContext context) {
    String v = txt_Keyword.text;

    if (v.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CountryDetailsPage(v)));
    } else {
      const snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Center(child: Text('Keyword requis')),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
