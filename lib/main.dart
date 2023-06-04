import 'package:covid_19_corona_cases/covid_api.dart';
import 'package:covid_19_corona_cases/filecovid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CovidTrackerApp());
}

class CovidTrackerApp extends StatelessWidget {
  const CovidTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CovidTrackerScreen(),
    );
  }
}

class CovidTrackerScreen extends StatefulWidget {
  const CovidTrackerScreen({Key? key}) : super(key: key);

  @override
  State<CovidTrackerScreen> createState() => _CovidTrackerScreenState();
}

class _CovidTrackerScreenState extends State<CovidTrackerScreen> {
  final COVIDAPI _apiService = COVIDAPI();
  GlobalData? _globalData;
  late List<CountryData> _countryData;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    try {
      final globalData = await _apiService.getGlobalData();
      final countryData = await _apiService.getCountryData();
      setState(() {
        _globalData = globalData;
        _countryData = countryData;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch data'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
      ),
      body: _globalData == null || _countryData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Global Cases:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _buildStatsCard('Cases', _globalData!.cases),
          _buildStatsCard('Deaths', _globalData!.deaths),
          _buildStatsCard('Recovered', _globalData!.recovered),
          _buildStatsCard('Active', _globalData!.active),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Country-wise Cases:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _countryData.length,
              itemBuilder: (context, index) {
                final country = _countryData[index];
                return ListTile(
                  title: Text(country.country),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cases:${country.cases}'),
                      Text('Deaths:${country.deaths}'),
                      Text('Recovered:${country.recovered}'),
                      Text('Active:${country.active}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, int count) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          count.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}