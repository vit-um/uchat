#include "server.h"

/*
 * Function: mx_free_room
 * -------------------------------
 * free struct t_db_room
 * 
 * room: structure t_db_room created with g_malloc
 */
void mx_free_room(t_db_room **room) {
    if (!room || !*room)
        return;
    if ((*room)->room_name)
        g_free((*room)->room_name);
    if ((*room)->desc)
        g_free((*room)->desc);
    vm_free((void **)room);
    room = NULL;
}

/*
 * Function: mx_free_message
 * -------------------------------
 * free struct t_db_message
 * 
 * message: structure t_db_message created with g_malloc
 */
void mx_free_message(t_db_message **message) {
    if (!message || !*message)
        return;
    if ((*message)->message)
        g_free((*message)->message);
    if ((*message)->file_name)
        g_free((*message)->file_name);
    vm_free((void **)message);
    message = NULL;
}
