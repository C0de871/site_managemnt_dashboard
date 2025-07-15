import '../../../core/utils/constants/constant.dart';

enum CableStatus { ok, notOk }

extension CableStatusExtension on CableStatus {
  String get arabicName {
    switch (this) {
      case CableStatus.ok:
        return 'جيدة';
      case CableStatus.notOk:
        return 'غير جيدة';
    }
  }
}

extension GetCableStatus on String {
  CableStatus get cabaleStatus {
    switch (this) {
      case Constant.ok:
        return CableStatus.ok;
      case Constant.notOk:
        return CableStatus.notOk;
      default:
        return CableStatus.ok;
    }
  }
}
