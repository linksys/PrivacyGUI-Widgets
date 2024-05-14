import 'dart:math';
import 'dart:ui';

import 'package:graphview/GraphView.dart';

class CustomEdgeRenderer extends EdgeRenderer {
  BuchheimWalkerConfiguration configuration;

  CustomEdgeRenderer(this.configuration);

  var linePath = Path();

  @override
  void render(Canvas canvas, Graph graph, Paint paint) {
    for (var node in graph.nodes) {
      var children = graph.successorsOf(node);

      for (var child in children) {
        var edge = graph.getEdgeBetween(node, child);
        var edgePaint = (edge?.paint ?? paint)..style = PaintingStyle.stroke;

        //Default value is top bottom case
        var startPoint = Point(node.x + node.width / 2,
            node.y + node.height); // bottom center of parent node
        var endPoint = Point(
            child.x + child.width / 2, child.y); // top center of child node

        linePath.reset();
        switch (configuration.orientation) {
          case BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM:
            startPoint = Point(node.x + node.width / 2,
                node.y + node.height); // bottom center of parent node
            endPoint = Point(
                child.x + child.width / 2, child.y); // top center of child node
            break;
          case BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP:
            startPoint = Point(
                node.x + node.width / 2, node.y); // top center of parent node
            endPoint = Point(child.x + child.width / 2,
                child.y + child.height); // bottom center of child node
            break;
          case BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT:
            startPoint = Point(node.x + node.width,
                node.y + node.height / 2); // right center of parent node
            endPoint = Point(child.x,
                child.y + child.height / 2); // left center of child node
            break;
          case BuchheimWalkerConfiguration.ORIENTATION_RIGHT_LEFT:
            startPoint = Point(
                node.x, node.y + node.height / 2); // left center of parent node
            endPoint = Point(child.x + child.width,
                child.y + child.height / 2); // right center of child node
        }

        final deltaX = endPoint.x - startPoint.x;
        final deltaY = endPoint.y - startPoint.y;

        final newStartPoint = Point(
            startPoint.x +
                (deltaX == 0
                    ? deltaX
                    : deltaX > 0
                        ? deltaX - 24
                        : deltaX + 24),
            startPoint.y + (deltaY * 3) / 4);

        var controlPoint1 = Point(newStartPoint.x, endPoint.y);
        var controlPoint2 = Point(endPoint.x, newStartPoint.y);

        linePath.moveTo(startPoint.x, startPoint.y);
        linePath.lineTo(startPoint.x, newStartPoint.y);
        linePath.lineTo(newStartPoint.x, newStartPoint.y);

        linePath.quadraticBezierTo(
            controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);

        // final lineAngel =
        //     atan2(controlPoint2.y - endPoint.y, controlPoint2.x - endPoint.x);
        // double delta = pi / 6;
        // for (var i in [0, 1]) {
        //   linePath.moveTo(endPoint.x, endPoint.y);
        //   linePath.lineTo(endPoint.x + (16 * cos(lineAngel + delta)),
        //       endPoint.y + (16 * sin(lineAngel + delta)));
        //   delta *= -1;
        // }

        canvas.drawPath(linePath, edgePaint);
      }
    }
  }
}
