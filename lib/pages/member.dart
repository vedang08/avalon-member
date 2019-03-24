import 'package:avalon_member/pages/first.dart';
import 'package:avalon_member/scoped-models/registrations.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MemberPage extends StatefulWidget {
  final int memNo;
  final String teamName;
  final String regNo;
  MemberPage(this.memNo, this.teamName, this.regNo);
  @override
  State<StatefulWidget> createState() {
    return _MemberPageState();
  }
}

class _MemberPageState extends State<MemberPage> {
  List<TextEditingController> controllers = List();
  List<String> members = List();
  final _formKey = GlobalKey<FormState>();
  Widget _buildSubmitButton(RegistrationModel model) {
    if (model.isLoading) {
      return CircularProgressIndicator();
    } else {
      return RaisedButton(
          child: Text("Submit"),
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            } else {
              _formKey.currentState.save();
              model.addMembers(members).then((value) {
                if (value) {
                  _showDialog(model);
                }
              });
            }
          });
    }
  }

  void _showDialog(RegistrationModel model) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(model.newReg),
          content: new Text("Note this registration number: " +
              model.newReg +
              "\nEnsure its written on the reciept"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes, its done!"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return FirstPage();
                }));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMemberList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: this.widget.memNo - 1,
      itemBuilder: (BuildContext context, int i) {
        controllers.add(TextEditingController());
        return _buildMember(i);
      },
    );
  }

  Widget _buildMember(int i) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Center(
            child: Text(
          "Member " + (i + 2).toString(),
          textScaleFactor: 1.5,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: "Name"),
            controller: controllers[i],
            validator: (String value) {
              if (value.isEmpty && value.length <= 5) {
                return "The name is not valid";
              }
            },
            onSaved: (String value) {
              setState(() {
                members.add(value);
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RegistrationModel>(
      builder: (BuildContext context, Widget child, RegistrationModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.newReg == null
                ? "Loading..."
                : model.newReg.toString()),
          ),
          body: Center(
            child: this.widget.memNo < 2
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        model.newReg.toString() == null
                            ? CircularProgressIndicator()
                            : Text(
                                "Registration Number is " +
                                    model.newReg.toString(),
                                textScaleFactor: 1.5,
                              ),
                        RaisedButton(
                          child: Text("Noted"),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return FirstPage();
                            }));
                          },
                        )
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                _buildMemberList(),
                                _buildSubmitButton(model),
                              ],
                            ),
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
