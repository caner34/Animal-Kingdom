import 'Animal.dart';

class Node
{
    String question;
    Animal animal;
    int level;
    Node leftChild;
    Node rightChild;
    Node next;


    Node(this.question, [this.animal, this.level, this.leftChild, this.rightChild]);

    LinkedListNode(question, animal, level, next)
    {
        this.question = question;
        this.animal = animal;
        this.level = level;
        this.next = next;
    }

    @override
    String toString() {
        String questionPrint = question.isEmpty ? "null" : question;
        String animalNamePrint = animal.name.isEmpty ? "null" : animal.name;
        int value = animal.value;
        return '\"$questionPrint;$value;$level;$animalNamePrint\", \n';
    }


}