import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_time/common/model/dark_mode_model.dart';
import 'package:navigation_time/common/repos/dark_mode_repo.dart';

class DarkModeViewModel extends Notifier<DarkModeModel> {
  final DarkModeRepository _repository;

  DarkModeViewModel(this._repository);

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = DarkModeModel(darkMode: value);
  }

  @override
  DarkModeModel build() {
    return DarkModeModel(
      darkMode: _repository.isDarkMode(),
    );
  }
}

final darkModeProvider = NotifierProvider<DarkModeViewModel, DarkModeModel>(
  () => throw UnimplementedError(),
);
