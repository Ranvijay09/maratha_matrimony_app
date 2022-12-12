import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';

class ChatCardSkeleton extends StatelessWidget {
  const ChatCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: COLOR_GREY.withOpacity(.4)),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: COLOR_GREY.withOpacity(.4)),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: COLOR_GREY.withOpacity(.4)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
