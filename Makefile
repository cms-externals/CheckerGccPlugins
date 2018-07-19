HOST_GCC=g++
TARGET_GCC=gcc
PLUGIN_SOURCE_FILES= $(wildcard src/*.cxx)
GCCPLUGINS_DIR:= $(shell $(TARGET_GCC) -print-file-name=plugin)
CXXFLAGS+= -I$(GCCPLUGINS_DIR)/include -fPIC -fno-rtti -O2 -std=c++11

all: libdir lib/libchecker_gccplugins.so

libdir:
	mkdir -p lib

lib/libchecker_gccplugins.so: $(PLUGIN_SOURCE_FILES) 
	$(HOST_GCC) -shared $(CXXFLAGS) $^ -o $@

