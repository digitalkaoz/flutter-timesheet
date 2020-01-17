import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet_flutter/model/client.dart';
import 'package:timesheet_flutter/model/clients.dart';
import 'package:timesheet_flutter/services/theme.dart';

class ClientEditForm extends StatefulWidget {
  @override
  _ClientEditFormState createState() => _ClientEditFormState();
}

class _ClientEditFormState extends State<ClientEditForm> {
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
    final Client client = clients.current;

    if (client == null) {
      return Container();
    }

    _controller.value = TextEditingValue(text: client.name);

    return SimpleDialog(
      title: Text('Edit ${client.name}'),
      contentPadding: EdgeInsets.all(20),
      children: [
        Column(
          children: <Widget>[
            TextFormField(
              controller: _controller,
              autofocus: false,
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
                  child: Text('Save'),
                  onPressed: clients.validateName(_controller.text) == null
                      ? () {
                          final name = _controller.text;
                          if (name.isNotEmpty) {
                            client.setName(name);
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
