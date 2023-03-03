import 'package:code_mittings_app/assets/theme/colors.dart';
import 'package:flutter/material.dart';

class NamedLogo extends StatelessWidget {
  const NamedLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: <Color>[
          logoColor0,
          logoColor1,
          logoColor2,
          logoColor3,
          logoColor4,
          logoColor5,
          logoColor6,
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  [
          const Flexible(
            flex: 5,
            child: Icon(
              Icons.local_fire_department_outlined,
              size: 200,
              shadows: [
                Shadow(
                  blurRadius: 30,
                )
              ],
            ),
          ),
          Flexible(
            child: FittedBox(
              child: Text(
                'Flame',
                style: textTheme.displayLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}