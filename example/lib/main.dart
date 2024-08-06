import 'package:flutter/material.dart';
import 'package:kustomer_native_plugin/kustomer_native_plugin.dart';
import 'package:kustomer_native_plugin/model/conversation_input.dart';
import 'package:kustomer_native_plugin/model/kustomer_config.dart';
import 'package:kustomer_native_plugin/model/kustomer_user.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final kustomer = Kustomer();

  //TODO: Para sacar el token de KustomerUser -> user.token se debe llamar la siguiente API.

/*
      curl --location 'https://ftd-kustomer-services-voqp7ipqwq-uc.a.run.app/kustomer/customer/token' \
    --header 'sec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "Microsoft Edge";v="126"' \
    --header 'sec-ch-ua-mobile: ?0' \
    --header 'Authorization: Basic eW9hbmEuYW5nYXJpdGFAZmFybWF0b2RvLmNvbS90b2tlbjp6UWZ3Y3RmNmxNQW5sbFlBSWFhMUJMRzdOYnlhVUliSlk2cVppRHA5' \
    --header 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0' \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json, text/plain' \
    --header 'Referer: https://qa-kustomer-chat-dot-staging-dot-web-farmatodo.uc.r.appspot.com/' \
    --header 'Country: COL' \
    --header 'sec-ch-ua-platform: "Windows"' \
    --data-raw '{"externalId":"268226","email":"diegofca.08@gmail.com"}'

    externalId -> ID del usuario en FARMATODO
    email -> Correo del usuario en FARMATODO

*/

  //Los datos de configuración de Kustomer se utilizan para configurar la plataforma de Kustomer. El brandId es el id de la marca en la plataforma de Kustomer y el apiKey es la clave de la API de la plataforma de Kustomer.
  final KustomerConfig _kustomerConfig = KustomerConfig(
    brandId: "6523ffeabe7cea70f42cc6fc",
    apiKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YTAwZmRlY2U5MjBiYjUxM2M3ODQ4MCIsInVzZXIiOiI2NmEwMGZkZGVlNmQzYTNkY2I5YWVkZGEiLCJvcmciOiI2NTIzZmZlNjU5MWU4NjM0MGI2N2RkYjEiLCJvcmdOYW1lIjoiZmFybWF0b2RvIiwidXNlclR5cGUiOiJtYWNoaW5lIiwicG9kIjoicHJvZDEiLCJyb2xlcyI6WyJvcmcudHJhY2tpbmciXSwiYXVkIjoidXJuOmNvbnN1bWVyIiwiaXNzIjoidXJuOmFwaSIsInN1YiI6IjY2YTAwZmRkZWU2ZDNhM2RjYjlhZWRkYSJ9.jO2AjreNGkGWV2pdvNsxHLkbzGZtynjdfsYvnip6WHc", // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2YTAwZmRlY2U5MjBiYjUxM2M3ODQ4MCIsInVzZXIiOiI2NmEwMGZkZGVlNmQzYTNkY2I5YWVkZGEiLCJvcmciOiI2NTIzZmZlNjU5MWU4NjM0MGI2N2RkYjEiLCJvcmdOYW1lIjoiZmFybWF0b2RvIiwidXNlclR5cGUiOiJtYWNoaW5lIiwicG9kIjoicHJvZDEiLCJyb2xlcyI6WyJvcmcudHJhY2tpbmciXSwiYXVkIjoidXJuOmNvbnN1bWVyIiwiaXNzIjoidXJuOmFwaSIsInN1YiI6IjY2YTAwZmRkZWU2ZDNhM2RjYjlhZWRkYSJ9.jO2AjreNGkGWV2pdvNsxHLkbzGZtynjdfsYvnip6WHc",
    user: KustomerUser(
      token:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHRlcm5hbElkIjoiMjY4MjI2IiwiaWF0IjoxNzIyODg5NDg0LCJlbWFpbCI6ImRpZWdvZmNhLjA4QGdtYWlsLmNvbSJ9.InqUcYmkXYTKIKw55DdQiR_K3KYXZCF4motzs9g9wAk",
      email: "diegofca.08@gmail.com",
      phone: '573114742370',
    ),
    //user: KustomerUser.annonimousUser(),
    conversationInput: ConversationInput(
      initialMessage: 'Nueva conversación',
      title: 'Farmatodo',
    ),
  );

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final logged = await kustomer.start(_kustomerConfig);
    print(logged);
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
                await kustomer.openChat();
              },
              child: const Text('Open Chat'),
            ),
            TextButton(
              onPressed: () async {
                await kustomer.logOut(_kustomerConfig);
              },
              child: const Text('Log Out'),
            )
          ],
        )),
      ),
    );
  }
}
