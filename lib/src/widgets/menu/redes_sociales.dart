import 'package:flutter/material.dart';
import 'package:prueba_luismar/src/widgets/menu/webview.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class RedesSociales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.tiktok,color : const Color(0xFF9999FF)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(url: 'https://www.tiktok.com/es/'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.facebook, color : const Color(0xFF9999FF)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(url: 'https://www.facebook.com/'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(FontAwesome.twitter, color : const Color(0xFF9999FF)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(url: 'https://www.twitter.com/'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(FontAwesome.youtube, color : const Color(0xFF9999FF)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(url: 'https://www.youtube.com/'),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(FontAwesome.instagram, color : const Color(0xFF9999FF)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(url: 'https://www.instagram.com/'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
