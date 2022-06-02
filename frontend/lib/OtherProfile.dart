import 'package:flutter/material.dart';
import 'package:frontend/models/User.dart';
import 'Database.dart';

class OtherProfile extends StatefulWidget {
  final User mainUser;
  final User user;
  const OtherProfile({required this.mainUser, required this.user, Key? key}) : super(key: key);

  @override
  State<OtherProfile> createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 64.0, 32.0, 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.arrow_back_rounded, size: 24),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    widget.user.username,
                    textScaleFactor: 1.5,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.add, size: 32),
                    onTap: () async { //todo add friend to main user
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        await addFriend(widget.mainUser, widget.user);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added User')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            _otherprofileFields(context)
          ]
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _otherprofileFields(BuildContext context) {
    Column careerinfo = getCareerInfo(widget.user);
    Column populatedFields = buildSubDescription(widget.user);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFebebeb),
                child: Column(
                  children: [
                    Container(
                      height: 35
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://i.imgur.com/BoN9kdC.png")
                          )
                      ),
                    ),
                    Container(
                        height: 5
                    ),
                    Text(widget.user.firstName + " " + widget.user.lastName),
                    careerinfo
                  ],
                ),
              )
            ),
            SizedBox(
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFebebeb),
                child: Column(
                  children: [
                    Container(height: 10),
                    Container(child: populatedFields)
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  Column getCareerInfo(User user){
    List<Text> entries = [];
    if (user.college != ""){
      if (user.major != ""){
        entries.add(Text(widget.user.college + ": " + widget.user.major));
      }
      else{
        entries.add(Text("College: " + widget.user.college));
      }
    }
    else if (user.major != ""){
      entries.add(Text("Major: " + widget.user.major));
    }
    
    if (user.job != ""){
      if (user.job != ""){
        entries.add(Text(widget.user.job + ": " + widget.user.job));
      }
      else{
        entries.add(Text("Job: " + widget.user.job));
      }
    }
    
    Column col = Column(children: entries);
    return col;
  }

  Column buildSubDescription(User user){
    List<Row> entries = [];

    if (user.phoneNumber != ""){
      entries.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: Flexible(
              child: Text("Phone Number: " + widget.user.phoneNumber),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
        ],
      ));
    }

    if (user.bio != ""){
      entries.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: SizedBox(
              width: 250,
              child: Text("\n" + widget.user.bio),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
        ],
      ));
    }
    Column col = Column(children: entries);
    return col;
  }

  Future<void> addFriend(User mainUser, User user) async {
    List<String> mainUserFriends = mainUser.friends;
    mainUserFriends.add(user.username);
    List<String> userFriends = user.friends;
    userFriends.add(mainUser.username);
    mainUser = User(
        location: mainUser.location,
        username: mainUser.username,
        password: mainUser.password,
        firstName: mainUser.firstName,
        lastName: mainUser.lastName,
        phoneNumber: mainUser.phoneNumber,
        bio: mainUser.bio,
        friends: mainUserFriends,
        preferredStatus: mainUser.preferredStatus,
        PFP: mainUser.PFP,
        college: mainUser.college,
        major: mainUser.major,
        job: mainUser.job,
        song: mainUser.song,
        socials: mainUser.socials
    );
    user = User(
        location: user.location,
        username: user.username,
        password: user.password,
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        bio: user.bio,
        friends: userFriends,
        preferredStatus: user.preferredStatus,
        PFP: user.PFP,
        college: user.college,
        major: user.major,
        job: user.job,
        song: user.song,
        socials: user.socials
    );
    await MongoDatabase.update(mainUser);
    await MongoDatabase.update(user);
  }
}
