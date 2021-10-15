import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var check="";
  int scorewhite=0;
  int scoreblack=0;
  var Mystyle=TextStyle(color: Colors.black,fontSize: 20.0);

  Future<bool?> _onbreakpress<bool>(BuildContext context)async{
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Do you want to close it?"),
        actions: [
          FlatButton(onPressed: (){
            Navigator.pop(context,false);
          }, child: Text("No",style: Mystyle,)),
          FlatButton(onPressed: (){
            Navigator.pop(context,true);
          }, child: Text("Yes",style: Mystyle,))


        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{
          return await _onbreakpress(context);
        },

        child: Scaffold(
          backgroundColor: Colors.grey[800],
            body: Column(
              children: [
                Expanded(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Player-White",style: TextStyle(color: Colors.white,fontSize: 21),),

                          Text(scorewhite.toString(),style: TextStyle(color: Colors.white,fontSize: 21),)

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Player-Black",style: TextStyle(color: Colors.white,fontSize: 21),),
                          Text(scoreblack.toString(),style: TextStyle(color: Colors.white,fontSize: 21),)

                        ],
                      ),
                    )
                  ],
                )),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: ChessBoard(
                      boardType:BoardType.brown ,
                      size:MediaQuery.of(context).size.width,
                      onMove: (move){
                        print(move);
                      },
                      onCheck: (color){
                        if(color==PieceColor.Black){
                          _showcheck(context,"Black Queen is Check");
                        }else if(color==PieceColor.White){
                          _showcheck(context,"White Queen is Check ");

                        }
                      },
                      onCheckMate: (color){
                        if(color==PieceColor.Black){
                          _showdialog(context,"White");
                        }else if(color==PieceColor.White){
                          _showdialog(context,"Black");

                        }
                        print(color);
                      },
                      onDraw: (){
                        print("Draw!!!");
                        playagin(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(

                      ),
                    )
                )
              ],
            )
        ),
      ),
    );
  }
  void playagin(BuildContext context){
   showDialog(context: context, builder: (context){
     return AlertDialog(
       title: Text("This game is draw!!"),
       actions: [
         FlatButton(onPressed: (){
           setState(() {
             Navigator.of(context).pop();
           });
         }, child: Text("Playagin!"))
       ],
     );
   });
  }
  void _showdialog(BuildContext context,var value){
    if(value=="White"){
      scorewhite+=1;
    }else if(value=="Black"){
      scoreblack+=1;
    }
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Game is over ,"+value+" is check meet"),
        content: Text(value+"is wine",style: TextStyle(color: Colors.green,fontSize: 23),),
        actions: [
          FlatButton(onPressed: (){
            setState(() {
              Navigator.of(context).pop();
            });
          }, child: Text("Play Agin!"))
        ],
      );
    });
  }
  void _showcheck(BuildContext context,var value){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(value),
        actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Solve check"))
        ],
      );
    });
  }
}
