import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class ChallengeController extends GetxController {
  var _isChecked1 = false.obs;
  var _isChecked2 = false.obs;
  var _isChecked3 = false.obs;

  get checkedOne => this._isChecked1;
  get checkedTwo => this._isChecked2;
  get checkedThree => this._isChecked3;
  set checkedValue(value) => value == 1
      ? this._isChecked1.value = !this._isChecked1.value
      : value == 2
          ? this._isChecked2.value = !this._isChecked2.value
          : this._isChecked3.value = !this._isChecked3.value;
}
