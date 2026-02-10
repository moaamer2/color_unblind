import 'package:colors_blind/core/data/local/local_data_source.dart';
import 'package:colors_blind/core/data/local/params/send_frames_local_data_source_params.dart';
import 'package:colors_blind/module/enums/processing_type.dart';
import 'package:colors_blind/module/models/color_blind_type.dart';

class LocalDataSourceFiltersImplementation implements LocalDataSource {
  final Map<ColorBlindType,Map<ProcessingType,List<double>>> _matrixes = {
    ColorBlindType.normal: {
      ProcessingType.simulation: _identity,
      ProcessingType.correction: _identity,
    },

    ColorBlindType.protanopia: {
      ProcessingType.simulation: _protanopiaSimulation,
      ProcessingType.correction: _protanopiaCorrection,
    },

    ColorBlindType.deuteranopia: {
      ProcessingType.simulation: _deuteranopiaSimulation,
      ProcessingType.correction: _deuteranopiaCorrection,
    },

    ColorBlindType.tritanopia: {
      ProcessingType.simulation: _tritanopiaSimulation,
      ProcessingType.correction: _tritanopiaCorrection,
    },
  };

  @override
  Future<List<double>> getFilterMatrix(SendFramesLocalDataSourceParams params) async {
    final base = _matrixes[params.colorBlindType]?[params.processingType] ?? _identity;

    final bright = _brightnessMatrix(_normalizeBrightness(params.brightness),);
    // Apply brightness after base: result = bright * base
    return _multiplyMatrix(bright, base);
  }

  double _normalizeBrightness(double brightness) {
    return 1.0 + (brightness - 50) / 50.0; // Normalize to [0.0, 2.0]
  }

  // Basic color matrices (4x5) for simulation + identity for normal.
  // Values from common approximations (suitable for UI demo).
  static const List<double> _identity = <double>[
    1, 0, 0, 0, 0, //
    0, 1, 0, 0, 0, //
    0, 0, 1, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const List<double> _protanopiaSimulation = <double>[
    0.567, 0.433, 0, 0, 0, //
    0.558, 0.442, 0, 0, 0, //
    0, 0.242, 0.758, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const List<double> _protanopiaCorrection = <double>[
    1, 0, 0, 0, 0, //
    0, 1, 0, 0, 0, //
    -0.062, 0.558,  0.502, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const List<double> _deuteranopiaSimulation = <double>[
    0.625, 0.375, 0, 0, 0, //
    0.7, 0.3, 0, 0, 0, //
    0, 0.3, 0.7, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const List<double> _deuteranopiaCorrection = <double>[
    1, 0, 0, 0, 0, //
    0, 1, 0, 0, 0, //
    0.000, 0.700, 0.300, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const List<double> _tritanopiaSimulation = <double>[
    0.95, 0.05, 0, 0, 0, //
    0, 0.433, 0.567, 0, 0, //
    0, 0.475, 0.525, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const List<double> _tritanopiaCorrection = <double>[
    1, 0, 0, 0, 0, //
    0, 1, 0, 0, 0, //
    0.000,  -0.178, 1.178, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  // brightness matrix: scales RGB channels by factor (f)
  List<double> _brightnessMatrix(double f) {
    return <double>[
      f, 0, 0, 0, 0, //
      0, f, 0, 0, 0, //
      0, 0, f, 0, 0, //
      0, 0, 0, 1, 0, //
    ];
  }

  // multiply two 4x5 matrices: a * b
  List<double> _multiplyMatrix(List<double> a, List<double> b) {
    // both are 20 length arrays representing 4x5 matrices in row-major
    final out = List<double>.filled(20, 0.0);
    for (var row = 0; row < 4; row++) {
      for (var col = 0; col < 5; col++) {
        double sum = 0.0;
        for (var k = 0; k < 4; k++) {
          sum += a[row * 5 + k] * b[k * 5 + col];
        }
        if (col == 4) {
          // bias term: add a[row][4] (bias) * 1 (since b has no fifth column as variable)
          sum += a[row * 5 + 4];
        }
        out[row * 5 + col] = sum;
      }
    }
    return out;
  }
}
