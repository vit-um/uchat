ifeq '$(findstring ;,$(PATH))' ';'
    detected_OS := Windows
else
    detected_OS := $(shell uname 2>/dev/null || echo Unknown)
    detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
    detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
    detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

#colors:
B = \033[1;94m#   BLUE
G = \033[1;92m#   GREEN
Y = \033[1;93m#   YELLOW
R = \033[1;31m#   RED
M = \033[1;95m#   MAGENTA
K = \033[K#       ERASE END OF LINE
D = \033[0m#      DEFAULT
A = \007#         BEEP

CLIENT = uchat
SERVER = uchat_server
CJSON = cjson
SQL = sqlite3
VM = vmchat


CLIENTD = client
SERVERD = server
LIBDIR = libraries
LIB_DIR = libraries/inc libraries/lib


CLIENTO = $(CLIENTD)/$(CLIENT)
SERVERO = $(SERVERD)/$(SERVER)
SQLDIRO = $(LIBDIR)/$(SQL)
CJSONDIRO = $(LIBDIR)/$(CJSON)
VMDIRO = $(LIBDIR)/$(VM)

all: ENV_VERIFICATION $(CJSON) $(SQL) $(VM) $(CLIENT) $(SERVER)

ENV_VERIFICATION:
ifeq ($(detected_OS),Linux)        
	@printf "Detected OS: $R$(detected_OS)$D\n"
	@if ! dpkg -s libgtk-3-dev | grep Status | grep -q installed; then \
		echo ERROR: sudo package not installed!; \
		sudo apt-get update; \
		sudo apt-get install -y libgtk-3-dev; fi
endif

$(CJSON): $(CJSONDIRO)
$(SQL): $(SQLDIRO)
$(VM): $(VMDIRO)
$(CLIENT): $(CLIENTO)
$(SERVER): $(SERVERO)

$(CLIENTO): $(CLIENTD)
$(SERVERO): $(SERVERD)

$(LIB_DIR):
	@mkdir -p $(LIB_DIR)

$(SQL) $(CJSON) $(VM): | $(LIB_DIR)
	@make -sC $<

$(CLIENTO) $(SERVERO):
	@make -sC $<


uninstall: 
	@rm   -rf $(CLIENT)
	@rm   -rf $(SERVER)
	@make -sC $(CJSONDIRO) $@
	@make -sC $(SQLDIRO)   $@
	@make -sC $(VMDIRO)   $@
	@make -sC $(CLIENTD)   $@
	@make -sC $(SERVERD)   $@
	@rm -rf $(LIB_DIR)

clean:
	@make -sC $(CJSONDIRO) $@
	@make -sC $(SQLDIRO)   $@
	@make -sC $(VMDIRO)   $@
	@make -sC $(CLIENTD)   $@
	@make -sC $(SERVERD)   $@

reinstall: uninstall all

.PHONY: + uninstall clean reinstall $(CLIENTO) $(SERVERO) 
