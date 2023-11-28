import 'package:flutter/material.dart';
import 'package:sachiel_website/dashboard/sections/content/provider/content_data_structure.dart';
import 'package:sachiel_website/resources/colors_resources.dart';

class ItemMobile extends StatefulWidget {

  ContentDataStructure contentDataStructure;

  ItemMobile({Key? key, required this.contentDataStructure}) : super(key: key);

  @override
  State<ItemMobile> createState() => _ItemMobileState();
}
class _ItemMobileState extends State<ItemMobile> {

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
            )
            /* End
             * Cover, Name, Summary, Screenshots
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

      allScreenshots.add(screenshots(element));

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

  Widget screenshots(String screenshotLink) {

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