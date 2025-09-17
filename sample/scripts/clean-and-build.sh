#!/bin/bash

set -e

echo "🧹 Script simplificado de limpeza e build..."

# ------------------------------
# LIMPEZA DE CACHE
# ------------------------------
echo "📂 Limpando DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*

echo "🏗️ Limpando builds antigos do projeto iOS..."
cd ios
rm -rf build
xcodebuild clean || echo "⚠️  xcodebuild clean falhou, continuando..."
rm -rf Pods
cd ..

echo "🥣 Limpando cache do CocoaPods..."
pod cache clean --all
rm -rf ~/Library/Caches/CocoaPods

echo "🧶 Limpando cache do Yarn..."
yarn cache clean

echo "🚀 Limpando cache do Metro bundler..."
rm -rf /tmp/metro-*

# ------------------------------
# INSTALAÇÃO DOS PODS
# ------------------------------
echo "📦 Instalando pods..."
cd ios
pod install --repo-update
cd ..

# ------------------------------
# VERIFICAÇÃO DE XCFRAMEWORKS
# ------------------------------
echo "🔍 Verificando XCFrameworks disponíveis..."
XCFRAMEWORKS=("UsercentricsUI")
for XCFRAMEWORK in "${XCFRAMEWORKS[@]}"; do
  XCFRAMEWORK_PATH="ios/Pods/$XCFRAMEWORK/$XCFRAMEWORK.xcframework"
  if [ -d "$XCFRAMEWORK_PATH" ]; then
    echo "✅ $XCFRAMEWORK XCFramework encontrado em: $XCFRAMEWORK_PATH"
  else
    echo "⚠️  $XCFRAMEWORK XCFramework não encontrado em: $XCFRAMEWORK_PATH"
  fi
done

# ------------------------------
# BUILD FINAL DO APP
# ------------------------------
echo ""
echo "📦 Construindo o app final..."
echo "=========================================="

cd ios
xcodebuild -workspace sample.xcworkspace \
  -scheme sample \
  -configuration Debug \
  -sdk iphonesimulator \
  BUILD_DIR=build clean build

echo ""
echo "🎉 Build final do app concluído com sucesso!"
echo "✅ O app foi construído e está pronto para uso no simulador"
