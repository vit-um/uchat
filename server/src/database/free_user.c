#include "server.h"

/*
 * Function: free_user
 * -------------------------------
 * free struct t_db_user
 * 
 * user: structure t_db_user created with g_malloc
 */
void free_user(t_db_user **user) {
    if (!user || !*user)
        return;
    if ((*user)->login)
        g_free((*user)->login);
    if ((*user)->pass)
        g_free((*user)->pass); 
    if ((*user)->auth_token) 
        g_free((*user)->auth_token);
    if ((*user)->desc)
        g_free((*user)->desc);
    if ((*user)->name)
        g_free((*user)->name);
    vm_free((gpointer)user);
    *user = NULL;
}

/*
 * Function: free_room
 * -------------------------------
 * free struct t_db_room
 * 
 * room: structure t_db_room created with g_malloc
 */
void free_room(t_db_room **room) {
    if (!room || !*room)
        return;
    vm_free((void **)room);
}

/*
 * Function: free_message
 * -------------------------------
 * free struct t_db_message
 * 
 * message: structure t_db_message created with g_malloc
 */
void free_message(t_db_message **message) {
    if (!message || !*message)
        return;
    if ((*message)->message)
        g_free((*message)->message);
    if ((*message)->file_name)
        g_free((*message)->file_name);
    vm_free((void **)message);
    message = NULL;
}
