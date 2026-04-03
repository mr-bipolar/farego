import 'package:flutter/material.dart';
import 'dart:math' as math;

class UniversalStepper extends StatefulWidget {
  final double min;
  final double max;
  final double step;
  final double initialValue;
  final int decimals;
  final double width;
  final ValueChanged<double> onChanged;

  const UniversalStepper({
    super.key,
    required this.min,
    required this.max,
    required this.step,
    this.initialValue = 0,
    this.decimals = 1,
    required this.onChanged,
    this.width = 80,
  });

  @override
  State<UniversalStepper> createState() => _UniversalStepperState();
}

class _UniversalStepperState extends State<UniversalStepper> {
  late int _valueSteps;
  late int _minSteps;
  late int _maxSteps;
  late int _stepValue;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final factor = math.pow(10, widget.decimals).toInt();

    _stepValue = (widget.step * factor).round();
    _minSteps = (widget.min * factor).round();
    _maxSteps = (widget.max * factor).round();
    _valueSteps = (widget.initialValue * factor).round();

    _controller = TextEditingController(
      text: (_valueSteps / factor).toStringAsFixed(widget.decimals),
    );
  }

  void _updateSteps(int newSteps) {
    newSteps = newSteps.clamp(_minSteps, _maxSteps);

    setState(() {
      _valueSteps = newSteps;
      _controller.text = (_valueSteps / math.pow(10, widget.decimals))
          .toStringAsFixed(widget.decimals);
    });

    widget.onChanged(_valueSteps / math.pow(10, widget.decimals));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _button(Icons.remove, () => _updateSteps(_valueSteps - _stepValue)),
        SizedBox(
          width: widget.width,
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
            ),
            onSubmitted: (text) {
              final parsed = double.tryParse(text);
              if (parsed == null) return;
              final factor = math.pow(10, widget.decimals).toInt();
              _updateSteps((parsed * factor).round());
            },
          ),
        ),
        _button(Icons.add, () => _updateSteps(_valueSteps + _stepValue)),
      ],
    );
  }

  Widget _button(IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
