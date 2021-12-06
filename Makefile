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
	@echo ------------START ENV VERIFICATION-------------
	@if ! dpkg -s pkg-config | grep Status | grep -q installed; then \
		@echo ERROR: pkg-config package not installed!; \
		@apt-get install -y pkg-config; fi
	@echo -------------END ENV VERIFICATION---------------

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
