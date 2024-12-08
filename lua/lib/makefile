CC = clang

ALL_ENTRIES = $(wildcard *)
SRCDIRS = $(filter %/, $(wildcard */))
TARGETS = $(patsubst %/, %.so, $(SRCDIRS))

INCDIR = include

CFLAGS := -std=c23 -I$(INCDIR) -Wtautological-compare -Wsign-compare -Wall    \
          -Wextra -fforce-emit-vtables -ffunction-sections -fdata-sections    \
		  -faddrsig -march=native -mtune=native -funroll-loops -fomit-frame-pointer \
		  -fPIC -O3
LDFLAGS = -flto=full -fwhole-program-vtables -funroll-loops -fomit-frame-pointer \
		  -O3 -shared

.DEFAULT_GOAL = $(TARGETS)

%.so: %
	$(CC) $</*.c $(CFLAGS) $(LDFLAGS) -o $@

clean:
	rm $(TARGETS)
