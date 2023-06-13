import 'package:flutter/material.dart';
import 'package:ist/stories/models/content_data.dart';
import 'package:ist/stories/screens/widgets/message_area.dart';
import 'package:video_player/video_player.dart';

// 画像や動画を表示するWidget
class Content extends StatefulWidget {
  const Content({
    super.key,
    required this.contentData,
    required this.focusNode,
    required this.textController,
    required this.videoController,
    required this.isLongPress,
  });

  final ContentData contentData;
  final FocusNode focusNode;
  final TextEditingController textController;
  final VideoPlayerController? videoController;
  final bool isLongPress;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: () {
              switch (widget.contentData.media) {
                case MediaType.image:
                  return Container(
                    constraints: const BoxConstraints.expand(),
                    child: Image(
                      image: NetworkImage(widget.contentData.url),
                      fit: BoxFit.fitWidth,
                    ),
                  );
                case MediaType.video:
                  final videoController = widget.videoController;
                  if (videoController == null ||
                      !videoController.value.isInitialized) {
                    return const SizedBox.shrink();
                  }
                  return FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                      width: videoController.value.size.width,
                      height: videoController.value.size.height,
                      child: VideoPlayer(videoController),
                    ),
                  );
              }
            }(),
          ),
        ),
        AnimatedOpacity(
          opacity: widget.isLongPress ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          child: MessageArea(
            focusNode: widget.focusNode,
            textController: widget.textController,
          ),
        ),
      ],
    );
  }
}
