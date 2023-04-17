// Matriz de coordenadas para el tablero de la oca, sumar para añadir jugadores
List<List<int>> matrizCoordenadas = [
  [15, 342],
  [114, 342],
  [146, 342],
  [178, 342],
  [211, 342],
  [242, 342],
  [273, 342],
  [301, 342],
  [315, 325],
  [313, 296],
  [313, 266],
  [313, 235],
  [313, 205],
  [313, 175],
  [313, 145],
  [313, 115],
  [313, 85],
  [313, 55],
  [295, 40],
  [266, 45],
  [236, 45],
  [206, 45],
  [176, 45],
  [146, 45],
  [114, 45],
  [84, 45],
  [54, 45],
  [26, 42],
  [10, 57],
  [10, 84],
  [10, 114],
  [10, 144],
  [10, 174],
  [10, 208],
  [10, 238],
  [8, 268],
  [24, 282],
  [52, 280],
  [82, 280],
  [115, 280],
  [145, 280],
  [177, 280],
  [209, 280],
  [238, 280],
  [254, 265],
  [250, 236],
  [250, 206],
  [250, 176],
  [250, 145],
  [255, 117],
  [236, 100],
  [207, 100],
  [177, 100],
  [147, 100],
  [116, 100],
  [86, 98],
  [70, 118],
  [75, 145],
  [75, 175],
  [70, 205],
  [88, 220],
  [115, 215],
  [125, 145]
];

// Jajajaj lo siento por esto intentare reducirla
List<int> calcularCoordenadas(int jugador, int posicion) {
  if (posicion > 62) {
    posicion = 62;
  }
  switch (jugador) {
    case 1:
      return matrizCoordenadas[posicion];
    case 2:
      if (posicion <= 7) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 10
        ];
      }
      if (posicion > 7 && posicion <= 17) {
        return [
          matrizCoordenadas[posicion][0] + 10,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 17 && posicion <= 27) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] - 10
        ];
      }
      if (posicion > 27 && posicion <= 35) {
        return [
          matrizCoordenadas[posicion][0] - 10,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 35 && posicion <= 43) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 10
        ];
      }
      if (posicion > 43 && posicion <= 49) {
        return [
          matrizCoordenadas[posicion][0] + 10,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 49 && posicion <= 55) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] - 10
        ];
      }
      if (posicion > 55 && posicion <= 59) {
        return [
          matrizCoordenadas[posicion][0] - 10,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 59 && posicion <= 62) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 10
        ];
      }
      return [0, 0];
    case 3:
      if (posicion <= 7) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 20
        ];
      }
      if (posicion > 7 && posicion <= 17) {
        return [
          matrizCoordenadas[posicion][0] + 20,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 17 && posicion <= 27) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] - 20
        ];
      }
      if (posicion > 27 && posicion <= 35) {
        return [
          matrizCoordenadas[posicion][0] - 20,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 35 && posicion <= 43) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 20
        ];
      }
      if (posicion > 43 && posicion <= 49) {
        return [
          matrizCoordenadas[posicion][0] + 20,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 49 && posicion <= 55) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] - 20
        ];
      }
      if (posicion > 55 && posicion <= 59) {
        return [
          matrizCoordenadas[posicion][0] - 20,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 59 && posicion <= 62) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 20
        ];
      }
      return [0, 0];
    case 4:
      if (posicion <= 7) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 30
        ];
      }
      if (posicion > 7 && posicion <= 17) {
        return [
          matrizCoordenadas[posicion][0] + 30,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 17 && posicion <= 27) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] - 30
        ];
      }
      if (posicion > 27 && posicion <= 35) {
        return [
          matrizCoordenadas[posicion][0] - 30,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 35 && posicion <= 43) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 30
        ];
      }
      if (posicion > 43 && posicion <= 49) {
        return [
          matrizCoordenadas[posicion][0] + 30,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 49 && posicion <= 55) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] - 30
        ];
      }
      if (posicion > 55 && posicion <= 59) {
        return [
          matrizCoordenadas[posicion][0] - 30,
          matrizCoordenadas[posicion][1]
        ];
      }
      if (posicion > 59 && posicion <= 62) {
        return [
          matrizCoordenadas[posicion][0],
          matrizCoordenadas[posicion][1] + 30
        ];
      }
      return [0, 0];
    default:
      return [0, 0];
  }
}
