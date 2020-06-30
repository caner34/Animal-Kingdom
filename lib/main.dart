import 'package:flutterapp/Animal.dart';
import 'package:flutterapp/AnimalLinkedList.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Boolean.dart';
import 'package:flutterapp/Node.dart';
import 'CustomButton.dart';
import 'Game.dart';
import 'Tree.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Kingdom',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Animal Kingdom'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String message = "Please pick an animal in your mind!\n\nThen press Start The Game Button.\n\nThen the app will try to guess the animal in your mind in the light of your answers to the questions regarding the animal.\n\nPlease try to answer them correctly for a proper guess.\n\nEnjoy it!\n";
  String messageContributionQuestion = "";
  Game crGame;
  CustomButton customButtonStartGame, customButtonYes, customButtonNo, customButtonSubmitContribution;
  Tree t;
  AnimalLinkedList animalLinkedList;

  int lastGuessedAnimalValue = -1;
  String lastGuessedAnimalName = "";

  TextField textFieldAnimalName, textFieldContributionQuestion;
  TextEditingController textEditingControllerAnimalName, textEditingControllerContributionQuestion;

  Image imageAnimal;
  String imageAssetPath = 'assets/images/cat.gif';

  bool _isVisibleButtonsYesNo = false;
  bool _isVisibleButtonStartGame = true;
  bool _isVisibleTextFieldAndItsSubmitButton = false;
  bool _isVisibleImage = true;
  bool _isFirstLunch = true;


  @override
  void initState() {
    super.initState();
    activateImageAndSound("Animal Kingdom");
  }

  var animalsWithPhoto = [ "Animal Kingdom", "Thanks", "Antilope", "Bat", "Bear", "Bee", "Camel", "Canary", "Cat", "Chicken", "Cow", "Crab", "Deer", "Dog", "Dolphin", "Donkey", "Duck", "Eagle", "Elephant", "Fly", "Frog", "Giraffe", "Horse", "Insect", "Kangaroo", "Lion", "Monkey", "Mouse", "Owl", "Pig", "Pigeon", "Rabbit", "Scorpion", "Sea Serpent", "Shark", "Sheep", "Shrimp", "Snake", "Tiger", "Whale", "Worm", "Zebra" ];

  var animalsWithSound = [ "Animal Kingdom", "Thanks", "Contribution", "Oh No", "Reject", "Correct", "Antilope", "Bat", "Bear", "Bee", "Camel", "Canary", "Cat", "Chicken", "Cow", "Crab", "Deer", "Dog", "Dolphin", "Donkey", "Duck", "Eagle", "Elephant", "Fly", "Frog", "Giraffe", "Horse", "Insect", "Kangaroo", "Lion", "Monkey", "Mouse", "Owl", "Pig", "Pigeon", "Rabbit", "Scorpion", "Sea Serpent", "Shark", "Sheep", "Snake", "Tiger", "Whale", "Worm", "Zebra" ];

