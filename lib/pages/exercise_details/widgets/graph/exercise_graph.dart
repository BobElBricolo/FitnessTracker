import 'package:fitness_tracker/helpers/colors_helper.dart';
import 'package:fitness_tracker/pages/exercise_details/widgets/graph/exercise_data_point.dart';
import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  final List<ExerciseDataPoint> data;

  const GraphWidget({super.key, required this.data});

   @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Row(
            children: [
              Text(
                'Progression',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ColorsHelper.textColor),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.show_chart,
                size: 15,
                color: ColorsHelper.primaryColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // If there is no data, display a message
        if (data.isEmpty || data.length == 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "No enough data to display a graph",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          )
        else
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsHelper.cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: ColorsHelper.cardBorderColor),
              boxShadow: const [
                BoxShadow(
                  color: ColorsHelper.cardShadowColor,
                  blurRadius: 3,
                  offset: Offset(3, 3),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0 , top: 23, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 215,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: GraphPainter(data: data),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem(Colors.blue, "Weight (kg)"),
                      const SizedBox(width: 16),
                      _buildLegendItem(Colors.red, "Reps"),
                      const SizedBox(width: 16),
                      _buildLegendItem(Colors.green, "Sets"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<ExerciseDataPoint> data;

  GraphPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    double xSpacing = size.width / (data.length - 1);

    // Normalisation des valeurs pour chaque métrique
    double maxWeight = data.fold(0, (prev, point) => point.weight > prev ? point.weight : prev);
    double maxReps = data.fold(0, (prev, point) => point.reps > prev ? point.reps : prev);
    double maxSets = data.fold(0, (prev, point) => point.sets > prev ? point.sets : prev);

    double yRatio = size.height; // Normalisé sur la hauteur totale

    // Peintures pour les trois lignes
    Paint weightPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint repsPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint setsPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Peinture pour les lignes de fond
    Paint gridPaint = Paint()
      ..color = Colors.grey[500]!
      ..style = PaintingStyle.stroke;

    // Peinture pour les axes X et Y
    Paint axisPaint = Paint()
      ..color = Colors.grey[700]!
      ..strokeWidth = 1;

    // Lignes de grille horizontales
    const int numberOfGridLines = 5;
    for (int i = 0; i <= numberOfGridLines; i++) {
      double y = size.height - (i * size.height / numberOfGridLines);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Dessiner l'axe des X
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axisPaint,
    );

    // Dessiner l'axe des Y
    canvas.drawLine(
      const Offset(0, 0),
      Offset(0, size.height),
      axisPaint,
    );

    // Tracés des lignes
    Path weightPath = Path();
    Path repsPath = Path();
    Path setsPath = Path();

    for (int i = 0; i < data.length; i++) {
      double x = i * xSpacing;

      // Normalisation des valeurs entre 0 et 1 et réduction de 0.1 pour éviter les bords
      double normalizedWeight = data[i].weight / maxWeight - 0.1;
      double normalizedReps = data[i].reps / maxReps - 0.1;
      double normalizedSets = data[i].sets / maxSets - 0.1;

      // Inversion de Y (0 en bas, max en haut)
      double yWeight = size.height - (normalizedWeight * yRatio);
      double yReps = size.height - (normalizedReps * yRatio);
      double ySets = size.height - (normalizedSets * yRatio);

      if (i == 0) {
        weightPath.moveTo(x, yWeight);
        repsPath.moveTo(x, yReps);
        setsPath.moveTo(x, ySets);
      } else {
        weightPath.lineTo(x, yWeight);
        repsPath.lineTo(x, yReps);
        setsPath.lineTo(x, ySets);
      }
    }

    // Dessiner les chemins normalisés
    canvas.drawPath(weightPath, weightPaint);
    canvas.drawPath(repsPath, repsPaint);
    canvas.drawPath(setsPath, setsPaint);

    // Dessiner les points pour chaque série
    Paint dotPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      double x = i * xSpacing;

      double normalizedWeight = data[i].weight / maxWeight - 0.1;
      double normalizedReps = data[i].reps / maxReps - 0.1;
      double normalizedSets = data[i].sets / maxSets - 0.1;

      double yWeight = size.height - (normalizedWeight * yRatio);
      double yReps = size.height - (normalizedReps * yRatio);
      double ySets = size.height - (normalizedSets * yRatio);

      dotPaint.color = Colors.blue;
      canvas.drawCircle(Offset(x, yWeight), 4, dotPaint);

      dotPaint.color = Colors.red;
      canvas.drawCircle(Offset(x, yReps), 4, dotPaint);

      dotPaint.color = Colors.green;
      canvas.drawCircle(Offset(x, ySets), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
