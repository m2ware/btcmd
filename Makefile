###########################################
# Simple Makefile for HIDAPI test program
#
# Alan Ott
# Signal 11 Software
# 2010-06-01
#
# Modified (slightly) jdm June 2015
# Changed target name to btcmd.
###########################################

all: btcmd libs

libs: libhidapi-hidraw.so

CC       ?= gcc
CFLAGS   ?= -Wall -g -fpic

CXX      ?= g++
CXXFLAGS ?= -Wall -g -fpic

LDFLAGS  ?= -Wall -g


COBJS     = hid.o
CPPOBJS   = ../hidtest/hidtest.o
OBJS      = $(COBJS) $(CPPOBJS)
LIBS_UDEV = `pkg-config libudev --libs` -lrt
LIBS      = $(LIBS_UDEV)
INCLUDES ?= -I../hidapi `pkg-config libusb-1.0 --cflags`

all: btcmd install

# Console Test Program
btcmd: $(COBJS) $(CPPOBJS)
	$(CXX) $(LDFLAGS) $^ $(LIBS_UDEV) -o $@

# Shared Libs
libhidapi-hidraw.so: $(COBJS)
	$(CC) $(LDFLAGS) $(LIBS_UDEV) -shared -fpic -Wl,-soname,$@.0 $^ -o $@

# Objects
$(COBJS): %.o: %.c
	$(CC) $(CFLAGS) -c $(INCLUDES) $< -o $@

$(CPPOBJS): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $(INCLUDES) $< -o $@

install:
	@echo "[Install]"
	@cp btcmd /usr/local/bin
	@chown root.root /usr/local/bin/btcmd
	@chmod 4755 /usr/local/bin/btcmd

clean:
	rm -f $(OBJS) hidtest-hidraw libhidapi-hidraw.so ../hidtest/hidtest.o

.PHONY: clean libs
