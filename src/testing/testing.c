/**
 * @file src/testing.c
 */

#include "testing.h"
#undef main

#ifdef TEST_MODE
int test__success;
int test__count;
int main() {
  PRINT("\n" ESCBLU "Passed" ESCLR ": ", test__success, "/", test__count, "\n");
  // pre-commit: make test || exit 1
  return test__count - test__success;
}

test (testing_test) {
  expect(1 + 1 == 2);
  expecteq(3, 3);
  expectneq(1, 10);

  test_filter("testing test") {
    expect(false);
    expect(1 + 1 == 1);

    expecteq(5, 3);
    expecteq(3, 3 + 3);

    expectneq(3 + 7, 50 / 5 + 6 * 0);

    expect(false);
  }
}

#endif
