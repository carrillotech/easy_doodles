import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'doodle/doodle_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Simple Doodle App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

GlobalKey _globalKey = GlobalKey();
const Color kCanvasColor = Color(0xfff2f3f7);

class MyHomePageState extends State<MyHomePage> {
  Future<void>? _launched;

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  void initState() {
    super.initState();

    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'www.cash.app', path: '\$jcelevated/');
    final Uri toLaunch2 =
        Uri(scheme: 'https', host: 'www.venmo.com', path: '/u/jcelevated/');
    final Uri toLaunch3 =
        Uri(scheme: 'https', host: 'www.paypal.me', path: '/jcelevated1/');
    final Uri toLaunch4 = Uri(
        scheme: 'https', host: 'www.patreon.com', path: '/user?u=63034918/');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.blue,
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text('Simple Doodle App'),
          ),
        ),
      ),
      body: Container(
        color: Colors.cyan,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Spacer(),
              const Text(
                'Click below to create your own custom creation!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
/*                      foreground: Paint()
                      ..shader = ui.Gradient.linear(
                        const Offset(0, 100),
                        const Offset(150, 20),
                        <Color>[
                          Colors.black,
                          Colors.white,
                        ],
                      )*/
                ),
              ),
              const Spacer(), //Welcome text
              Center(
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    child: const FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        "Start A New Doodle",
                        style: TextStyle(fontSize: 45, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoodleMaker()),
                      );
                    },
                  ),
                ),
              ),
              const Spacer(), //Generate button
              const Text(
                'Please consider donating',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ), //Donate text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Column(
                      children: const [
                        Icon(Icons.monetization_on_outlined,
                            color: Colors.black),
                        Text('Cashapp'),
                      ],
                    ),
                    onTap: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch);
                    }),
                  ),
                  InkWell(
                    child: Column(
                      children: const [
                        Icon(Icons.monetization_on_outlined,
                            color: Colors.black),
                        Text('Venmo'),
                      ],
                    ),
                    onTap: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch2);
                    }),
                  ),
                  InkWell(
                    child: Column(
                      children: const [
                        Icon(Icons.monetization_on_outlined,
                            color: Colors.black),
                        Text('Paypal'),
                      ],
                    ),
                    onTap: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch3);
                    }),
                  ),
                  InkWell(
                    child: Column(
                      children: const [
                        Icon(Icons.monetization_on_outlined,
                            color: Colors.black),
                        Text('Patreon'),
                      ],
                    ),
                    onTap: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch4);
                    }),
                  ),
                  // commented out but included both methods to open url
                  // InkWell(
                  //   onTap: () => setState(() {
                  //     _launched = _launchUniversalLinkIos(toLaunch); //Launch a universal link in a native app, fallback to Safari.(Youtube)')
                  //     _launched = _launchInBrowser(toLaunch); //Launch in browser
                  //   }),
                ],
              ), // Donation options
              FutureBuilder<void>(future: _launched, builder: _launchStatus),
            ],
          ),
        ),
      ),
    );
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    debugPrint(info);
  }
}

// Second route
class DoodleMaker extends StatelessWidget {
  const DoodleMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.blue,
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text('Simple Doodle App'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "paint_save",
        tooltip: 'Save',
        onPressed: () {
          const Text('Image Saved');
          _saveScreen();
        },
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RepaintBoundary(
                key: _globalKey,
                child: const DoodlePage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  _saveScreen() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      debugPrint(result);
      _toastInfo('Image Saved');
    }
  }
}