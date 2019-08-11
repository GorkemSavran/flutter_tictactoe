import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int gameCounter = 0;
  List<List<String>> _xo = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];
  String currentPlayer = "X";
  bool isFinished = false;

  void _tap(int subList, int idx) {
    setState(() {
      gameCounter = 0;
      if (currentPlayer == "O") {
        _xo[subList][idx] = "O";
        currentPlayer = "X";
      } else {
        _xo[subList][idx] = "X";
        currentPlayer = "O";
      }
      for (var subList in _xo) {
        for (var e in subList) {
          if (e == "X" || e == "O") {
            gameCounter++;
          }
        }
      }
    });
    String checked = check();
    if (isFinished) {
      _showFinishedDialog("You must click the button");
    } else if (checked == "X" || checked == "O") {
      _showFinishedDialog(checked);
    } else if (gameCounter == 9) {
      _showFinishedDialog("No winner");
    }
  }

  String check() {
    //vertical
    for (var i = 0; i < 3; i++) {
      if (equals3(_xo[0][i], _xo[1][i], _xo[2][i])) {
        return diverseCurrentPlayer(currentPlayer);
      }
    }
    for (var i = 0; i < 3; i++) {
      if (equals3(_xo[i][0], _xo[i][1], _xo[i][2])) {
        return diverseCurrentPlayer(currentPlayer);
      }
    }

    if (equals3(_xo[0][0], _xo[1][1], _xo[2][2])) {
      return diverseCurrentPlayer(currentPlayer);
    }

    if (equals3(_xo[0][2], _xo[1][1], _xo[2][0])) {
      return diverseCurrentPlayer(currentPlayer);
    }

    return "";
  }

  String diverseCurrentPlayer(String currentPlayer) {
    if (currentPlayer == "X") return "O";
    return "X";
  }

  bool equals3(String a, String b, String c) {
    if (a == b && b == c && a == c && a != "") {
      return true;
    }
    return false;
  }

  void _showFinishedDialog(String winner) {
    setState(() {
      isFinished = true;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: winner == "No winner"
                ? Text("There is no winner")
                : winner == "You must click the button"
                    ? Text("You must click the button")
                    : Text("${winner} is winner"),
            content: Text("Click button to play again!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Try Again"),
                onPressed: () {
                  _reset();
                  setState(() {
                    isFinished = false;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _reset() {
    setState(() {
      currentPlayer = "X";
      gameCounter = 0;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          _xo[i][j] = "";
        }
      }
    });
  }

  Widget _box(int a, int b) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Text(
              "${_xo[a][b]}",
              textScaleFactor: 10,
            ),
          ),
          onTap: () => _tap(a, b),
        ));
  }

  Widget _verticalDivider() {
    return VerticalDivider(
      color: Colors.black,
      width: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Tic Tac Toe"),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  _box(0, 0),
                  _verticalDivider(),
                  _box(0, 1),
                  _verticalDivider(),
                  _box(0, 2)
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 5,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  _box(1, 0),
                  _verticalDivider(),
                  _box(1, 1),
                  _verticalDivider(),
                  _box(1, 2)
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 5,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  _box(2, 0),
                  _verticalDivider(),
                  _box(2, 1),
                  _verticalDivider(),
                  _box(2, 2)
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 5,
            ),
            Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Text("${currentPlayer} is playing"),
                ))
          ],
        ));
  }
}
