import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kustomer_native_plugin/kustomer_native_plugin.dart';
import 'package:kustomer_native_plugin/model/conversation_input.dart';
import 'package:kustomer_native_plugin/model/describe_customer.dart';
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
  
  //Los datos de configuración de Kustomer se utilizan para configurar la plataforma de Kustomer. El brandId es el id de la marca en la plataforma de Kustomer y el apiKey es la clave de la API de la plataforma de Kustomer.
  final KustomerConfig _kustomerConfig =  KustomerConfig(brandId: "6406563db1e150b1e83fc134", apiKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZGY1YTdhZWFhY2VhMDcxMjhmZGY5NCIsInVzZXIiOiI2NWRmNWE3OTYyNjE1ODIxN2Y1ODlmNjUiLCJvcmciOiI2NDA2NTYyYTdhNmI4NmZkMjgyYmNhM2IiLCJvcmdOYW1lIjoienp6LWZhcm1hdG9kby1qZXNzeSIsInVzZXJUeXBlIjoibWFjaGluZSIsInBvZCI6InByb2QxIiwicm9sZXMiOlsib3JnLnRyYWNraW5nIl0sImF1ZCI6InVybjpjb25zdW1lciIsImlzcyI6InVybjphcGkiLCJzdWIiOiI2NWRmNWE3OTYyNjE1ODIxN2Y1ODlmNjUifQ.qt7Jr8lAIpYOFCLO3HVqUxFaiVmzV78trlY9-ak0huw");
  
  //Los datos del usuario se utilizan para loguear al mismo en la plataforma de Kustomer.EL token es el token de autenticación de la plataforma de Kustomer y se obtiene del backend.
  final User user = User(email:"omar.paba@farmatodo.com", token:"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHRlcm5hbElkIjoiNTU3MzAyIiwiaWF0IjoxNzEzMjcwMjAwLCJlbWFpbCI6Im9tYXIucGFiYUBmYXJtYXRvZG8uY29tIn0.1f1c0XBGuOViyfuDw8c8U5IVJLyGRgcm7Zl1BczWmkI");
  
  //Los datos de la conversación se utilizan para iniciar una conversación con la plataforma de Kustomer. El mensaje inicial es el mensaje que se envía al iniciar la conversación.Si no se envia mensaje  lleva a la pantalla principal de la plataforma de Kustomer. El título es el título de la conversación y el mapa es un mapa de datos que se envía a la plataforma de Kustomer.
  final ConversationInput conversationInput = ConversationInput(initialMessage:'Necesito ayuda con mi orden #349123',title: 'Example', map: {"property":"value"});
  
  //Los datos del cliente se utilizan para describir al cliente en la plataforma de Kustomer. El email es el email del cliente, el teléfono es el teléfono del cliente y el custom es un mapa de datos que se envía a la plataforma de Kustomer.
  final DescribeCustomer describeCustomer = DescribeCustomer(email: "omar.paba@farmatodo.com",phone: '23412341235', custom: {"property":"value"});

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
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  await _kustomerNativePlugin.start(_kustomerConfig, user, conversationInput,describeCustomer);
                },
                child: const Text('New Conversation'),
              ),
              TextButton(
                onPressed: () async {
                  await _kustomerNativePlugin.logOut(_kustomerConfig);
                },
                child: const Text('Log Out'),
              )
            ],
          )
        ),
      ),
    );
  }
}
