# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/mariacarolina.andrad/esp/esp-idf/components/bootloader/subproject"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/bootloader"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/bootloader-prefix"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/bootloader-prefix/tmp"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/bootloader-prefix/src/bootloader-stamp"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/bootloader-prefix/src"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/bootloader-prefix/src/bootloader-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/bootloader-prefix/src/bootloader-stamp/${subDir}")
endforeach()
