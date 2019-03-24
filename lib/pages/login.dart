import 'package:avalon_member/pages/colleges.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/registrations.dart';

class LoginPage extends StatelessWidget {
  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Unauthorized Access"),
          content: new Text(
              "You are not authorized to access the registration panel"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RegistrationModel>(
      builder: (BuildContext context, Widget child, RegistrationModel _model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign In"),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: _model.isLoading
                ? CircularProgressIndicator()
                : RaisedButton(
                    onPressed: () async {
                      try {
                        _model.login().then((value) {
                          if (value) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return CollegePage();
                            }));
                          } else {
                            _showDialog(context);
                          }
                        });
                      } catch (e) {
                      }
                    },
                    child: Text("Login"),
                  ),
          ),
        );
      },
    );
  }
}
