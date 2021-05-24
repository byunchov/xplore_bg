import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninBloc extends ChangeNotifier {
  SigninBloc() {
    checkSignIn();
    checkGuestUser();
    initPackageInfo();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignin = new GoogleSignIn();
  final FacebookLogin _fbLogin = new FacebookLogin();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _errorCode;
  String get errorCode => _errorCode;

  String _name;
  String get name => _name;

  String _uid;
  String get uid => _uid;

  String _email;
  String get email => _email;

  String _imageUrl;
  String get imageUrl => _imageUrl;

  String _joinDate;
  String get joinDate => _joinDate;

  int _lovedCount;
  int get lovedCount => _lovedCount;

  int _bookmarksCount;
  int get bookmarksCount => _bookmarksCount;

  String _signInProvider;
  String get signInProvider => _signInProvider;

  String timestamp;

  String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;

  void initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    _packageName = packageInfo.packageName;
    notifyListeners();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignin
        .signIn()
        .catchError((error) => print('error : $error'));
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        User userDetails =
            (await _firebaseAuth.signInWithCredential(credential)).user;

        this._name = userDetails.displayName;
        this._email = userDetails.email;
        this._imageUrl = userDetails.photoURL;
        this._uid = userDetails.uid;
        this._signInProvider = 'google';

        _hasError = false;
        notifyListeners();
      } catch (e) {
        _hasError = true;
        _errorCode = e.toString();
        notifyListeners();
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future signInwithFacebook() async {
    User currentUser;
    final FacebookLoginResult fbLoginResult = await _fbLogin
        .logIn(['email', 'public_profile']).catchError(
            (error) => print('error: $error'));
    if (fbLoginResult.status == FacebookLoginStatus.cancelledByUser) {
      _hasError = true;
      _errorCode = 'cancel';
      notifyListeners();
    } else if (fbLoginResult.status == FacebookLoginStatus.error) {
      _hasError = true;
      notifyListeners();
    } else {
      try {
        if (fbLoginResult.status == FacebookLoginStatus.loggedIn) {
          FacebookAccessToken facebookAccessToken = fbLoginResult.accessToken;
          final AuthCredential credential =
              FacebookAuthProvider.credential(facebookAccessToken.token);
          final User user =
              (await _firebaseAuth.signInWithCredential(credential)).user;
          assert(user.email != null);
          assert(user.displayName != null);
          assert(!user.isAnonymous);
          assert(await user.getIdToken() != null);
          currentUser = _firebaseAuth.currentUser;
          assert(user.uid == currentUser.uid);

          this._name = user.displayName;
          this._email = user.email;
          this._imageUrl = user.photoURL;
          this._uid = user.uid;
          this._signInProvider = 'facebook';

          _hasError = false;
          notifyListeners();
        }
      } catch (e) {
        _hasError = true;
        _errorCode = e.toString();
        notifyListeners();
      }
    }
  }

  Future<bool> checkIfUserExists() async {
    DocumentSnapshot snap = await firestore.collection('users').doc(_uid).get();
    if (snap.exists) {
      print('User Exists');
      return true;
    } else {
      print('New user');
      return false;
    }
  }

  Future saveToFirebase() async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    var userData = {
      'name': _name,
      'email': _email,
      'uid': _uid,
      'profile_image': _imageUrl,
      'join_date': _joinDate,
      'loved_places': [],
      'bookmarked_places': [],
      'loved_count': 0,
      'bookmarks_count': 0,
    };
    await ref.set(userData);
  }

  Future getJoinDate() async {
    DateTime now = DateTime.now();
    _joinDate = DateFormat('yyyyMMddTHHmmss').format(now);
    notifyListeners();
  }

  Future saveDataToSP() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString('name', _name);
    await sp.setString('email', _email);
    await sp.setString('image_url', _imageUrl);
    await sp.setString('uid', _uid);
    await sp.setString('join_date', _joinDate);
    await sp.setString('sign_in_provider', _signInProvider);
    await sp.setInt('loved_count', _lovedCount);
    await sp.setInt('bookmarks_count', _bookmarksCount);
    print("saveDataToSP() called.");
  }

  Future getDataFromSP() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name');
    _email = sp.getString('email');
    _imageUrl = sp.getString('image_url');
    _uid = sp.getString('uid');
    _joinDate = sp.getString('join_date');
    _signInProvider = sp.getString('sign_in_provider');
    _lovedCount = sp.getInt('loved_count');
    _bookmarksCount = sp.getInt('bookmarks_count');
    notifyListeners();
    print("getDataFromSP() $_name");
  }

  Future getUserDataFromFirebase(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snap) {
      this._uid = snap.data()['uid'];
      this._name = snap.data()['name'];
      this._email = snap.data()['email'];
      this._imageUrl = snap.data()['profile_image'];
      this._joinDate = snap.data()['join_date'];
      this._lovedCount = snap.data()['loved_count'];
      this._bookmarksCount = snap.data()['bookmarks_count'];
      print(_name);
    });
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
    print("checkSignIn() $_isSignedIn");
  }

  Future userSignout() async {
    if (_signInProvider == 'facebook') {
      await _firebaseAuth.signOut();
      await _fbLogin.logOut();
    } else if (_signInProvider == 'google') {
      await _firebaseAuth.signOut();
      await _googleSignin.signOut();
    }
    await clearAllData();
    _isSignedIn = false;
    _guestUser = false;
    notifyListeners();
    print("userSignout()");
  }

  Future setGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', true);
    _guestUser = true;
    notifyListeners();
    print("setGuestUser() $_guestUser");
  }

  void checkGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _guestUser = sp.getBool('guest_user') ?? false;
    notifyListeners();
  }

  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
    print("guestSignout() $_guestUser");
  }

  Future updateUserProfile(String newName, String newImageUrl) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'name': newName,
      'profile_image': newImageUrl,
    });

    sp.setString('name', newName);
    sp.setString('profile_image', newImageUrl);
    _name = newName;
    _imageUrl = newImageUrl;

    notifyListeners();
  }
}
