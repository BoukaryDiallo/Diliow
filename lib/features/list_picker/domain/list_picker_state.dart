import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_picker_state.freezed.dart';

@freezed
class ListPickerState with _$ListPickerState {
  const factory ListPickerState({
    @Default(<String>[]) List<String> options,
    int? winnerIndex,
    @Default(false) bool isPicking,
  }) = _ListPickerState;
}
