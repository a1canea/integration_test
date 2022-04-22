import 'package:flutter/material.dart';

import '../models/post.dart';

class PostsListItem extends StatelessWidget {
  final Post post;

  const PostsListItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      child: ListTile(
        leading: Text(
          '${post.id}',
          style: textTheme.caption,
        ),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}
