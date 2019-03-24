import 'package:avalon_member/pages/pending.dart';
import 'package:flutter/material.dart';

class CompletePaymentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return _CompletePaymentPageState();
  }
}

class _CompletePaymentPageState extends State<CompletePaymentPage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter registration number"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Registration Number"),
                textCapitalization: TextCapitalization.characters,
                controller: _controller,
              ),
            ),
            RaisedButton(
              child: Text("Go!"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return PendingPage(_controller.value.text.trim());
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
