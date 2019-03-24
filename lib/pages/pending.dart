import 'package:avalon_member/pages/first.dart';
import 'package:avalon_member/scoped-models/registrations.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';

class PendingPage extends StatelessWidget {
  final String regNo;
  PendingPage(this.regNo);

  Widget amount(RegistrationModel model, BuildContext context) {
    model.getPending(regNo);
    if (model.isLoading) {
      return Container(
        child: CircularProgressIndicator(),
      );
    } else {
      try {
        int value = model.registration['pending'];
        if (!model.registration['closed']) {
          return Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(model.registration['avalonMember'] +
                    " has not submitted the previous payment to the treasurer"),
              ));
        }
        var date = DateTime.fromMillisecondsSinceEpoch(
            model.registration['timestamp']);
        var formatter = new DateFormat('MMMMd');
        String formatted = formatter.format(date);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    regNo,
                    textScaleFactor: 2.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    "Team Name: " + model.registration['teamName'],
                    textScaleFactor: 1.5,
                  ),
                  Text(
                    "Leader Name: " + model.registration['leaderName'],
                    textScaleFactor: 1.5,
                  ),
                  Text(
                    "Paid Rs." + model.registration['paid'].toString(),
                    textScaleFactor: 1.5,
                  ),
                  Text(
                    "To: " +
                        model.registration['avalonMember'] +
                        " on " +
                        formatted.toString(),
                    textScaleFactor: 1.5,
                  ),
                  Text(
                    "Pending: " + value.toString(),
                    textScaleFactor: 1.5,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  value != 0
                      ? RaisedButton(
                          child: Text("Yes! Collected"),
                          onPressed: () {
                            _showDialog(model, context);
                          },
                        )
                      : Container(),
                  RaisedButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      } catch (err) {
        return Center(
          child: Text("No such registration"),
        );
      }
    }
  }

  void _showDialog(RegistrationModel model, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm payment!"),
          content: new Text("Payment of " +
              model.registration['pending'].toString() +
              " is done?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("Yes, its done!"),
                onPressed: () {
                  model.completePayment(regNo).then((value) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return FirstPage();
                    }));
                  });
                }),
            new FlatButton(
                child: new Text("No, its not!"),
                onPressed: () {
                  model.completePayment(regNo).then((value) {
                    Navigator.of(context).pop();
                  });
                })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RegistrationModel>(
      builder: (BuildContext context, Widget child, RegistrationModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Payment Information"),
          ),
          body: Center(
            child: amount(model, context),
          ),
        );
      },
    );
  }
}
