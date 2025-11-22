import 'package:flutter/material.dart';

import '../../models/comment_model.dart';
import '../../models/photo_model.dart';
import '../../models/user_model.dart';
import 'comment_item.dart';
import 'post_bloc.dart';

class PostScreen extends StatefulWidget {
  final PhotoModel photo;
  final UserModel user;

  const PostScreen({super.key, required this.photo, required this.user});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _bloc = PostBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getComments(widget.photo.id);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(),
            _buildPhotoContent(),
            _buildActionButtons(),
            const Divider(height: 1),
            _buildPostTitleAndTags(),
            _buildCommentSection(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              offset: const Offset(0, 2.0),
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Photo',
            style: TextStyle(
              color: Color(0xFF60107B),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF60107B)),
          actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    final userSeed = widget.user.id;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?u=${userSeed.toString()}',
            ),
          ),
          const SizedBox(width: 10),
          Text(
            widget.user.username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          const Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildPhotoContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Image.network(
        widget.photo.url,
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 300,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_border, size: 28),
              const SizedBox(width: 15),
              const Icon(Icons.chat_bubble_outline, size: 28),
              const SizedBox(width: 15),
              const Icon(Icons.send_outlined, size: 28),
            ],
          ),
          const Icon(Icons.bookmark_border, size: 28),
        ],
      ),
    );
  }

  Widget _buildPostTitleAndTags() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/100?img=4',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/100?img=5',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const Text('Liked by user_4 and 45 others'),
            ],
          ),
          const SizedBox(height: 8),

          Text(widget.photo.title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),

          const Text(
            '#photo #album_view #framebox',
            style: TextStyle(
              color: Color(0xFF60107B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          const Text(
            '2 days ago',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return StreamBuilder<List<CommentModel>?>(
      stream: _bloc.output,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final comments = snapshot.data;

        if (comments == null || comments.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Nenhum comentário ainda.'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                'Comentários (${comments.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentItem(comment: comments[index]);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
