/**
 * @file include/testing.h
 * @brief Define macros for testing
 * @note Tests not in the test_filter block are always executed
 */

#pragma once
#include "chore.h"

#ifdef TEST_MODE
 #include "ansiesc.h"
 #include "gene.h"
 #include <stdio.h>
 #include <string.h>

extern int TEST_success;
extern int TEST_count;

 #define TEST_HEADER " ■ " ESCBLU "Testing " ESCLR
 #define ALIGN_COL(name) \
   do { \
     int col = 4 - ((int)strlen(#name) + 3) / 8; \
     for (int i = 0; i < col; i++) putchar('\t'); \
   } while (0)
 #define PRINT_FAILED(cnt) PRINT("\n └" ESCRED ESBLD "[NG:", cnt, "]\n" ESCLR)
 #define PRINT_SUCCESS     puts("=> " ESCGRN "[OK]" ESCLR)

// zig style testing syntax
 #define test(name) \
   static void TEST_test##name(int *); \
   [[gnu::constructor]] static void TEST_run##name() { \
     TEST_count++; \
     printf(TEST_HEADER ESBLD #name ESCLR); \
     int failed = 0; \
     TEST_test##name(&failed); \
     if (failed) { \
       PRINT_FAILED(failed); \
       return; \
     } \
     ALIGN_COL(name); \
     PRINT_SUCCESS; \
     TEST_success++; \
   } \
   static void TEST_test##name(int *TEST_failed)

 #ifdef TEST_FILTER
  #define test_filter(filter) if (strstr(filter, TEST_FILTER))
 #else
  #define test_filter(filter) if (0)
 #endif

// generate function parameter
 #define PMAP(tok, _, ...) \
   t->tok __VA_OPT__(, _PMAP EMP()()(tok##p, __VA_ARGS__))
 #define _PMAP() PMAP

// generate struct member
// e.g.) T1 p /* expected */; T2 pp /* arg1 */; T3 ppp /* arg2 */; ...
 #define SMAP(tok, _1, ...) \
   _1 tok; \
   __VA_OPT__(_SMAP EMP()()(tok##p, __VA_ARGS__))
 #define _SMAP() SMAP

 #define CALL(fn, ...) fn(EVAL(PMAP(pp, __VA_ARGS__)))
 #define STDEF(...) \
   struct { \
     EVAL(SMAP(p, __VA_ARGS__)) \
   }

// if {a, b, c} is passed as a macro parameter, it becomes "{a", "b", "c}", so
// it must be received as a variable length argument.
 #define test_table(name, fn, signature, ...) \
   [[gnu::constructor]] static void TEST_tabletest##name() { \
     TEST_count++; \
     printf(TEST_HEADER ESBLD #name ESCLR); \
     int failed = 0; \
     typedef STDEF signature S; \
     S data[] = __VA_ARGS__; \
     for (size_t i = 0; i < sizeof data / sizeof(S); i++) { \
       S *t = data + i; \
       int *TEST_failed /* for expecteq */ = &failed; \
       int pre = failed; \
       expecteq(t->p, CALL(fn, CDR signature)); \
       if (pre != failed) PRINT(" at test case ", i); \
     } \
     if (failed) { \
       PRINT_FAILED(failed); \
       return; \
     } \
     ALIGN_COL(name); \
     PRINT_SUCCESS; \
     TEST_success++; \
   }

// disable main function somewhere
 #define main TEST_dummymain

 #define expect(cond) \
   do { \
     if (cond) break; \
     puts("\n ├┬ Unexpected result at " HERE); \
     printf(" │└─ `" #cond "` " ESCRED ESBLD " [NG]" ESCLR); \
     (*TEST_failed)++; \
   } while (0)

 #define expecteq(expected, actual) \
   do { \
     typeof(actual) const lhs = expected; \
     auto const rhs = actual; \
     if (eq(lhs, rhs)) break; \
     puts("\n ├┬ Expected equal at " HERE); \
     printf(" │├─ " ESCGRN "Expected" ESCLR ": "); \
     printanyf(lhs); \
     printf("\n │└─ " ESCRED "Actual" ESCLR ":   "); \
     printanyf(rhs); \
     printf(ESCRED ESBLD " [NG]" ESCLR); \
     (*TEST_failed)++; \
   } while (0)

 #define expectneq(unexpected, actual) \
   do { \
     typeof(actual) const lhs = unexpected; \
     auto const rhs = actual; \
     if (!eq(lhs, rhs)) break; \
     int __llen = (int)strlen(#unexpected); \
     int __rlen = (int)strlen(#actual); \
     int __lpad = bigger(0, __rlen - __llen); \
     int __rpad = bigger(0, __llen - __rlen); \
     puts("\n ├┬ Unexpected equality at " HERE); \
     printf(" │├─ Left side:  `" #unexpected "` ─"); \
     for (int __i = 0; __i < __lpad; __i++) printf("─"); \
     puts("┐"); \
     printf(" │└─ Right side: `" #actual "` ─"); \
     for (int __i = 0; __i < __rpad; __i++) printf("─"); \
     printf("┴─➤ "); \
     printanyf(lhs); \
     printf(ESCRED ESBLD " [NG]" ESCLR); \
     (*TEST_failed)++; \
   } while (0)

 #define testing_unreachable \
   ({ \
    puts("\n ├┬ " ESCRED "Reached line " HERE ESCLR); \
    printf(" │└─ " ESCRED ESBLD "[NG]" ESCLR); \
    (*TEST_failed)++; \
    (size_t)0; \
   })
#else
// --gc-sections
 #define test(name) [[gnu::unused]] static void TEST_dum##name(int *TEST_failed)
 #define test_table(...)
 #define test_filter(filter)
 #define expect(cond) \
   do { \
     _ = cond; \
     _ = TEST_failed; \
   } while (0)
 #define expecteq(lhs, rhs) \
   do { \
     _ = lhs; \
     _ = rhs; \
     _ = TEST_failed; \
   } while (0)
 #define expectneq(lhs, rhs) \
   do { \
     _ = lhs; \
     _ = rhs; \
     _ = TEST_failed; \
   } while (0)
 #define testing_unreachable _ = TEST_failed
#endif
