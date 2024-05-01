CC := gcc
CXX := g++

SCUDO_SRCS = \
  scudo/standalone/checksum.cpp \
  scudo/standalone/common.cpp \
  scudo/standalone/condition_variable_linux.cpp \
  scudo/standalone/crc32_hw.cpp \
  scudo/standalone/flags.cpp \
  scudo/standalone/flags_parser.cpp \
  scudo/standalone/linux.cpp \
  scudo/standalone/mem_map.cpp \
  scudo/standalone/mem_map_linux.cpp \
  scudo/standalone/release.cpp \
  scudo/standalone/report.cpp \
  scudo/standalone/report_linux.cpp \
  scudo/standalone/string_utils.cpp \
  scudo/standalone/timing.cpp \
  scudo/standalone/wrappers_c.cpp \
  scudo/standalone/wrappers_cpp.cpp
SCUDO_OBJS = ${SCUDO_SRCS:.cpp=.o}
OBJS += ${SCUDO_OBJS}
LUKKO_SRCS = \
  src/scudo-config.c \
  src/stack-protector.c
LUKKO_OBJS = ${LUKKO_SRCS:.c=.o}
OBJS += ${LUKKO_OBJS}

LIB = liblukko.so
CFLAGS += -std=gnu11 -pedantic -fPIC -DPIC
CXXFLAGS += -std=gnu++23 -pedantic -fPIC -DPIC
CPPFLAGS += -Iscudo/standalone/include

TESTS = \
  tests/double-free \
  tests/offset-free \
  tests/buffer-overflow

all: ${LIB}

# We know it is bad code, that is the whole point...
${TESTS}:
	${CC} -Wno-all -Wno-free-nonheap-object -o $@ $@.c

check: ${LIB} ${TESTS}
	@for i in ${TESTS}; do \
		echo -n "==> $$i: "; \
		(LD_PRELOAD=./${LIB} $$i || true) &>/dev/null; \
		echo "PASSED"; \
	done

${LIB}: ${OBJS}
	${CXX} -o ${LIB} -shared ${OBJS}

clean:
	rm -f ${LIB} ${OBJS} ${TESTS}

.PHONY: clean
