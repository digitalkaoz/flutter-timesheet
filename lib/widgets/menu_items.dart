import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/screens/dialog/client_add.dart';
import 'package:timesheet_flutter/screens/dialog/client_delete.dart';
import 'package:timesheet_flutter/screens/dialog/client_edit.dart';
import 'package:timesheet_flutter/services/theme.dart';

class MenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);

    final headerTheme =
        Theme.of(context).textTheme.subhead.copyWith(color: defaultColor);

    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          title: Center(
            child: Text(
              "Data",
              style: headerTheme,
            ),
          ),
        ),
        ListTile(
          title: Text("Import"),
          leading: Icon(
            Icons.cloud_upload,
            color: defaultColor,
          ),
          onTap: () async {
            File file = await FilePicker.getFile(type: FileType.ANY);
            if (file != null) {
              await clients.import(file);
            }
          },
        ),
        ListTile(
          title: Text("Export"),
          leading: Icon(
            Icons.cloud_download,
            color: defaultColor,
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
          dense: true,
          title: Center(
            child: Text(
              "Clients",
              style: headerTheme,
            ),
          ),
        ),
        ListTile(
          title: Text("Add"),
          leading: Icon(
            Icons.create_new_folder,
            color: defaultColor,
          ),
          onTap: () async {
            await showClientAddDialog(context);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Edit"),
          leading: Icon(Icons.edit, color: defaultColor),
          onTap: () async {
            await showClientEditDialog(context);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text("Delete"),
          leading: Icon(Icons.delete, color: defaultColor),
          onTap: () async {
            await showClientDeleteDialog(context);
            Navigator.pop(context);
          },
        ),
        ListTile(
          dense: true,
          title: Center(
            child: Text(
              "App",
              style: headerTheme,
            ),
          ),
        ),
        ListTile(
          title: Text("About"),
          leading: Icon(Icons.view_quilt, color: defaultColor),
          onTap: () async {
            showAboutDialog(
              context: context,
              applicationIcon: Image.asset(
                "assets/icon.png",
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