/*
  var animalInfoArray = [
    "Does the animal has legs?;2000;0;null",
    "Is it omnivore?;1000;1;null",
    "Does it bark?;750;3;null",
    "null;625;4;Dog",
    "null;875;4;Pig",
    "Does it fly?;1750;3;null",
    "null;1625;4;Eagle",
    "Is it domesticated?;1875;4;null",
    "null;1813;5;Cat",
    "null;1938;5;Lion",
    "Does it have feathers?;500;2;null",
    "null;250;3;Chicken",
    "Is it herbivore?;1500;2;null",
    "Does humans ride it?;1250;3;null",
    "Does it have hump?;1125;4;null",
    "null;1063;5;Camel",
    "null;1188;5;Horse",
    "Does it have wool?;1375;4;null",
    "null;1313;5;Sheep",
    "null;1438;5;Cow",
    "Does it live underwater?;3000;1;null",
    "Does it jump?;2500;2;null",
    "null;2250;3;Dolphin",
    "Does it have a lot of sharp teeth?;2750;3;null",
    "null;2625;4;Shark",
    "Does it skin itself?;2875;4;null",
    "null;2813;5;Sea Serpent",
    "null;2938;5;Whale",
    "Does it skin itself?;3500;2;null",
    "null;3250;3;Snake",
    "null;3750;3;Worm"
  ];
*/

  var animalInfoArray = [
    "Does the animal has legs?;2000;0;null",
    "Is it omnivore?;1000;1;null",
    "Does it have feathers?;500;2;null",
    "Does it swim?;250;3;null",
    "null;125;4;Duck",
    "Can it fly?;375;4;null",
    "null;313;5;Canary",
    "null;438;5;Chicken",
    "Does it bark?;750;3;null",
    "null;625;4;Dog",
    "null;875;4;Pig",
    "Is it herbivore?;1500;2;null",
    "Does humans ride it?;1250;3;null",
    "Does it have hump?;1125;4;null",
    "null;1063;5;Camel",
    "Does it have a trunk?;1188;5;null",
    "null;1157;6;Elephant",
    "Does it have long ears?;1219;6;null",
    "null;1204;7;Donkey",
    "null;1235;7;Horse",
    "Does it have wool?;1375;4;null",
    "null;1313;5;Sheep",
    "Can it fly?;1438;5;null",
    "null;1407;6;Pigeon",
    "Does it have black stripes?;1469;6;null",
    "null;1454;7;Zebra",
    "Does it have a very long neck?;1485;7;null",
    "null;1477;8;Giraffe",
    "null;1493;8;Cow",
    "Does it fly?;1750;3;null",
    "Does it prefer hunting at night?;1625;4;null",
    "null;1563;5;Owl",
    "null;1688;5;Eagle",
    "Is it domesticated?;1875;4;null",
    "null;1813;5;Cat",
    "Can it swim?;1938;5;null",
    "null;1907;6;Frog",
    "Is it poisonous?;1969;6;null",
    "null;1954;7;Scorpion",
    "Does it have black stripes?;1985;7;null",
    "null;1977;8;Tiger",
    "null;1993;8;Lion",
    "Does it live underwater?;3000;1;null",
    "Does it jump?;2500;2;null",
    "null;2250;3;Dolphin",
    "Does it have a lot of sharp teeth?;2750;3;null",
    "null;2625;4;Shark",
    "Does it skin itself?;2875;4;null",
    "null;2813;5;Sea Serpent",
    "null;2938;5;Whale",
    "Does it skin itself?;3500;2;null",
    "null;3250;3;Snake",
    "null;3750;3;Worm"
  ];


  startNewGame()
  {
    if(_isFirstLunch)
    {
      _isFirstLunch = false;
    }
    else
    {
      activateImageAndSound("Animal Kingdom");
    }
    if(animalLinkedList == null)
    {
      animalLinkedList = getLinkedListByAnimalInfoArray(animalInfoArray);
    }
    t = Tree.createTree(t, animalLinkedList);
    crGame = Game(customButtonStartGame, message, null, null, t, setMessage, activateImageAndSound, setImageAssetName, startSound, startNewGame, noNewGame, activateTextField);
    crGame.proceedGame(null);
    setState(() {
      _isVisibleButtonStartGame = false;
      _isVisibleButtonsYesNo = true;
    });
  }

  noNewGame()
  {
    setState(() {
      _isVisibleButtonStartGame = true;
      _isVisibleButtonsYesNo = false;
    });
  }

  setMessage(String newString)
  {
    setState(() {
      message = newString;
    });
    print("message: "+message);
  }

  activateImageAndSound(String animalName)
  {
    setImageAssetName(animalName);
    startSound(animalName);
  }

  setImageAssetName(String animalName)
  {
    setState(() {
      if(!animalsWithPhoto.contains(animalName))
      {
        return;
      }

      animalName = animalName.toLowerCase();
      if(animalName.contains(" "))
      {
        animalName = animalName.replaceAll(" ", "_");
      }
      imageAssetPath = 'assets/images/'+animalName+'.gif';
    });
  }

  startSound(String animalName)
  {
    setState(() {
      if(!animalsWithSound.contains(animalName))
      {
        return;
      }

      animalName = animalName.toLowerCase();
      if(animalName.contains(" "))
      {
        animalName = animalName.replaceAll(" ", "_");
      }

      String soundPath = 'sounds/'+animalName+'.mp3';

      AudioCache player = new AudioCache();
      player.play(soundPath);
    });
  }


  static String CONS_IMPROVEMENT_HELP_QUESTION_START = "Can you please write a question to the box below\n such that its answer is yes for ";
  static String CONS_IMPROVEMENT_HELP_QUESTION_AND_NO_FOR = " and no for ";
  static String CONS_IMPROVEMENT_HELP_QUESTION_QUESTION_MARK_END = "?";
  static String CONS_IMPROVEMENT_HELP_QUESTION_WHAT_WAS_THE_ANIMAL_IN_YOUR_MIND = "What was the animal in your mind?";

  activateTextField()
  {
    setState(() {
      _isVisibleButtonsYesNo = false;

      lastGuessedAnimalValue = int.parse(message);
      Node lastGuessedAnimalNode = t.getNodeByOnlyValue(lastGuessedAnimalValue);
      lastGuessedAnimalName = lastGuessedAnimalNode.animal.name;
      messageContributionQuestion = CONS_IMPROVEMENT_HELP_QUESTION_START + CONS_IMPROVEMENT_HELP_QUESTION_AND_NO_FOR + lastGuessedAnimalName + " " + CONS_IMPROVEMENT_HELP_QUESTION_QUESTION_MARK_END;
      message = CONS_IMPROVEMENT_HELP_QUESTION_WHAT_WAS_THE_ANIMAL_IN_YOUR_MIND;
      _isVisibleTextFieldAndItsSubmitButton = true;

      textEditingControllerAnimalName = TextEditingController();
      textEditingControllerAnimalName.addListener(() {
        setState((){
          messageContributionQuestion = CONS_IMPROVEMENT_HELP_QUESTION_START + textEditingControllerAnimalName.text + CONS_IMPROVEMENT_HELP_QUESTION_AND_NO_FOR + lastGuessedAnimalName + " " + CONS_IMPROVEMENT_HELP_QUESTION_QUESTION_MARK_END;
        }
        );
      });
      textEditingControllerContributionQuestion = TextEditingController();
    });
  }

  deactivateTextField()
  {
    setState(() {
      _isVisibleTextFieldAndItsSubmitButton = false;

      //textEditingControllerAnimalName.dispose();
      //textEditingControllerContributionQuestion.dispose();
    });
  }

  final String CONS_THANKS_FOR_YOUR_CONTRIBUTION = "Thanks for your contribution\nThe animal is added.\nAnd The game has been improved.";
  final String CONS_NOSPACE_FOR_THAT_ANIMAL = "Thanks for your contribution\nHowever, the animal could not be added.\nNo space for the new animal.";
  submitContribution()
  {
    setState(() {
      deactivateTextField();
      Node incorrectlyGuessedAnimalNode = t.getNodeByOnlyValue(lastGuessedAnimalValue);
      String newAnimalName = textEditingControllerAnimalName.text;
      String newQuestion = textEditingControllerContributionQuestion.text;

      if(t.enlargeTreeWithNewQuestionAndAnimal(animalLinkedList, incorrectlyGuessedAnimalNode, newAnimalName, newQuestion))
      {
        setMessage(CONS_THANKS_FOR_YOUR_CONTRIBUTION);
        startSound("Contribution");
      }
      else
      {
        setMessage(CONS_NOSPACE_FOR_THAT_ANIMAL);
      }

      noNewGame();
    });
  }

  @override
  Widget build(BuildContext context) {





    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.


        child: SingleChildScrollView(




          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Visibility (
                visible: _isVisibleImage,
                child: imageAnimal = Image.asset(
                  imageAssetPath,
                  width: 500,
                  height: 500,
                  fit: BoxFit.fill,
                ),
              ),

              Text(
                  '$message',
                  style: TextStyle(fontSize: 18.0, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                  Visibility (
                    visible: _isVisibleButtonStartGame,
                    child: customButtonStartGame = CustomButton(
                          () {
                        setState((){

                          startNewGame();

                        }
                        );
                      },
                      "Start The Game",
                    ),
                  ),




                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Visibility (
                        visible: _isVisibleButtonsYesNo,
                        child: CustomButton(
                              () {
                            crGame.proceedGame(Boolean(true));
                          },
                          "YES",
                        ),
                      ),

                      Visibility (
                        visible: _isVisibleButtonsYesNo,
                        child:
                        CustomButton(
                              () {
                            crGame.proceedGame(Boolean(false));
                          },
                          "NO",
                        ),
                      ),

                    ],
                  ),


                  Visibility (
                    visible: _isVisibleTextFieldAndItsSubmitButton,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius:  BorderRadius.circular(32),
                      ),
                      child: textFieldAnimalName = TextField(
                        controller: textEditingControllerAnimalName,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Enter the animal in your mind please',
                          suffixIcon: Icon(Icons.cached),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),


                  Visibility (
                    visible: _isVisibleTextFieldAndItsSubmitButton,
                    child: Text(
                        '$messageContributionQuestion',
                        style: TextStyle(fontSize: 24.0, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center
                    ),
                  ),


                  Visibility (
                    visible: _isVisibleTextFieldAndItsSubmitButton,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius:  BorderRadius.circular(64),
                      ),
                      child: textFieldContributionQuestion = TextField(
                        controller: textEditingControllerContributionQuestion,
                        /*onChanged: (text) {
                        setState(){



                        }
                      },*/
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Enter the question please',
                          suffixIcon: Icon(Icons.account_box),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),




                  Visibility (
                    visible: _isVisibleTextFieldAndItsSubmitButton,
                    child: customButtonSubmitContribution = CustomButton(
                          () {
                        setState((){

                          submitContribution();

                        }
                        );
                      },
                      "Submit Your Contribution",
                    ),
                  ),


                ],
              ),

            ],

          ),




        ),






      ),
    );
  }

  AnimalLinkedList getLinkedListByAnimalInfoArray(List<String> animalInfoArray)
  {
    AnimalLinkedList result = AnimalLinkedList(null);
    String questionStr, valueStr, levelStr, animalNameStr;
    int value, level;
    for(int i = 0; i < animalInfoArray.length; i++)
    {
      var rawLine = animalInfoArray.elementAt(i).split(";");
      questionStr = rawLine.elementAt(0);
      valueStr = rawLine.elementAt(1);
      levelStr = rawLine.elementAt(2);
      animalNameStr = rawLine.elementAt(3);
      if(questionStr == "null")
      {
        questionStr = "";
      }
      if(animalNameStr == "null")
      {
        animalNameStr = "";
      }
      value = int.parse(valueStr);
      level = int.parse(levelStr);

      if(questionStr.isNotEmpty)
      {
        Node crNode = Node(questionStr);
        crNode.LinkedListNode(questionStr, Animal(value), level, null);
        result.addNode(crNode);
      }
      else if(animalNameStr.isNotEmpty)
      {
        Node crNode = Node(questionStr, Animal(value, animalNameStr), level, null, null);
        result.addNode(crNode);
      }
    }
    print("result AnimalLinkedList.size(): "+result.getSize().toString());
    result = result.getSortedAnimalLinkedListByLevelAndValue();
    print("result Sorted AnimalLinkedList.size(): "+result.getSize().toString());
    print("after sorting: " + result.toString());
    return result;
  }

}
