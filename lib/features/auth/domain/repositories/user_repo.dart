abstract class UserRepo {
  Future<Map<String, dynamic>> register(Map<String, dynamic> requestbody);
  Future<Map<String, dynamic>> login(Map<String, dynamic> requestbody);
  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> requestbody);
  Future<Map<String, dynamic>> resendVerification(Map<String, dynamic> requestbody);
}
