// scripts/firebase_seed.js
// Usage:
// 1) Install dependencies: npm install firebase-admin
// 2) Run locally:
//    node scripts/firebase_seed.js --serviceAccount=path/to/serviceAccount.json --projectId=your-project-id
// Or set env vars: FIREBASE_SERVICE_ACCOUNT_JSON (base64) and FIREBASE_PROJECT_ID

const fs = require('fs');
const path = require('path');
const admin = require('firebase-admin');

function loadServiceAccountFromFile(filePath) {
  const resolved = path.resolve(filePath);
  if (!fs.existsSync(resolved)) throw new Error('Service account file not found: ' + resolved);
  return JSON.parse(fs.readFileSync(resolved, 'utf8'));
}

function loadServiceAccountFromEnv(base64Env) {
  const json = Buffer.from(base64Env, 'base64').toString('utf8');
  return JSON.parse(json);
}

function parseArgs() {
  const args = process.argv.slice(2);
  const out = {};
  args.forEach(arg => {
    if (arg.startsWith('--serviceAccount=')) out.serviceAccount = arg.split('=')[1];
    if (arg.startsWith('--projectId=')) out.projectId = arg.split('=')[1];
  });
  return out;
}

async function ensureUser(email, password, displayName, role) {
  try {
    const user = await admin.auth().getUserByEmail(email);
    console.log('User exists:', email);
    await admin.auth().setCustomUserClaims(user.uid, { role });
    return user.uid;
  } catch (e) {
    if (e.code === 'auth/user-not-found') {
      const userRecord = await admin.auth().createUser({ email, password, displayName });
      await admin.auth().setCustomUserClaims(userRecord.uid, { role });
      console.log('Created user:', email);
      return userRecord.uid;
    }
    throw e;
  }
}

async function seed({ projectId }) {
  console.log('Seeding Firestore for project:', projectId);
  const db = admin.firestore();

  const now = admin.firestore.FieldValue.serverTimestamp();

  // Create categories
  const categories = ['Electronics', 'Fashion', 'Home', 'Beauty', 'Sports', 'Toys', 'Books', 'Automotive', 'Groceries', 'Health'];
  const categoryRefs = {};
  for (const name of categories) {
    const slug = name.toLowerCase().replace(/\s+/g, '-');
    const docRef = db.collection('categories').doc(slug);
    await docRef.set({ name, slug, imageUrl: `https://via.placeholder.com/600x200?text=${encodeURIComponent(name)}`, createdAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
    categoryRefs[name] = docRef.id;
  }
  console.log('Categories created/updated.');

  // Create admin user
  const adminEmail = 'admin@example.com';
  const adminPassword = 'Admin@12345';
  const adminUid = await ensureUser(adminEmail, adminPassword, 'Admin', 'admin');

  // Create 10 sellers and for each create 10 products
  for (let s = 1; s <= 10; s++) {
    const sellerEmail = `seller${s}@example.com`;
    const sellerPassword = 'Seller@12345';
    const sellerName = `Seller ${s}`;
    const sellerUid = await ensureUser(sellerEmail, sellerPassword, sellerName, 'seller');

    const sellerDocRef = db.collection('sellers').doc();
    const sellerDoc = {
      name: sellerName,
      description: `Official store of ${sellerName}.`,
      logoUrl: `https://via.placeholder.com/200x100?text=${encodeURIComponent(sellerName)}`,
      ownerUserId: sellerUid,
      status: 'active',
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    };
    await sellerDocRef.set(sellerDoc);
    console.log('Created seller:', sellerName);

    // Create 10 products
    for (let p = 1; p <= 10; p++) {
      const title = `${sellerName} Product ${p}`;
      const categoryIndex = ((s + p) % categories.length);
      const categoryName = categories[categoryIndex];
      const productDocRef = db.collection('products').doc();
      const price = Math.round((Math.random() * 90 + 10) * 100) / 100; // 10.00 - 100.00
      const product = {
        sellerId: sellerDocRef.id,
        title,
        description: `${title} is a high quality product by ${sellerName}.`,
        price,
        currency: 'USD',
        stock: Math.floor(Math.random() * 50) + 1,
        category: categoryRefs[categoryName] || null,
        images: [ `https://via.placeholder.com/400x400?text=${encodeURIComponent(title)}` ],
        sku: `SKU-${s}-${p}`,
        active: true,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      };
      await productDocRef.set(product);
    }
    console.log(`Created 10 products for ${sellerName}`);
  }

  console.log('Seeding finished. Admin:', adminEmail, 'password:', adminPassword);
  console.log('Seller accounts: seller1..seller10@example.com  password: Seller@12345');
}

(async () => {
  try {
    const args = parseArgs();
    let serviceAccount;
    if (args.serviceAccount) serviceAccount = loadServiceAccountFromFile(args.serviceAccount);
    else if (process.env.FIREBASE_SERVICE_ACCOUNT_JSON) serviceAccount = loadServiceAccountFromEnv(process.env.FIREBASE_SERVICE_ACCOUNT_JSON);
    else throw new Error('Provide a service account via --serviceAccount=path or FIREBASE_SERVICE_ACCOUNT_JSON env var (base64)');

    const projectId = args.projectId || process.env.FIREBASE_PROJECT_ID;
    if (!projectId) throw new Error('Provide --projectId or FIREBASE_PROJECT_ID env var');

    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      projectId
    });

    await seed({ projectId });
    process.exit(0);
  } catch (err) {
    console.error('Error seeding:', err);
    process.exit(1);
  }
})();
