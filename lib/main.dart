import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pruebas_flutter/circularAnimation.dart';
import 'package:pruebas_flutter/iconImport.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

// MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => MyState()),
//       ],
//       child: MyAppProvider(),
//     );
//------------------STATIC IMAGE TO HEADER WIDGET---------------------
class StaticImage extends StatelessWidget {
  const StaticImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 110,
        child: OverflowBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 110,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 100,
                color: Colors.blue,
              ),
              Positioned(
                bottom: 3, //mover imagen
                right: -10,
                child: SizedBox(
                  width: 110, // Ancho de la imagen antes de cortar
                  height: 120, // Alto de la imagen antes de cortar
                  child: Transform(
                    transform: Matrix4.rotationZ(0.4),
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/42203.png',
                      fit: BoxFit.cover,
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
}

//------------------FIN STATIC IMAGE TO HEADER WIDGET---------------------
//----------------ANIMATED IMAGE TO HEADER WIDGET--------------------
class AnimatedImage extends StatefulWidget {
  const AnimatedImage({super.key});

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> {
  bool showFirstImage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: SizedBox(
                height: 110,
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: 110,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 100,
                        color: Colors.blue,
                      ),
                      Positioned(
                        bottom: 3, //mover imagen
                        right: -10,
                        child: SizedBox(
                          width: 110, // Ancho de la imagen antes de cortar
                          height: 120, // Alto de la imagen antes de cortar
                          child: Transform(
                            transform: Matrix4.rotationZ(0.4),
                            alignment: Alignment.topLeft,
                            child: AnimatedSwitcher(
                              duration: const Duration(seconds: 1),
                              child: showFirstImage
                                  ? Image.asset(
                                      'assets/42203.png',
                                      key: ValueKey<bool>(showFirstImage),
                                    )
                                  : Image.asset(
                                      'assets/tijera.png',
                                      key: ValueKey<bool>(showFirstImage),
                                    ),
                            ),

                            //  Image.asset(
                            //   'assets/42203.png',
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: ElevatedButton(
                onPressed: () {
                  _toggleImage();
                },
                child: const Text("Animar")),
          )
        ],
      ),
    );
  }

  void _toggleImage() {
    setState(() {
      showFirstImage = !showFirstImage;
    });
  }
}

class MultiAnimation extends StatefulWidget {
  const MultiAnimation({Key? key}) : super(key: key);

  @override
  State<MultiAnimation> createState() => _MultiAnimationState();
}

class _MultiAnimationState extends State<MultiAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> inAnimation;
  late Animation<double> enlargeAnimation;
  late Animation<double> shrinkAnimation;
  late Animation<double> rotateAnimation;
  late Animation<double> outAnimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    );

    // Definimos animación de entrada desde fuera de la pantalla hasta su posición original
    inAnimation = Tween(begin: -0.5, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      // Se ejecuta la entrada en el primer 25% de la animación
      // Utilizamos el Curves.bounceOut para el ejecto de rebote al final
      curve: const Interval(0.00, 0.25, curve: Curves.easeIn),
    ));

    // Definimos animación de agrandado hasta 2 veces
    enlargeAnimation = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
      parent: controller,
      // Se ejecuta la agrandado entre el 30% y 60% de la animación
      // Utilizamos el Curves.easeOutCubic para un efecto de agranddado acelerado al inicio y lento al final
      curve: const Interval(0.30, 0.60, curve: Curves.easeOutCubic),
    ));

    // Definimos animación de encojer con los valores a sustraer del agrandado para volver la escala original
    shrinkAnimation = Tween(begin: 0.0, end: 4.0).animate(CurvedAnimation(
      parent: controller,
      // Se ejecuta el encondido entre el 65% y 90% de la animación
      // Utilizamos el Curves.easeOutCubic para un efecto de encogido acelerado al inicio y lento al final
      curve: const Interval(0.65, 0.90, curve: Curves.easeOutCubic),
    ));

    // Definimo una rotación de 1 vuelta completa
    rotateAnimation = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
      parent: controller,
      // Se ejecuta el encondido entre el 65% y 90% de la animación, mismo intervalo que encojer
      // Utilizamos el Curves.easeInBack para el efecto de tomar impulso
      curve: const Interval(0.65, 0.90, curve: Curves.easeInBack),
    ));

    // Definimos la animación de salida ejecutarse desde su posición inicial hasta fuera de la pantalla
    outAnimation = Tween(begin: 0.0, end: -1.0).animate(CurvedAnimation(
      parent: controller,
      // Se ejecuta en el ultimo 10% de la animación
      curve: const Interval(0.90, 1.0, curve: Curves.easeInOutCirc),
    ));

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.5;
    final width = (MediaQuery.of(context).size.width * 0.5);

    return Column(
      children: [
        Expanded(
          // color: Colors.amberAccent,
          // height: 500,
          child: Center(
            child: Transform.translate(
              // La traslación dx utiliza el outAnimation para la salida mienstra dy utiliza inAnimation para la entrada
              offset: Offset(width, inAnimation.value * height),
              child: Container(
                  width: 64.0, height: 64.0, color: Colors.blueAccent),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.reset();
            controller.forward();
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            color: Colors.blue,
            height: 90,
            child: const Text("Animar"),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
//----------------FIN ANIMATED IMAGE TO HEADER WIDGET--------------------
//----------------PERSPECTIVE CARD WIDGET--------------------

//snipper to call it
//  List<Color> colores = [
//       Colors.black,
//       Colors.indigo,
//       Colors.deepPurpleAccent,
//       Colors.cyan,
//       Colors.yellow,
//       Colors.grey
//     ];
//     PerspectiveListView(
//             visualizedItem: 15,//How many card are visualiza in the list
//             itemExtend: MediaQuery.of(context).size.height * .33,
//             initialIndex: colores.length - 1,
//             backItemsShadowColor: Theme.of(context).scaffoldBackgroundColor,
//             padding: const EdgeInsets.all(15),
//             stock: List.generate(
//                 colores.length,
//                 (index) => Container(
//                       height: double.infinity,
//                       width: double.infinity,
//                       color: colores[index],
//                     )),
//           )
class PerspectiveListView extends StatefulWidget {
  const PerspectiveListView({
    super.key,
    required this.itemExtend,
    required this.visualizedItem,
    required this.stock,
    this.initialIndex = 0,
    this.padding = const EdgeInsets.all(0.0),
    this.backItemsShadowColor = Colors.black,
  });
  final double itemExtend;
  final int visualizedItem;
  final int initialIndex;
  final EdgeInsetsGeometry padding;
  final Color backItemsShadowColor;
  final List<Widget> stock;

  @override
  State<PerspectiveListView> createState() => _PerspectiveListViewState();
}

class _PerspectiveListViewState extends State<PerspectiveListView> {
  late PageController _pageController;
  late double _pagePercent;
  late int _currentIndex;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: widget.initialIndex,
        viewportFraction: 1 / widget.visualizedItem);
    _currentIndex = widget.initialIndex;
    _pagePercent = 0.0;
    _pageController.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    _currentIndex = _pageController.page!.floor();
    _pagePercent = (_pageController.page! - _currentIndex).abs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;
      return Stack(
        children: [
          //Perspective items
          Padding(
            padding: widget.padding,
            child: PerspectiveItem(
              heightItem: widget.itemExtend,
              currentIndex: _currentIndex,
              generateItems: widget.visualizedItem - 1,
              pagePercent: _pagePercent,
              children: widget.stock,
            ),
          ),
          //back item shadow
          Positioned.fill(
              child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  widget.backItemsShadowColor.withOpacity(.8),
                  widget.backItemsShadowColor.withOpacity(0)
                ])),
          )),
          //void page items
          PageView.builder(
            itemCount: widget.stock.length,
            itemBuilder: (context, index) {
              return const SizedBox();
            },
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
          ),
          //on tap otem area
          Positioned.fill(
              top: height - widget.itemExtend,
              child: GestureDetector(
                onTap: () {
                  //IMPLEMENT TAP
                  // print("pprueba "+_currentIndex.toString());
                },
              ))
        ],
      );
    });
  }
}

