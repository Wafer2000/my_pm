import 'package:flutter/material.dart';
export './theme/light_mode.dart';
export './theme/dark_mode.dart';

/*
Colores para la versión clara:
- Quarter Spanish White (#f8f6e3) — Contraparte oscura: Black Pearl (#05161c)
- Kangaroo (#c0c5b9) — Contraparte oscura: Bitter (#7e8474)
- Conch (#cddbd5) — Contraparte oscura: Pewter (#99a6a0)
- Nobel (#bcb4b4) — Contraparte oscura: Friar Gray (#7c7c76)


Colores para la versión oscura:
- Black Pearl (#05161c) — Contraparte clara: Quarter Spanish White (#f8f6e3)
- Boston Blue (#3199ac) — Contraparte clara: No aplica (Se puede usar en ambas versiones como color de acento)
- Pewter (#99a6a0) — Contraparte clara: Conch (#cddbd5)
- Friar Gray (#7c7c76) — Contraparte clara: Nobel (#bcb4b4)
- Bitter (#7e8474) — Contraparte clara: Kangaroo (#c0c5b9)
- Eagle (#bcbca4) — Este tono podría adaptarse a ambos temas según el contexto visual.
*/

class MyColor {
  final Color color;

  const MyColor._(this.color);

  factory MyColor.blackPearl() {
    return const MyColor._(Color(0xFF05161C)); // Black Pearl
  }

  factory MyColor.bostonBlue() {
    return const MyColor._(Color(0xFF3199AC)); // Boston Blue
  }

  factory MyColor.quarterSpanishWhite() {
    return const MyColor._(Color(0xFFF8F6E3)); // Quarter Spanish White
  }

  factory MyColor.pewter() {
    return const MyColor._(Color(0xFF99A6A0)); // Pewter
  }

  factory MyColor.friarGray() {
    return const MyColor._(Color(0xFF7C7C76)); // Friar Gray
  }

  factory MyColor.conch() {
    return const MyColor._(Color(0xFFCDDBD5)); // Conch
  }

  factory MyColor.kangaroo() {
    return const MyColor._(Color(0xFFC0C5B9)); // Kangaroo
  }

  factory MyColor.bitter() {
    return const MyColor._(Color(0xFF7E8474)); // Bitter
  }

  factory MyColor.nobel() {
    return const MyColor._(Color(0xFFBCB4B4)); // Nobel
  }

  factory MyColor.eagle() {
    return const MyColor._(Color(0xFFBCBCA4)); // Eagle
  }
}
