/**
 * @file src/ansiesc.c
 * @brief Test escape sequence macros
 */

#include "ansiesc.h"
#include "testing.h"

test (ansi_escape_sequence) {
  expect(true);

  test_filter("all") {
    puts(ESCLR);

#define PRINT_HELLO(x) puts(x "hello" ESCLR);
    MAP(
      PRINT_HELLO,
      ESBLD,
      ESTHN,
      ESITA,
      ESULN,
      ESBLN,
      ESFBLN,
      ESREV,
      ESHID,
      ESUDO,
      ESCRED,
      ESCGRN,
      ESCYEL,
      ESCBLU,
      ESCMGN,
      ESCCYN,
      ESCBLK,
      ESCBRED,
      ESCBGRN,
      ESCBYEL,
      ESCBBLU,
      ESCBMGN,
      ESCBCYN,
      ESCBBLK,
      ESCCODE(100),
      ESCCODE_RGB(100, 100, 100)
    )
  }
}
