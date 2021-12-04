#include "client.h"

gboolean delete_gmsg(t_gmsg *gmsg) {                    ///maybe del later
    if (gmsg) {
        // vm_free((void**)&(gmsg->msg));
        // vm_free((void**)&(gmsg->login));
        // vm_free((void**)&gmsg);
        gmsg = NULL;
    }
    return TRUE;
}

t_gmsg *create_gmsg(cJSON *msg, t_chat *chat) {
    t_gmsg *gmsg = vm_malloc(sizeof(t_gmsg));
    t_groom *groom = NULL;

    gmsg->room_id = vm_get_object(msg, "room_id")->valueint;
    groom = get_groom_by_id(gmsg->room_id, chat->builder);
    gint user_id = vm_get_object(msg, "user_id")->valueint;
    gpointer hash = g_hash_table_lookup(groom->members, GINT_TO_POINTER(user_id));

    gmsg->login = g_strdup(MX_J_STR(hash));
    gmsg->msg = vm_get_valuestring(msg, "msg");
    gmsg->date = vm_get_object(msg, "date")->valueint;
    gmsg->msg_id = vm_get_object(msg, "msg_id")->valueint;
    gmsg->msg_type = vm_get_object(msg, "msg_type")->valueint;
    gmsg->row_msg = NULL;

    return gmsg;
}
