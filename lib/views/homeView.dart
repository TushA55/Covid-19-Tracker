import 'package:covid_19_tracker/provider/provider.dart';
import 'package:covid_19_tracker/views/statsView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:humanize/humanize.dart' as humanize;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  _getTotalCases(List _data) {
    int _sum = 0;
    _data.forEach((element) {
      _sum += element.cases;
    });
    return _sum;
  }

  _getTotalDeaths(List _data) {
    int _sum = 0;
    _data.forEach((element) {
      _sum += element.deaths;
    });
    return _sum;
  }

  _getTotalRecovered(List _data) {
    int _sum = 0;
    _data.forEach((element) {
      _sum += element.recovered;
    });
    return _sum;
  }

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<DataProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          title: Text(
            'Covid-19 Tracker Live Data',
            style: GoogleFonts.aBeeZee(fontSize: 22),
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
        body: StreamBuilder(
          stream: _dataProvider.getStatus(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 130),
                        child: Text(
                          'Global Coronavirus Cases',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 1,
                        color: Colors.white,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                'CONFIRMED',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    humanize.intComma(
                                        _getTotalCases(snapshot.data)),
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        color: Colors.white,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                'RECOVERED',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    humanize.intComma(
                                        _getTotalRecovered(snapshot.data)),
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        color: Colors.white,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                'DEATHS',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    humanize.intComma(
                                        _getTotalDeaths(snapshot.data)),
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
          },
        ),
        bottomSheet: Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child: FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StatsView(),
              ),
            ),
            child: Text(
              'All Country Data',
              style: GoogleFonts.raleway(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
