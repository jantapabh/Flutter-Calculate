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
      answer; //ประกาศตัวแปร answer โดยมีชนิดเป็น String สำหรับเก็บค่า number ที่ผู้ใช้กด
  String
      answerTemp; //ประกาศตัวแปร answerTemp โดยมีชนิดเป็น String สำหรับเก็บค่า answer จำนวนแรก
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

  Widget buildAnswerWidget() { //สร้าง Wdget ชื่อ buildAnswerWidget โดยจะมีการ render เป็นแบบ Expanded โดยจะมีการยืดเต็มพื้นที่นั่นเอง
    return Expanded(
        child: Container(  //ภายใน Expanded จะมีส่วนของ Container โดยจะสามารถกำหนดลักษณะการแสดงผลในรูปแบบต่าง ๆ ได่เช่นการกำหนดความห่างของขอบ การกำหนดสีและอีกมากมาย
            padding: EdgeInsets.all(16), //กำหนดให้ขอบนอกของ container ทุกด้านขนาด 16
            color: Colors.blueGrey, //กำหนดสี
            child: Align( //สร้าง component Align สำหรับแสดงค่าตัวเลขที่ผู้ใช้กดเลือก
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, //จัดให้อยู่ตำแหน่งขวาสุดคือ .end
                    mainAxisSize: MainAxisSize.min, //ให้มีการแสดงผลตัวเลขที่ผู้ใช้กดโดยพื้นที่จะจำกัดแค่จำนวนที่กดเท่านั้น
                    children: <Widget>[
                      Text(answer, //แสดงตัวแปร answer ที่ผู้ใช้เลือก
                          style: TextStyle(
                              fontSize: 40, ))
                    ]))));
  }

  //ส่วนการแสดงปุ๋มกดตัวเลขและเครื่องหมาย
  // widget ชื่อ buildNumPadWidget() สำหรับแสดงปุ๋มกดต่าง ๆ ตั้งแต่ 0 - 9 และเครื่องหมายต่าง ๆ 
  // สำหรับฟังก์ชัน buildNumPadWidget() คือจะสร้างปแถวทั้งหมดแบ่งเป็น 4 แถวโดยในแต่ละอถวจะมีปุ๋ม 4 ปุ๋มนั่นเองโดยแต่ละปุ๋มจะทำการ set ค่าตัวเลขโดยเมื่อกดปุ๋มจะทำการเซ็ตค่าตัวแปร answer

  Widget buildNumPadWidget() {
    return Container(
        color: Colors.white, //การแแสดงผลจะจัดเป็น Column และแต่ละคอลัมล์จะมีการแสดงผลเป้นปุ๋มแต่ละปุ๋มแบบ row 4 ปุ๋ม
        child: Column(
          mainAxisSize: MainAxisSize.max, //กำหนดให้แสดงแต่ละ Column แบบยืดเต็มพื้นที่
          children: <Widget>[
            Row(children: <Widget>[   //แสดงปุ๋มแถวบนสุดโดยมีตัวเลข 4 ตัว โดยเรียกการทำงานของ class buildNumberButton //แสดงปุ๋มแถวบนสุดโดยมีตัวเลข 4 ตัว โดยเรียกการทำงานของ class buildNumberButton
              buildNumberButton("9",  //ปุ่มแสดงเลข 9 และส่งค่า 9 ไปยังเมธอด addNumberToAnswer()
              onTap: () {  
                addNumberToAnswer(9); 
              },),
              buildNumberButton("8", onTap: () {  // ฟังก์ชัน onTap คือฟังค์ชันสำหรับ handle กรณีที่ User กดที่ item ใน ปุ๋ม ทำหน้าที่คล้ายๆ onItemClickListener
                addNumberToAnswer(8); //ปุ่มแสดงเลข 8 และส่งค่า 8 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7); //ปุ่มแสดงเลข 7 และส่งค่า 7 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");  //ปุ่มแสดงเครื่องหมาย + และส่งค่า + ไปยังเมธอด addOperatorToAnswer()
              }),
            ]),
            Row(children: <Widget>[   //แสดงปุ๋มแถวที่สองโดยนับจากบนโดยมีตัวเลข 4 ตัว โดยเรียกการทำงานของ class buildNumberButton 
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6); //ปุ่มแสดงเลข 6 และส่งค่า 6 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);  //ปุ่มแสดงเลข 5 และส่งค่า 5 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4); //ปุ่มแสดงเลข 4 และส่งค่า 4 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("−", numberButton: false, onTap: () {
                addOperatorToAnswer("-"); //ปุ่มแสดงเครื่องหมาย - และส่งค่า - ไปยังเมธอด addOperatorToAnswer()
              }),
            ]),
            Row(children: <Widget>[ //แสดงปุ๋มแถวที่สามโดยนับจากบนโดยมีตัวเลข 4 ตัว โดยเรียกการทำงานของ class buildNumberButton
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3); //ปุ่มแสดงเลข 3 และส่งค่า 3 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);  //ปุ่มแสดงเลข 2 และส่งค่า 2 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);  //ปุ่มแสดงเลข 1 และส่งค่า 1 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("×", numberButton: false, onTap: () {
                addOperatorToAnswer("×"); //ปุ่มแสดงเครื่องหมาย x และส่งค่า x ไปยังเมธอด addOperatorToAnswer()
              }),
            ]),
            Row(children: <Widget>[ //แสดงปุ๋มแถวสุดท้ายโดยนับจากบนโดยมีตัวเลข 4 ตัว โดยเรียกการทำงานของ class buildNumberButton
              buildNumberButton("C", numberButton: false, onTap: () {
                clearAll();    //ปุ่มแสดงเครื่องหมาย C และทำการลบค่าาทั้งหมด
              }),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0); //ปุ่มแสดงเลข 0 และส่งค่า 0 ไปยังเมธอด addNumberToAnswer()
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate(); //ปุ่มแสดงเครื่องหมาย = และเมื่อกดปุ๋มนี้จะแดงค่าผลลัพธ์
              }),
              buildNumberButton("/", numberButton: false, onTap: () {
                addOperatorToAnswer("/");  //ปุ่มแสดงเครื่องหมาย / และทำการหารค่าเมื่อกดเครืองหมายนี้
              }),
            ]),
          ],
        ));  //จบการทำงานของ buildNumPadWidget()
  }

  //โหมดการทำงานการลบค่า

  void toggleNegative() {  //เมธอดการลบค่าจะทำการเซ็ตค่าตัวแปร answer โดยนำค่าตัวแปรที่ 1 มาลบกับตัวแปรที่ 2 
    setState(() {
      if (answer.contains("-")) { //เช็คเงื่อนไขโดยเรียกใช้เมธอด contains ในการเปรียบเทียบว่าตัวอักษรที่กดเป็ยน - ใช่หรือไม่
        answer = answer.replaceAll("-", " "); // แทนที่คำตอบที่แสดงบนส่วนแสดงตัวเลขที่กดด้วยช่องว่าง
      } else {
        answer = "-" + answer; // ถ้าไม่เข้าเงื่อนไขด้านบนจะทำเงื่อนไขนี้คือการเซ็ตค่าตัวแปร answer ให้มีค่า - แล้วตามด้วยค่าคำตอบ
      }
    });
  }

  //โหมดการทำงานการล้างค่า

  void clearAnswer() {
    setState(() {  //เมธอดนี้จะทำการเคลียร์ค่าให้เป็นค่าว่าง
      answer = " ";
    });
  }

  //โหมดการทำงานการล้างค่า

  void clearAll() { //เมธอดนี้จะทำการเคลียร์ค่าทั้งหมดให้เป็นค่าว่าง
    setState(() {
      answer = " ";  
      inputFull = "";
      calculateMode = false;
      operator = " ";
    });
  }

  //โหมดการทำงานการล้คำนวณค่าและการเซ็คค่าของ state

  void calculate() { //ในส่วนนี้จะเป็นการทำงานของฟังก์ชั่น calculate ที่ดำเนินการทาง๕ริตศาสตร์โดยจะมีตัวแปรที่เกี่ยวข้องคือ +, - , 8 และ / 
    setState(() {
      if (calculateMode) { //เช็คเงื่อนไขว่ามีการเลือกคำนวณหรือไม่

        bool decimalMode = false; //เช็คค่าให้ตัวแปร decimalMode เป็นค่า false
        double value = 0;

        //โหมดการบวกค่า
        if (operator == "+") {
          value = (double.parse(answerTemp) + double.parse(answer)); //ทำการบวกค่า
        } else if (operator == "-") {
          value = (double.parse(answerTemp) - double.parse(answer));  //ทำการลบค่า
        } else if (operator == "×") {
          value = (double.parse(answerTemp) * double.parse(answer)); //ทำการคูณค่า
        } else if (operator == "/") {
          value = (double.parse(answerTemp) / double.parse(answer)); //ทำการหารค่า
        }else if (operator == "/" && answer == 0) { //ทำการเช็ตเงื่อนไขเพิ่มเติมคือหารเกิดกรณีที่หารด้วย 0 นั้นจะแสดงค่าคำตอบเป็น Error
          answer = "Error Calculate";
        }
        
        if (!decimalMode) {  //เงื่อนไขการเช็คค่าหาก decimalMode เป็นจริงก็จะทำการนำค่า value มาแปลงจาก double เป็น string
          answer = value.toInt().toString();
        } else {
          answer = value.toString(); //การเซ็ตค่าคำตอบที่ได้จากการคำนวณมาแปลงชนิดตัวแปรให้ value แปลงจาก double เป็น string
        }

        calculateMode = false; //เช็คค่าให้ตัวแปร calculateMode เป็นค่า false
        operator = "";  //เช็คค่าให้ตัวแปร operator เป็นค่าว่าง
        answerTemp = ""; //เช็คค่าให้ตัวแปร answerTemp เป็นค่าว่าง
        inputFull = "";  //เช็คค่าให้ตัวแปร inputFull เป็นค่าว่าง

      }
    });
  }

  //เมธอด addOperatorToAnswer ใช้สำหรับเพิ่มเครื่องหมายดำเนินการไปยังสมการนั่นเองซึ่งมีการทำงานคือจะรับค่าตัวแปรมา 1 ค่าคือตัวแปร op

  void addOperatorToAnswer(String op) {
    setState(() {
      if (answer != " " && !calculateMode) { //เงื่อนไขแรกทำการเช็คค่าว่าตัวแปร answer ว่าเท่ากับค่าว่างหรือไม่และมรการเลือกโหมดการคำนวณหรือไม่ หากเข้าเงื่อนไขจะทำงานดังนี้
        
        calculateMode = true; //เซ็ตค่า cslculateMode ให้มีค่าเป็น true 
        answerTemp = answer; // นำค่าในตัวแปร answer ใส่ใน answerTemp 
        operator = op;  // เช็ตค่าตัวแปร operator ให้มีค่าเท่ากับค่า op ที่่รับมา 
        answer = " "; // เช็ตค่า answer ให้เท่ากับค่าว่าง
       
       if(operator == "/" && answer == "0"){  //ส่วนในการเช็ตค่าตัวแปร operator ว่าเท่ากับการหารหรือไม่และตัวแปร answer ว่่าเท่ากับ 0 หรือไม่ หากเข้าเงื่อนไขก็จะทำการแสดง Error นั่นเอง
         answer = "Error";
       }

      } else if (calculateMode) { //ส่วนเช็คเงื่อนไขเมธอด calculateMode หากไม่มีการเลือกการทำงาน

        if (answer.isNotEmpty) { //ส่วนเช็ตค่าตัวแปร answer ว่าเป็นค่าว่างหรือไม่หากว่างจะเข้าเงื่อนไข
          calculate();  // เรียกฟังก์ชั่น calculate เพื่อทำการคำนวณ
          answerTemp = answer; // นำค่าในตัวแปร answer ใส่ใน answerTemp 
          inputFull = ""; //เช็คค่าให้ตัวแปร inputFull เป็นค่าว่าง
          operator = ""; // เช็ตค่าตัวแปร operator ให้มีค่าเท่ากับค่าว่าง
        } 
        else {
          operator = op; //ถ้ามีการคำนวณหรือค่า answer ไม่เป็นค่าว่างจะเช็ตค่าตัวแปร  operator ให้มีค่าเท่ากับ op
        }
      }
     
    });
  } // จบฟังก์ชั่นการทำงาน addOperatorToAnswer


  // ตัวแปร number คือค่าที่ส่งมาเมื่อมีการกดปุ๋ม

  void addNumberToAnswer(int number) {  // ในส่วนการทำงานในฟังก์ชั่น addNumberToAnswer เป็นส่วนที่ทำการเช็คเงื่อนไขต่าง ๆ ของตัวเลขที่กดเข้ามาจากปุ่มกดซึ่งตัวเลขที่กดมาจะมาทำการเช็คค่าในเงื่อนไขดังนี้

    setState(() {

      if( operator == "/" && number == 0){  // ถ้าตัวแปร operator มีค่าเท่ากับ / และ number เท่ากับ 0 จะให้ answer มีค่าเท่ากับ Error

        answer = "Error";

      }
      if (number == 0 && answer == "0") { // เช็คเงื่อนไขการทำงานถ้าหากค่าตัวเลขที่กดมาจากปุ่มนั้นมีค่าเท่ากับ 0 และค่าตัวแปร answer เท่ากับ 0 จะไม่มีการทำคำสั่งใด
        // Not do anything.
      } else if (number != 0 && answer == "0") { //เช็คเงื่อนไขนี้หากไม่เข้าเงื่อนไขข้างบนคือจะเช็นว่าหาก number ไม่เป็นค่า 0 และค่าตัวแปร answer เท่ากับ 0 จะทำการแปลงตัวแปร number เป็น string และเช็คค่าใส่ในตัวแปร answer

        answer = number.toString(); //แปลงตัวแปร number เป็น string และใส่ในตัววแปรชื่อ answer
      }
     else {
        answer += number.toString(); // หากไม่เข้าเงื่อนไขใดเลยจะนำค่าตัวแปร answer บวกกับค่า number ที่ผู้ใช้กดและทำการแปลงเป็น string นั่นเอง
      }
    });
  }

//จบการทำงานของเมธอด addNumberToAnswer

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
                      height: 90,
                      child: Center(
                          child: Text(
                            str,
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
