class Team {
  String number;
  int memNum;
  int paid;
  String avalonMember;
  String competition;
  String category;
  String leaderName;
  String leaderEmail;
  String leaderPhone;
  String altEmail;
  String altPhone;
  String teamName;
  String members;
  bool closed;
  int expected;
  int pending;
  String college;
  Team(
      {this.teamName,
      this.category,
      this.competition,
      this.leaderName,
      this.leaderEmail,
      this.leaderPhone,
      this.altEmail,
      this.altPhone,
      this.memNum,
      this.number,
      this.paid,
      this.members,
      this.closed,
      this.expected,
      this.pending,
      this.avalonMember,
      this.college});
}

class Member {
  String name;
  String team;
  Member({this.name, this.team});
}
