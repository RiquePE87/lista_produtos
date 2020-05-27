import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class MLkitProvider {
  FirebaseVision _firebaseVision = FirebaseVision.instance;

  Future<String> getImagem(var imagem) async {
    File _imagem = imagem;
    final FirebaseVisionImage _visionImage = FirebaseVisionImage.fromFile(
        _imagem);
    final TextRecognizer _textRecognizer = _firebaseVision.textRecognizer();
    final VisionText _visionText = await _textRecognizer.processImage(_visionImage);
    String _detectedText = _visionText.text;
    return _detectedText;
  }

}