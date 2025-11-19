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

  # Use apenas o path local para desenvolvimento
  s.source       = { :path => '.' }

  s.source_files = 'ios/**/*.{h,m,mm,swift}'

  s.dependency 'React-Core'
  s.dependency 'React-NativeModulesApple'
  s.dependency 'UsercentricsUI', "#{package['iosPackageVersion']}"
  s.dependency 'RNScreens'

  # Base C++ configuration
  # Note: RCT_NEW_ARCH_ENABLED is inherited from parent project build settings
  # This ensures compatibility with Expo's prebuild process
  base_cpp_flags = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++20',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'OTHER_CPLUSPLUSFLAGS' => '-std=c++20 -stdlib=libc++ $(inherited)',
    'CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER' => 'NO',
    'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'NO',
    'GCC_WARN_INHIBIT_ALL_WARNINGS' => 'YES',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'DEFINES_MODULE' => 'YES',
    # Ensure C++ standard library headers are accessible
    'USE_HEADERMAP' => 'YES',
    'ALWAYS_SEARCH_USER_PATHS' => 'NO'
  }

  # Header search paths - include React Native and C++ standard library paths
  header_search_paths = [
    '$(PODS_ROOT)/React-Core',
    '$(PODS_ROOT)/React-NativeModulesApple',
    '$(PODS_ROOT)/ReactCommon',
    '$(PODS_CONFIGURATION_BUILD_DIR)/ReactCommon',
    '$(PODS_TARGET_SRCROOT)',
    '$(PODS_ROOT)/Headers/Public',
    '$(PODS_ROOT)/Headers/Public/React-Core',
    '$(PODS_ROOT)/Headers/Public/ReactCommon'
  ]

  # Add new architecture paths if available (will be resolved at build time)
  header_search_paths += [
    '$(PODS_ROOT)/Headers/Public/React-Fabric',
    '$(PODS_ROOT)/Headers/Public/React-Codegen',
    '$(PODS_CONFIGURATION_BUILD_DIR)/React-Codegen/React_Codegen.framework/Headers',
    '$(PODS_CONFIGURATION_BUILD_DIR)/React-Fabric/React_Fabric.framework/Headers'
  ]

  base_cpp_flags['HEADER_SEARCH_PATHS'] = header_search_paths.map { |path| "\"#{path}\"" }.join(' ')

  # Preprocessor definitions - inherit RCT_NEW_ARCH_ENABLED from parent project
  # This allows Expo/React Native to control the new architecture flag
  base_cpp_flags['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited)'

  s.pod_target_xcconfig = base_cpp_flags

  s.user_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++20',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'OTHER_CPLUSPLUSFLAGS' => '-std=c++20 -stdlib=libc++ $(inherited)',
    'CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER' => 'NO',
    'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'NO',
    'GCC_WARN_INHIBIT_ALL_WARNINGS' => 'YES'
  }
end
