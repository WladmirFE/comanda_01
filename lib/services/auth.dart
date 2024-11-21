import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Retorna o usuário atual
  User? get currerntUser => _firebaseAuth.currentUser;

  // Retorna um stream para acompanhar as mudanças no estado de autenticação
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Método para realizar o logout
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Método para realizar login com email e senha
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Método para criar um novo usuário com email, senha e nome
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Atualizando o nome do usuário
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
