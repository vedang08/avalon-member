import 'package:avalon_member/pages/first.dart';
import 'package:avalon_member/scoped-models/registrations.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class OnlinePendingPage extends StatelessWidget {
  final String teamName;
  OnlinePendingPage(this.teamName);

  Widget amount(RegistrationModel model, BuildContext context) {
    int value;
    model.getPendingOnline(teamName);
    if (model.isLoading) {
      return Container(
        child: CircularProgressIndicator(),
      );
    } else {
      try {
        int count = int.parse(model.registration['member_count']);
        if (model.registration['competition'] == "tpp") {
          value = 400 + (count - 3) * 50;
        } else {
          value = 600 + (count - 4) * 50;
        }
        if (model.registration['paid'] != null) {
          return Text(
            "No payment pending for " + teamName,
            textScaleFactor: 1.5,
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Team Name: " + teamName,
                    textScaleFactor: 1.5,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    "Title: " + model.registration['project_title'],
                    textScaleFactor: 1.5,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    "Pay: " + value.toString(),
                    textScaleFactor: 1.5,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  RaisedButton(
                    child: Text("Yes! Collected"),
                    onPressed: () {
                      _showDialog(model, context, value);
                    },
                  ),
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

  void _showDialog(RegistrationModel model, BuildContext context, int paid) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm payment!"),
          content: new Text("Payment of " + paid.toString() + " is done?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("Yes, its done!"),
                onPressed: () {
                  model.completeOnlinePayment(teamName, paid).then((value) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return FirstPage();
                    }));
                  });
                }),
            new FlatButton(
                child: new Text("No, its not!"),
                onPressed: () {
                  Navigator.of(context).pop();
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
