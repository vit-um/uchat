#include "server.h"

/*
 * Function: mx_init_info
 * -------------------------------
 * Creates information about another users, database for all clients
 * 
 * returns: new information
 */
t_info *mx_init_info(void) {
    t_info *info = vm_malloc(sizeof(t_info));

    info->users = g_hash_table_new(g_str_hash, g_str_equal);
    info->database = open_db(DB_PATH);
    return info;
}

/*
 * Function: mx_deinit_info
 * -------------------------------
 * Closes database, deletes all used memory
 * 
 * info: pointer to information
 */
void mx_deinit_info(t_info **info) {
    close_db((*info)->database);
    g_hash_table_destroy((*info)->users);
    free(*info);
    *info = NULL;
}

void mx_deinit_client(t_client **client) {
    if (client && *client) {
        if ((*client)->info->users && (*client)->out && (*client)->user
            && !(*client)->is_file) {
            g_hash_table_remove((*client)->info->users,
                                (*client)->user->login);
        }
        if ((*client)->request)
            g_free((*client)->request);
        if ((*client)->conn)
            g_io_stream_close(G_IO_STREAM((*client)->conn), NULL, NULL);
        (*client)->request = NULL;
        g_free(*client);
        *client = NULL;
    }
}
