import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash/Providers/themeProvider.dart';
import 'package:splash/widgets/widget.dart';
import 'package:flutter/services.dart' show rootBundle;

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String data = '';

  fetchFileData() async {
    String responseText =
        await rootBundle.loadString('textFiles/PrivacyPolicyText.txt');

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
        title: Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text(
            data,
            style: TextStyle(fontSize: 15, fontFamily: "mulish"),
          ),
        ),
      ),
    );
  }
}
