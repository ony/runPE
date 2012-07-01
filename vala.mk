VALAC ?= valac
VALAFLAGS += $(patsubst %,--pkg=%,$(VALA_PKGS)) $(patsubst %,-X %,$(CFLAGS))
VALAFLAGS += $(patsubst %,--vapidir=%,$(VAPI_DIRS))
LDLIBS += $(patsubst %,-l%,$(LIBS))
VALA_LDLIBS += $(patsubst %,-X %,$(LDLIBS))

.SUFFIXES: .c .vala .vapi

%.c: %.vala
	$(VALAC) $(VALAFLAGS) -C -o $(@) $(<)
