
#include <stdio.h>

// Bibliotecas para o acelerometro //
#include "esp_sleep.h"
#include "soc/rtc_cntl_reg.h"
#include "soc/sens_reg.h"
#include "soc/rtc_periph.h"
#include "driver/gpio.h"
#include "driver/rtc_io.h"
#include "esp32/ulp.h"
#include "ulp_main.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "esp_event.h"
#include "nvs_flash.h"
#include "esp_log.h"
#include "esp8266_wrapper.h"
#include "../../global.h"

extern const uint8_t ulp_main_bin_start[] asm("_binary_ulp_main_bin_start");
extern const uint8_t ulp_main_bin_end[]   asm("_binary_ulp_main_bin_end");


static void update_pulse_count(void);
static void init_ulp_program(void);



#define INT1_PIN      34

/* ----- user tasks ----------------------------- */


void app_main(void)
{
        // Set UART Parameter.
        uart_set_baud(0, 115200);
        // Give the UART some time to settle
        vTaskDelay(100 / portTICK_PERIOD_MS);

        /** -- MANDATORY PART -- */

    
    
        gpio_enable(INT1_PIN, GPIO_INPUT);
      

        esp_sleep_wakeup_cause_t cause = esp_sleep_get_wakeup_cause(); // checando qual evento acordou do Deep Sleep
            if (cause != ESP_SLEEP_WAKEUP_TIMER && cause !=ESP_SLEEP_WAKEUP_ULP) {  // caso não tenha atingido o tempo 
                printf("Not Timer wakeup, initializing ULP\n"); // inicializa o ULP
            } else {
                if(cause == ESP_SLEEP_WAKEUP_TIMER ){
                    printf("TIMER, saving pulse count\n");
                    valor = gpio_get_level(INT1_PIN);
                    update_pulse_count();
                    init_ble();
                     
                }
                else {
                    printf("ULP MAXCOUNT, saving pulse count\n");
                    valor = gpio_get_level(INT1_PIN);
                    update_pulse_count();
                    init_ble();
                }
            }
            init_ulp_program();
            printf( "Entering deep sleep\n\n");
            const uint64_t wakeup_time_sec = 1*30; // define em quanto tempo ele deve acordar do sleep
            printf("Enabling timer wakeup, %ds\n", (int)wakeup_time_sec);
            ESP_ERROR_CHECK(esp_sleep_enable_ulp_wakeup());
            ESP_ERROR_CHECK(esp_sleep_enable_timer_wakeup(wakeup_time_sec * 1000000ull)); // configura para acordar do sleep se o timer atingir o tempo definido
            esp_deep_sleep_start();          
        }


static void init_ulp_program(void)
{
    esp_err_t err = ulp_load_binary(0, ulp_main_bin_start,
            (ulp_main_bin_end - ulp_main_bin_start) / sizeof(uint32_t));
    ESP_ERROR_CHECK(err);

    /* GPIO used for pulse counting. */
    gpio_num_t gpio_num = INT1_PIN;
    int rtcio_num = rtc_io_number_get(gpio_num);
    assert(rtc_gpio_is_valid_gpio(gpio_num) && "GPIO used for pulse counting must be an RTC IO");

    /* Initialize some variables used by ULP program.
     * Each 'ulp_xyz' variable corresponds to 'xyz' variable in the ULP program.
     * These variables are declared in an auto generated header file,
     * 'ulp_main.h', name of this file is defined in component.mk as ULP_APP_NAME.
     * These variables are located in RTC_SLOW_MEM and can be accessed both by the
     * ULP and the main CPUs.
     *
     * Note that the ULP reads only the lower 16 bits of these variables.
     */
    ulp_debounce_counter = 3;
    ulp_debounce_max_count = 3;
    ulp_next_edge  =
    ulp_io_number = rtcio_num; /* map from GPIO# to RTC_IO# */
    ulp_edge_count_to_wake_up = 1; /* dobro de acionamentos desejados */

    /* Initialize selected GPIO as RTC IO, enable input, disable pullup and pulldown */
    rtc_gpio_init(gpio_num);
    rtc_gpio_set_direction(gpio_num, RTC_GPIO_MODE_INPUT_ONLY);
    rtc_gpio_pulldown_dis(gpio_num);
    rtc_gpio_pullup_dis(gpio_num);
    rtc_gpio_hold_en(gpio_num);

    bool valor_new = gpio_get_level(INT1_PIN);
   // printf("gpio: %d\n", valor);

    if(valor_new == 1){
        ulp_next_edge  = 0;

    }else{

        ulp_next_edge  = 1;
    }
    printf("ulp_next_edge: %d\n", ulp_next_edge);

    /* Disconnect GPIO12 and GPIO15 to remove current drain through
     * pullup/pulldown resistors.
     * GPIO12 may be pulled high to select flash voltage.
     */
    rtc_gpio_isolate(GPIO_NUM_12);
    rtc_gpio_isolate(GPIO_NUM_15);
    esp_deep_sleep_disable_rom_logging(); // suppress boot messages

    /* Set ULP wake up period to T = 20ms.
     * Minimum pulse width has to be T * (ulp_debounce_counter + 1) = 80ms.
     */
    ulp_set_wakeup_period(0, 20000);

    /* Start the program */
    err = ulp_run(&ulp_entry - RTC_SLOW_MEM);
    ESP_ERROR_CHECK(err);
}

static void update_pulse_count(void)
{
    //printf("Pino INT1: %d\n", gpio_get_level(INT1_PIN));
    /* ULP program counts signal edges, convert that to the number of pulses */
    uint32_t pulse_count_from_ulp = (ulp_edge_count & UINT16_MAX);
    count_acion = pulse_count_from_ulp;
    /* In case of an odd number of edges, keep one until next time */
    ulp_edge_count = 0x00;
    printf("count action: %d\n",count_acion);

}

