import 'package:flutter/material.dart';

class UserProgress extends ChangeNotifier {
  static final UserProgress _instance = UserProgress._internal();
  factory UserProgress() => _instance;
  UserProgress._internal();

  int _currentLevel = 1; // Starting at level 1 to match Academy initial state
  int _currentXP = 0;

  int get currentLevel => _currentLevel;
  int get currentXP => _currentXP;

  int get xpRequiredForNextLevel {
    if (_currentLevel >= 30) return 0;
    return 500 + (_currentLevel - 1) * 100;
  }

  double get xpProgress {
    if (_currentLevel >= 30) return 1.0;
    return _currentXP / xpRequiredForNextLevel;
  }

  void addXP(int xp) {
    if (_currentLevel >= 30) return;

    _currentXP += xp;
    while (_currentLevel < 30 && _currentXP >= xpRequiredForNextLevel) {        
      _currentXP -= xpRequiredForNextLevel;
      _currentLevel++;
    }
    if (_currentLevel >= 30) {
      _currentLevel = 30;
      _currentXP = 0;
    }
    notifyListeners();
  }
}

