import 'package:flutter/material.dart'; //จะเป็นการ import ตัว package ของ material จาก flutter

//ความแตกต่างระหว่าง StatelessWidget กับ StatefulWidget คือ
//StatelessWidget คือ widget ที่ไม่มี state หรือไม่มีสภาวะการเปลี่ยนแปลง หรือไม่จำเป็นต้องใช้งานการเปลี่ยนแปลง จึงใช้งาน widgetนี้
//ส่วน StatefulWidget คือ  widget ที่มี state หรือมีสภาวะการเปลี่ยนแปลง ไปตามข้อมูลที่ได้รับหรือจากการกำหนดจากผู้ใช้
//ข้อแตกต่างที่สำคัญของทั้งสองส่วนนี้คือ stateful widget จะมี State object ที่ใช้ในการเก็บข้อมูล state และ ทำการส่งต่อสำหรับใช้งานในกระบวนการสร้าง widget ใหม่เมื่อมีการเปลี่ยนแปลง ทำให้ค่า state ไม่ได้หายไปไหน

void main() => runApp(MyApp()); //ประกาศว่าฟังก์ชั้น main จะเปิดที่คลาส MayApp

class MyApp extends StatelessWidget {
  // class MyApp จะทีการสร้าง MaterialApp ไว้สำหรับเรียกใช้งานคลาสย่อยชื่อ MyCalculator โดยคลาสแม่คือคลาส MyCalculator และมีคลาสลูกคือ _MyCalculatorState

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULATOR',
      home: MyCalculator(
          title:
              'CALCULATOR BY JANTAPA 6035512034'), //เรียกการทำงานของคลาส MyCalculator ให้มีการ render มาที่หน้า Home ของคลาส MyApp
    );
  }
}

//สร้างส่วนแสดงงผล state ของ Calculate
//คลาส MyCalculator จะเป็นส่วนที่ทำการสร้างเครื่องคิดเลขโดยจะสร้าง state ชื่อ _MyCalculatorState ไว้สำหรับจัดการกับ state ต่าง ๆที่มีการเปลี่ยนค่าในโปรแกรมเครื่องคิดเลขนั่นเอง

class MyCalculator extends StatefulWidget {
  MyCalculator({Key key, this.title})
      : super(key: key); //ทำการเรียกค่า title มาจาก class MyApp

  final String title;

  //ประกาศตัวแปร title โดยมีชนิดเป็น String
  // การใช้งาน final และ const มีข้อควรทำความเข้าใจดังนี้ สำหรับ final เราสามารถกำหนดได้เพียงครั้งเดียวและจะถูกเพิ่มเข้าไปในหน่วยความจำเมื่อมีการเรียกใช้งานเท่านั้น

  @override
  _MyCalculatorState createState() =>
      _MyCalculatorState(); //ทำการสร้าง state  ชื่อ _MyCalculatorState  ไว้หรับเปลี่ยนแปลงค่าซึ่งใช้งานในคลาส MyCalculator
}

// คลาสสำหรับการทำงานของ state _MyCalculatorState

class _MyCalculatorState extends State<MyCalculator> {
  String
      answer; //ประกาศตัวแปร answer โดยมีชนิดเป็น String สำหรับเก็บค่าคำตอบเมื่อมีการคำนวณครั้งแรก
  String
      answerTemp; //ประกาศตัวแปร answerTemp โดยมีชนิดเป็น String สำหรับเก็บค่าคำตอบ
  String
      inputFull; //ประกาศตัวแปร inputFull โดยมีชนิดเป็น String สำหรับเก็บค่าคำตอบเมื่อมีการคำนวณเสร็จสิ้นของชุดก่อนหน้า
  String
      operator; //ประกาศตัวแปร operator โดยมีชนิดเป็น String สำหรับเก็บค่าของเครื่องหมายการคำนวณ
  bool
      calculateMode; //ประกาศตัวแปร calculateMode โดยมีชนิดเป็น boolean สำหรับเก็บค่าการทำงานของโหมดการคำนวณที่ผู้ใช้เลือกโดยมีค่าแค่ 2 ค่าคือ True , False

  @override
  
  void initState() {
    //เรียกฟังก์ชั่นจาก flutter คือฟังก์ชั่นในการกำหนด state เเรกเริ่มให้กับตัวแปรต่าง ๆ ที่จะทำการเปลี่ยน state เมื่อมีการเรียกใช้

    answer = " ";  //กำหนดค่าเริ่มต้นของตัวแปร answer = ค่าว่าง
    operator = "";  //กำหนดค่าเริ่มต้นของตัวแปร opreator = ค่าว่าง
    answerTemp = "";  //กำหนดค่าเริ่มต้นของตัวแปร answerTemp = ค่าว่าง
    inputFull = "";  //กำหนดค่าเริ่มต้นของตัวแปร inputFull = ค่าว่าง
    calculateMode = false;  //กำหนดค่าเริ่มต้นของตัวแปร calculateMode = false
    super.initState();  //กำหนด.shmedki initial State
  }

  //ส่วนการเรียกช้งาน MyCalculatePage
  //ส่วนฟังก์ชันในการ render ส่วนของ component ต่าง ๆ ไปแสดงบนหน้าหลักของแอป

