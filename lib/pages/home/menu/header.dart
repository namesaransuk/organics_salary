// import 'package:flutter/material.dart';
// import 'package:organics_salary/theme.dart';

// class _DiagonalHeaderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();

//     //Properties
//     paint.color = Colors.deepPurple;
//     paint.style = PaintingStyle.fill;
//     paint.strokeWidth = 5.0;

//     /*Path start always in 0,0 position
//     * x,y
//     * */
//     final path = Path();
//     path.lineTo(0, size.height * .45);
//     path.lineTo(size.width, size.height * .25);
//     path.lineTo(size.width, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

// /*3.  TRIANGLE HEADER*/
// class _TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = new Paint();
//     paint.color = Colors.deepOrange;
//     paint.strokeWidth = 5.0;
//     paint.style = PaintingStyle.fill;

//     final path = new Path();
//     path.lineTo(0, size.height * .25);
//     path.lineTo(size.width * .5, size.height * .35);
//     path.lineTo(size.width, size.height * .25);
//     path.lineTo(size.width, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

// /*4.  CURVE HEADER*/
// class _CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = new Paint();
//     paint.color = Colors.teal;
//     paint.strokeWidth = 20.0;
//     paint.style = PaintingStyle.fill;

//     final path = new Path();
//     path.lineTo(0, size.height * .25);
//     path.quadraticBezierTo(
//         size.width * 0.50, size.height * .50, size.width, size.height * .25);
//     path.lineTo(size.width, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

/*5.   HEADER*/
// class _WavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//     paint.color = AppTheme.ognSoftGreen;
//     paint.strokeWidth = 20.0;
//     paint.style = PaintingStyle.fill;

//     final path = Path();
//     path.lineTo(0, size.height * .25);
//     path.quadraticBezierTo(size.width * .25, size.height * .30, size.width * .5,
//         size.height * .25);
//     path.quadraticBezierTo(
//         size.width * .75, size.height * .20, size.width, size.height * .25);
//     path.lineTo(size.width, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
