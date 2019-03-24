import 'package:avalon_member/pages/complete_online.dart';
import 'package:flutter/material.dart';

class CompleteOnlinePaymentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompleteOnlinePaymentPageState();
  }
}

class _CompleteOnlinePaymentPageState extends State<CompleteOnlinePaymentPage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Team Name"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Team Name"),
                textCapitalization: TextCapitalization.none,
                controller: _controller,
              ),
            ),
            RaisedButton(
              child: Text("Go!"),
              onPressed: () {
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                print(_controller.value.text.trim());
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return OnlinePendingPage(_controller.value.text.trim());
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
