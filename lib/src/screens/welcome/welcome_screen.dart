
import 'package:prueba_luismar/src/widgets/welcome.dart';
import 'package:flutter/material.dart';



class WelcomeScren extends StatelessWidget {
  const WelcomeScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CustomBody(),
    );
  }
}

class _CustomBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;

    return Column(
      children: [
        _AnimationWidget(size: size),
        WelcomeWidget(size: size)
        // Platform.isAndroid ? WelcomeWidget(size: size) : WelcomeAndrod(),
      ],
    );
  }
}

class _AnimationWidget extends StatelessWidget {
  const _AnimationWidget({
    super.key,
    required this.size,
  });

  final double size;
@override
Widget build(BuildContext context) {
  return SizedBox(
    height: size * 0.6,
    width: double.infinity,
    // color: Colors.amber,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
           /* Lottie.asset(
              'assets/animations/animacionflota.json',
              width: 300,
              height: 300,
            ),
            */
                          Container(
                width: 300, // Ancho personalizado
                height: 300, // Alto personalizado
                child: Image.asset('assets/animations/loginphoto.png'),
              ),
            const Text(
              "P R U E B A ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            const Text(
              "¡S I G U E  A H O R R A N D O  T O D O S  L O S  D Í A S!",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
          ],
        ),
      ),
    ),
  );
}
}