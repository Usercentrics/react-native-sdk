require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['iosPackageName']
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.platform     = :ios, "11.0"

  s.source       = { :git => "https://github.com/Usercentrics/usercentrics-react-native.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/**/*.{h,m,swift}"

  # React Native 0.78+ dependencies
  s.dependency 'React-Core'
  s.dependency 'React-NativeModulesApple'
  s.dependency 'UsercentricsUI', "#{package['iosPackageVersion']}"

  # C++20 support for React Native 0.78+
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++20',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/React-Core" "$(PODS_ROOT)/React-NativeModulesApple"'
  }

  # Ensure proper header search paths
  s.user_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++20',
    'CLANG_CXX_LIBRARY' => 'libc++'
  }

end
