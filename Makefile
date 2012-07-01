TARGET = runpe
VAPI_DIRS += .
CFLAGS += -g
VALAFLAGS += --profile=posix

VAPI_SRCS = $(wildcard *.vapi)
VALA_SRCS = $(wildcard *.vala)
CUSTOM_VAPI = $(patsubst %.vapi,%,$(VAPI_SRCS))
VALA_PKGS += $(CUSTOM_VAPI)
LIBS += magic

C_SRCS = $(patsubst %.vala,%.c,$(VALA_SRCS))

all: $(TARGET)

clean:
	rm -f $(TARGET)

pristine: clean
	rm -f $(C_SRCS)

$(C_SRCS): $(VAPI_SRCS)

$(TARGET): $(C_SRCS)

.PHONY: all clean pristine

include vala.mk


