import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:flutter/material.dart';

class FABs extends StatefulWidget {
  const FABs({super.key});

  @override
  State<FABs> createState() => _FABsState();
}

class _FABsState extends State<FABs> with SingleTickerProviderStateMixin {
  bool toggle = true;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
      reverseDuration: const Duration(milliseconds: 275),
    );
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeIn);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Alignment alignment1 = const Alignment(0.0, 0.0);
  Alignment alignment2 = const Alignment(0.0, 0.0);
  Alignment alignment3 = const Alignment(0.0, 0.0);
  double size1 = 50;
  double size2 = 50;
  double size3 = 50;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250,
        width: 250,
        child: Stack(
          children: [
            AnimatedAlign(
              duration: toggle
                  ? const Duration(milliseconds: 275)
                  : const Duration(milliseconds: 875),
              alignment: alignment1,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size1,
                width: size1,
                decoration: BoxDecoration(
                  boxShadow: List.generate(
                    3,
                    (index) => BoxShadow(
                      color: context.resources.color.grey,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(
                        0,
                        2.5,
                      ),
                    ),
                  ),
                  color: context.resources.color.colorDark,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.search,
                  color: context.resources.color.colorWhite,
                ),
              ),
            ),
            AnimatedAlign(
              duration: toggle
                  ? const Duration(milliseconds: 275)
                  : const Duration(milliseconds: 875),
              alignment: alignment2,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size2,
                width: size2,
                decoration: BoxDecoration(
                  boxShadow: List.generate(
                    3,
                    (index) => BoxShadow(
                      color: context.resources.color.grey,
                      blurRadius: 8,
                      spreadRadius: 0.5,
                      offset: const Offset(
                        0,
                        2.5,
                      ),
                    ),
                  ),
                  color: context.resources.color.colorDark,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.edit,
                  color: context.resources.color.colorWhite,
                ),
              ),
            ),
            AnimatedAlign(
              duration: toggle
                  ? const Duration(milliseconds: 275)
                  : const Duration(milliseconds: 875),
              alignment: alignment3,
              curve: toggle ? Curves.easeIn : Curves.elasticOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size3,
                width: size3,
                decoration: BoxDecoration(
                  boxShadow: List.generate(
                    3,
                    (index) => BoxShadow(
                      color: context.resources.color.grey,
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(
                        0,
                        2.5,
                      ),
                    ),
                  ),
                  color: context.resources.color.colorDark,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.camera_enhance,
                  color: context.resources.color.colorWhite,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: _animation.value * (22 / 7) * (3 / 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 375),
                  curve: Curves.easeOut,
                  height: toggle ? 70 : 60,
                  width: toggle ? 70 : 60,
                  decoration: BoxDecoration(
                    boxShadow: List.generate(
                      3,
                      (index) => BoxShadow(
                        color: context.resources.color.grey,
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(
                          0,
                          2.5,
                        ),
                      ),
                    ),
                    color: context.resources.color.colorDarkest,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: Colors.black54,
                      splashRadius: 30,
                      onPressed: () {
                        setState(() {
                          if (toggle) {
                            toggle = !toggle;
                            _controller.forward();
                            Future.delayed(const Duration(milliseconds: 10),
                                () {
                              alignment1 = const Alignment(-0.7, -0.4);
                              size1 = 50;
                            });
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              alignment2 = const Alignment(0.0, -0.8);
                              size2 = 50;
                            });
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              alignment3 = const Alignment(0.7, -0.4);
                              size3 = 50;
                            });
                          } else {
                            toggle = !toggle;
                            _controller.reverse();
                            alignment1 = const Alignment(0.0, 0.0);
                            alignment2 = const Alignment(0.0, 0.0);
                            alignment3 = const Alignment(0.0, 0.0);
                            size1 = size2 = size3 = 20;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        size: 40,
                        color: context.resources.color.colorWhite,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
