import 'package:avalon_member/models/registration.dart';
import 'package:avalon_member/pages/member.dart';
import 'package:avalon_member/scoped-models/registrations.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:scoped_model/scoped_model.dart';

enum Category { category1, category2, category3 }

class OptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OptionPageState();
  }
}

class _OptionPageState extends State<OptionPage> {
  int _members = 1;
  String leaderName;
  String leaderEmail;
  String leaderPhone;
  String altEmail;
  String altPhone;
  String teamName;
  FocusNode _teamNameFocusNode = FocusNode();
  FocusNode _leaderNameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _altPhoneFocusNode = FocusNode();
  FocusNode _altEmailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _category = "COMPS/IT";

  void _showDialog(RegistrationModel model, Team team) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Details"),
          content: Column(
            children: <Widget>[
              Expanded(child: new Text("Team Name: " + team.teamName)),
              Expanded(child: Text("Leader Name: " + team.leaderName)),
              Expanded(child: Text("Leader Email: " + team.leaderEmail)),
              Expanded(child: Text("Leader Phone: " + team.leaderPhone)),
              Expanded(child: Text("Member Count: " + team.memNum.toString())),
              Expanded(child: Text("Competition: " + team.competition)),
              Expanded(child: Text("Category: " + team.category.toString())),
              Expanded(child: Text("Paying: Rs." + team.paid.toString())),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Confirm!"),
              onPressed: () {
                model.createTeam(team).then((value) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MemberPage(_members, model.newReg, value);
                  }));
                });
              },
            ),
            FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future submit(RegistrationModel model, String competition, int paid,
      int expected) async {
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      _formKey.currentState.save();
      Team team = Team(
          teamName: teamName,
          paid: paid,
          memNum: _members,
          leaderName: leaderName,
          leaderEmail: leaderEmail,
          leaderPhone: leaderPhone,
          altEmail: altEmail,
          altPhone: altPhone,
          competition: competition,
          category: _category.toString(),
          expected: expected,
          pending: expected - paid);
      _showDialog(model, team);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    int costTPP = 400 + 50 * (_members - 3);
    if (costTPP <= 400) {
      costTPP = 400;
    }
    int costPRO = 600 + 50 * (_members - 4);
    if (costPRO <= 600) {
      costPRO = 600;
    }

    return ScopedModelDescendant<RegistrationModel>(
      builder: (BuildContext context, Widget child, RegistrationModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Details"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(labelText: "Team Name"),
                        focusNode: _teamNameFocusNode,
                        validator: (String value) {
                          if (value.isEmpty && value.length <= 5) {
                            return "The name is not valid";
                          }
                        },
                        onSaved: (String value) {
                          setState(() {
                            teamName = value;
                          });
                        },
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: _members,
                      minValue: 1,
                      maxValue: 8,
                      onChanged: (newValue) =>
                          setState(() => _members = newValue),
                    ),
                    Text(
                      "Number of members",
                      textScaleFactor: 2.0,
                    ),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(labelText: "Leader Name"),
                        focusNode: _leaderNameFocusNode,
                        validator: (String value) {
                          if (value.isEmpty && value.length <= 5) {
                            return "The name is not valid";
                          }
                        },
                        onSaved: (String value) {
                          setState(() {
                            leaderName = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Leader E-Mail"),
                        focusNode: _emailFocusNode,
                        validator: (String value) {
                          if (value.isEmpty ||
                              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                        },
                        onSaved: (String value) {
                          setState(() {
                            leaderEmail = value.trim();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: "Leader Phone"),
                          focusNode: _phoneFocusNode,
                          validator: (String value) {
                            if (value.isEmpty || value.length != 10) {
                              return "Please enter a valid phone number";
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              leaderPhone = value.trim();
                            });
                          }),
                    ),
                    _members > 1
                        ? Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: "Alternate E-Mail"),
                                  focusNode: _altEmailFocusNode,
                                  validator: (String value) {
                                    if (value.isEmpty ||
                                        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                            .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                  },
                                  onSaved: (String value) {
                                    setState(() {
                                      altEmail = value.trim();
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "Alternate Phone"),
                                    focusNode: _altPhoneFocusNode,
                                    validator: (String value) {
                                      if (value.isEmpty || value.length != 10) {
                                        return "Please enter a valid phone number";
                                      }
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        altPhone = value.trim();
                                      });
                                    }),
                              ),
                            ],
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Radio(
                                  onChanged: (String value) {
                                    setState(() {
                                      _category = value;
                                    });
                                  },
                                  value: "COMPS/IT",
                                  groupValue: _category,
                                ),
                                Text("COMPS/IT"),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  onChanged: (String value) {
                                    setState(() {
                                      _category = value;
                                    });
                                  },
                                  value: "ELEX/EXTC",
                                  groupValue: _category,
                                  //title:
                                ),
                                Text("ELEX/EXTC"),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  onChanged: (String value) {
                                    setState(() {
                                      _category = value;
                                    });
                                  },
                                  value: "MECH/MTRX/CIVIL",
                                  groupValue: _category,
                                  //title:
                                ),
                                Text("MECH/MTRX/CIVIL"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    model.isLoading
                        ? CircularProgressIndicator()
                        : Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "TPP: ",
                                        textScaleFactor: 1.5,
                                      ),
                                      SizedBox(
                                        width: _width * 0.05,
                                      ),
                                      RaisedButton(
                                        padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text("Rs. 50"),
                                        onPressed: () {
                                          submit(model, 'TPP', 50, costTPP);
                                        },
                                      ),
                                      SizedBox(
                                        width: _width * 0.05,
                                      ),
                                      RaisedButton(
                                        padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child:
                                            Text("Rs. " + costTPP.toString()),
                                        onPressed: () {
                                          submit(
                                              model, 'TPP', costTPP, costTPP);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.05,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Proj: ",
                                        textScaleFactor: 1.5,
                                      ),
                                      SizedBox(
                                        width: _width * 0.05,
                                      ),
                                      RaisedButton(
                                        padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text("Rs. 60"),
                                        onPressed: () {
                                          submit(model, 'PROJ', 60, costPRO);
                                        },
                                      ),
                                      SizedBox(
                                        width: _width * 0.05,
                                      ),
                                      RaisedButton(
                                        padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child:
                                            Text("Rs. " + costPRO.toString()),
                                        onPressed: () {
                                          submit(
                                              model, 'PROJ', costPRO, costPRO);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
