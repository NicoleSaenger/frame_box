import 'package:flutter/material.dart';

import '../../models/comment_model.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0, right: 8.0),
            child: Icon(
              Icons.comment_outlined,
              size: 18,
              color: Color(0xFF60107B),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.email.split('@')[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF60107B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  comment.body,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
