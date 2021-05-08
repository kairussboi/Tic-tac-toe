import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/pages/home_page.dart';
import 'winner_page.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

List<String> text = [
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
];
int plays = 0;

class _GamePageState extends State<GamePage> {
  Random rng = new Random();

  textStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: "Poppins",
      color: white,
    );
  }

  ongoBack(dynamic value) {
    Navigator.pop(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  // check who won and navigate to that screen
  void winnerAlert(String winner) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WinnerPage(winner),
      ),
    ).then(ongoBack);
  }

  void play(int index, bool isPlayer) {
    if (isPlayer) {
      if (text[index] == "") {
        setState(() {
          plays++;
          text[index] = "X";
        });
      }
      if (plays == 9) {
        winnerAlert("tie");
      }
      if (winCheck()) {
        winnerAlert("You");
      }
      // calling botPlay so that the game can continue
      // also checking for tiebreaker
      if (!winCheck() && plays < 9) {
        botPlay();
      }
    } else {
      // here only the bot can come in.
      // same check if the box isnt already taken. then changing text of index to "O"
      if (text[index] == "") {
        setState(() {
          plays++;
          text[index] = "O";
        });
      }
      if (plays == 9) {
        winnerAlert("tie");
      }
      if (winCheck()) {
        winnerAlert("Computer");
      }
    }
  }

  void botPlay() {
    // this function makes a random number using the nextInt function of Random class.
    int randomIndex = rng.nextInt(8);
    if (text[randomIndex] != "") {
      botPlay();
    } else {
      play(randomIndex, false);
    }
  }

  bool winCheck() {
    // 012
    if (text[0] != "" && text[0] == text[1] && text[1] == text[2]) {
      return true;
    }
    // 345
    else if (text[3] != "" && text[3] == text[4] && text[4] == text[5]) {
      return true;
    }
    // 678
    else if (text[6] != "" && text[6] == text[7] && text[7] == text[8]) {
      return true;
    }
    // 036
    else if (text[0] != "" && text[0] == text[3] && text[3] == text[6]) {
      return true;
    }
    // 147
    else if (text[1] != "" && text[1] == text[4] && text[4] == text[7]) {
      return true;
    }
    // 258
    else if (text[2] != "" && text[2] == text[5] && text[5] == text[8]) {
      return true;
    }
    // 048
    else if (text[0] != "" && text[0] == text[4] && text[4] == text[8]) {
      return true;
    }
    // 246
    else if (text[2] != "" && text[2] == text[4] && text[4] == text[6]) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold so that there is place for appbar etc.
    return Scaffold(
      // stack so that we can place more than 1 item in the body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),

          Container(
            child: Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(3.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: 9,
                itemBuilder: (context, i) => SizedBox(
                  child: TextButton(
                    onPressed: () {
                      if (text[i] == "") play(i, true);
                    },
                    child: Text(
                      text[i],
                      style: textStyle(50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // the text to show what character the player is
          Text(
            "You are: X",
            style: textStyle(25),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Developed by SoulNinja#7777",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white30,
            ),
          ),
        ],
      ),
      backgroundColor: bg,
      // app bar to show some info
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: bg,
        title: Text(
          "Tic Tac Toe",
          style: textStyle(25),
        ),
        centerTitle: true,
      ),
    );
  }
}
