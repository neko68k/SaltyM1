// Include the interface headers.
// PPB APIs describe calls from the module to the browser.
// PPP APIs describe calls from the browser to the functions defined in your module.
#include <stdlib.h>
#include <string.h>
#include "ppapi/c/pp_errors.h"
#include "ppapi/c/pp_module.h"
#include "ppapi/c/pp_var.h"
#include "ppapi/c/ppb.h"
#include "ppapi/c/ppb_console.h"
#include "ppapi/c/ppb_instance.h"
#include "ppapi/c/ppb_messaging.h"
#include "ppapi/c/ppb_var.h"
#include "ppapi/c/ppp.h"
#include "ppapi/c/ppp_instance.h"
#include "ppapi/c/ppp_messaging.h"
#include "ppapi/c/ppb_input_event.h"
#include "ppapi/c/ppp_input_event.h"

// Create pointers for each PPB interface that your module uses.
static PPB_Instance* ppb_instance_interface = NULL;
static PPB_Instance* ppb_input_event_interface = NULL;

// Define all the functions for each PPP interface that your module uses. 
// Here is a stub for the first function in PPP_Instance.       
static PP_Bool Instance_DidCreate(PP_Instance instance,
                                  uint32_t argc,
                                  const char* argn[],
                                  const char* argv[]) {
        return PP_TRUE;
}    
/**
 * Called when the NaCl module is destroyed. This will always be called,
 * even if DidCreate returned failure. This routine should deallocate any data
 * associated with the instance.
 * @param[in] instance The identifier of the instance representing this NaCl
 *     module.
 */
static void Instance_DidDestroy(PP_Instance instance) {}

/**
 * Called when the position, the size, or the clip rect of the element in the
 * browser that corresponds to this NaCl module has changed.
 * @param[in] instance The identifier of the instance representing this NaCl
 *     module.
 * @param[in] position The location on the page of this NaCl module. This is
 *     relative to the top left corner of the viewport, which changes as the
 *     page is scrolled.
 * @param[in] clip The visible region of the NaCl module. This is relative to
 *     the top left of the plugin's coordinate system (not the page).  If the
 *     plugin is invisible, @a clip will be (0, 0, 0, 0).
 */
static void Instance_DidChangeView(PP_Instance instance,
                                   PP_Resource view_resource) {}

/**
 * Notification that the given NaCl module has gained or lost focus.
 * Having focus means that keyboard events will be sent to the NaCl module
 * represented by @a instance. A NaCl module's default condition is that it
 * will not have focus.
 *
 * Note: clicks on NaCl modules will give focus only if you handle the
 * click event. You signal if you handled it by returning @a true from
 * HandleInputEvent. Otherwise the browser will bubble the event and give
 * focus to the element on the page that actually did end up consuming it.
 * If you're not getting focus, check to make sure you're returning true from
 * the mouse click in HandleInputEvent.
 * @param[in] instance The identifier of the instance representing this NaCl
 *     module.
 * @param[in] has_focus Indicates whether this NaCl module gained or lost
 *     event focus.
 */
static void Instance_DidChangeFocus(PP_Instance instance, PP_Bool has_focus) {}

/**
 * Handler that gets called after a full-frame module is instantiated based on
 * registered MIME types.  This function is not called on NaCl modules.  This
 * function is essentially a place-holder for the required function pointer in
 * the PPP_Instance structure.
 * @param[in] instance The identifier of the instance representing this NaCl
 *     module.
 * @param[in] url_loader A PP_Resource an open PPB_URLLoader instance.
 * @return PP_FALSE.
 */
static PP_Bool Instance_HandleDocumentLoad(PP_Instance instance,
                                           PP_Resource url_loader) {
  /* NaCl modules do not need to handle the document load function. */
  return PP_FALSE;
}

PP_Bool Instance_HandleInput(PP_Instance instance, PP_Resource event) {
  return PP_FALSE;
}

// Define PPP_GetInterface.
// This function should return a non-NULL value for every interface you are using.
// The string for the name of the interface is defined in the interface's header file.  
// The browser calls this function to get pointers to the interfaces that your module implements.
PP_EXPORT const void* PPP_GetInterface(const char* interface_name) {
        // Create structs for each PPP interface.
        // Assign the interface functions to the data fields.
         if (strcmp(interface_name, PPP_INSTANCE_INTERFACE) == 0) {
                static  PPP_Instance instance_interface = {
                        &Instance_DidCreate, 
                        // The definitions of these functions are not shown
                        &Instance_DidDestroy,
                        &Instance_DidChangeView,
                        &Instance_DidChangeFocus,
                        &Instance_HandleDocumentLoad
                };
                return &instance_interface;
         }

         if (strcmp(interface_name, PPP_INPUT_EVENT_INTERFACE) == 0) {
                static PPP_InputEvent input_interface = {
                        // The definition of this function is not shown.
                        &Instance_HandleInput,
                };
                return &input_interface;
         }
         // Return NULL for interfaces that you do not implement.
         return NULL;
}

// Define PPP_InitializeModule, the entry point of your module.
// Retrieve the API for the browser-side (PPB) interfaces you will use.
PP_EXPORT int32_t PPP_InitializeModule(PP_Module a_module_id, PPB_GetInterface get_browser) {
        ppb_instance_interface = (PPB_Instance*)(get_browser(PPB_INSTANCE_INTERFACE));
        ppb_input_event_interface = (PPB_Instance*)(get_browser(PPB_INPUT_EVENT_INTERFACE));
        return PP_OK;
}

/**
 * Called before the plugin module is unloaded.
 */
PP_EXPORT void PPP_ShutdownModule() {}