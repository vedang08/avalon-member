import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:scoped_model/scoped_model.dart';
import '../database.dart';
import '../models/registration.dart';
import 'package:http/http.dart' as http;

class RegistrationModel extends Model {
  FirebaseUser loggedInUser;
  DataBase dataBase;
  final databaseReference = FirebaseDatabase.instance.reference();
  bool isLoading = false;
  String newReg;
  bool isAuthenticated = false;
  String name;
  String college;
  Map<dynamic, dynamic> registration;
  String email;
  final List<String> listOMails = [
    'vedangnaik007@gmail.com',
    "kamath797@gmail.com",
    "tanvibane099@gmail.com",
    "gaikwadpooja225@gmail.com",
    "adityakul1999@gmail.com",
    "saurabhharad111@gmail.com",
    "adwaitpatil1199@gmail.com",
    "shree.meher11@gmail.com",
    "vinayak4work@gmail.com",
    "poojamdhade10@gmail.com",
    "samruddhimhatre15@gmail.com",
    "akshatachandure23@gmail.com",
    "vidularaje@gmail.com",
    "surajgosavi841998@gmail.com",
    "nikitamhamane026@gmail.com",
    "sukanth.kotian@gmail.com",
    "ameyash99@gmail.com",
    "knarksd@gmail.com",
    "atharvakawale@gmail.com",
    "rahulthorat2599@gmail.com",
    "saurabhmasurkar13@gmail.com",
    "hemangibhoir78@gmail.com",
    "sayalishelke5600@gmail.com",
    "sonalsawant027@gmail.com",
    "jayeshkathwal@gmail.com",
    "verma.apurv224@gmail.com",
    "ankit040998@gmail.com",
    "nehathube19@gmail.com",
    "vp97859@gmail.com",
    "sejalrai13@gmail.com",
    "ketankp06@gmail.com",
    "shamallatkar@gmail.com",
    "abbasirizwan916@gmail.com",
    "9961ashyadav@gmail.com",
    "monalizap14@gmail.com",
    "subha26chem@gmail.com",
    "rutuwarya204@gmail.com",
    "ruchiravaity@gmail.com",
    "shreyalamture123@gmail.com",
    "namratamandekar30@gmail.com",
    "harshachrekar16@gmail.com",
    "mahendrahiwale@gmail.com",
    "sahil.birwadkar@gmail.com",
    "tejaswarishe@gmail.com",
    "purva4542@gmail.com",
    "omkarraut2412@gmail.com",
    "ikshulaj@gmail.com",
    "leenapatil589@gmail.com",
    "rutujafirke123@gmail.com",
    "samysamyukta@gmail.com",
    "pdiresh@gmail.com",
    "jadhavomkar85@gmail.com",
    "paraggurav998@gmail.com",
    "asmorye@gmail.com",
    "anushkamestry29@gmail.com",
    "pandeyprathmaesh725@gmail.com",
    "rupal.kaldate@gmail.com",
    "harshal21230@gmail.com",
    "poddarshivani1980@gmail.com",
    "roshninair02@gmail.com",
    "rammanish723@gmail.com",
    "sahil11panindre@gmail.com",
    "rajburundkar@gmail.com",
    "sagarsanil17@gmail.com",
    "sandra.a.nair@gmail.com",
    "vivekodubey1999@gmail.com",
    "vy35250@gmail.com",
    "vcsonawane99@gmail.com",
    "smgingram94@gmail.com",
    "pranayrane8@gmail.com",
    "surbhi.dhar9@gmail.com",
    "anishangane@gmail.com",
    "haraneashish1999@gmail.com",
    "prateekpk0610@gmail.com",
    "saurabhdaware99@gmail.com",
    "satyajithn99@gmail.com",
    "subhambre3@gmail.com",
    "sanketk5199@gmail.com",
    "kirtunambiar@gmail.com",
    "sakshi.kale1999@gmail.com",
    "sam241099@gmail.com",
  ];
  Future<bool> login() async {
    isLoading = true;
    notifyListeners();
    DataBase _dataBase = DataBase();
    this.dataBase = _dataBase;
    FirebaseUser user = await dataBase.signIn();
    this.loggedInUser = user;
    name = user.providerData[1].displayName.trim().toLowerCase();
    email = user.providerData[1].email.trim().toLowerCase();
    this.isAuthenticated = listOMails.contains(email);
    if (!this.isAuthenticated) {
      signOut();
      isLoading = false;
      notifyListeners();
      return false;
    }
    isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> signOut() async {
    isLoading = true;
    notifyListeners();
    dataBase.signOut();
    isAuthenticated = false;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> interestAdd(Map<String, dynamic> interestMap) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> interestData = {
      'name': interestMap['name'],
      'email': interestMap['email'],
      'phone': interestMap['phone'],
      'category': interestMap['category'],
      'year': interestMap['year'],
      'college': college
    };
    try {
      var x = databaseReference.child("interests").push();
      x.set(interestData);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<String> createTeam(Team team) async {
    isLoading = true;
    notifyListeners();
    String currCat;
    newReg = null;
    try {
      if (team.competition == "TPP") {
        currCat = "TPP";
      } else {
        currCat = "PROJ";
      }
      DataSnapshot snapshot = await databaseReference
          .child("registrations")
          .child(currCat)
          .orderByChild('timestamp')
          .limitToLast(1)
          .once();
      final value = snapshot.value as Map;
      if (value == null) {
        if (currCat == "TPP") {
          newReg = "OFT1";
        } else {
          newReg = "OFP1";
        }
      } else {
        String lastkey = value.keys.first;
        Map<dynamic, dynamic> lastEntry = value[lastkey];
        String regNo = lastEntry["number"];
        int number = int.parse(regNo.substring(3));
        number = number + 1;
        if (currCat == "TPP") {
          newReg = "OFT" + number.toString();
        } else {
          newReg = "OFP" + number.toString();
        }
      }
      databaseReference
          .child("registrations")
          .child(currCat)
          .child(newReg)
          .set({
        'teamName': team.teamName,
        'memNum': team.memNum,
        'paid': team.paid,
        'competition': team.competition,
        'category': team.category,
        'leaderName': team.leaderName,
        'leaderEmail': team.leaderEmail,
        'leaderPhone': team.leaderPhone,
        'altEmail': team.altEmail,
        'altPhone': team.altPhone,
        'timestamp': ServerValue.timestamp,
        'number': newReg,
        'avalonMember': name,
        'college': college,
        'closed': false,
        'expected': team.expected,
        'pending': team.pending
      });
      http.post(
          "https://us-central1-avln19.cloudfunctions.net/app/send-email-confirmation",
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "email": team.leaderEmail,
            "teamname": team.teamName,
            "leadername": team.leaderName,
            "competition": team.competition == "TPP" ? "tpp" : "project",
            "registrationId": newReg
          }));
      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
    return newReg;
  }

  Future<bool> addMembers(List<String> members) async {
    isLoading = true;
    notifyListeners();
    String cat = "PROJ";
    try {
      int i;
      if (newReg.contains("T")) {
        cat = "TPP";
      }
      for (i = 0; i < members.length; i++) {
        databaseReference
            .child("registrations")
            .child(cat)
            .child(newReg)
            .child("members")
            .child((i + 2).toString())
            .set({'name': members[i]});
      }
      isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getPending(String regNo) async {
    isLoading = true;
    notifyListeners();
    try {
      if (regNo.contains("T")) {
        databaseReference
            .child("registrations")
            .child("TPP")
            .child(regNo)
            .once()
            .then((DataSnapshot snapshot) {
          registration = snapshot.value;
        });
      } else {
        databaseReference
            .child("registrations")
            .child("PROJ")
            .child(regNo)
            .once()
            .then((DataSnapshot snapshot) {
          registration = snapshot.value;
        });
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> completePayment(String regNo) async {
    isLoading = true;
    notifyListeners();
    String currCat;
    if (regNo.contains("T")) {
      currCat = "TPP";
    } else {
      currCat = "PROJ";
    }
    try {
      databaseReference
          .child("registrations")
          .child(currCat)
          .child(regNo)
          .child('pending')
          .set(0);
      databaseReference
          .child("registrations")
          .child(currCat)
          .child(regNo)
          .child('closed')
          .set(false);
      databaseReference
          .child("registrations")
          .child(currCat)
          .child(regNo)
          .child("avalonMember")
          .set(name);
      databaseReference
          .child("registrations")
          .child(currCat)
          .child(regNo)
          .child('paid')
          .set(registration['pending']);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getPendingOnline(String teamName) async {
    isLoading = true;
    notifyListeners();
    try {
      databaseReference
          .child("users")
          .child(teamName)
          .once()
          .then((DataSnapshot snapshot) {
        registration = snapshot.value;
        print(registration);
      });
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> completeOnlinePayment(String teamName, int paid) async {
    isLoading = true;
    notifyListeners();
    try {
      databaseReference.child("users").child(teamName).child('paid').set(paid);
      databaseReference
          .child("users")
          .child(teamName)
          .child('closed')
          .set(false);
      databaseReference
          .child("users")
          .child(teamName)
          .child("avalonMember")
          .set(name);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
