import 'package:prueba_luismar/src/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      height: size * 0.4,
      width: double.infinity,
      decoration: const BoxDecoration(
       color: Color.fromARGB(255, 201, 29, 10), // Cambia el color de fondo a #055199
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bienvenidos",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800,
             color: Colors.white),
      
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Compra lo que necesitas las 24 horas del día desde aqui.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,
             color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              CustomButton(
                text: 'Inicia sesión',
                //color: Colors.amber,
                color: Color(0xFFFDD20A), // Cambia el color a #FDD20A

                textColor: Colors.white,
                onTap: () {
                  //() {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LoginScreen(),
                  //     ),
                  //   );
                  // },
                  Navigator.pushNamed(context, "/login");
                },
              ),
              const SizedBox(
                width: 30,
              ),
              CustomButton(
                text: 'Registrarse',
                color: Colors.white,
                textColor: Colors.black,
                onTap: () {
                  Navigator.pushNamed(context, "/register");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
