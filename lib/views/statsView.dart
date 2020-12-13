import 'package:covid_19_tracker/provider/provider.dart';
import 'package:covid_19_tracker/views/searchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:humanize/humanize.dart' as humanize;

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  List _stats;

  _search(DataProvider _p) {
    setState(() {
      _stats.forEach((element) {
        element.country = _p.countriesMap[element.country];
      });
    });
    showSearch(
        context: context,
        delegate: Search(
          stats: _stats,
          countries: _p.countriesMap.map(
            (k, v) => MapEntry(v, k),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _search(_dataProvider),
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        title: Text('Country Stats', style: GoogleFonts.aBeeZee(fontSize: 22)),
      ),
      body: StreamBuilder(
        stream: _dataProvider.getStatus(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    _stats = snapshot.data;
                    return Card(
                      child: Container(
                        height: 130,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    _dataProvider.countriesMap[
                                                snapshot.data[index].country] ==
                                            null
                                        ? ""
                                        : _dataProvider.countriesMap[
                                                snapshot.data[index].country]
                                            .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Image.network(
                                    'https://www.countryflags.io/${snapshot.data[index].country}/flat/64.png',
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
                                            .intComma(
                                                snapshot.data[index].cases)
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  Text(
                                    'RECOVERED:' +
                                        humanize
                                            .intComma(
                                                snapshot.data[index].recovered)
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    'DEATHS:' +
                                        humanize
                                            .intComma(
                                                snapshot.data[index].deaths)
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
                )
              : snapshot.hasError
                  ? Center(
                      child: Text('${snapshot.error}'),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    );
        },
      ),
    );
  }
}
