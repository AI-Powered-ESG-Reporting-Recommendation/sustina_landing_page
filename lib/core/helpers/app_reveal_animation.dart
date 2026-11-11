import 'package:flutter/widgets.dart';

/// A subtle, performant entrance animation that fades, gently slides,
/// and optionally scales its [child] widget into place when entering the viewport.
///
/// Uses a single [AnimationController] with an [Interval] (avoiding fragile timers),
/// detaches scroll listeners after revealing once, and respects reduced-motion settings.
class AppRevealAnimation extends StatefulWidget {
  const AppRevealAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 520),
    this.offset = const Offset(0, 0.045),
    this.beginScale = 0.985,
    this.curve = Curves.easeOutCubic,
    this.triggerOnVisible = true,
    this.onRevealed,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final double beginScale;
  final Curve curve;
  final bool triggerOnVisible;
  final VoidCallback? onRevealed;

  @override
  State<AppRevealAnimation> createState() => _AppRevealAnimationState();
}

class _AppRevealAnimationState extends State<AppRevealAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  ScrollPosition? _scrollPosition;
  bool _hasTriggered = false;
  bool _postFrameScheduled = false;

  @override
  void initState() {
    super.initState();

    final totalMs =
        widget.delay.inMilliseconds + widget.duration.inMilliseconds;
    final totalDuration = Duration(milliseconds: totalMs > 0 ? totalMs : 1);
    final startInterval = totalMs > 0
        ? (widget.delay.inMilliseconds / totalMs).clamp(0.0, 0.85)
        : 0.0;

    _controller = AnimationController(
      vsync: this,
      duration: totalDuration,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        widget.onRevealed?.call();
      }
    });

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Interval(startInterval, 1.0, curve: widget.curve),
    );

    _fadeAnimation = curved;

    _slideAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(curved);

    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(curved);

    if (!widget.triggerOnVisible) {
      _hasTriggered = true;
      _controller.forward();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      _detachScrollListener();
      _hasTriggered = true;
      _controller.value = 1.0;
      return;
    }

    if (_hasTriggered) return;

    final scrollable = Scrollable.maybeOf(context);
    final newPosition = scrollable?.position;
    if (_scrollPosition != newPosition) {
      _detachScrollListener();
      _scrollPosition = newPosition;
      _scrollPosition?.addListener(_onScrollCheck);
    }

    _scheduleViewportCheck();
  }

  void _scheduleViewportCheck() {
    if (_hasTriggered || _postFrameScheduled) return;
    _postFrameScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postFrameScheduled = false;
      if (mounted && !_hasTriggered) {
        _checkVisibility();
      }
    });
  }

  void _onScrollCheck() {
    if (!mounted || _hasTriggered) return;
    _checkVisibility();
  }

  void _checkVisibility() {
    if (!mounted || _hasTriggered) return;

    if (_scrollPosition == null) {
      _triggerReveal();
      return;
    }

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox ||
        !renderObject.hasSize ||
        !renderObject.attached) {
      return;
    }

    final topLeft = renderObject.localToGlobal(Offset.zero);
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final bottomY = topLeft.dy + renderObject.size.height;

    // Trigger cleanly slightly before the widget enters the viewport
    if (topLeft.dy <= viewportHeight * 1.08 && bottomY >= -60) {
      _triggerReveal();
    }
  }

  void _triggerReveal() {
    if (_hasTriggered) return;
    _hasTriggered = true;
    _detachScrollListener();
    if (mounted) {
      _controller.forward();
    }
  }

  void _detachScrollListener() {
    _scrollPosition?.removeListener(_onScrollCheck);
    _scrollPosition = null;
  }

  @override
  void dispose() {
    _detachScrollListener();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (disableAnimations) {
      return widget.child;
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
