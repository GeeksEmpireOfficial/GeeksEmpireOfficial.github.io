import 'package:flutter/material.dart';
import 'package:sachiel_website/dashboard/provider/content_data_structure.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Item extends StatefulWidget {

  ContentDataStructure contentDataStructure;

  Item({Key? key, required this.contentDataStructure}) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}
class _ItemState extends State<Item> {

  ScrollController scrollController = ScrollController();

  Widget screenshotsPlaceholder = const SizedBox(
    height: 537,
  );

  @override
  void initState() {
    super.initState();

    prepareScreenshots();

  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(137, 137, 137, 79),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            /* Start
             * Cover, Name, Summary, Screenshots
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                /* Start
                 * Cover, Name, Summary
                 */
                coverNameSummary(),
                /* End
                 * Cover, Name, Summary
                 */

                const SizedBox(
                  height: 19,
                ),

                /* Start
                 * Screenshots
                 */
                screenshotsPlaceholder
                /* End
                 * Screenshots
                 */

              ]
            ),
            /* End
             * Cover, Name, Summary, Screenshots
             */

            const Divider(
              height: 19,
              color: Colors.transparent,
            ),

            /*
             * Start - Description, Contact, Install
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(37),
                  child: Container(
                    color: ColorsResources.black.withOpacity(0.07),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(37, 13, 37, 13),
                      child: SizedBox(
                        width: 1231,
                        child: Text(
                          widget.contentDataStructure.applicationDescriptionValue(),
                          maxLines: 7,
                          style: const TextStyle(
                            color: ColorsResources.premiumLight,
                            fontSize: 19,
                            overflow: TextOverflow.fade,
                            height: 1.19
                          ),
                        )
                      )
                    )
                  )
                ),
                const SizedBox(
                  width: 13
                ),

                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(
                                  height: 59,
                                  width: 59,
                                  child: InkWell(
                                      onTap: () {

                                        launchUrlString(widget.contentDataStructure.applicationFacebookValue(), mode: LaunchMode.externalNonBrowserApplication);

                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Image(
                                          image: AssetImage('assets/facebook_icon.png'),
                                        )
                                      )
                                  )
                              ),

                              SizedBox(
                                  height: 59,
                                  width: 59,
                                  child: InkWell(
                                      onTap: () {

                                        launchUrlString(widget.contentDataStructure.applicationXValue(), mode: LaunchMode.externalNonBrowserApplication);

                                      },
                                      child: const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Image(
                                            image: AssetImage('assets/twitter_icon.png'),
                                          )
                                      )
                                  )
                              ),

                              SizedBox(
                                  height: 59,
                                  width: 59,
                                  child: InkWell(
                                      onTap: () {

                                        launchUrlString(widget.contentDataStructure.applicationYoutubeValue(), mode: LaunchMode.externalNonBrowserApplication);

                                      },
                                      child: const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Image(
                                            image: AssetImage('assets/youtube_icon.png'),
                                          )
                                      )
                                  )
                              ),

                            ]
                        ),

                        const Divider(
                          height: 13,
                          color: Colors.transparent,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [

                              BoxShadow(
                                color: ColorsResources.black.withOpacity(0.19),
                                blurRadius: 19,
                                offset: const Offset(0, 13)
                              )

                            ]
                          ),
                          child: SizedBox(
                              height: 67,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(19),
                                  child: Material(
                                      shadowColor: Colors.transparent,
                                      color: Colors.transparent,
                                      child: InkWell(
                                          splashColor: ColorsResources.premiumLight,
                                          splashFactory: InkRipple.splashFactory,
                                          onTap: () {

                                            Future.delayed(const Duration(milliseconds: 357), () {

                                              launchUrlString(widget.contentDataStructure.packageNameValue(), mode: LaunchMode.externalApplication);

                                            });

                                          },
                                          child: const Image(
                                            image: AssetImage('assets/install_icon.png'),
                                          )
                                      )
                                  )
                              )
                          )
                        )

                      ]
                  )

                )
              ]
            )
            /*
             * End - Description, Contact, Install
             */

          ]
        )
    );
  }

  /* Start -
   * Cover, Name, Summary
   */
  Widget coverNameSummary() {

    return SizedBox(
      height: 571,
      width: 549,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: SizedBox(
                width: 549,
                height: 267,
                child: Image.network(
                  widget.contentDataStructure.applicationCoverValue(),
                  fit: BoxFit.cover,
                ),
              )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 37, right: 37, top: 19),
              child: Row(
                  children: [

                    Padding(
                        padding: const EdgeInsets.only(),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(37),
                            child: SizedBox(
                                width: 137,
                                height: 137,
                                child: Image.network(
                                  widget.contentDataStructure.applicationIconValue(),
                                  fit: BoxFit.cover,
                                )
                            )
                        )
                    ),

                    const SizedBox(
                      width: 19,
                    ),

                    SizedBox(
                        height: 137,
                        width: 319,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.contentDataStructure.applicationNameValue(),
                              style: const TextStyle(
                                  color: ColorsResources.premiumLight,
                                  fontSize: 41
                              ),
                            )
                        )
                    )

                  ]
              )
            ),

            Padding(
                padding: const EdgeInsets.only(left: 19, right: 37, top: 19),
                child: SizedBox(
                    height: 73,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.contentDataStructure.applicationSummaryValue(),
                          style: const TextStyle(
                              color: ColorsResources.premiumLight,
                              fontSize: 27
                          ),
                        )
                    )
                )
            )

          ]
      )
    );
  }
  /* End -
   * Cover, Name, Summary
   */

  /* Start -
   * Screenshots
   */
  void prepareScreenshots() async {

    List<Widget> allScreenshots = [];

    widget.contentDataStructure.applicationScreenshotsValue().indexed.forEach((element) {

      allScreenshots.add(screenshotItem(element.$1, element.$2));

    });

    setState(() {

      screenshotsPlaceholder = SizedBox(
        height: 537,
        width: 1097,
        child: Padding(
            padding: const EdgeInsets.only(left: 37),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(37),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    shrinkWrap: false,
                    children: allScreenshots
                )
            )
        )
      );

    });

  }

  Widget screenshotItem(int index, String screenshotLink) {

    double rightPadding = 13;

    if ((index + 1) == widget.contentDataStructure.applicationScreenshotsValue().length) {

      rightPadding = 0;

    }

    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: SizedBox(
          height: 537,
          width: 716,
          child: GestureDetector(
            onHorizontalDragEnd: (dragDetails) {
              debugPrint('Delta X: ${dragDetails.velocity.pixelsPerSecond}');

              if (dragDetails.velocity.pixelsPerSecond.dx < 0) {

                scrollController.animateTo((dragDetails.velocity.pixelsPerSecond.dx / 5) * -1, duration: const Duration(milliseconds: 555), curve: Curves.decelerate);

              } else {

                scrollController.animateTo((dragDetails.velocity.pixelsPerSecond.dx / 5) * -1, duration: const Duration(milliseconds: 555), curve: Curves.decelerate);

              }

            },
            child: Image.network(
              screenshotLink,
            )
          )
      )
    );
  }
  /* End -
   * Screenshots
   */

}