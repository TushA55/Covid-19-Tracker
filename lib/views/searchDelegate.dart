import 'package:flutter/material.dart';
import 'package:humanize/humanize.dart' as humanize;

class Search extends SearchDelegate {
  final List stats;
  final Map countries;

  Search({this.stats, this.countries});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: Colors.blueGrey[900],
      primaryColor: Colors.blueGrey[900],
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      cursorColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final _suggestions = this
        .stats
        .where((element) =>
            element.country.toString().toLowerCase().startsWith(query))
        .toList();
    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return _suggestions.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Card(
                child: Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _suggestions[index].country,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              'https://www.countryflags.io/${this.countries[_suggestions[index].country]}/flat/64.png',
                              height: 70,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CONFIRMED:' +
                                  humanize
                                      .intComma(_suggestions[index].cases)
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              'RECOVERED:' +
                                  humanize
                                      .intComma(_suggestions[index].recovered)
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            Text(
                              'DEATHS:' +
                                  humanize
                                      .intComma(_suggestions[index].deaths)
                                      .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[100]
                                    : Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _suggestions = query.isEmpty
        ? this.stats
        : this
            .stats
            .where((element) =>
                element.country.toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return _suggestions.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Card(
                child: Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _suggestions[index].country,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              'https://www.countryflags.io/${this.countries[_suggestions[index].country]}/flat/64.png',
                              height: 70,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CONFIRMED:' +
                                  humanize
                                      .intComma(_suggestions[index].cases)
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              'RECOVERED:' +
                                  humanize
                                      .intComma(_suggestions[index].recovered)
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            Text(
                              'DEATHS:' +
                                  humanize
                                      .intComma(_suggestions[index].deaths)
                                      .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[100]
                                    : Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
      },
    );
  }
}
