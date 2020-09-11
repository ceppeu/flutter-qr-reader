import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';

import 'package:flutter_map/flutter_map.dart';

class ShowMapPage extends StatefulWidget {
  @override
  _ShowMapPageState createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<ShowMapPage> {
  MapController mapController = new MapController();

  String mapType = 'streets';
  final mapTypes = ['streets', 'dark', 'light', 'outdoors', 'satellite'];
  int typeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapController.move(scan.getLanLng(), 12);
            },
          )
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLanLng(),
        zoom: 12,
      ),
      layers: [_createMap(), _createMarkers(scan)],
    );
  }

  _createMap() {
    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
          'id': 'mapbox.$mapType'
        });
  }

  _createMarkers(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLanLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.repeat,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {
          typeIndex != 4 ? typeIndex++ : typeIndex = 0;
          mapType = mapTypes[typeIndex];
        });
      },
    );
  }
}
