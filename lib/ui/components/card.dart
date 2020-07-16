import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class PCard extends StatelessWidget {
  final String front;
  final String back;
  final Color color;
  PCard({this.front, this.back, this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.all(2),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                front: Container(
                  decoration: BoxDecoration(
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(front, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                back: Container(
                  decoration: BoxDecoration(
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(back, style: TextStyle(fontSize:16, fontWeight: FontWeight.bold )),
                        ),
                    ],
                ),
              ),
            ),
        );
  }
}