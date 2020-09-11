import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';

import 'package:qr_reader_app/src/pages/address_page.dart';
import 'package:qr_reader_app/src/pages/maps_page.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;

// import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: scansBloc.deleteAllScans)
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
      ),
    );
  }

  _scanQR(BuildContext context) async {
    // http://agustintm.com
    // geo:40.73359922990753,-73.98877516230472

    // * Usar estas líneas para probarse en dispositivos físicos
    // ScanResult futureString;

    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (error) {
    //   print(error.toString());
    // }
    // * **************************************************

    // * Usar estas líneas para probarse en dispositivos virtuales
    String futureString = 'https://agustintm.com';
    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      scansBloc.addScan(scan);

      final scan2 =
          ScanModel(value: 'geo:40.73359922990753,-73.98877516230472');
      scansBloc.addScan(scan2);
      // * *************************************************************

      /**
       * Esta instrucción sirve para verificar en que plataforma estamos corriendo
       * la aplicación. En IOS pusimos un delayed de 750 milisegundos ya que la
       * animación del scanner choca con el lanzamiento de la página web.
       */
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.launchScan(context, scan);
        });
      } else {
        utils.launchScan(context, scan);
      }
    }
  }

  Widget _createBottomNav() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
    );
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
      case 1:
        return AddressPage();
      default:
        return MapsPage();
    }
  }
}
