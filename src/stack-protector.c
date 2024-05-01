/* SPDX-License-Identifier: Apache-2.0 */
/* stack-protector.c: hooks which get called when validating the stack canary.
 * If the stack canary fails validation, we immediately call __lukko_crash() to
 * crash the process. */
#include "common.h"

void __stack_chk_fail_local(void) {
	__lukko_crash();
}

void __stack_chk_fail(void) {
	__lukko_crash();
}
