import 'package:codeit_kss_git_client/data/exports.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QueryPage extends StatefulWidget {
  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  String studentName;
  DateTime _fromDate;
  DateTime _toDate;
  bool _isRange = false;
  bool _isLoading = false;

  List<Widget> _programs = [];

  @override
  void initState() {
    super.initState();

    studentName = studentNames.first;
    _fromDate = DateTime.now();
    _toDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Query Page', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 12.0),
            if (_isLoading) Center(child: CircularProgressIndicator()),
            if (!_isLoading) ..._programs,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlineButton(
          child: Text('Range / Date'),
          onPressed: () => setState(() => _isRange = !_isRange),
        ),
        SizedBox(width: 12),
        _fromDateSelector(),
        _toDateSelector(),
      ],
    );
  }

  Widget _fromDateSelector() {
    return FlatButton(
      child: Text(_fromDate.toString().substring(0, 10)),
      onPressed: () => showDatePicker(
        context: context,
        initialDate: _fromDate,
        firstDate: DateTime.parse('2020-10-09'),
        lastDate: DateTime.now(),
      ).then((val) => setState(() {
            _fromDate = val ?? _fromDate;
            if (!_isRange) _toDate = _fromDate;
          })),
    );
  }

  Widget _toDateSelector() {
    return _isRange
        ? FlatButton(
            child: Text(_toDate.toString().substring(0, 10)),
            onPressed: () => showDatePicker(
              context: context,
              initialDate: _toDate,
              firstDate: DateTime.parse('2020-10-09'),
              lastDate: DateTime.now(),
            ).then((val) => setState(() {
                  _toDate = val ?? _toDate;
                })),
          )
        : Center();
  }

  Widget _button() {
    var url = 'https://raw.githubusercontent.com/' +
        gitID[studentName] +
        '/Codeit-KSS/main/';

    return RaisedButton(
      child: Text(
        'Get Programs',
        style: TextStyle(color: Colors.white),
      ),
      color: Theme.of(context).primaryColor,
      onPressed: () async {
        setState(() => _isLoading = true);
        DateTime iter = _fromDate;
        DateTime end = _toDate.add(Duration(days: 1));
        _programs.clear();
        setState(() => _programs);

        while (iter.isBefore(end)) {
          _programs.add(_dateHeader(iter));
          await get(
              url, iter.toString().substring(0, 10).replaceAll('-', '_'), '01');
          await get(
              url, iter.toString().substring(0, 10).replaceAll('-', '_'), '02');
          iter = iter.add(Duration(days: 1));
        }
        setState(() {
          _isLoading = false;
          return _programs;
        });
      },
    );
  }

  Future get(url, date, pID) async {
    var response = await http.get(url + date + '_$pID');
    if (response.statusCode == 200) {
      _programs.add(_header('Program $pID:'));
      _programs.add(_content(response.body));
    } else {
      _programs.add(_header('Program $pID: Not found'));
    }
  }

  _dateHeader(DateTime date) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        date.toString().substring(0, 10),
        style: TextStyle(fontSize: 24.0, color: Colors.green),
      ),
    );
  }

  _header(String text) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(text, style: TextStyle(fontSize: 20.0)),
    );
  }

  _content(String text) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(),
      child: Text(text),
    );
  }
}
