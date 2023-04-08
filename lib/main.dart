import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'doodle/doodle_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Doodle App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

GlobalKey _globalKey = GlobalKey();
const Color kCanvasColor = Color(0xfff2f3f7);

class _MyHomePageState extends State<MyHomePage> {

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
    final Uri toLaunch4 =
    Uri(scheme: 'https', host: 'www.patreon.com', path: '/user?u=63034918/');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.blue,
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Simple Doodle App'),
          ),
        ),
      ),
      body: Container(
        color: Colors.lightBlue,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  'Click below to create your own custom creation!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ), //Welcome text
              Center(
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child:
                      Text("Start Your Doodle",
                        style: TextStyle(fontSize: 45, color: Colors.blue[500]),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DoodleMaker()),
                      );
                    },
                  ),
                ),
              ), //Generate button
              Text(
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
                      children: [
                        Icon(Icons.monetization_on_outlined, color: Colors.black),
                        const Text('Cashapp'),
                      ],
                    ),
                    onTap: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch);
                    }),
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.monetization_on_outlined, color: Colors.black),
                        const Text('Venmo'),
                      ],
                    ),
                    onTap: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch2);
                    }),
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.monetization_on_outlined, color: Colors.black),
                        const Text('Paypal'),
                      ],
                    ),
                    onTap: () => setState(() {
                      _launched = _launchUniversalLinkIos(toLaunch3);
                    }),
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.monetization_on_outlined, color: Colors.black),
                        const Text('Patreon'),
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
    print(info);
  //  _toastInfo(info);
  }
/*  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }*/
}
// Second route
class DoodleMaker extends StatelessWidget {
  const DoodleMaker({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.blue,
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Simple Doodle App'),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[850],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RepaintBoundary(
                    key: _globalKey,
                    child: Expanded(
                      child: Container(
                           height: 300,
                          child: DoodlePage(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _saveScreen,
                          child: const Text('Generate New Fractal'),
                        ), //Generate new fractal
                        ElevatedButton(
                          onPressed: _saveScreen,
                          child: const Text('Save to Device'),
                        ), //Save to device
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  _saveScreen() async {
    RenderRepaintBoundary boundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png) as FutureOr<ByteData?>);
    if (byteData != null) {
      final result =
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print(result);
    //  _toastInfo(result.toString());
    }
  }
}
