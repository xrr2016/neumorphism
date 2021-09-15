import 'dart:ui';
import 'package:flutter/material.dart';

import '../exports.dart';

class CardPage extends StatefulWidget {
  static String routeName = 'card_page';

  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: NetworkImage(
          //       'https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_960_720.jpg'),
          //   fit: BoxFit.cover,
          // ),
          color: Colors.black26,
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20.0,
                  sigmaY: 20.0,
                ),
                child: Container(
                    width: 360,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.2),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Card',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.75))),
                              Icon(
                                Icons.credit_card_sharp,
                                color: Colors.white.withOpacity(0.75),
                              )
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('TL Templates',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.75))),
                              Text('07/25',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.75))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('5555 5555 5555 4444',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.75))),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
