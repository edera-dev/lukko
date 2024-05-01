/* SPDX-License-Identifier: Apache-2.0 */
#include "common.h"

const char *__scudo_default_options(void) {
	return "dealloc_type_mismatch=true:delete_size_mismatch=true:zero_contents=true:may_return_null=false";
}
