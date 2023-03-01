#include "ble.h"
#include "esp_log.h"
#include "esp8266_wrapper.h"
#include "esp_mac.h"

#define INT1_PIN  34 

static const char *TAG = "BLE";
static bool has_called_read_chr = false;

uint8_t ble_addr_type;
void ble_app_advertise(void);
static bool waiting = true;

/**
 * Build payload to be sent over BLE
 * NOTE: Returns a heap allocated string, you are required to free it after use.
 * @returns char* = {base_mac_addr[0] , base_mac_addr[1] , base_mac_addr[2] , base_mac_addr[3], base_mac_addr[4] , base_mac_addr[5], hex_new_byte2, hex_new_byte1};
 */

static int device_write(uint16_t conn_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg){
    printf("Data from the client: %.*s\n", ctxt->om->om_len, ctxt->om->om_data);

    return 0;

}

static int device_read(uint16_t con_handle, uint16_t attr_handle, struct ble_gatt_access_ctxt *ctxt, void *arg)
{
    has_called_read_chr = true;

    char payload[40] = {"0"};
    bool valor = gpio_get_level(INT1_PIN);
    float bat = 3.2;
    uint8_t  baseMac[6] = {0};
    char baseMacChr[13] = {0};

    esp_efuse_mac_get_default(baseMac);
    esp_read_mac(baseMac, ESP_MAC_BT);
    sprintf(baseMacChr, "%02X%02X%02X%02X%02X%02X", 
                                    baseMac[0], 
                                    baseMac[1], 
                                    baseMac[2], 
                                    baseMac[3], 
                                    baseMac[4], 
                                    baseMac[5]);


    sprintf(payload, "{\"pin\":%d, \"v\":%0.2f, \"m\":%s}", valor, bat, baseMacChr);
    printf("payload:%s\n", payload);

    int rc = os_mbuf_append(ctxt->om, payload, strlen(payload));

    if (rc != 0)
    {
       // saveNVS_UptadePulse("plusentc", "count", count_action);
    }
    else
    {
      //  saveNVS_UptadePulse("plusentc", "count", 0);
    }

    //free(payload);

    waiting = false;

    return rc;
}

// Array of pointers to other service definitions
// Array de ponteiros para outras definições de serviço
// UUID - Identificador Único Universal
// UUID - Universal Unique Identifier
static const struct ble_gatt_svc_def gatt_svcs[] = {
    {.type = BLE_GATT_SVC_TYPE_PRIMARY,
     .uuid = BLE_UUID16_DECLARE(0x180),                 // Define UUID for device type
     .characteristics = (struct ble_gatt_chr_def[]){
         {.uuid = BLE_UUID16_DECLARE(0xFEF4),           // Define UUID for reading
          .flags = BLE_GATT_CHR_F_READ,
          .access_cb = device_read},
         {.uuid = BLE_UUID16_DECLARE(0xDEAD),           // Define UUID for writing
          .flags = BLE_GATT_CHR_F_WRITE,
          .access_cb = device_write},
         {0}}},
    {0}};


static int ble_gap_event(struct ble_gap_event *event, void *arg)
{
    switch (event->type)
    {
    // Advertise if connected  - Anuncie se estiver conectado
    case BLE_GAP_EVENT_CONNECT:
        ESP_LOGI(TAG, "BLE GAP EVENT CONNECT %s", event->connect.status == 0 ? "OK!" : "FAILED!");
        if (event->connect.status != 0)
        {
            ble_app_advertise();
        }
        break;
        // Advertise if desconnected - Anuncie se estiver desconectado
    case BLE_GAP_EVENT_DISCONNECT:
        ESP_LOGI(TAG, "BLE GAP EVENT DISCONNECTED %s", event->connect.status == 1 ? "OK!" : "DISCONNECTED!");

        if (event->connect.status != 1)
        {
            ble_app_advertise();
        }
        break;
    // Advertise again after completion of the event -  Anuncie novamente após a conclusão do evento
    case BLE_GAP_EVENT_ADV_COMPLETE:
        ESP_LOGI(TAG, "BLE GAP EVENT");
        ble_app_advertise();
        break;
    default:
        ESP_LOGI(TAG, "BLE GAP EVENT");
        break;
    }
    return 0;
}

void ble_app_advertise(void)
{
    // GAP - device name definition - GAP - definição do nome do dispositivo
    struct ble_hs_adv_fields fields;
    const char *device_name;
    memset(&fields, 0, sizeof(fields));
    device_name = ble_svc_gap_device_name(); // Read the BLE device name
    fields.name = (uint8_t *)device_name;
    fields.name_len = strlen(device_name);
    fields.name_is_complete = 1;
    ble_gap_adv_set_fields(&fields);

    // GAP - device connectivity definition - GAP - definição de conectividade do dispositivo
    struct ble_gap_adv_params adv_params;
    memset(&adv_params, 0, sizeof(adv_params));
    adv_params.conn_mode = BLE_GAP_CONN_MODE_UND; // connectable or non-connectable
    adv_params.disc_mode = BLE_GAP_DISC_MODE_GEN; // discoverable or non-discoverable
    ble_gap_adv_start(ble_addr_type, NULL, BLE_HS_FOREVER, &adv_params, ble_gap_event, NULL);
}

void ble_app_on_sync(void)
{
    uint8_t u8p[6] = {0};

#ifdef DEBUG
    esp_err_t rc = 0;
    
    for (int j=0; j<4; j++)
    {
        rc = ble_hs_id_copy_addr(j, u8p, NULL);
        printf("ESP_MAC_BT [%d][%d] %02x:%02x:%02x:%02x:%02x:%02x\n", j, rc, u8p[5], u8p[4], u8p[3], u8p[2], u8p[1], u8p[0]);
    }
#endif

    ble_hs_id_infer_auto(0, &ble_addr_type); // Determines the best address type automatically
    ble_app_advertise();                     // Define the BLE connection
}

// The infinite task
void host_task(void *param)
{
    nimble_port_run(); // This function will return only when nimble_port_stop() is executed
}

void init_ble(void)
{
    waiting = true;
   // readNVS_UptadePulse("plusentc", "count"); // access NVS to update count_action   
    nvs_flash_init();   // 1 - Initialize NVS flash using
    esp_nimble_hci_and_controller_init();             // 2 - Initialize ESP controller
    nimble_port_init();                               // 3 - Initialize the host stack
    ble_svc_gap_device_name_set("DEVICE_V1"); // 4 - Initialize NimBLE configuration - server name
    ble_svc_gap_init();                               // 4 - Initialize NimBLE configuration - gap service
    ble_svc_gatt_init();                              // 4 - Initialize NimBLE configuration - gatt service

    ble_hs_cfg.sync_cb = ble_app_on_sync; // 5 - Initialize application

    ble_gatts_count_cfg(gatt_svcs); // 4 - Initialize NimBLE configuration - config gatt services
    ble_gatts_add_svcs(gatt_svcs);  // 4 - Initialize NimBLE configuration - queues gatt services.

    nimble_port_freertos_init(host_task); // 6 - Run the thread

    int i = 3000;
    while(waiting && i--)
    {
        vTaskDelay(10 / portTICK_RATE_MS);
    }

    if(!has_called_read_chr) {
    //    saveNVS_UptadePulse("plusentc", "count", count_action);
    }

    vTaskDelay(500 / portTICK_RATE_MS);

}