import 'package:flutter/material.dart';

class SkilltreeCharacterItem extends StatelessWidget {
  const SkilltreeCharacterItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (rect) {
                return const RadialGradient(
                  radius: 0.55,
                  center: Alignment.center,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.network(
                "https://cdn.discordapp.com/attachments/854749872862265365/855141670243532810/Wei_490bed8decd11c3433d325b1d05a0bef_jpg_460810_-_Character_Design_Blogs.jpg",
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Container(
              width: 150,
              color: Colors.black38,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                "Gwynbleidd",
                style: Theme.of(context).textTheme.titleMedium,
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
          )
        ],
      ),
    );
  }
}
