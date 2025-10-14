cmake_minimum_required(VERSION 3.13)
set(CMAKE_VERBOSE_MAKEFILE ON)

# ---------------------------------------------------------
# Set CMAKE_PREFIX_PATH to locate fbjni and ReactAndroid
# This ensures that CMake can find the required packages
# when building the SDK in the sample app
# ---------------------------------------------------------
if(NOT DEFINED CMAKE_PREFIX_PATH)
    set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../node_modules/react-native/ReactAndroid/cmake-utils")
endif()
message(STATUS "CMAKE_PREFIX_PATH = ${CMAKE_PREFIX_PATH}")

# ---------------------------------------------------------
# Compiler options
# Enable exceptions, RTTI, C++20 standard, and all warnings
# ---------------------------------------------------------
add_compile_options(
        -fexceptions
        -frtti
        -std=c++20
        -Wall
)

# ---------------------------------------------------------
# Native source files
# Glob all .cpp files in the current directory
# ---------------------------------------------------------
file(GLOB RN_USERCENTRICS_SRC CONFIGURE_DEPENDS
        "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
)

# ---------------------------------------------------------
# Include generated codegen headers if they exist
# This allows integration with React Native New Architecture
# ---------------------------------------------------------
set(RN_USERCENTRICS_CODEGEN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build/generated/source/codegen/jni")
if(EXISTS "${RN_USERCENTRICS_CODEGEN_DIR}")
    include_directories("${RN_USERCENTRICS_CODEGEN_DIR}")

    # Only add the codegen subdirectory if its CMakeLists.txt exists
    if(EXISTS "${RN_USERCENTRICS_CODEGEN_DIR}/CMakeLists.txt")
        add_subdirectory(
                "${RN_USERCENTRICS_CODEGEN_DIR}"
                "${CMAKE_CURRENT_BINARY_DIR}/RNUsercentricsCodegen"
        )
    endif()
endif()

# ---------------------------------------------------------
# Create the shared library for the SDK
# ---------------------------------------------------------
add_library(rn_usercentrics SHARED ${RN_USERCENTRICS_SRC})
target_include_directories(rn_usercentrics PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# ---------------------------------------------------------
# Find required packages
# fbjni and ReactAndroid are needed for TurboModules and JNI
# ---------------------------------------------------------
find_package(fbjni REQUIRED CONFIG PATHS "${CMAKE_PREFIX_PATH}")
find_package(ReactAndroid REQUIRED CONFIG PATHS "${CMAKE_PREFIX_PATH}")

# ---------------------------------------------------------
# Link the required libraries
# - fbjni for JNI helper functions
# - ReactAndroid::jsi and reactnative for RN integration
# - android and log for NDK support
# ---------------------------------------------------------
target_link_libraries(
        rn_usercentrics
        fbjni::fbjni
        ReactAndroid::jsi
        ReactAndroid::reactnative
        android
        log
)

# ---------------------------------------------------------
# Optionally link the codegen module if it was generated
# This avoids CMake errors when the codegen is missing
# ---------------------------------------------------------
if(TARGET react_codegen_RNUsercentricsModule)
    target_link_libraries(rn_usercentrics react_codegen_RNUsercentricsModule)
endif()
