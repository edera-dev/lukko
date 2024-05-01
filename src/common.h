/* SPDX-License-Identifier: Apache-2.0 */
#pragma once

static inline void __lukko_crash(void) {
	__builtin_trap();
}
