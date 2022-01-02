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
  String task = 'Click the button and find out!';
  final ScrollController listScrollController = ScrollController();
  var colors = [
    Colors.blueGrey[700],
    Colors.blueGrey[700],
    Colors.lightBlueAccent,
    Colors.black
  ];
  var rolls =
      List<int>.generate(20, (i) => i + 1); //to change num tasks change here
  var list = List<int>.generate(20, (i) => i + 1); //and here
  var powerUps = ['', '', '', '', '', ''];
  var yourUps = '';
  var num = 0;
  var index = 0;
  var history = [];
  var turn = 0;
  /*var display = [
    '''Hello there! Good day! Welcome! Salutations! Top of the mornin! Top of the mornin! Top of the mornin! 
                          So this game is pretty simple: roll the dice up there to the left, I'll tell you to do something, you do it. 
                          The game ends when all numbers have been rolled. 
                          Goodluck and have fun!'''
  ];*/
  var display = [
    <TextSpan>[
      TextSpan(
          text:
              'Hello there! Good day! Welcome! Salutations! Top of the mornin! Top of the mornin! Top of the mornin!',
          style: TextStyle(fontSize: 18, color: Colors.red[200])),
      TextSpan(
          text:
              '\nSo this game is pretty simple: roll the dice up there to the left, I\'ll tell you to do something, you do it.',
          style: TextStyle(fontSize: 18, color: Colors.red[200])),
      const TextSpan(
          text: '\nThe game ends when all numbers have been rolled.',
          style: TextStyle(
            fontSize: 24,
            color: Colors.lightGreenAccent,
          )),
      TextSpan(
          text: '\nGoodluck and have fun!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.red[200],
          ))
    ]
  ];
  var tasks = {
    //and change size here
    1: 'Finish your drink then take another turn, goodluck!',
    2: 'Take 2 shots- double critical failure :(',
    3: 'Take 3 shots! Jk plank until your next turn or take a shot',
    4: 'All bros drink 4 times - easy peasy',
    5: 'All non bros drink 3 times - unequal pay',
    6: 'Give a hot take - if everyone or no one agrees you have to take a shot',
    7: 'The person with the fullest cup take 5 drinks',
    8: 'Everyone nominate a person to drink 3 times- ties mean all winners drink',
    9: 'Choose a victim. Play them in finger game. You decide the amount and you go first.',
    10: 'Rock Paper Scissors with a person to your right- loser takes a shot of the winners choice',
    11: 'Choose a person to drink with you. Play waterfall. ',
    12: 'The team must shotgun a beer. Dont care how its done, what trades are necessary, how many drinkers. Just DO IT.',
    13: 'Categories- loser takes a shot',
    14: 'Ask a question about yourself to the person to your right- loser takes 5 drink',
    15: 'Hot seat - everyone asks you one question, respond or finish your drink (each question)',
    16: 'Tell us a joke- if no one laughs you leave... or your take 10 drinks',
    17: 'Choose a nickname for the rest of the game- if anyone doesn\'t call you that they drink',
    18: 'Substitution Jutsu! Choose someone to tell us a secret about themself or finish their drink',
    19: 'Free space- you get a high five from the person of your choosing',
    20: 'OJs Immunity! You don\'t have to drink until your next turn',
  };
  int max = 20;

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
    const Key bottomKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roll the Dice!'),
        leading: IconButton(
          icon: const Icon(Icons.play_arrow_sharp),
          onPressed: () {
            setState(() {
              index++;
              bottom.add(bottom.length);
              debugPrint('bottom: $bottom roll: ');
              num = rolls[Random().nextInt(rolls.length)];
              history.add(num);
              turn = (history.length - 1) % 5 + 1;
              task = tasks[num].toString();
              if (list.contains(num)) {
                list.remove(num);
                checkDone();
              }
              if (num == 4 || num == 17 || num == 18 || num == 20) {
                powerUps[turn] += task + '\n';
              }

              var hits = history.where((element) => element == num);
              if (hits.length == 3) {
                rolls.remove(num);
              }
              //Your power-ups are: $yourUps
              /*display.add('Roll# $index'
                          'Hello Player $turn'
                          'Your role: $num'
                          'Your task is: $task' 
                          'Your potential rolls: $rolls' 
                          'Numbers Remaining: $list'); */
              display.add(<TextSpan>[
                TextSpan(
                    text: 'Roll# $index   -   Player $turn',
                    style: TextStyle(fontSize: 20, color: Colors.red[200])),
                TextSpan(
                    text: '\nYou rolled a $num',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red[200],
                    )),
                TextSpan(
                    text: '\nYour task is: $task',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.lightGreenAccent,
                    )),
                TextSpan(
                    text: '\nNumbers Remaining: $list',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red[200],
                    )),
                TextSpan(
                    text: '\nYour potential rolls: $rolls',
                    style: TextStyle(fontSize: 20, color: Colors.red[200])),
              ]);
            });
            if (listScrollController.hasClients) {
              final position = listScrollController.position.maxScrollExtent;
              listScrollController.jumpTo(position + 200);
            }
          },
        ),
      ),
      body: CustomScrollView(
        //center: bottomKey, //centers on the centerkey
        controller: listScrollController,
        slivers: <Widget>[
          SliverList(
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
            key: bottomKey,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10.0),
                    color: index % 2 == 1 ? colors[0] : colors[1],
                    height: index == 0 ? 150 : 200,
                    child: index == 0
                        ? RichText(text: TextSpan(children: display[index]))
                        : index % 2 == 1
                            ? RichText(text: TextSpan(children: display[index]))
                            : RichText(
                                text: TextSpan(children: display[index])));
              },
              childCount: bottom.length,
            ),
          ),
        ],
      ),
    );
  }
}
