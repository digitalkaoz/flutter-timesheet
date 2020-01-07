import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/model/local_storage.dart';
import 'package:timesheet_flutter/model/timesheet.dart';
import 'package:timesheet_flutter/services/theme.dart';

class ClientAddForm extends StatefulWidget {
  @override
  _ClientAddFormState createState() => _ClientAddFormState();
}

class _ClientAddFormState extends State<ClientAddForm> {
  final TextEditingController _controller = TextEditingController();

  bool submittable = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Clients clients = Provider.of<Clients>(context);
    final Storage storage = Provider.of<Storage>(context);

    return SimpleDialog(
      title: Text('Add new client'),
      contentPadding: EdgeInsets.all(20),
      children: [
        Column(
          children: <Widget>[
            TextFormField(
              controller: _controller,
              autofocus: true,
              autovalidate: true,
              validator: (value) {
                final errorMessage = clients.validateName(_controller.text);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (errorMessage == null) {
                    setState(() => submittable = true);
                  } else {
                    setState(() => submittable = false);
                  }
                });

                return errorMessage;
              },
              decoration: InputDecoration(
                hintText: 'Client Name',
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                RaisedButton(
                  color: defaultColor,
                  child: Text('Create'),
                  onPressed: clients.validateName(_controller.text) == null
                      ? () {
                          final name = _controller.text;
                          if (name.isNotEmpty) {
                            Client c = Client(storage, name);
                            c.addSheet(Timesheet(storage));
                            clients.addClient(c);

                            Navigator.of(context)
                                .pop("added $name! swipe right to get there");
                            return;
                          }

                          Navigator.of(context).pop();
                        }
                      : null,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
