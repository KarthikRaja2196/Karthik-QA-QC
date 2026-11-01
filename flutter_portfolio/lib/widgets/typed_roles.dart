import 'dart:async';

import 'package:flutter/material.dart';

import '../theme.dart';

/// Types each role, holds, deletes, moves on (65 ms per step), with a blinking caret.
class TypedRoles extends StatefulWidget {
  const TypedRoles({super.key, required this.roles});

  final List<String> roles;

  @override
  State<TypedRoles> createState() => _TypedRolesState();
}

class _TypedRolesState extends State<TypedRoles> {
  Timer? _timer;
  Timer? _blink;
  late String _display = widget.roles.first;
  bool _caretOn = true;
  int _roleIdx = 0;
  int _chars = 0;
  bool _deleting = false;
  int _hold = 0;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    // Reduced motion: leave the first role static rather than animating.
    if (MediaQuery.disableAnimationsOf(context)) return;
    _display = '';
    _timer = Timer.periodic(const Duration(milliseconds: 65), (_) => _tick());
    _blink = Timer.periodic(const Duration(milliseconds: 500), (_) => setState(() => _caretOn = !_caretOn));
  }

  void _tick() {
    if (_hold > 0) {
      _hold--;
      return;
    }
    final full = widget.roles[_roleIdx];
    if (!_deleting) {
      if (_chars < full.length) {
        _chars++;
      } else {
        _deleting = true;
        _hold = 26;
      }
    } else if (_chars > 0) {
      _chars--;
    } else {
      _deleting = false;
      _roleIdx = (_roleIdx + 1) % widget.roles.length;
      _hold = 4;
    }
    setState(() => _display = widget.roles[_roleIdx].substring(0, _chars));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blink?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(_display, style: mono(18, color: C.text), overflow: TextOverflow.clip, maxLines: 1)),
          const SizedBox(width: 2),
          Container(width: 10, height: 19, color: _caretOn || _timer == null ? C.accent : Colors.transparent),
        ],
      );
}
