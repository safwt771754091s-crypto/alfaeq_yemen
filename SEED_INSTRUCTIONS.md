Firebase seed instructions

This repository now contains a seed script that populates Firestore with sample data (1 admin, 10 sellers, each with 10 products) and some basic Firestore security rules.

Files added:
- scripts/firebase_seed.js : Node script that uses firebase-admin to create users, sellers, categories and products.
- firebase/firestore.rules : Example security rules (role-based) for Firestore.
- .github/workflows/run-seed.yml : (optional) manual GitHub Actions workflow to run the seeder using secrets.

Important: DO NOT commit or upload your Firebase service account JSON to the repository. Instead, provide it locally or via GitHub Actions secrets.

Run locally (recommended for testing):
1) Install dependencies:
   cd repo-root
   npm install firebase-admin

2) Obtain a Firebase service account JSON file for your project (from Firebase Console → Project settings → Service accounts).

3) Run the seeder:
   node scripts/firebase_seed.js --serviceAccount=path/to/serviceAccount.json --projectId=your-project-id

Or using environment variables (base64 encoded service account):
   export FIREBASE_SERVICE_ACCOUNT_JSON=$(base64 path/to/serviceAccount.json)
   export FIREBASE_PROJECT_ID=your-project-id
   node scripts/firebase_seed.js

GitHub Actions (manual run):
- Add repository secrets:
  - FIREBASE_SERVICE_ACCOUNT_JSON : base64 encoded JSON content
  - FIREBASE_PROJECT_ID : your Firebase project id
- Go to Actions → Run seed → Run workflow (choose branch main)

After running, default admin credentials:
- Email: admin@example.com
- Password: Admin@12345

Sample sellers credentials:
- seller1@example.com ... seller10@example.com
- Password for all sellers: Seller@12345

Notes and next steps:
- Customize categories, product images, prices, or structure as needed.
- Adapt Firestore rules to your exact data model and test with the Firebase emulator before deploying.
- Consider enabling email verification and stronger passwords for production.
