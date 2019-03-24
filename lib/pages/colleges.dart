import 'package:avalon_member/pages/first.dart';
import 'package:avalon_member/scoped-models/registrations.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CollegePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CollegePageState();
  }
}

class _CollegePageState extends State<CollegePage> {
  String college;
  Widget collegeList(RegistrationModel model) {
    List<String> colleges = [
      "Terna Engineering College",
      "A.C Patil College of Engineering",
      "Abdul Razzak Kalsekar Polytechnic",
      "Agnel Polytechnic",
      "Atharva College of Engineering",
      "Balasaheb Mhatre Polytechnic",
      "Bharati Vidyapeeth's College of Engineering",
      "Bhartiya Vidya Bhavan's Sardar Patel College of Engineering",
      "Bhartiya vidyapeeth institute of technology ",
      "DATTA MEGHE COLLEGE OF ENGINEERING",
      "Don Bosco Institute of Technology",
      "Dwarkadas J. Sanghvi College of Engineering",
      "Fr. C. Rodrigues Institute of Technology",
      "FR.Conceicao Rodrigues College of Engineering",
      "G.V Acharya Polytechnic",
      "Gokhale Education Society Polytechnic Institute",
      "Government Polytechnic Mumbai",
      "Government Polytechnic Thane",
      "Indian Institute of Technology Bombay",
      "Indira Gandhi College Of Engineering.",
      "Institute of Chemical Technology",
      "K J Somaiya Institute  of Engineering and Information Technology ",
      "K. J. Somaiya College of Engineering",
      "K.C College of Engineering",
      "Konkan Gyanpeeth College Of Engineering",
      "L&T institute of technology",
      "Lokmanya Tilak College of Engineering",
      "M.H. Saboo Siddik College of Engineering",
      "Matoshree Maniben J Shah Polytechnic",
      "MGM's College of Engineering and Technology",
      "Muchhala Polytechnic",
      "Padmabhushan Vasantdada Patil Pratishthan's College of Engineering",
      "Padmashree.Dr.D.Y.Patil Polytechnic Institute",
      "Parshvanath College of Engineering",
      "Pillai College of  Engineering",
      "Pillai polytechnic",
      "Pravin patil college of diploma engineering and technology",
      "RAJIV GANDHI INSTITUTE OF TECHNOLOGY",
      "Ramrao Adik Institute of Technology",
      "Rizvi College of Engineering",
      "S.H Jondhale polytechnic",
      "S.I.E.S Graduate School of Technology ",
      "Saraswati College of Engineering",
      "Sardar Patel Institue of Technology",
      "Shah & Anchor Kutchhi Engineering College",
      "Shah and Anchor Kutchhi Polytechnic",
      "Shivajirao S. Jondhale College of Engineering",
      "ST. FRANCIS INSTITUTE OF TECHNOLOGY (ENGG. COLLEGE)",
      "St.john college of engineering and technology",      
      "Thadomal Shahani Engineering College",
      "Thakur college of Engineering and Technology",
      "Thakur Polytechnic",
      "Universal College of Engineering",
      "Usha Mittal Institute of Technology",
      "Veermata Jijabai Technological Institute",
      "Vidya Prasarak Mandal's Polytechnic",
      "Vidyalankar Institute of Technology ",
      "Vidyalankar Polytechnic",
      "vidyavardini's college of Engineering",
      "Vivekanand Education Society’s Institute of Technology",
      "Vivekanand educations society's polytechnic",
      "Watumall Institute of Electronics Engineering &Computer Technology",
      "Xavier Institute of Engineering ",
      "Yadavrao Tasgaonkar College Of Engineering & Management",
    ];
    return ListView.builder(
      itemCount: colleges.length,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          child: Row(
            children: <Widget>[
              Radio(
                onChanged: (value) {
                  setState(() {
                    college = value;
                    model.college = college;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return FirstPage();
                    }));
                  });
                },
                value: colleges[i],
                groupValue: college,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  colleges[i],
                  maxLines: 2,
                ),
              )
            ],
          ),
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
            title: Text("Select Current College"),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            child: collegeList(model),
          ),
        );
      },
    );
  }
}
