import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.getScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final scans = snapshot.data;
        if (scans.length == 0) return Center(child: Text('No hay información'));
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
            child: ListTile(
              leading: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[i].value),
              subtitle: Text('El id es: ${scans[i].id}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => utils.launchScan(context, scans[i]),
            ),
          ),
        );
      },
    );
  }
}
