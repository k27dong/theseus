CC=gcc
COMPILE.c=$(CC) $(CFLAGS) $(CPPFLAGS) -c
LINK.c=$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
LDFLAGS=
LDDIR=-Llib
LDLIBS=$(LDDIR) -lapue $(EXTRALIBS)
CFLAGS=-ansi -Iinclude -Wall -DLINUX -D_GNU_SOURCE $(EXTRA)
RANLIB=echo
AR=ar
AWK=awk
LIBAPUE=lib/libapue.a
TEMPFILES=core core.* *.o temp.* *.out
SRCS=$(wildcard *.c)
PROGS=$(patsubst %.c,%,$(SRCS))
LIBS=lib
BINS=bin

all:
	(cd $(LIBS) && $(MAKE)) || exit 1;
	for i in $(PROGS); do \
		($(CC) $(CFLAGS) $$i.c -o $$i $(LDFLAGS) $(LDLIBS)) || exit 1; \
		(mv $$i $(BINS)) || exit 1; \
	done

clean:
	(cd $(LIBS) && $(MAKE) clean) || exit 1;
	cd $(BINS) && rm -f $(PROGS) $(TEMPFILES) *.o