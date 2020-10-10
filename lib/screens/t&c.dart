import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/widgets/widget.dart';
import 'package:flutter/services.dart' show rootBundle;

class TermsAndCondition extends StatefulWidget {
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  String data = '';

  fetchFileData() async {
    String responseText =
        await rootBundle.loadString('textFiles/TermsandConditionText.txt');

    setState(() {
      data = responseText;
    });
  }

  @override
  void initState() {
    fetchFileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff292929),
        title: Text("Terms & Conditions"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text(
            data,
            style: TextStyle(fontFamily: "mulish", fontSize: 15),
          ),
        ),
      ),
    );
  }
}
