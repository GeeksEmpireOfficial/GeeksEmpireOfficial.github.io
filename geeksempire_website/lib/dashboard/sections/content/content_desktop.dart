import 'package:flutter/material.dart';
import 'package:sachiel_website/dashboard/provider/content_data_structure.dart';
import 'package:sachiel_website/resources/colors_resources.dart';

class ItemDesktop extends StatefulWidget {

  ContentDataStructure contentDataStructure;

  ItemDesktop({Key? key, required this.contentDataStructure}) : super(key: key);

  @override
  State<ItemDesktop> createState() => _ItemDesktopState();
}
class _ItemDesktopState extends State<ItemDesktop> {

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
                          style: TextStyle(
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

    widget.contentDataStructure.applicationScreenshotsValue().forEach((element) {

      allScreenshots.add(screenshotItem(element));

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
                    children: allScreenshots
                )
            )
        )
      );

    });

  }

  Widget screenshotItem(String screenshotLink) {

    return Padding(
      padding: const EdgeInsets.only(right: 13),
      child: SizedBox(
          height: 537,
          width: 716,
          child: Image.network(
            screenshotLink,
          )
      )
    );
  }
  /* End -
   * Screenshots
   */

}