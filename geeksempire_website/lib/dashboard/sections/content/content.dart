import 'package:flutter/material.dart';
import 'package:sachiel_website/dashboard/sections/content/provider/content_data_structure.dart';

class Item extends StatefulWidget {

  ContentDataStructure contentDataStructure;

  Item({Key? key, required this.contentDataStructure}) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}
class _ItemState extends State<Item> {

  @override
  void initState() {
    super.initState();
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

                /* Start
                 * Screenshots
                 */

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

  /* Start
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
              child: Image.network(
                widget.contentDataStructure.applicationCoverValue(),
                fit: BoxFit.cover,
              ),
            )

          ]
      )
    );
  }
  /* End
   * Cover, Name, Summary
   */

}