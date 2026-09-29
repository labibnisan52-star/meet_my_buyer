import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageEnhancementService {
  static const String _apiEndpoint = 'https://image-api.photoroom.com/v2/edit';
  static const String _apiKey =
      'sandbox_sk_pr_default_5748b046395bfc68061b96d681ceb0d9f2a369ad';

  /// Enhances an image using a Cloud Image API.
  ///
  /// [imagePath] - The path or blob URL of the original image.
  /// [style] - The enhancement style selected by the user.
  ///
  /// Returns the enhanced image as Uint8List bytes (or original path if simulating).
  Future<dynamic> enhanceImage(String imagePath, String style) async {
    try {
      // 1. Read the file bytes using XFile (works safely on Web and Mobile)
      final xFile = XFile(imagePath);
      final bytes = await xFile.readAsBytes();

      if (_apiKey == 'YOUR_API_KEY_HERE') {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 3));
        return imagePath; // Return original path if simulating
      }

      // 2. Prepare the multipart request
      var request = http.MultipartRequest('POST', Uri.parse(_apiEndpoint));
      request.headers['x-api-key'] = _apiKey;

      // Set the background prompt based on the chosen style
      String prompt = '';
      if (style == 'Professional') {
        prompt =
            'studio lighting, clean white background, professional product photography';
      } else if (style == 'Vibrant') {
        prompt =
            'vibrant colors, bright background, high contrast, popping details';
      } else {
        prompt = 'creative artistic background';
      }

      request.fields['background.prompt'] = prompt;

      // Attach the image bytes
      request.files.add(
        http.MultipartFile.fromBytes(
          'imageFile',
          bytes,
          filename: 'product_image.jpg',
        ),
      );

      // 3. Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        // 4. Return the enhanced image bytes directly (avoids file system issues on Web)
        return await response.stream.toBytes();
      } else {
        final errorMsg = await response.stream.bytesToString();
        throw Exception(
          'API Request failed with status ${response.statusCode}: $errorMsg',
        );
      }
    } catch (e) {
      throw Exception('Failed to enhance image: $e');
    }
  }
}
