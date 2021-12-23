import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'D20 ';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<int> top = <int>[];
  List<int> bottom = <int>[0];
  int max = 20;
  String task = 'Click the button and find out!';
  var powerUps = ['', '', '', '', '', ''];
  var yourUps = '';
  var num = 0;
  var index = 0;
  var history = [];
  var turn = 0;
  var display = [
    '''Hello there! Good day! Welcome! Salutations! Top of the mornin! Top of the mornin! Top of the mornin! 
                          So this game is pretty simple: roll the dice up there to the left, I'll tell you to do something, you do it. 
                          The game ends when all numbers have been rolled. 
                          Goodluck and have fun!'''
  ];
  var colors = [Colors.tealAccent[400], Colors.blueGrey[800]];
  var rolls = List<int>.generate(20, (i) => i + 1);
  var list = List<int>.generate(20, (i) => i + 1);
  var tasks = {
    1: 'Finish your drink then tell us an embarrasing secret',
    2: 'Take 2 shots- double critical failure :(',
    3: 'Take 3 shots! Jk swap shirts with someone or shotgun an alcohol- if youre high voicing you have to lick the floor ',
    4: 'Next three turns you have to do double the number of drinks',
    5: 'Give a hot take - if everyone or no one agrees you have to take a shot',
    6: 'Coin stop- if you fail do 10 sit ups, else give someone 1 shot',
    7: 'Change the song to anything you want- if it sucks by unanimous decision you take a shot',
    8: 'Everyone nominate a person to drink 3 times- ties mean all winners drink',
    9: 'Three flip cups in 15 seconds of take 5 sips',
    10: 'Rock Paper Scissors with a person to your right- loser takes a shot of the winners choice',
    11: 'Get a new drink and everyone must drink your old drink',
    12: 'Donkey Balls - loser takes a shot',
    13: 'Categories- loser takes a shot',
    14: 'Ask a trivia question to the person to your right- if they get it right you drink, else they drink',
    15: 'Truth or Die - if you die finish your drink',
    16: 'Tell us a joke- if no one laughs you leave... or your take 10 drinks',
    17: 'Drink half the drinks the next three turns',
    18: 'Substitution Jutsu! Swap any future turn with the person to your right',
    19: 'Free space- Kara gives you a cracker/ pretzal',
    20: 'OJs Immunity! Negate one future task',
  };

  void checkDone() {
    if (list.isEmpty) {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Thanks bro"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Congraddddulations!"),
      content: const Text(
          "You have traveled through the forest and across the river styx. Well done sir of madame. Goodulck in your travels."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roll the Dice!'),
        leading: IconButton(
          icon: const Icon(Icons.gamepad),
          onPressed: () {
            setState(() {
              index++;
              bottom.add(bottom.length);
              debugPrint('bottom: $bottom roll: ');
              num = rolls[Random().nextInt(rolls.length)];
              history.add(num);
              turn = history.length % 4;
              task = tasks[num].toString();
              if (list.contains(num)) {
                list.remove(num);
                checkDone();
              }
              if (num == 4 || num == 17 || num == 18 || num == 20) {
                powerUps[turn] += task + '\n';
              }

              var hits = history.where((element) => element == num);
              if (hits.length == 5) {
                rolls.remove(num);
              }
              display.add('''Roll# $index
                          Hello Player $turn
                          Your role: $num
                          Your task is: $task 
                          Your power-ups are: $yourUps
                          Your potential rolls: $rolls 
                          Numbers Remaining: $list''');
            });
          },
        ),
      ),
      body: CustomScrollView(
        center: centerKey, //centers on the centerkey
        slivers: <Widget>[
          SliverList(
            key: centerKey, //I have the centerkey and I am king
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //for loop to make stuff
                return Container(
                  alignment: Alignment.center,
                  color: Colors.blue[200 + top[index] % 4 * 100],
                  height: 100 + top[index] % 4 * 20.0,
                  child: Text('Roll: ${top[index]}'),
                );
              },
              childCount: top.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  color: index % 2 == 1 ? colors[0] : colors[1],
                  height: index == 0 ? 100 : 200,
                  child: index == 0
                      ? Text(display[index],
                          style: const TextStyle(
                              fontSize: 16, color: Colors.lightBlueAccent))
                      : index % 2 == 1
                          ? Text(display[index],
                              style: const TextStyle(color: Colors.black))
                          : Text(display[index],
                              style: const TextStyle(color: Colors.white)),
                );
              },
              childCount: bottom.length,
            ),
          ),
        ],
      ),
    );
  }
}
