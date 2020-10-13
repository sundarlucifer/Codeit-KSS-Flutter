import 'package:codeit_kss_git_client/data/exports.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QueryPage extends StatefulWidget {
  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  String studentName;
  DateTime date;

  var p1 = {'txt': '', 'err': ''};
  var p2 = {'txt': '', 'err': ''};

  // String p1 = '', p2 = '', e1 = '', e2 = '';

  @override
  void initState() {
    super.initState();

    studentName = studentNames.first;
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Query Page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0,
              color: Colors.grey[100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _studentSelecter(),
                    _dateSelector(),
                    _button(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Program 1: ' + p1['err'],
                style: TextStyle(fontSize: 32.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(),
              child: Text(p1['txt']),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Program 2: ' + p2['err'],
                style: TextStyle(fontSize: 32.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(),
              child: Text(p2['txt']),
            ),
          ],
        ),
      ),
    );
  }

  Widget _studentSelecter() {
    return DropdownButton(
      items: studentNames
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (val) =>
          setState(() => this.studentName = val ?? this.studentName),
      value: studentName,
    );
  }

  Widget _dateSelector() {
    return FlatButton(
      child: Text(this.date.toString().substring(0, 10)),
      onPressed: () => showDatePicker(
        context: context,
        initialDate: this.date,
        firstDate: DateTime.parse('2020-10-09'),
        lastDate: DateTime.now(),
      ).then((val) => setState(() => this.date = val ?? this.date)),
    );
  }

  Widget _button() {
    var url = 'https://raw.githubusercontent.com/' +
        gitID[studentName] +
        '/Codeit-KSS/main/' +
        date.toString().substring(0, 10).replaceAll('-', '_');
    return RaisedButton(
      child: Text('Get Programs'),
      onPressed: () {
        get(url + '_01', p1);
        get(url + '_02', p2);
      },
    );
  }

  void get(url, p) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        p['txt'] = response.body;
        p['err'] = '';
      });
    } else {
      setState(() {
        p['err'] = 'File not found';
        p['txt'] = '';
      });
    }
  }
}
