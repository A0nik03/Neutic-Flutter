import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:neutic/glassmorphism.dart';
import 'package:flutter_glow/flutter_glow.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;
  const GameScreen({super.key, required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];
  List<int> matchedIndexes = [];

  String resultDeclaration = "";
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://w0.peakpx.com/wallpaper/697/811/HD-wallpaper-dark-vertical-anime-girls-artwork-anime-portrait-display.jpg",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          GlassMorphism(
            blur: 15,
            opacity: 0.4,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.player1,
                                style: GoogleFonts.belgrano(
                                    textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                              ),
                              Text(
                                oScore.toString(),
                                style: GoogleFonts.belgrano(
                                    textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(width: 70),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.player2,
                                style: GoogleFonts.belgrano(
                                    textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                              ),
                              Text(
                                xScore.toString(),
                                style: GoogleFonts.belgrano(
                                    textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if(!winnerFound ) {
                                _tapped(index);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 5.0,
                                  ),
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(-8.0, -8.0),
                                    blurRadius: 100.0,
                                    spreadRadius: 5.0,
                                  ),
                                ],
                                color: matchedIndexes.contains(index)
                                    ? Colors.greenAccent.shade400
                                    : Colors.blue.shade900.withOpacity(0.7),
                              ),
                              child: Center(
                                child: GlowText(
                                  softWrap: true,
                                  displayXO[index],
                                  blurRadius: 5,
                                  glowColor: Colors.indigoAccent,
                                  style: GoogleFonts.belgrano(
                                      textStyle: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: GlowText(
                            resultDeclaration,
                            glowColor: Colors.cyanAccent,
                            blurRadius: 5,
                            style: GoogleFonts.belgrano(
                                textStyle: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontStyle: FontStyle.normal,
                            )),
                          ),
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            _clearBoard();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade500.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(8.0, 8.0),
                                      blurRadius: 15.0,
                                      spreadRadius: 5.0,
                                    ),
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(-8.0, -8.0),
                                      blurRadius: 100.0,
                                      spreadRadius: 5.0,
                                    ),
                                  ]),
                              child: Center(
                                child: Text(
                                  "Play Again",
                                  style: GoogleFonts.belgrano(
                                      textStyle: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurStyle: BlurStyle.inner,
                                        blurRadius: 1.0,
                                        spreadRadius: 5.0,
                                      )
                                    ],
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
      setState(() {
        if (oTurn && displayXO[index] == "") {
          displayXO[index] = "O";
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == "") {
          displayXO[index] = "X";
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
  }

  void _checkWinner() {

    //For Tie
    if (filledBoxes == 9) {
      setState(() {
        resultDeclaration = "It's a Tie!";
      });
    }

    //check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]}  Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        _updateScore(displayXO[0]);
      });
    }

    //check for 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[3]}  Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        _updateScore(displayXO[3]);
      });
    }
    //check for 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]}  Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        _updateScore(displayXO[6]);
      });
    }
    //check for 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]}  Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        _updateScore(displayXO[0]);
      });
    }
    //check for 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[1]}  Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        _updateScore(displayXO[1]);
      });
    }
    //check for 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]}  Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        _updateScore(displayXO[2]);
      });
    }
    //check for diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]}  Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        _updateScore(displayXO[0]);
      });
    }
    //check for diagonal
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]}  Wins!';
        matchedIndexes.addAll([2, 4, 6]);
        _updateScore(displayXO[2]);
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == "X") {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = "";
      }
      resultDeclaration = "";
      matchedIndexes = [];
    });
    filledBoxes = 0;
    winnerFound = false;
  }
}
