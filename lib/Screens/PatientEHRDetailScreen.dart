import 'package:cached_network_image/cached_network_image.dart';
import 'package:fend_ehr/WidgetComponents/ActionButton.dart';
import 'package:fend_ehr/model/EHR.dart';
import 'package:flutter/material.dart';

import '../sizeConfig.dart';

class PatientEHRDetailScreen extends StatefulWidget {
  final EHR ehrData;
  const PatientEHRDetailScreen({Key key, @required this.ehrData})
      : super(key: key);
  @override
  _PatientEHRDetailScreenState createState() => _PatientEHRDetailScreenState();
}

class _PatientEHRDetailScreenState extends State<PatientEHRDetailScreen>
    with SingleTickerProviderStateMixin {
  bool isContainerCollapsed = true;
  bool isDateAndTimeVisible = false;
  bool isUserProfileImageVisible = false;
  bool isPhoneLogoVisible = false;
  bool areDetailsvisible = false;
  AnimationController animationController;
  Tween<double> tweenedValue;
  Animation tweenAnimation;
  bool docVal0 = false;
  bool docVal1 = false;

  onSwitchValueChanged0(bool newVal) {
    setState(() {
      docVal0 = newVal;
    });
  }

  onSwitchValueChanged1(bool newVal) {
    setState(() {
      docVal1 = newVal;
    });
  }

  @override
  void initState() {
    super.initState();
    initiateAnimation();
    animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 275),
    );
    tweenedValue = Tween(begin: 50, end: 0);
    tweenAnimation = tweenedValue.animate(animationController);
    animationController.addListener(
      () {
        setState(() {});
      },
    );
  }

  ///The animation here are staged
  void initiateAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isContainerCollapsed = false;
      });
    }).then(
      (f) {
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            isDateAndTimeVisible = true;
          });
        }).then((f) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              isUserProfileImageVisible = true;
            });
          }).then((f) {
            Future.delayed(Duration(milliseconds: 200), () {
              setState(() {
                isPhoneLogoVisible = true;
              });
            }).then((f) {
              Future.delayed(Duration(milliseconds: 150), () {
                setState(() {
                  areDetailsvisible = true;
                });
                animationController.forward();
              });
            });
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: AnimatedOpacity(
        duration: Duration(milliseconds: 230),
        opacity: isContainerCollapsed ? 0 : 1,
        child: ActionButton(
          onAcceptPressed: () {
            print('Nothing Configured for it ');
          },
          onDecinePressed: () {
            reverseAnimation();
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  AnimatedContainer(
                    curve: isContainerCollapsed
                        ? Curves.elasticIn
                        : Curves.elasticOut,
                    duration: Duration(seconds: 1),
                    height: isContainerCollapsed
                        ? 0
                        : SizeConfig.safeBlockVertical * 40,
                    width: isContainerCollapsed
                        ? 0
                        : SizeConfig.safeBlockHorizontal * 100,
                    decoration: BoxDecoration(
                      color: Color(0xff2C8BFF),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(145),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: new IconButton(
                                icon: new Icon(Icons.arrow_back),
                                onPressed: () => reverseAnimation()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 48.0),
                          child: Container(
                            // color: Colors.white,
                            height: SizeConfig.safeBlockVertical * 19,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            child: Center(
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 375),
                                opacity: isDateAndTimeVisible ? 1 : 0,
                                child: Text(
                                  widget.ehrData.appoitmentDate +
                                      ', ' +
                                      widget.ehrData.appoitmentTime,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.safeBlockVertical * 45,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 65.0),
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: AnimatedOpacity(
                              opacity: isUserProfileImageVisible ? 1 : 0,
                              duration: Duration(milliseconds: 300),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          widget.ehrData.imgLink),
                                      fit: BoxFit.fill),
                                  color: Colors.grey[200],
                                  border:
                                      Border.all(color: Colors.white, width: 5),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                height: SizeConfig.safeBlockVertical * 13,
                                width: SizeConfig.safeBlockHorizontal * 26,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 18),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () {
                                  print('download button pressed');
                                },
                                child: AnimatedOpacity(
                                  opacity: isPhoneLogoVisible ? 1 : 0,
                                  duration: Duration(milliseconds: 300),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        border: Border.all(
                                            color: Colors.white, width: 5),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    height: SizeConfig.safeBlockVertical * 8.66,
                                    width:
                                        SizeConfig.safeBlockHorizontal * 17.33,
                                    child: Icon(
                                      Icons.file_download,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 8.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 25.0, left: 18),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () {
                                  print('call button pressed');
                                },
                                child: AnimatedOpacity(
                                  opacity: isPhoneLogoVisible ? 1 : 0,
                                  duration: Duration(milliseconds: 300),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        border: Border.all(
                                            color: Colors.white, width: 5),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    height: SizeConfig.safeBlockVertical * 8.66,
                                    width:
                                        SizeConfig.safeBlockHorizontal * 17.33,
                                    child: Icon(
                                      Icons.call,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 8.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 65.0, top: 8, right: 22),
                child: Transform.translate(
                  offset: Offset(0, tweenAnimation.value),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 235),
                    opacity: areDetailsvisible ? 1 : 0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 80,
                          height: SizeConfig.safeBlockVertical * 9,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.ehrData.patientName,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                            //color: Colors.yellow,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            height: SizeConfig.safeBlockVertical * 9,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.ehrData.patienSurname,
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        Container(
                            //color: Colors.yellow,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            height: SizeConfig.safeBlockVertical * 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Permissions:',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            )),
                        Row(
                          children: <Widget>[
                            Container(
                              //color: Colors.yellow,
                              width: SizeConfig.safeBlockHorizontal * 55,
                              // height: SizeConfig.safeBlockVertical*20,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Dr. Kohinoor Chatterjee',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Switch(
                                    value: docVal0,
                                    onChanged: (newVal) {
                                      onSwitchValueChanged0(newVal);
                                      print('permission changed --> 0');
                                    }),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              //color: Colors.yellow,
                              width: SizeConfig.safeBlockHorizontal * 55,
                              // height: SizeConfig.safeBlockVertical*20,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Dr. K. Chatterjee',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Switch(
                                    value: docVal1,
                                    onChanged: (newVal) {
                                      onSwitchValueChanged1(newVal);
                                      print('permission changed --> 1');
                                    }),
                              ),
                            )
                          ],
                        ),
                        Container(
                            //color: Colors.yellow,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            height: SizeConfig.safeBlockVertical * 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Symtoms:',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            )),
                        Container(
                          //color: Colors.yellow,
                          width: SizeConfig.safeBlockHorizontal * 80,
                          //height: SizeConfig.safeBlockVertical*20,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.ehrData.appoitmentComment,
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                            //color: Colors.yellow,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            height: SizeConfig.safeBlockVertical * 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Doctor:',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            )),
                        Container(
                          //color: Colors.yellow,
                          width: SizeConfig.safeBlockHorizontal * 80,
                          //height: SizeConfig.safeBlockVertical*20,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.ehrData.appoitmentComment,
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                            //color: Colors.yellow,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            height: SizeConfig.safeBlockVertical * 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Comment:',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            )),
                        Container(
                          //color: Colors.yellow,
                          width: SizeConfig.safeBlockHorizontal * 80,
                          //height: SizeConfig.safeBlockVertical*20,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.ehrData.appoitmentComment,
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reverseAnimation() {
    Future.delayed(Duration(milliseconds: 00), () {
      setState(() {
        isContainerCollapsed = true;
      });
    }).then((f) {
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          isDateAndTimeVisible = false;
        });
      }).then((f) {
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            isUserProfileImageVisible = false;
          });
        }).then((f) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              isPhoneLogoVisible = false;
            });
          }).then((f) {
            Future.delayed(Duration(milliseconds: 250), () {
              setState(() {
                areDetailsvisible = false;
              });
              animationController.reverse().then((f) {
                Navigator.pop(context);
              });
            });
          });
        });
      });
    });
  }
}
