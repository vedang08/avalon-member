import 'package:avalon_member/pages/colleges.dart';
import 'package:avalon_member/pages/complete.dart';
import 'package:avalon_member/pages/info.dart';
import 'package:avalon_member/pages/interest.dart';
import 'package:avalon_member/pages/login.dart';
import 'package:avalon_member/pages/online_payment.dart';
import 'package:avalon_member/pages/options.dart';
import 'package:avalon_member/scoped-models/registrations.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return ScopedModelDescendant<RegistrationModel>(
      builder: (BuildContext context, Widget child, RegistrationModel model) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                      child: Text(
                    "References",
                    textScaleFactor: 3.0,
                  )),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return InfoPage(1);
                    }));
                  },
                  title: Center(child: Text("Avalon")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return InfoPage(2);
                    }));
                  },
                  title: Center(child: Text("TPP")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return InfoPage(3);
                    }));
                  },
                  title: Center(child: Text("Project")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return InfoPage(4);
                    }));
                  },
                  title: Center(child: Text("Basic Requirements")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return InfoPage(5);
                    }));
                  },
                  title: Center(child: Text("Publicity Guidelines")),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return InfoPage(6);
                    }));
                  },
                  title: Center(child: Text("About the App")),
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              model.college,
              maxLines: 2,
            ),
            // automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.amber,
                  padding: EdgeInsets.all(_height * 0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_height * 0.04),
                  ),
                  child: Text("Complete Website Payment"),
                  onPressed: () {
                    return Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CompleteOnlinePaymentPage();
                    }));
                  },
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                RaisedButton(
                  color: Colors.lightGreen,
                  padding: EdgeInsets.all(_height * 0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_height * 0.04),
                  ),
                  child: Text("New Interest"),
                  onPressed: () {
                    return Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return InterestPage();
                    }));
                  },
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                RaisedButton(
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(_height * 0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_height * 0.04),
                  ),
                  child: Text("New Registration"),
                  onPressed: () {
                    return Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return OptionPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                RaisedButton(
                  color: Colors.limeAccent,
                  padding: EdgeInsets.all(_height * 0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_height * 0.04),
                  ),
                  child: Text("Complete App Payment"),
                  onPressed: () {
                    return Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CompletePaymentPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(_height * 0.01),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_height * 0.01),
                  ),
                  child: Text("Change College"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CollegePage();
                    }));
                  },
                ),
                model.isLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(_height * 0.01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_height * 0.01),
                        ),
                        child: Text("Sign Out"),
                        onPressed: () {
                          model.signOut().then((value) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return LoginPage();
                            }));
                          });
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
