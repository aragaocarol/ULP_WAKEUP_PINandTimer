@echo off
cd /D C:\Users\mariacarolina.andrad\Downloads\banheiros\ULP_WAKEUP_PINandTimer\build\esp-idf\main\ulp_main || (set FAIL_LINE=2& goto :ABORT)
C:\Users\mariacarolina.andrad\.espressif\tools\xtensa-esp32-elf\esp-2021r2-patch3-8.4.0\xtensa-esp32-elf\bin\xtensa-esp32-elf-gcc.exe -E -P -xc -o ulp_fsm.ld -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/main/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/newlib/platform_include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/freertos/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/freertos/include/esp_additions/freertos -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/freertos/port/xtensa/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/freertos/include/esp_additions -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_hw_support/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_hw_support/include/soc -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_hw_support/include/soc/esp32 -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_hw_support/port/esp32/. -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_hw_support/port/esp32/private_include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/heap/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/log/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/lwip/include/apps -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/lwip/include/apps/sntp -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/lwip/lwip/src/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/lwip/port/esp32/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/lwip/port/esp32/include/arch -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/soc/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/soc/esp32/. -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/soc/esp32/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/hal/esp32/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/hal/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/hal/platform_port/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_rom/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_rom/include/esp32 -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_rom/esp32 -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_common/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_system/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_system/port/soc -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_system/port/public_compat -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp32/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/xtensa/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/xtensa/esp32/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/driver/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/driver/esp32/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_pm/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_ringbuf/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/efuse/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/efuse/esp32/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/vfs/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_wifi/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_event/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_netif/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_eth/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/tcpip_adapter/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_phy/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_phy/esp32/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_ipc/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/app_trace/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/esp_timer/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/nvs_flash/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/spi_flash/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/mbedtls/port/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/mbedtls/mbedtls/include -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/mbedtls/esp_crt_bundle/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/mbedtls/mbedtls/include/ -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/mbedtls/mbedtls/include/ -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/mbedtls/mbedtls/include/ -IC:/Users/mariacarolina.andrad/esp/esp-idf/components/ulp/include -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/main -IC:/Users/mariacarolina.andrad/Downloads/banheiros/ULP_WAKEUP_PINandTimer/build/config -D__ASSEMBLER__ C:/Users/mariacarolina.andrad/esp/esp-idf/components/ulp/ld/ulp_fsm.ld || (set FAIL_LINE=3& goto :ABORT)
goto :EOF

:ABORT
set ERROR_CODE=%ERRORLEVEL%
echo Batch file failed at line %FAIL_LINE% with errorcode %ERRORLEVEL%
exit /b %ERROR_CODE%