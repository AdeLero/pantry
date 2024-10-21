import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/screens/meal_time/meal_time_provider.dart';
import 'package:provider/provider.dart';

class MealtimeCountdown extends StatefulWidget {
  final TimeOfDay breakfastTime;
  final TimeOfDay lunchTime;
  final TimeOfDay dinnerTime;

  const MealtimeCountdown({
    Key? key,
    required this.breakfastTime,
    required this.lunchTime,
    required this.dinnerTime,
  }) : super(key: key);

  @override
  State<MealtimeCountdown> createState() => _MealtimeCountdownState();
}

class _MealtimeCountdownState extends State<MealtimeCountdown> {
  late String _mealTime;
  late DateTime _nextMealTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _nextMealTime = DateTime.now().add(Duration(seconds: 1));
    _initializeMealTime();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateNextMealTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeMealTime() {
    _updateMealTime();

    Timer.periodic(Duration(minutes:1), (Timer timer) {
      if (mounted) {
        _updateMealTime();
      }
    });
  }

  void _updateMealTime() {
    DateTime now = DateTime.now();
    TimeOfDay currentTime = TimeOfDay.fromDateTime(now);

    if (currentTime.hour < widget.breakfastTime.hour ||
        (currentTime.hour == widget.breakfastTime.hour &&
            currentTime.minute < widget.breakfastTime.minute)) {
      if (mounted) {
        setState(() {
          _mealTime = 'Breakfast';
        });
      }
    } else if (currentTime.hour < widget.lunchTime.hour ||
        (currentTime.hour == widget.lunchTime.hour &&
            currentTime.minute < widget.lunchTime.minute)) {
      if (mounted) {
        setState(() {
          _mealTime = 'Lunch';
        });
      }
    } else if (currentTime.hour < widget.dinnerTime.hour ||
        (currentTime.hour == widget.dinnerTime.hour &&
            currentTime.minute < widget.dinnerTime.minute)) {
      if (mounted) {
        setState(() {
          _mealTime = 'Dinner';
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _mealTime = 'Breakfast';
        });
      }
    }
  }

  void _updateNextMealTime() {
    DateTime now =DateTime.now();
    DateTime nextMealTime;

    switch (_mealTime) {
      case 'Breakfast':
        nextMealTime = DateTime(
          now.year,
          now.month,
          now.day,
          widget.breakfastTime.hour,
          widget.breakfastTime.minute,
        );
        break;
      case 'Lunch':
        nextMealTime = DateTime(
          now.year,
          now.month,
          now.day,
          widget.lunchTime.hour,
          widget.lunchTime.minute,
        );
        break;
      case 'dinner':
        nextMealTime = DateTime(
          now.year,
          now.month,
          now.day,
          widget.dinnerTime.hour,
          widget.dinnerTime.minute,
        );
        break;
      default:
        nextMealTime = now;
        break;
    }

    if (nextMealTime.isBefore(now)) {
      nextMealTime = nextMealTime.add(Duration(days: 1));
    }

    if (nextMealTime != _nextMealTime) {
      setState(() {
        _nextMealTime = nextMealTime;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateMealTime();
      _updateNextMealTime();
    });
  }

  Widget _buildCountdownTimer() {
    if (_nextMealTime == null) {
      return Container();
    }
    Duration timeDifference = _nextMealTime.difference(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: timeDifference.inSeconds < 60 ? AppColors.deepRed : AppColors.deepGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              '${timeDifference.inHours}',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: timeDifference.inSeconds < 60 ? AppColors.lightRed : AppColors.lightGreen,
              ),
            ),
          ),
        ),
        SizedBox(width: 10,),
        Text(
          ':',
          style: TextStyle(
            color: timeDifference.inSeconds < 60 ? AppColors.lightRed : AppColors.lightGreen,
            fontWeight: FontWeight.w800,
            fontSize: 50,
          ),
        ),
        SizedBox(width: 10,),
        Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: timeDifference.inSeconds < 60 ? AppColors.deepRed : AppColors.deepGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              '${timeDifference.inMinutes.remainder(60)}',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                color: timeDifference.inSeconds < 60 ? AppColors.lightRed : AppColors.lightGreen,
              ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Column(
        children: [
          Text(
            'Next $_mealTime in',
            style: TextStyle(
              color: AppColors.deepGreen,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          _buildCountdownTimer(),
        ],
      ),
    );
  }
}
