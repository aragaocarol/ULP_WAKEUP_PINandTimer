# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/mariacarolina.andrad/esp/esp-idf/components/ulp/cmake"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/esp-idf/main/ulp_main"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/esp-idf/main/ulp_main-prefix"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/esp-idf/main/ulp_main-prefix/tmp"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/esp-idf/main/ulp_main-prefix/src/ulp_main-stamp"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/esp-idf/main/ulp_main-prefix/src"
  "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/esp-idf/main/ulp_main-prefix/src/ulp_main-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/mariacarolina.andrad/Downloads/ULP_WAKEUP_PINandTimer/build/esp-idf/main/ulp_main-prefix/src/ulp_main-stamp/${subDir}")
endforeach()
