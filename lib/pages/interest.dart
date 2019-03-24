import 'package:avalon_member/pages/first.dart';
import 'package:avalon_member/scoped-models/registrations.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class InterestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InterestPageState();
  }
}

class _InterestPageState extends State<InterestPage> {
  bool loading = false;
  String name;
  String email;
  String phone;
  String year = "-";
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _mailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _category = "none";
  List<String> years = [
    "-",
    "Diploma",
    "FE",
    "SE",
    "TE",
    "BE",
  ];
  List<DropdownMenuItem> dropDownMenuItem = [];
  Widget _buildDropDownItem({String group}) {
    return DropdownMenuItem(
      child: Text(group),
      value: group.toUpperCase(),
    );
  }

  @override
  void initState() {
    super.initState();
    dropDownMenuItem = List.generate(years.length, (i) {
      return _buildDropDownItem(group: years[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RegistrationModel>(
      builder: (BuildContext context, Widget child, RegistrationModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("New Interest"),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(labelText: "Name"),
                            focusNode: _nameFocusNode,
                            validator: (String value) {
                              if (value.isEmpty && value.length <= 5) {
                                return "The name is not valid";
                              }
                            },
                            onSaved: (String value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(labelText: "E-Mail"),
                            focusNode: _mailFocusNode,
                            validator: (String value) {
                              if (value.isEmpty ||
                                  !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                            },
                            onSaved: (String value) {
                              setState(() {
                                email = value.trim();
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: "Phone"),
                              focusNode: _phoneFocusNode,
                              validator: (String value) {
                                if (value.isEmpty || value.length != 10) {
                                  return "Please enter a valid phone number";
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  phone = value.trim();
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                hasFloatingPlaceholder: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                labelText: 'Year'),
                            value: year,
                            onChanged: (value) {
                              setState(() {
                                year = value;
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                year = value;
                              });
                            },
                            items: dropDownMenuItem,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Radio(
                                  onChanged: (String value) {
                                    setState(() {
                                      _category = value;
                                    });
                                  },
                                  value: "none",
                                  groupValue: _category,
                                ),
                                Text("None"),
                                Radio(
                                  onChanged: (String value) {
                                    setState(() {
                                      _category = value;
                                    });
                                  },
                                  value: "tpp",
                                  groupValue: _category,
                                  //title:
                                ),
                                Text("TPP"),
                                Radio(
                                  onChanged: (String value) {
                                    setState(() {
                                      _category = value;
                                    });
                                  },
                                  value: "project",
                                  groupValue: _category,
                                  //title:
                                ),
                                Text("Project"),
                              ],
                            ),
                          ),
                        ),
                        loading
                            ? CircularProgressIndicator()
                            : Builder(
                                builder: (context) {
                                  return RaisedButton(
                                      child: Text("Submit"),
                                      onPressed: () {
                                        if (!_formKey.currentState.validate()) {
                                          return;
                                        } else {
                                          _formKey.currentState.save();
                                          setState(() {
                                            loading = true;
                                          });
                                          Map<String, dynamic> _interestMap = {
                                            'name': name.trim(),
                                            'year': year.trim(),
                                            'email': email.trim(),
                                            'phone': phone.trim(),
                                            'category': _category.trim()
                                          };
                                          model
                                              .interestAdd(_interestMap)
                                              .then((onValue) {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Interest Added"),
                                              action: SnackBarAction(
                                                label: "Go Back",
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                    return FirstPage();
                                                  }));
                                                },
                                              ),
                                            ));
                                            setState(() {
                                              loading = false;
                                            });
                                          });
                                        }
                                      });
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
