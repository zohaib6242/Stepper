import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:stepper/stepitem.dart';
import 'package:flutter/services.dart';

const channel = MethodChannel('com.zohaib.stepper/channelStepper');

void main() => runApp(MaterialApp(
  home: HomePage(),
));

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('TyrAds Stepper'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: StepperWidget(),
          )
      ),
    );
  }
}

class StepperWidget extends StatefulWidget {

  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {

  int _stepNumber = 0;

  List<StepItem> steps = List<StepItem>.empty();

  void nextPage(BuildContext context) {
    setState(() {
      if (_stepNumber < steps.length-1){
        _stepNumber++;
      }
    });
  }

  void previousPage(BuildContext context) {
    setState(() {
      if (_stepNumber > 0){
        _stepNumber--;
      }
    });
  }

  void getStepsList() async {
    String? stepJsonString = await channel.invokeMethod<String>('getStepperValues');
    Iterable l = json.decode(stepJsonString!);
    setState(() {
      steps = List<StepItem>.from(l.map((model)=> StepItem.fromJson(model)));
    });
  }

  @override
  Widget build(BuildContext context) {
    if(steps.length == 0) {
      getStepsList();
    }
    return Column(
      children: steps.map((step) {
          // get index
          var stepIndex = steps.indexOf(step);
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    shape: BoxShape.circle,
                    // You can use like this way or like the below line
                    //borderRadius: new BorderRadius.circular(30.0),
                    color: Colors.amber,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${step.stepNumber}'),
                    ],
                  ),
                ),
                Container(
                    margin:EdgeInsets.only(left: 10) ,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.stepTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 150,
                          child: Text(step.stepDescription),
                        ),
                        SizedBox(height: 5),
                        if ( stepIndex == _stepNumber ) Row(
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  nextPage(this.context);
                                },
                                child: Text("Next")
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: (){
                                   previousPage(this.context);
                                },
                                child: Text("Back")
                            )
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
          );
        }).toList()
    );
  }
}

/*void getStepsList() async {
  String? stepJsonString = await channel.invokeMethod<String>('getStepperValues');
  Iterable l = json.decode(stepJsonString!);
  List<StepItem> steps = List<StepItem>.from(l.map((model)=> StepItem.fromJson(model)));
}*/


