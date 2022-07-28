import 'package:flutter/material.dart';
import 'constants.dart';
import 'gallery_screen.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _controller1 = AnimationController(
    duration: const Duration(seconds: 15),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller1,
    curve: Curves.linear,
  );

  // late final AnimationController _controller2 = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 5),
  // )..repeat(reverse: false);
  //
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   end: Offset.zero,
  //   begin: const Offset(1.5, 0.0),
  // ).animate(
  //   _controller2,
  // );
  //
  // @override
  // void dispose() {
  //   _controller2.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Animations HomeWork"),
      ),
      body: ListView(children: [
        rotationPicture(),
        expansionAndRotation(),
        heroBear(),
      ]),
    );
  }

  Widget rotationPicture() {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              width: 150,
              height: 150,
              child: FadeInImage(
                placeholder: NetworkImage(urls[0]),
                image: NetworkImage(urls[1]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget expansionAndRotation() {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 1000),
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: const Text(
                'Winnie the Pooh',
                style: TextStyle(color: Colors.black),
              ),
              trailing: AnimatedRotation(
                duration: const Duration(milliseconds: 1000),
                turns: _expanded ? 0.5 : 0,
                child: const Icon(
                  Icons.arrow_downward,
                ),
              ),
            );
          },
          body: ListTile(
            subtitle: AnimatedSlide(
              offset: _expanded ? Offset.zero : Offset(1.5, 0.0),
              duration: const Duration(milliseconds: 1500),
              child: Text(items[0]),
            ),
          ),
          isExpanded: _expanded,
          canTapOnHeader: true,
        ),
      ],
      dividerColor: Colors.grey,
      expansionCallback: (panelIndex, isExpanded) {
        _expanded = !_expanded;
        setState(() {});
      },
    );
  }

  // Widget listAnimation() {
  //   return SlideTransition(
  //     position: _offsetAnimation,
  //     child: const Padding(
  //       padding: EdgeInsets.all(8.0),
  //       child: Text('Winnie-the-Pooh, also called Pooh Bear and Pooh'),
  //     ),
  //   );
  // }

  Widget heroBear() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(30),
          width: 150,
          height: 150,
          child: FadeInImage(
            placeholder: NetworkImage(urls[0]),
            image: NetworkImage(urls[2]),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: Text(items[1]),
        )
      ],
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 2000),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const GalleryScreen(
        heroTag: 'bear hero',
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(curve: Curves.ease, parent: animation);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
