Deployment to Firebase Hosting (Flutter web)

This repo contains a GitHub Actions workflow that builds the Flutter web app and deploys it to Firebase Hosting.

What you must add to repository secrets (Settings → Secrets → Actions):
- FIREBASE_SERVICE_ACCOUNT_JSON : the full contents of your Firebase service account JSON (NOT base64-encoded). Copy the JSON file contents and paste as the secret value.
- FIREBASE_PROJECT_ID : your Firebase project id (example: my-project-id)

Notes:
- The workflow is set to run automatically on push to main and can also be triggered manually from the Actions tab.
- The workflow uses subosito/flutter-action to install Flutter and FirebaseExtended/action-hosting-deploy to publish to Hosting.
- Before deploying, ensure your Flutter app builds for web locally with: flutter build web

If you prefer to store the service account as base64, you can decode it in a custom workflow step and pass it to the deploy action. The simplest approach is to store the raw JSON content as the secret value.
