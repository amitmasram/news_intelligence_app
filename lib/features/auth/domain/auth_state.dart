/// Represents the different states of the authentication process.
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

/// Holds the state for the authentication feature.
class AuthState {
  /// The current status of authentication.
  final AuthStatus status;
  
  /// An optional error message if the status is [AuthStatus.error].
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.errorMessage,
  });

  /// Factory for the initial state of the application.
  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);
  
  /// Factory for when an authentication action is in progress.
  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);
  
  /// Factory for when the user is successfully authenticated.
  factory AuthState.authenticated() => const AuthState(status: AuthStatus.authenticated);
  
  /// Factory for when the user is not authenticated.
  factory AuthState.unauthenticated() => const AuthState(status: AuthStatus.unauthenticated);
  
  /// Factory for when an authentication error occurs.
  factory AuthState.error(String message) => AuthState(status: AuthStatus.error, errorMessage: message);

  /// Helper getter to check if the state is currently loading.
  bool get isLoading => status == AuthStatus.loading;
  
  /// Helper getter to check if the user is authenticated.
  bool get isAuthenticated => status == AuthStatus.authenticated;
  
  /// Helper getter to check if the user is unauthenticated.
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  
  /// Helper getter to check if an error has occurred.
  bool get isError => status == AuthStatus.error;
}
