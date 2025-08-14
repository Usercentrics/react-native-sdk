# Minimum CMake version required
cmake_minimum_required(VERSION 3.9.0)

# Project name
project(appmodules)

# === FORCE SHARED STL ===
# This ensures all native targets use c++_shared
set(CMAKE_ANDROID_STL_TYPE c++_shared)

# === INCLUDE DIRECTORIES ===
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
)

# === ADD LIBRARY TARGET ===
# Add your native library; adjust source files as needed
add_library(appmodules
    SHARED
    OnLoad.cpp
    rncli.cpp
)

# === SET C++ STANDARD ===
set_target_properties(appmodules PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
    POSITION_INDEPENDENT_CODE ON
)

# === COMPILE DEFINITIONS ===
target_compile_definitions(
    appmodules
    PRIVATE
    -DFOLLY_NO_CONFIG=1
)

# === FIND REACT NATIVE PACKAGES ===
find_package(ReactAndroid REQUIRED CONFIG)
find_package(fbjni REQUIRED CONFIG)

# === LINK LIBRARIES ===
# Adjust according to your RN version
target_link_libraries(appmodules
    ReactAndroid::reactnative
    ReactAndroid::jsi
    ReactAndroid::react_nativemodule_core
    ReactAndroid::react_utils
    ReactAndroid::reactnativejni
    ReactAndroid::fabricjni      # Fabric support
    ReactAndroid::react_debug
    ReactAndroid::react_render_core
    ReactAndroid::runtimeexecutor
    ReactAndroid::react_render_graphics
    ReactAndroid::rrc_view
    ReactAndroid::yoga
    ReactAndroid::rrc_text
    ReactAndroid::glog
    ReactAndroid::react_render_componentregistry
    fbjni::fbjni
    android
)