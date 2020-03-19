import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';

class MenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    final iconColor = accent(context);

    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Import Data"),
          leading: Icon(
            Icons.cloud_upload,
            color: iconColor,
          ),
          onTap: () async {
            File file = await FilePicker.getFile(type: FileType.ANY);
            if (file != null) {
              await clients.import(file);
            }
          },
        ),
        ListTile(
          title: Text("Export Data"),
          leading: Icon(
            Icons.cloud_download,
            color: iconColor,
          ),
          onTap: () async {
            final file = await clients.export();
            Navigator.pop(context);
            if (defaultTargetPlatform == TargetPlatform.android) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Exported to ${file.parent.path}"),
                ),
              );
            }
          },
        ),
        ListTile(
          title: Text("Imprint"),
          leading: Icon(
            Icons.view_quilt,
            color: iconColor,
          ),
          onTap: () async {
            showAboutDialog(
              context: context,
              applicationIcon: Image.asset(
                "assets/app_icon_transparent.png",
                width: 50,
              ),
              applicationLegalese:
                  "copyright 2020 by Robert Schönthal https://digitalkaoz.net",
            );
          },
        ),
      ],
    );
  }
}
