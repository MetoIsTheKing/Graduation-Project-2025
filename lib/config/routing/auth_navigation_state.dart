// This file is used to save the original route (page) when navigating to the login page.

class AuthNavigationState {
  String? _onSuccessRedirectRouteName;

  String? get routeName => _onSuccessRedirectRouteName;

  // Call this BEFORE navigating to login
  void setRedirectRoute(String? routeName) {
    _onSuccessRedirectRouteName = routeName;
  }

  // Call this AFTER a successful login to clean up
  void clearRedirectRoute() {
    _onSuccessRedirectRouteName = null;
  }
}
