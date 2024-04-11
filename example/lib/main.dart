import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kustomer_native_plugin/kustomer_native_plugin.dart';
import 'package:kustomer_native_plugin/model/kustomer_config.dart';
import 'package:kustomer_native_plugin/model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _kustomerNativePlugin = KustomerNativePlugin();
  final KustomerConfig _kustomerConfig =  KustomerConfig(brandId: "6406563db1e150b1e83fc134", apiKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZGY1YTdhZWFhY2VhMDcxMjhmZGY5NCIsInVzZXIiOiI2NWRmNWE3OTYyNjE1ODIxN2Y1ODlmNjUiLCJvcmciOiI2NDA2NTYyYTdhNmI4NmZkMjgyYmNhM2IiLCJvcmdOYW1lIjoienp6LWZhcm1hdG9kby1qZXNzeSIsInVzZXJUeXBlIjoibWFjaGluZSIsInBvZCI6InByb2QxIiwicm9sZXMiOlsib3JnLnRyYWNraW5nIl0sImF1ZCI6InVybjpjb25zdW1lciIsImlzcyI6InVybjphcGkiLCJzdWIiOiI2NWRmNWE3OTYyNjE1ODIxN2Y1ODlmNjUifQ.qt7Jr8lAIpYOFCLO3HVqUxFaiVmzV78trlY9-ak0huw");
  final User user = User(email:"omar.paba@farmatodo.com", token:"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHRlcm5hbElkIjoiNTU3MzAyIiwiaWF0IjoxNzEwODU4NDAxLCJlbWFpbCI6Im9tYXIucGFiYUBmYXJtYXRvZG8uY29tIn0.f4Mq9QclwB1f5SdAH_-iuBL9TwKn90VuHSgU87LWPMo");
  final String message = "Hola en que puedo ayudarte hoy?";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _kustomerNativePlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async {
              await _kustomerNativePlugin.start(_kustomerConfig, user, message);
            },
            child: const Text('New Conversation'),
          )
        ),
      ),
    );
  }
}
