import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';
import 'package:timesheet_flutter/widgets/app_bar.dart';
import 'package:timesheet_flutter/widgets/bottom_sheet.dart';
import 'package:timesheet_flutter/widgets/client/client_pages.dart';
import 'package:timesheet_flutter/widgets/time_add_form.dart';

class IndexScreen extends StatelessWidget {
  static const ROUTE = '/';

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    final PanelController sheet = Provider.of<PanelController>(context);

    return Scaffold(
      appBar: NavBar(),
      body: Observer(
        builder: (_) => Stack(
          children: <Widget>[
            ClientPages(),
            clients.current == null
                ? Container()
                : SlidingBottomSheet(
                    panel: _BottomPanel(),
                    controller: sheet,
                  )
          ],
        ),
      ),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    final PanelController sheet = Provider.of<PanelController>(context);

    return SingleChildScrollView(
      child: clients.current != null
          ? Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ActionChip(
                    onPressed: () =>
                        sheet.isPanelOpen() ? sheet.close() : sheet.open(),
                    label: Text('Add Time to ${clients.currentTitle}'),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(color: defaultColor),
                  ),
                ),
                TimeAddForm(),
              ],
            )
          : Container(),
    );
  }
}
