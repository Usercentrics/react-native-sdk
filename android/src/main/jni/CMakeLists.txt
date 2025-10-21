cmake_minimum_required(VERSION 3.13)
set(CMAKE_VERBOSE_MAKEFILE ON)

# Set library name
set(LIB_TARGET_NAME react_codegen_RNUsercentricsModule)

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

# Link libraries based on React Native version
if(ReactAndroid_VERSION_MINOR GREATER_EQUAL 76)
  target_link_libraries(
    ${LIB_TARGET_NAME}
    ReactAndroid::reactnative
    ReactAndroid::jsi
    fbjni::fbjni
  )
else()
  target_link_libraries(
    ${LIB_TARGET_NAME}
    fbjni
    folly_runtime
    glog
    jsi
    react_codegen_rncore
    react_debug
    react_nativemodule_core
    react_render_core
    react_render_debug
    react_render_graphics
    react_render_mapbuffer
    react_render_componentregistry
    react_utils
    rrc_view
    turbomodulejsijni
    yoga
  )
endif()

# Compile options based on React Native version
if(ReactAndroid_VERSION_MINOR GREATER_EQUAL 80)
  target_compile_reactnative_options(${LIB_TARGET_NAME} PRIVATE)
else()
  target_compile_options(
    ${LIB_TARGET_NAME}
    PRIVATE
    -DLOG_TAG=\"ReactNative\"
    -fexceptions
    -frtti
    -std=c++20
    -Wall
  )
endif()

# Additional include directories
target_include_directories(
 ${CMAKE_PROJECT_NAME}
 PUBLIC
 ${CMAKE_CURRENT_SOURCE_DIR}
)