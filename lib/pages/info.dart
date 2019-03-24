import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final int type;
  InfoPage(this.type);
  Widget _buildInfo(int type) {
    String info;
    if (type == 1) {
      info =
          "Avalon:\n\n\nAvalon is the annual TechFest of Terna and will be held on 5th and 6th March. It will provide students from various fields a chance to show their technical skills. Avalon, for the past many years has had participants from various parts of the country, from some of the best colleges. Participating in a national level event like Avalon is a great way for you to boost your career.";
    } else if (type == 2) {
      info =
          "Technical Paper Presentation:\n\n\nParticipate in Avalon’s Technical Paper Presentation and boost your CV! Presenting a paper will not just help you get placed but also strengthen your professional experience. Writing a paper and presenting it will always help you to learn more about your areas of expertise and you might as well learn a new skill. It’s not only about learning, you’ll also enjoy the process because it’s fun to present and share knowledge. Above all, it make your CV look good!";
    } else if (type == 3) {
      info =
          "Project Competition:\n\n\nA national level project competition for any branch any topic. Gear up your innovative skills and put them to use. Showcase your project to your peers and get a chance to win exciting prizes and certificates";
    } else if (type == 4) {
      info =
          "Basic Requirements that we will provide to the participants of project competition\n\n\n\nWi-Fi\nTables\nChairs\nExtension box\nElectric boxes";
    } else if (type == 5) {
      info =
          "Publicity Guidelines:\n\n\n\n- Emphasize that Avalon is a National level technical fest.\n\n- Ask direct second year students to use their Diploma final year projects for the competition.\n\n- Mention that all the necessary guidelines regarding writing a technical paper and project competition will be provided in the seminars that would  be held on 21st Feb and 22nd Feb for tpp and project presentation, respectively. \n\n- Explain what a technical paper is to students from FE, SE and TE.\n\n- For final year students, mention that the reviews given by the judges on their projects would help them improvise their work as well as they would be able to find loopholes in their projects. This would help them to do well during the final submission of their projects.\n\n- Also, inform them that their papers will be published in IJIIRD , an international journal. Publishing a paper would give them an edge over the other students during recruitment. And it would also be helpful for people who are going for higher education.\n\n- If they say their projects won't be ready till the competition dates, suggest them to make a technical paper on the same topic.\n\n- Try to impart confidence in the FE and SE students by explaining each and everything in detail , offering help and being cooperative.\n\n- Show them Avalon's website in your phone , explaining  how to register for tpp and project .\n\n- Explain the categories , number of members and fees explicitly .\n\n- Handover the rulebook and information booklet for them to read incase they want more details.\n\n- Try to get the contacts of HODs of each department and the council memebers(preferably technical secretary).\n\n- Inform your friends and colleagues about Avalon .";
    } else {
      info =
          "This is the offical administration app for Avalon 2019. The uses of various buttons are listed below:\n\n\nComplete Website Payment:\nThis option is to complete the payments of registrations made on the website and website only and requires the team name\n\nNew Interest:\nIf a student is interested in taking part but is not wiling to pay at the moment, this should be used to collect basic data about him/her so that he/she can pursued later\n\nNew Registration:\nWhile getting the registration, please ensure that you click on the button that represents the correct category and the amount being paid, since this cannot be undone\n\nComplete App Payment:\nThis is to complete the payments for the registrations that were done through the app only\n\nRegistrations that are not done through the app are invalid!\n\n\nYour Friendly Neighbourhood - Vean";
    }
    return Container(
        margin: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Center(
            child: Text(
              info,
              textScaleFactor: 1.5,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
      ),
      body: _buildInfo(type),
    );
  }
}