class PerspectiveItem extends StatelessWidget {
  const PerspectiveItem({
    super.key,
    required this.generateItems,
    required this.currentIndex,
    required this.heightItem,
    required this.pagePercent,
    required this.children,
  });
  final int generateItems;
  final int currentIndex;
  final double heightItem;
  final double pagePercent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return Stack(
          fit: StackFit.expand,
          children: List.generate(generateItems, (index) {
            final invertedIndex = (generateItems - 2) - index;
            final indexPlus = index + 1;
            final positionPercent = indexPlus / generateItems;
            final endPositionPercent = index / generateItems;
            return (currentIndex > invertedIndex)
                ? _TransformedItem(
                    heightItem: heightItem,
                    factorChange: pagePercent,
                    scale: lerpDouble(.5, 1.0, positionPercent)!,
                    endScale: lerpDouble(.5, 1.0, endPositionPercent)!,
                    translateY: (height - heightItem) * positionPercent,
                    endTranslateY: (height - heightItem) * endPositionPercent,
                    child: children[currentIndex - (invertedIndex + 1)],
                  )
                : const SizedBox();
          })
            //hide button item
            ..add((currentIndex < (children.length - 1)
                ? _TransformedItem(
                    heightItem: heightItem,
                    factorChange: pagePercent,
                    translateY: height + 20,
                    endTranslateY: (height - heightItem),
                    child: children[currentIndex + 1],
                  )
                : const SizedBox()))
            //static last item
            ..insert(
                0,
                (currentIndex > (generateItems - 1)
                    ? _TransformedItem(
                        heightItem: heightItem,
                        factorChange: 1.0,
                        endScale: .5,
                        child: children[currentIndex - generateItems],
                      )
                    : const SizedBox())),
        );
      },
    );
  }
}

class _TransformedItem extends StatelessWidget {
  const _TransformedItem({
    required this.child,
    required this.heightItem,
    required this.factorChange,
    this.scale = 1.0,
    this.endScale = 1.0,
    this.translateY = 0.0,
    this.endTranslateY = 0.0,
  });
  final Widget child;
  final double heightItem;
  final double factorChange;
  final double scale;
  final double endScale;
  final double translateY;
  final double endTranslateY;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..scale(lerpDouble(scale, endScale, factorChange))
        ..translate(
            0.0, lerpDouble(translateY, endTranslateY, factorChange)!, 0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: heightItem,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
//----------------FIN PERSPECTIVE CARD WIDGET--------------------