  @override
  Widget build(BuildContext context) { 
    return Scaffold(   //กำหนดให้มีการ return ส่วนของ Scaffold โดยภายในมีคอมโพเนนต์ backgroundColor, title และ  elevation
      appBar: AppBar( //สร้าง component appBar โดยภายในเราสามารถกำหนดลักษณะต่าง ๆ ได้เช่น สี, ข้อความ เป็นต้น
        backgroundColor: Colors.blue, //กำหนดให้ Appbar เป็น สีฟ้า
        title: Text(widget.title, //กำหนดข้อความโดยมีการตกแต่งลักษณะต่าง ๆ ด้วย
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold)),
        elevation: 1,
      ),
      body: Container(  //ในส่วนของ Body จะมีการ render คอมโพเนนต์หลักที่ชื่อว่า vcontainer โดยภายในประกอบด้วยส่วนคอมโพเนนต์ย่อยเป็น column
        child: Column(
        mainAxisSize: MainAxisSize.max, //ภายในการ render จะแสดงส่วนของการทำงานในคลาส buildAnswerWidget() และ buildNumPadWidget() โดยมีการจัดตำแหน่งการแสดงผลแบบ MainAxisSize
        children: <Widget>[buildAnswerWidget(), buildNumPadWidget()],
      )),
    );
  }

  //ส่วนแสดงการคำนวณและคำตอบ

  Widget buildAnswerWidget() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(16),
            color: Color(0xffdbdbdb),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(answer,
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold))
                    ]))));
  }

  //ส่วนการแสดงปุ๋มกดตัวเลขและเครื่องหมาย

  Widget buildNumPadWidget() {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
              }),
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
              }),
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
              }),
              buildNumberButton("−", numberButton: false, onTap: () {
                addOperatorToAnswer("-");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
              }),
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
              }),
              buildNumberButton("×", numberButton: false, onTap: () {
                addOperatorToAnswer("×");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("C", numberButton: false, onTap: () {
                clearAll();
              }),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate();
              }),
              buildNumberButton("/", numberButton: false, onTap: () {
                addOperatorToAnswer("/");
              }),
            ]),
          ],
        ));
  }

  //โหมดการทำงานการลบค่า

  void toggleNegative() {
    setState(() {
      if (answer.contains("-")) {
        answer = answer.replaceAll("-", " ");
      } else {
        answer = "-" + answer;
      }
    });
  }

  //โหมดการทำงานการล้างค่า

  void clearAnswer() {
    setState(() {
      answer = " ";
    });
  }

  //โหมดการทำงานการล้างค่า

  void clearAll() {
    setState(() {
      answer = " ";
      inputFull = "";
      calculateMode = false;
      operator = "";
    });
  }

  //โหมดการทำงานการล้คำนวณค่าและการเซ้คค่าของ state

  void calculate() {
    setState(() {
      if (calculateMode) {

        bool decimalMode = false;
        double value = 0;

        //โหมดการบวกค่า
        if (operator == "+") {
          value = (double.parse(answerTemp) + double.parse(answer));
        } else if (operator == "-") {
          value = (double.parse(answerTemp) - double.parse(answer));
        } else if (operator == "×") {
          value = (double.parse(answerTemp) * double.parse(answer));
        } else if (operator == "/") {
          value = (double.parse(answerTemp) / double.parse(answer));
        }
        else if (operator == "/" && answerTemp == "0") {
          answer = "Error";
        }

        if (!decimalMode) {
          answer = value.toInt().toString();
        } else {
          answer = value.toString();
        }

        calculateMode = false;
        operator = "";
        answerTemp = "";
        inputFull = "";

      }
    });
  }

  void addOperatorToAnswer(String op) {
    setState(() {
      if (answer != " " && !calculateMode) {
        calculateMode = true;
        answerTemp = answer;
        inputFull += operator + " " + answerTemp;
        operator = op;
        answer = " ";
      } else if (calculateMode) {
        if (answer.isNotEmpty) {
          calculate();
          answerTemp = answer;
          inputFull = "";
          operator = "";
        } 
        else {
          operator = op;
        }
      }
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
        // Not do anything.
      } else if (number != 0 && answer == "0") {
        answer = number.toString();
      } else {
        answer += number.toString();
      }
    });
  }

  void removeAnswerLast() {
    if (answer == "0") {
      // Not do anything.
    } else {
      setState(() {
        if (answer.length > 1) {
          answer = answer.substring(0, answer.length - 1);
          if (answer.length == 1 && ( answer == "-")) {
            answer = "0";
          }
        } 
        else {
          answer = "0";
        }
      });
    }
  }

  Widget buildNumberButton(
    String str, {
    @required Function() onTap,
    bool numberButton = true,
  }) {
    Widget widget;
    if (numberButton) {
      widget = Container(
          child: Material(
              color: Colors.white,
              child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.blue,
                  child: Container(
                      height: 70,
                      child: Center(
                          child: Text(str,
                              style: TextStyle(
                                  fontSize: 32,
                                  )))))));
    } else {
      widget = Container(
          child: Material(
              color: Colors.white,
              child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.blue,
                  child: Container(
                      height: 70,
                      child: Center(
                          child: Text(str, style: TextStyle(fontSize: 28)))))));
    }

    return Expanded(child: widget);
  }
}
