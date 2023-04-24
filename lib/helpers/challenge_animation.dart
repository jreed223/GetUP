import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getup_csc450/models/challenge.dart';
import '../widgets/challenge_cards.dart';
import 'package:getup_csc450/widgets/home_screen_challenge_card.dart';

class ChallengeAnimation extends StatefulWidget {
  final ChallengeShown challengeShown;
  final Challenge challenge;
  const ChallengeAnimation({required this.challengeShown, required this.challenge});

  @override
  _ChallengeAnimationState createState() => _ChallengeAnimationState();
}

class _ChallengeAnimationState extends State<ChallengeAnimation>
    with SingleTickerProviderStateMixin {
  Duration duration = const Duration(milliseconds: 500);
  AnimationController? _controller;
  Animation<double>? _animation;
  bool isDisplayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isDisplayed = true;
          });
        }
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!);

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<bool?> _showConfirmationDialog(Key? key) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Challenge'),
          content: const Text('Are you sure you want to delete this challenge?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        final confirmed = await _showConfirmationDialog(widget.challengeShown.key);
        if (confirmed == true) {
          _controller!.reverse();
          Future.delayed(duration).then((_) {
            Provider.of<ChallengeDataState>(context, listen: false)
                .deleteChallenge(widget.challenge.challengeId);
          });
        }
      },
      child: FadeTransition(
        opacity: _animation!,
        child: widget.challengeShown,
      ),
    );
  }
}