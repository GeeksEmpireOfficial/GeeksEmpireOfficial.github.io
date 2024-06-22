import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/network/endpoints/Endpoints.dart';
import 'package:shaped_image/shaped_image.dart';

class ImagePreview extends StatefulWidget {

  String postId;

  ImagePreview({Key? key, required this.postId}) : super(key: key);

  @override
  State<ImagePreview> createState() => ImagePreviewState();

}
class ImagePreviewState extends State<ImagePreview> {

  Endpoints endpoints = Endpoints();

  String featuredImagePath = "https://geeksempire.co/wp-content/uploads/2024/01/Geeks-Empire-Logo.png";

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemNavigator.pop();

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    retrieveImage(widget.postId);

  }

  @override
  void dispose() {
    super.dispose();

    BackButtonInterceptor.remove(aInterceptor);

  }

  @override
  Widget build(BuildContext context) {

    return ShapedImage(
      imageTye: ImageType.NETWORK,
      path: featuredImagePath,
      shape: Shape.Rectarcle,
      height: 310,
      width: 235,
      boxFit: BoxFit.cover,
    );
  }

  Future retrieveImage(String postId) async {

    final postResponse = await http.post(Uri.parse(endpoints.postsById(postId)),
        headers: {
          "Authorization": "Basic Z2Vla3NlbXBpcmVpbmM6KmdYZW1waXJlIzEwMjk2JA=="
        });
    final postJson = jsonDecode(postResponse.body);

    int featuredMedia = postJson['featured_media'];

    final mediaResponse = await http.post(Uri.parse(endpoints.mediaUrl(featuredMedia.toString())),
        headers: {
          "Authorization": "Basic Z2Vla3NlbXBpcmVpbmM6KmdYZW1waXJlIzEwMjk2JA=="
        });
    final mediaJson = jsonDecode(mediaResponse.body);

    setState(() {

      featuredImagePath = mediaJson['guid']['rendered'];
      debugPrint(featuredImagePath);

    });

  }

}