#include "client.h"

void init_gui(t_chat *chat) {
    connect_authorization(chat);        //done
    connect_addroom(chat);              //done
    connect_send_message(chat);         //done
    connect_profile_settings(chat);     //done
    connect_room_settings(chat);        //done
    connect_message_ctrl(chat);         //done
    connect_search(chat);               //done
    connect_join_to_room(chat);         //done
    connect_stickers(chat);             //done
    connect_ban_member(chat);           //done
    connect_set_placeholder(chat);      //done
    connect_unset_placeholder(chat);    //done
    connect_filechooser(chat);          //done      --------      need to debug
    connect_theme_switcher(chat);       //done
}
