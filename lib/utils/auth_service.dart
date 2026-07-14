import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if current user is signed in
  bool get isSignedIn => currentUser != null;

  // Check if current user is guest (anonymous)
  bool get isAnonymous => currentUser?.isAnonymous ?? false;

  // Sign In Anonymously (Guest)
  Future<UserCredential> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      print("AuthService: Error signing in anonymously: $e");
      rethrow;
    }
  }

  // Sign In With Google (OAuth)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) {
        // User aborted the sign-in flow
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("AuthService: Error signing in with Google: $e");
      rethrow;
    }
  }

  // Link Current Anonymous Account with Google
  Future<UserCredential?> linkWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) {
        // User aborted the sign-in flow
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final user = _auth.currentUser;
      if (user != null) {
        return await user.linkWithCredential(credential);
      }
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'No active guest user session found to link.',
      );
    } catch (e) {
      print("AuthService: Error linking Google account: $e");
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print("AuthService: Error signing out: $e");
      rethrow;
    }
  }
}
