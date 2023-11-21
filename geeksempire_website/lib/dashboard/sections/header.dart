/*
 * Copyright © 2023 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 11/4/23, 11:09 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sachiel_website/dashboard/ui/Dashboard.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';

class Header extends StatefulWidget {

  DashboardState dashboardState;

  Header({Key? key, required this.dashboardState}) : super (key: key);

  @override
  State<Header> createState() => _HeaderState();
}
class _HeaderState extends State<Header> {

  double scaleParameter = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (GetPlatform.isDesktop) {

      scaleParameter = 1;

    } else {

      scaleParameter = 1.73;

    }

    return SizedBox(
      height: 210,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
                height: 137,
                child: Blur(
                    blur: 37,
                    colorOpacity: 0.73,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(37), topRight: Radius.circular(37)),
                    blurColor: ColorsResources.red,
                    overlay: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Padding(
                              padding: EdgeInsets.only(left: 37 / scaleParameter),
                              child: SizedBox(
                                  height: 59,
                                  width: 59,
                                  child: InkWell(
                                      onTap: () {

                                        if (widget.dashboardState.menuOpen) {

                                          widget.dashboardState.menuOpen = false;

                                          widget.dashboardState.animationController.reverse().whenComplete(() {

                                          });

                                          widget.dashboardState.setState(() {

                                            widget.dashboardState.opacityAnimation = 0.37;

                                            widget.dashboardState.radiusAnimation = BorderRadius.circular(0);

                                          });

                                        } else {


                                          widget.dashboardState.menuOpen = true;

                                          widget.dashboardState.animationController.forward().whenComplete(() {

                                          });

                                          widget.dashboardState.setState(() {

                                            widget.dashboardState.opacityAnimation = 1;

                                            widget.dashboardState.radiusAnimation = BorderRadius.circular(37);

                                          });

                                        }

                                      },
                                      child: const Image(
                                        image: AssetImage("assets/menu.png"),
                                      )
                                  )
                              )
                          ),

                          Expanded(
                              child: Center(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        SizedBox(
                                            height: 57,
                                            width: 57,
                                            child: const Image(
                                              image: AssetImage("assets/logo.png"),
                                            )
                                        ),

                                        SizedBox(
                                          width: 19,
                                        ),

                                        Text(
                                            StringsResources.geeksEmpire(),
                                            style: TextStyle(
                                                color: ColorsResources.premiumLight,
                                                fontSize: 33 / scaleParameter
                                            )
                                        )

                                      ]
                                  )
                              )
                          ),

                          Padding(
                              padding: EdgeInsets.only(right: 37 / scaleParameter),
                              child: SizedBox(
                                  height: 59,
                                  width: 59,
                                  child: InkWell(
                                      onTap: () {

                                        if (widget.dashboardState.menuOpen) {

                                          widget.dashboardState.menuOpen = false;

                                          widget.dashboardState.animationController.reverse().whenComplete(() {

                                          });

                                          widget.dashboardState.setState(() {

                                            widget.dashboardState.opacityAnimation = 0.37;

                                            widget.dashboardState.radiusAnimation = BorderRadius.circular(0);

                                          });

                                        } else {


                                          widget.dashboardState.menuOpen = true;

                                          widget.dashboardState.animationController.forward().whenComplete(() {

                                          });

                                          widget.dashboardState.setState(() {

                                            widget.dashboardState.opacityAnimation = 1;

                                            widget.dashboardState.radiusAnimation = BorderRadius.circular(37);

                                          });

                                        }

                                      },
                                      child: const Image(
                                        image: AssetImage("assets/support.png"),
                                      )
                                  )
                              )
                          ),

                        ]
                    ),
                    child: Container()
                )
            ),

            Container(
                height: 33,
                child: Image(
                  image: AssetImage("assets/shadow.png"),
                  fit: BoxFit.cover,
                )
            )

          ]

      )
    );
  }

}
