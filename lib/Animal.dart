
import 'package:flutterapp/Node.dart';
import 'package:flutterapp/Tree.dart';

class Animal
{
    String name;
    int value;

    Animal(this.value, [this.name]);

    static addAnimal(String question, int value, Tree t, int level, [String name])
    {
      t.addNode(Node(question, Animal(value, name), level, null, null));
    }

    static addEmptyAnimal(String question, int value, Tree t, int level)
    {
      t.addNode(Node(question, Animal(value, ""), level, null, null));
    }




}