#!/bin/bash
echo "=== 1. التحقق من حالة المستودع ==="
git status
echo "=== 2. سحب آخر التحديثات ==="
git pull origin main
echo "=== 3. تجهيز التعديلات وتجهيز البناء ==="
git add .
git commit -m "إعادة تهيئة البيئة واختبار alfaeq_yemen مع OpenSandbox"
git push origin main
echo "=== اكتملت العملية بنجاح! ==="
