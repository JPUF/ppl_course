class Utils {
  static T? safeCast<T>(dynamic x) => x is T ? x : null;
}
