import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice20',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'D20: The Game of Champions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // Fields in a Widget subclass are always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int max = 20;
  String task = 'Click the button and find out!';
  var powerUps = ['', '', '', '', '', ''];
  var yourUps = '';
  var num = 0;
  var history = [];
  var histLength = 0;
  var turn = 0;
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

  void buttonPress() {
    setState(() {
      num = rolls[Random().nextInt(rolls.length)];
      history.add(num);
      histLength = history.length;
      turn = (histLength % 4) + 1;
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
    });
  }

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
    // This method is rerun every time setState is called
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Text(
              'Your Number: $num\t',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Your Number: $num\t',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Your Task: $task\t',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Numbers remaining: $list \n',
            ),
            Text(
              'Your Potential rolls: $rolls\n',
            ),
            Text(
              'Turns Taken: $histLength',
            ),
            Text(
              'Whos up? Person #$turn',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Power Ups: $yourUps',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ));
  }

  // floatingActionButton= FloatingActionButton(
  //         onPressed: buttonPress,
  //         tooltip: 'Roll the dice!',
  //         child: const Icon(Icons
  //             .games_sharp)), // This trailing comma makes auto-formatting nicer for build methods.
  //   );
}
