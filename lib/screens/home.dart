import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';

import '../widgets/upload_image.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool loading = true;

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        loading = false;
      });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: const Text("Image Analysis"),
      actions: [
        IconButton(onPressed: () {

        }, icon: const Icon(Icons.list)),
      ],
      headerWidget:AnimatedSwitcher(
        switchInCurve: Curves.elasticOut,
        switchOutCurve: Curves.ease,
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 1200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: loading
            ? const CircularProgressIndicator.adaptive()
            :  headerWidget(context),
      ),
      headerBottomBar: headerBottomBarWidget(),
      body:  [

        SelectImage(loading:loading),
      ],
      fullyStretchable: false,
      expandedBody:   Container(),
      backgroundColor: Colors.white,
    );
  }

  Row headerBottomBarWidget() {
    return  Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.list),
        ),

      ],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Image.asset(
      "assets/Image viewer-rafiki.png",
      fit: BoxFit.cover,
    );
  }

  ListView listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        color: Colors.white70,
        child: ListTile(
          leading: CircleAvatar(
            child: Text("$index"),
          ),
          title: const Text("Title"),
          subtitle: const Text("Subtitle"),
        ),
      ),
    );
  }
}