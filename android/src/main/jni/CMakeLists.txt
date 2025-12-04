cmake_minimum_required(VERSION 3.13)
project(rn_usercentrics)
set(CMAKE_VERBOSE_MAKEFILE ON)

# Set library name
set(LIB_TARGET_NAME rn_usercentrics)

# Add compile options
add_compile_options(
  -fexceptions
  -frtti
  -std=c++20
  -Wall
  -Wpedantic
  -Wno-gnu-zero-variadic-macro-arguments
  -Wno-dollar-in-identifier-extension
)

# Find source files
file(GLOB LIB_CUSTOM_SRCS CONFIGURE_DEPENDS *.cpp)

# Create the library
add_library(
  ${LIB_TARGET_NAME}
  SHARED
  ${LIB_CUSTOM_SRCS}
)

# Include directories
target_include_directories(
  ${LIB_TARGET_NAME}
  PUBLIC
  .
)

# Find ReactAndroid package first (required for version detection)
find_package(ReactAndroid REQUIRED CONFIG)

# Link libraries based on React Native version
if(DEFINED ReactAndroid_VERSION_MINOR AND ReactAndroid_VERSION_MINOR GREATER_EQUAL 76)
  target_link_libraries(
    ${LIB_TARGET_NAME}
    ReactAndroid::reactnative
    ReactAndroid::jsi
    ReactAndroid::fbjni
    android
    log
  )
else()
  # Fallback for older RN versions or when version is not available
  target_link_libraries(
    ${LIB_TARGET_NAME}
    ReactAndroid::reactnative
    ReactAndroid::jsi
    android
    log
  )
endif()

# Compile options - use standard approach for compatibility
target_compile_options(
  ${LIB_TARGET_NAME}
  PRIVATE
  -DLOG_TAG=\"ReactNative\"
  -fexceptions
  -frtti
  -std=c++20
  -Wall
)

# Additional include directories
target_include_directories(
 ${LIB_TARGET_NAME}
 PRIVATE
 ${CMAKE_CURRENT_SOURCE_DIR}
)