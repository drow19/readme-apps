import 'dart:async';

import 'package:book_store_apps/widgets/alert/src/debug.dart';
import 'package:book_store_apps/widgets/alert/src/toast_list_item_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef ToastListItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
  Animation<double> animation,
);

class ToastTimer {
  int time;
  Duration duration;
  dynamic item;
  int index;

  ToastTimer(this.time, this.duration, this.item, this.index);
}

// ignore: must_be_immutable
class ToastListOverlay<T> extends StatefulWidget {
  ToastListOverlay({
    super.key,
    required this.child,
    this.timeoutDuration,
    this.position = Alignment.topCenter,
    this.reverse = false,
    this.limit = 5,
    required this.itemBuilder,
  });

  final Widget child;
  Duration? timeoutDuration;
  final Alignment position;
  final bool reverse;
  int? limit;
  final ToastListItemBuilder<T> itemBuilder;

  static ToastListOverlayState of<T>(BuildContext context) {
    assert(debugCheckHasToastListOverlay<T>(context));

    final _ToastListScope scope =
        context.dependOnInheritedWidgetOfExactType<_ToastListScope>()!;
    return scope._toastListOverlayState;
  }

  @override
  ToastListOverlayState<T> createState() => ToastListOverlayState<T>();
}

class ToastListOverlayState<T> extends State<ToastListOverlay<T>> {
  OverlayEntry? _overlayEntry;
  bool _isOverlayVisible = false;
  final _listItemNotifier = ToastListItemNotifier<T>();
  final _animatedListKey = GlobalKey<AnimatedListState>();
  Timer? countdownTimer;
  final List<ToastTimer> timerList = [];

  void show(BuildContext context, T toast) {
    if (!_isOverlayVisible) {
      try {
        _overlayEntry = OverlayEntry(
          builder: (context) {
            return SafeArea(
              child: Align(
                alignment: widget.position,
                child: Material(
                  color: Colors.transparent,
                  child: AnimatedList(
                    reverse: widget.reverse,
                    key: _animatedListKey,
                    initialItemCount: _listItemNotifier.listItem.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index, animation) {
                      final listItem = _listItemNotifier.listItem[index];

                      return widget.itemBuilder(
                        context,
                        listItem,
                        index,
                        animation,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );

        Overlay.of(context).insert(_overlayEntry!);
        _isOverlayVisible = true;
      } catch (e) {
        debugPrint('ToastListOverlay $e');
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // executes after build'
      if (_listItemNotifier.listItem.isEmpty) {
        countdownTimer = Timer.periodic(
          const Duration(milliseconds: 500),
          (timer) {
            if (_listItemNotifier.listItem.isEmpty) timer.cancel();

            final currentTime = DateTime.now().millisecondsSinceEpoch;

            final overTimedItems = timerList.where(
              (time) {
                final difference = currentTime - time.time;
                final maxDuration =
                    (widget.timeoutDuration ?? const Duration(seconds: 4))
                        .inMilliseconds;

                if (difference >= maxDuration) return true;

                return false;
              },
            ).toList();

            for (final overTimedItem in overTimedItems) {
              removeItem(
                overTimedItem.item,
                (context, animation) => widget.itemBuilder(
                  context,
                  overTimedItem.item,
                  overTimedItem.index,
                  animation,
                ),
              );
            }
          },
        );
      }

      if (_listItemNotifier.listItem.length == widget.limit) {
        final lastItem = _listItemNotifier.listItem.last;

        removeItem(
          lastItem,
          (context, animation) => widget.itemBuilder(
            context,
            lastItem,
            _listItemNotifier.listItem.indexOf(lastItem),
            animation,
          ),
        );
      }

      timerList.insert(
        0,
        ToastTimer(
          DateTime.now().millisecondsSinceEpoch,
          widget.timeoutDuration ?? const Duration(seconds: 1),
          toast,
          0,
        ),
      );

      _listItemNotifier.insert(0, toast);
      _animatedListKey.currentState?.insertItem(0);
    });
  }

  @override
  void initState() {
    super.initState();
    assert(widget.limit! > 0, 'Limit must have greather than 0');
  }

  void listItemChangeListener() {
    final listItem = _listItemNotifier.listItem;

    if (listItem.isEmpty && _isOverlayVisible) {
      try {
        disposeAll();
      } catch (e) {
        debugPrint('$e');
      }

      _isOverlayVisible = false;
    }
  }

  @override
  void dispose() {
    disposeAll();
    super.dispose();
  }

  void disposeAll() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _overlayEntry?.remove();
      countdownTimer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ToastListScope(
      toastListOverlayState: this,
      child: widget.child,
    );
  }

  void removeItem(
    T item,
    Widget Function(BuildContext, Animation<double>) builder,
  ) {
    final itemIndex = _listItemNotifier.listItem.indexOf(item);

    if (itemIndex == -1) return;

    timerList.removeAt(itemIndex);
    _listItemNotifier.remove(itemIndex);

    _animatedListKey.currentState?.removeItem(
      itemIndex,
      (context, animation) {
        void handler(status) {
          if (status == AnimationStatus.dismissed ||
              status == AnimationStatus.completed) {
            animation.removeStatusListener(handler);
            listItemChangeListener();
          }
        }

        animation.addStatusListener(handler);

        return builder(context, animation);
      },
    );
  }
}

class _ToastListScope extends InheritedWidget {
  const _ToastListScope({
    required super.child,
    required ToastListOverlayState toastListOverlayState,
  }) : _toastListOverlayState = toastListOverlayState;

  final ToastListOverlayState _toastListOverlayState;

  @override
  bool updateShouldNotify(_ToastListScope old) =>
      _toastListOverlayState != old._toastListOverlayState;
}
