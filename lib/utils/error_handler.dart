String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
    default:
      return "Something went wrong. Please try again. $errorCode";
  }
}
