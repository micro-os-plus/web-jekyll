---
layout: page
lang: en
permalink: /develop/predefined-macros/
title: Predefined compiler macros
author: Liviu Ionescu

date: 2015-08-05 13:48:01 +0000

---

## Platform dependencies

If some parts of the code are platform dependent, test the following preprocessor definitions:

```c
#if defined(__APPLE__)
#if defined(__linux__)
#if defined(__unix__)
#if defined(WIN32)
#if defined(__MINGW32__)
#if defined(__MINGW64__)
```

To check if not running native on a desktop machine:

```c
#if (!(defined(__APPLE__) || defined(__linux__) || defined(__unix__))) \
    || defined(__DOXYGEN__)

```

To check the compiler:

```c
#if defined (__GNUC__)
#if __GNUC__ == 4 && __GNUC_MINOR__ == 7
#if defined(__clang__)
```

To check if GCC only:

```c
#if defined(__GNUC__) && !defined(__clang__)
```

To check the size of the pointer:

```c
#if __SIZEOF_POINTER__ == __SIZEOF_INT__
#elif __SIZEOF_POINTER__ == __SIZEOF_LONG__
#elif __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__
```

To check if there are no **long long** variables:

```c
#if !defined(__SIZEOF_LONG_LONG)
```

To check if the compiling unit is C++:

```c
#if defined (__cplusplus)
```

To check if the compiling unit is an assembly file:

```c
#if defined(__ASSEMBLER__)
```

To check if optimisation is enabled (more than `-O0`):

```c
#if defined(__OPTIMIZE__)
```

To check if optimisation for size is enabled (`-Os`):

```c
#if defined(__OPTIMIZE_SIZE__)
```

To check if no inlines are enabled:

```c
#if defined(__NO_INLINE__)
```

To see the built-in definitions:

```console
$ g++ -dM -E - < /dev/null
$ clang++ -dM -E - < /dev/null
```

## ARM Cortex-M

When compiling Cortex-M applications, GCC 5.4 provides the following built-in definitions.

### ARM Cortex-M0/M0+

```console
$ ./arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_ARCH 6
#define __ARM_ARCH_6M__ 1
#define __ARM_ARCH_ISA_THUMB 1
#define __ARM_ARCH_PROFILE 77
#define __ARM_EABI__ 1
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1014
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb__ 1

$ ./arm-none-eabi-gcc -mcpu=cortex-m0plus -mthumb -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_ARCH 6
#define __ARM_ARCH_6M__ 1
#define __ARM_ARCH_ISA_THUMB 1
#define __ARM_ARCH_PROFILE 77
#define __ARM_EABI__ 1
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1014
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb__ 1
```

### ARM Cortex-M3

```console
$ ./arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_32BIT_STATE 1
#define __ARM_ARCH 7
#define __ARM_ARCH_7M__ 1
#define __ARM_ARCH_EXT_IDIV__ 1
#define __ARM_ARCH_ISA_THUMB 2
#define __ARM_ARCH_PROFILE 77
#define __ARM_ASM_SYNTAX_UNIFIED__ 1
#define __ARM_EABI__ 1
#define __ARM_FEATURE_CLZ 1
#define __ARM_FEATURE_COPROC 15
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1014
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1
```

### ARM Cortex-M4

```console
$ ./arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_32BIT_STATE 1
#define __ARM_ARCH 7
#define __ARM_ARCH_7EM__ 1
#define __ARM_ARCH_EXT_IDIV__ 1
#define __ARM_ARCH_ISA_THUMB 2
#define __ARM_ARCH_PROFILE 77
#define __ARM_ASM_SYNTAX_UNIFIED__ 1
#define __ARM_EABI__ 1
#define __ARM_FEATURE_CLZ 1
#define __ARM_FEATURE_COPROC 15
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1014
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1

$ ./arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=softfp -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_32BIT_STATE 1
#define __ARM_ARCH 7
#define __ARM_ARCH_7EM__ 1
#define __ARM_ARCH_EXT_IDIV__ 1
#define __ARM_ARCH_ISA_THUMB 2
#define __ARM_ARCH_PROFILE 77
#define __ARM_ASM_SYNTAX_UNIFIED__ 1
#define __ARM_EABI__ 1
#define __ARM_FEATURE_CLZ 1
#define __ARM_FEATURE_COPROC 15
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_FMA 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 4
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __FP_FAST_FMAF 1
#define __FP_FAST_FMAF32 1
#define __GXX_ABI_VERSION 1014
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1


$ ./arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_32BIT_STATE 1
#define __ARM_ARCH 7
#define __ARM_ARCH_7EM__ 1
#define __ARM_ARCH_EXT_IDIV__ 1
#define __ARM_ARCH_ISA_THUMB 2
#define __ARM_ARCH_PROFILE 77
#define __ARM_ASM_SYNTAX_UNIFIED__ 1
#define __ARM_EABI__ 1
#define __ARM_FEATURE_CLZ 1
#define __ARM_FEATURE_COPROC 15
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_FMA 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 4
#define __ARM_PCS_VFP 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __FP_FAST_FMAF 1
#define __FP_FAST_FMAF32 1
#define __GXX_ABI_VERSION 1014
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1
```

### ARM Cortex-M7

```console
$ ./arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=soft -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_32BIT_STATE 1
#define __ARM_ARCH 7
#define __ARM_ARCH_7EM__ 1
#define __ARM_ARCH_EXT_IDIV__ 1
#define __ARM_ARCH_ISA_THUMB 2
#define __ARM_ARCH_PROFILE 77
#define __ARM_ASM_SYNTAX_UNIFIED__ 1
#define __ARM_EABI__ 1
#define __ARM_FEATURE_CLZ 1
#define __ARM_FEATURE_COPROC 15
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1014
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1

$ ./arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=softfp -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_32BIT_STATE 1
#define __ARM_ARCH 7
#define __ARM_ARCH_7EM__ 1
#define __ARM_ARCH_EXT_IDIV__ 1
#define __ARM_ARCH_ISA_THUMB 2
#define __ARM_ARCH_PROFILE 77
#define __ARM_ASM_SYNTAX_UNIFIED__ 1
#define __ARM_EABI__ 1
#define __ARM_FEATURE_CLZ 1
#define __ARM_FEATURE_COPROC 15
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_FMA 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 14
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __FP_FAST_FMA 1
#define __FP_FAST_FMAF 1
#define __FP_FAST_FMAF32 1
#define __FP_FAST_FMAF32x 1
#define __FP_FAST_FMAF64 1
#define __FP_FAST_FMAL 1
#define __GXX_ABI_VERSION 1014
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1

$ ./arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp[^-]|version|abi' | sort
#define __ARMEL__ 1
#define __ARM_32BIT_STATE 1
#define __ARM_ARCH 7
#define __ARM_ARCH_7EM__ 1
#define __ARM_ARCH_EXT_IDIV__ 1
#define __ARM_ARCH_ISA_THUMB 2
#define __ARM_ARCH_PROFILE 77
#define __ARM_ASM_SYNTAX_UNIFIED__ 1
#define __ARM_EABI__ 1
#define __ARM_FEATURE_CLZ 1
#define __ARM_FEATURE_COPROC 15
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_FMA 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 14
#define __ARM_PCS_VFP 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __FP_FAST_FMA 1
#define __FP_FAST_FMAF 1
#define __FP_FAST_FMAF32 1
#define __FP_FAST_FMAF32x 1
#define __FP_FAST_FMAF64 1
#define __FP_FAST_FMAL 1
#define __GXX_ABI_VERSION 1014
#define __STDC_VERSION__ 201710L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "10.3.1 20210824 (release)"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1
```

## Floating point

To check if hardware floating point is enabled (`-mfloat-abi=softfp` or `-mfloat-abi=hard`):

```c
#define __ARM_FP 4
#define __ARM_FP 14
```

(4 for Cortex-M4, 14 for Cortex-M7)

For `-mfloat-abi=hard`:

```c
#define __ARM_PCS_VFP 1
```

## Freestanding

To check if `-ffreestanding` was defined, you can use the following:

```c
#define __STDC_HOSTED__ 0
```

By default, i.e. with `-fhosted` defined, the value is 1.

## C++ Exceptions

To check if a C++ program is compiled with `-fexceptions`, use:

```c
#define __EXCEPTIONS 1
```

## Other macros

```c
#define __CHAR_UNSIGNED__ 1
#define __LP64__ 1
```

## Warnings

When compiling third party sources, it might be necessary to temporarily disable some warnings:

```c
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpadded"

// ...

#pragma GCC diagnostic pop
```

clang specific warnings must be issued only for clang:

```c
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wsign-conversion"
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wgnu-include-next"
#pragma clang diagnostic ignored "-Wdisabled-macro-expansion"
#pragma clang diagnostic ignored "-Wmissing-variable-declarations"
#pragma clang diagnostic ignored "-Wexit-time-destructors"
#pragma clang diagnostic ignored "-Wglobal-constructors"
#endif

// ...

#pragma GCC diagnostic pop
```

To check if POSIX:

```c
#include <unistd.h>

#if defined(_POSIX_VERSION)
// ...
#endif
```

To include next version:

```c
#include <unistd.h>

#if defined(_POSIX_VERSION)

#pragma GCC diagnostic push
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wgnu-include-next"
#endif
#include_next <termios.h>
#pragma GCC diagnostic pop

#else

// Avoid warnings for __BSD* definitions.
#pragma GCC system_header

#ifdef __cplusplus
extern "C"
{
#endif

// ----------------------------------------------------------------------------
//...
// ----------------------------------------------------------------------------

#ifdef __cplusplus
}
#endif

#endif /* defined(_POSIX_VERSION) */
```

## Ubuntu GCC macros

```console
ilg@ubu20:~$ gcc --version
gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

ilg@ubu20:~$ gcc -E -dM - < /dev/null | sort
#define __amd64 1
#define __amd64__ 1
#define __ATOMIC_ACQ_REL 4
#define __ATOMIC_ACQUIRE 2
#define __ATOMIC_CONSUME 1
#define __ATOMIC_HLE_ACQUIRE 65536
#define __ATOMIC_HLE_RELEASE 131072
#define __ATOMIC_RELAXED 0
#define __ATOMIC_RELEASE 3
#define __ATOMIC_SEQ_CST 5
#define __BIGGEST_ALIGNMENT__ 16
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __CET__ 3
#define __CHAR16_TYPE__ short unsigned int
#define __CHAR32_TYPE__ unsigned int
#define __CHAR_BIT__ 8
#define __code_model_small__ 1
#define __DBL_DECIMAL_DIG__ 17
#define __DBL_DENORM_MIN__ ((double)4.94065645841246544176568792868221372e-324L)
#define __DBL_DIG__ 15
#define __DBL_EPSILON__ ((double)2.22044604925031308084726333618164062e-16L)
#define __DBL_HAS_DENORM__ 1
#define __DBL_HAS_INFINITY__ 1
#define __DBL_HAS_QUIET_NAN__ 1
#define __DBL_MANT_DIG__ 53
#define __DBL_MAX_10_EXP__ 308
#define __DBL_MAX__ ((double)1.79769313486231570814527423731704357e+308L)
#define __DBL_MAX_EXP__ 1024
#define __DBL_MIN_10_EXP__ (-307)
#define __DBL_MIN__ ((double)2.22507385850720138309023271733240406e-308L)
#define __DBL_MIN_EXP__ (-1021)
#define __DEC128_EPSILON__ 1E-33DL
#define __DEC128_MANT_DIG__ 34
#define __DEC128_MAX__ 9.999999999999999999999999999999999E6144DL
#define __DEC128_MAX_EXP__ 6145
#define __DEC128_MIN__ 1E-6143DL
#define __DEC128_MIN_EXP__ (-6142)
#define __DEC128_SUBNORMAL_MIN__ 0.000000000000000000000000000000001E-6143DL
#define __DEC32_EPSILON__ 1E-6DF
#define __DEC32_MANT_DIG__ 7
#define __DEC32_MAX__ 9.999999E96DF
#define __DEC32_MAX_EXP__ 97
#define __DEC32_MIN__ 1E-95DF
#define __DEC32_MIN_EXP__ (-94)
#define __DEC32_SUBNORMAL_MIN__ 0.000001E-95DF
#define __DEC64_EPSILON__ 1E-15DD
#define __DEC64_MANT_DIG__ 16
#define __DEC64_MAX__ 9.999999999999999E384DD
#define __DEC64_MAX_EXP__ 385
#define __DEC64_MIN__ 1E-383DD
#define __DEC64_MIN_EXP__ (-382)
#define __DEC64_SUBNORMAL_MIN__ 0.000000000000001E-383DD
#define __DEC_EVAL_METHOD__ 2
#define __DECIMAL_BID_FORMAT__ 1
#define __DECIMAL_DIG__ 21
#define __ELF__ 1
#define __FINITE_MATH_ONLY__ 0
#define __FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __FLT128_DECIMAL_DIG__ 36
#define __FLT128_DENORM_MIN__ 6.47517511943802511092443895822764655e-4966F128
#define __FLT128_DIG__ 33
#define __FLT128_EPSILON__ 1.92592994438723585305597794258492732e-34F128
#define __FLT128_HAS_DENORM__ 1
#define __FLT128_HAS_INFINITY__ 1
#define __FLT128_HAS_QUIET_NAN__ 1
#define __FLT128_MANT_DIG__ 113
#define __FLT128_MAX_10_EXP__ 4932
#define __FLT128_MAX__ 1.18973149535723176508575932662800702e+4932F128
#define __FLT128_MAX_EXP__ 16384
#define __FLT128_MIN_10_EXP__ (-4931)
#define __FLT128_MIN__ 3.36210314311209350626267781732175260e-4932F128
#define __FLT128_MIN_EXP__ (-16381)
#define __FLT32_DECIMAL_DIG__ 9
#define __FLT32_DENORM_MIN__ 1.40129846432481707092372958328991613e-45F32
#define __FLT32_DIG__ 6
#define __FLT32_EPSILON__ 1.19209289550781250000000000000000000e-7F32
#define __FLT32_HAS_DENORM__ 1
#define __FLT32_HAS_INFINITY__ 1
#define __FLT32_HAS_QUIET_NAN__ 1
#define __FLT32_MANT_DIG__ 24
#define __FLT32_MAX_10_EXP__ 38
#define __FLT32_MAX__ 3.40282346638528859811704183484516925e+38F32
#define __FLT32_MAX_EXP__ 128
#define __FLT32_MIN_10_EXP__ (-37)
#define __FLT32_MIN__ 1.17549435082228750796873653722224568e-38F32
#define __FLT32_MIN_EXP__ (-125)
#define __FLT32X_DECIMAL_DIG__ 17
#define __FLT32X_DENORM_MIN__ 4.94065645841246544176568792868221372e-324F32x
#define __FLT32X_DIG__ 15
#define __FLT32X_EPSILON__ 2.22044604925031308084726333618164062e-16F32x
#define __FLT32X_HAS_DENORM__ 1
#define __FLT32X_HAS_INFINITY__ 1
#define __FLT32X_HAS_QUIET_NAN__ 1
#define __FLT32X_MANT_DIG__ 53
#define __FLT32X_MAX_10_EXP__ 308
#define __FLT32X_MAX__ 1.79769313486231570814527423731704357e+308F32x
#define __FLT32X_MAX_EXP__ 1024
#define __FLT32X_MIN_10_EXP__ (-307)
#define __FLT32X_MIN__ 2.22507385850720138309023271733240406e-308F32x
#define __FLT32X_MIN_EXP__ (-1021)
#define __FLT64_DECIMAL_DIG__ 17
#define __FLT64_DENORM_MIN__ 4.94065645841246544176568792868221372e-324F64
#define __FLT64_DIG__ 15
#define __FLT64_EPSILON__ 2.22044604925031308084726333618164062e-16F64
#define __FLT64_HAS_DENORM__ 1
#define __FLT64_HAS_INFINITY__ 1
#define __FLT64_HAS_QUIET_NAN__ 1
#define __FLT64_MANT_DIG__ 53
#define __FLT64_MAX_10_EXP__ 308
#define __FLT64_MAX__ 1.79769313486231570814527423731704357e+308F64
#define __FLT64_MAX_EXP__ 1024
#define __FLT64_MIN_10_EXP__ (-307)
#define __FLT64_MIN__ 2.22507385850720138309023271733240406e-308F64
#define __FLT64_MIN_EXP__ (-1021)
#define __FLT64X_DECIMAL_DIG__ 21
#define __FLT64X_DENORM_MIN__ 3.64519953188247460252840593361941982e-4951F64x
#define __FLT64X_DIG__ 18
#define __FLT64X_EPSILON__ 1.08420217248550443400745280086994171e-19F64x
#define __FLT64X_HAS_DENORM__ 1
#define __FLT64X_HAS_INFINITY__ 1
#define __FLT64X_HAS_QUIET_NAN__ 1
#define __FLT64X_MANT_DIG__ 64
#define __FLT64X_MAX_10_EXP__ 4932
#define __FLT64X_MAX__ 1.18973149535723176502126385303097021e+4932F64x
#define __FLT64X_MAX_EXP__ 16384
#define __FLT64X_MIN_10_EXP__ (-4931)
#define __FLT64X_MIN__ 3.36210314311209350626267781732175260e-4932F64x
#define __FLT64X_MIN_EXP__ (-16381)
#define __FLT_DECIMAL_DIG__ 9
#define __FLT_DENORM_MIN__ 1.40129846432481707092372958328991613e-45F
#define __FLT_DIG__ 6
#define __FLT_EPSILON__ 1.19209289550781250000000000000000000e-7F
#define __FLT_EVAL_METHOD__ 0
#define __FLT_EVAL_METHOD_TS_18661_3__ 0
#define __FLT_HAS_DENORM__ 1
#define __FLT_HAS_INFINITY__ 1
#define __FLT_HAS_QUIET_NAN__ 1
#define __FLT_MANT_DIG__ 24
#define __FLT_MAX_10_EXP__ 38
#define __FLT_MAX__ 3.40282346638528859811704183484516925e+38F
#define __FLT_MAX_EXP__ 128
#define __FLT_MIN_10_EXP__ (-37)
#define __FLT_MIN__ 1.17549435082228750796873653722224568e-38F
#define __FLT_MIN_EXP__ (-125)
#define __FLT_RADIX__ 2
#define __FXSR__ 1
#define __GCC_ASM_FLAG_OUTPUTS__ 1
#define __GCC_ATOMIC_BOOL_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR_LOCK_FREE 2
#define __GCC_ATOMIC_INT_LOCK_FREE 2
#define __GCC_ATOMIC_LLONG_LOCK_FREE 2
#define __GCC_ATOMIC_LONG_LOCK_FREE 2
#define __GCC_ATOMIC_POINTER_LOCK_FREE 2
#define __GCC_ATOMIC_SHORT_LOCK_FREE 2
#define __GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1
#define __GCC_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __GCC_HAVE_DWARF2_CFI_ASM 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1
#define __GCC_IEC_559 2
#define __GCC_IEC_559_COMPLEX 2
#define __GNUC__ 9
#define __GNUC_MINOR__ 3
#define __GNUC_PATCHLEVEL__ 0
#define __GNUC_STDC_INLINE__ 1
#define __gnu_linux__ 1
#define __GXX_ABI_VERSION 1013
#define __has_include_next(STR) __has_include_next__(STR)
#define __has_include(STR) __has_include__(STR)
#define __HAVE_SPECULATION_SAFE_VALUE 1
#define __INT16_C(c) c
#define __INT16_MAX__ 0x7fff
#define __INT16_TYPE__ short int
#define __INT32_C(c) c
#define __INT32_MAX__ 0x7fffffff
#define __INT32_TYPE__ int
#define __INT64_C(c) c ## L
#define __INT64_MAX__ 0x7fffffffffffffffL
#define __INT64_TYPE__ long int
#define __INT8_C(c) c
#define __INT8_MAX__ 0x7f
#define __INT8_TYPE__ signed char
#define __INT_FAST16_MAX__ 0x7fffffffffffffffL
#define __INT_FAST16_TYPE__ long int
#define __INT_FAST16_WIDTH__ 64
#define __INT_FAST32_MAX__ 0x7fffffffffffffffL
#define __INT_FAST32_TYPE__ long int
#define __INT_FAST32_WIDTH__ 64
#define __INT_FAST64_MAX__ 0x7fffffffffffffffL
#define __INT_FAST64_TYPE__ long int
#define __INT_FAST64_WIDTH__ 64
#define __INT_FAST8_MAX__ 0x7f
#define __INT_FAST8_TYPE__ signed char
#define __INT_FAST8_WIDTH__ 8
#define __INT_LEAST16_MAX__ 0x7fff
#define __INT_LEAST16_TYPE__ short int
#define __INT_LEAST16_WIDTH__ 16
#define __INT_LEAST32_MAX__ 0x7fffffff
#define __INT_LEAST32_TYPE__ int
#define __INT_LEAST32_WIDTH__ 32
#define __INT_LEAST64_MAX__ 0x7fffffffffffffffL
#define __INT_LEAST64_TYPE__ long int
#define __INT_LEAST64_WIDTH__ 64
#define __INT_LEAST8_MAX__ 0x7f
#define __INT_LEAST8_TYPE__ signed char
#define __INT_LEAST8_WIDTH__ 8
#define __INT_MAX__ 0x7fffffff
#define __INTMAX_C(c) c ## L
#define __INTMAX_MAX__ 0x7fffffffffffffffL
#define __INTMAX_TYPE__ long int
#define __INTMAX_WIDTH__ 64
#define __INTPTR_MAX__ 0x7fffffffffffffffL
#define __INTPTR_TYPE__ long int
#define __INTPTR_WIDTH__ 64
#define __INT_WIDTH__ 32
#define __k8 1
#define __k8__ 1
#define __LDBL_DECIMAL_DIG__ 21
#define __LDBL_DENORM_MIN__ 3.64519953188247460252840593361941982e-4951L
#define __LDBL_DIG__ 18
#define __LDBL_EPSILON__ 1.08420217248550443400745280086994171e-19L
#define __LDBL_HAS_DENORM__ 1
#define __LDBL_HAS_INFINITY__ 1
#define __LDBL_HAS_QUIET_NAN__ 1
#define __LDBL_MANT_DIG__ 64
#define __LDBL_MAX_10_EXP__ 4932
#define __LDBL_MAX__ 1.18973149535723176502126385303097021e+4932L
#define __LDBL_MAX_EXP__ 16384
#define __LDBL_MIN_10_EXP__ (-4931)
#define __LDBL_MIN__ 3.36210314311209350626267781732175260e-4932L
#define __LDBL_MIN_EXP__ (-16381)
#define __linux 1
#define __linux__ 1
#define linux 1
#define __LONG_LONG_MAX__ 0x7fffffffffffffffLL
#define __LONG_LONG_WIDTH__ 64
#define __LONG_MAX__ 0x7fffffffffffffffL
#define __LONG_WIDTH__ 64
#define __LP64__ 1
#define _LP64 1
#define __MMX__ 1
#define __NO_INLINE__ 1
#define __ORDER_BIG_ENDIAN__ 4321
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __ORDER_PDP_ENDIAN__ 3412
#define __pic__ 2
#define __PIC__ 2
#define __pie__ 2
#define __PIE__ 2
#define __PRAGMA_REDEFINE_EXTNAME 1
#define __PTRDIFF_MAX__ 0x7fffffffffffffffL
#define __PTRDIFF_TYPE__ long int
#define __PTRDIFF_WIDTH__ 64
#define __REGISTER_PREFIX__
#define __SCHAR_MAX__ 0x7f
#define __SCHAR_WIDTH__ 8
#define __SEG_FS 1
#define __SEG_GS 1
#define __SHRT_MAX__ 0x7fff
#define __SHRT_WIDTH__ 16
#define __SIG_ATOMIC_MAX__ 0x7fffffff
#define __SIG_ATOMIC_MIN__ (-__SIG_ATOMIC_MAX__ - 1)
#define __SIG_ATOMIC_TYPE__ int
#define __SIG_ATOMIC_WIDTH__ 32
#define __SIZE_MAX__ 0xffffffffffffffffUL
#define __SIZEOF_DOUBLE__ 8
#define __SIZEOF_FLOAT128__ 16
#define __SIZEOF_FLOAT__ 4
#define __SIZEOF_FLOAT80__ 16
#define __SIZEOF_INT128__ 16
#define __SIZEOF_INT__ 4
#define __SIZEOF_LONG__ 8
#define __SIZEOF_LONG_DOUBLE__ 16
#define __SIZEOF_LONG_LONG__ 8
#define __SIZEOF_POINTER__ 8
#define __SIZEOF_PTRDIFF_T__ 8
#define __SIZEOF_SHORT__ 2
#define __SIZEOF_SIZE_T__ 8
#define __SIZEOF_WCHAR_T__ 4
#define __SIZEOF_WINT_T__ 4
#define __SIZE_TYPE__ long unsigned int
#define __SIZE_WIDTH__ 64
#define __SSE__ 1
#define __SSE2__ 1
#define __SSE2_MATH__ 1
#define __SSE_MATH__ 1
#define __SSP_STRONG__ 3
#define __STDC__ 1
#define __STDC_HOSTED__ 1
#define __STDC_IEC_559__ 1
#define __STDC_IEC_559_COMPLEX__ 1
#define __STDC_ISO_10646__ 201706L
#define _STDC_PREDEF_H 1
#define __STDC_UTF_16__ 1
#define __STDC_UTF_32__ 1
#define __STDC_VERSION__ 201710L
#define __UINT16_C(c) c
#define __UINT16_MAX__ 0xffff
#define __UINT16_TYPE__ short unsigned int
#define __UINT32_C(c) c ## U
#define __UINT32_MAX__ 0xffffffffU
#define __UINT32_TYPE__ unsigned int
#define __UINT64_C(c) c ## UL
#define __UINT64_MAX__ 0xffffffffffffffffUL
#define __UINT64_TYPE__ long unsigned int
#define __UINT8_C(c) c
#define __UINT8_MAX__ 0xff
#define __UINT8_TYPE__ unsigned char
#define __UINT_FAST16_MAX__ 0xffffffffffffffffUL
#define __UINT_FAST16_TYPE__ long unsigned int
#define __UINT_FAST32_MAX__ 0xffffffffffffffffUL
#define __UINT_FAST32_TYPE__ long unsigned int
#define __UINT_FAST64_MAX__ 0xffffffffffffffffUL
#define __UINT_FAST64_TYPE__ long unsigned int
#define __UINT_FAST8_MAX__ 0xff
#define __UINT_FAST8_TYPE__ unsigned char
#define __UINT_LEAST16_MAX__ 0xffff
#define __UINT_LEAST16_TYPE__ short unsigned int
#define __UINT_LEAST32_MAX__ 0xffffffffU
#define __UINT_LEAST32_TYPE__ unsigned int
#define __UINT_LEAST64_MAX__ 0xffffffffffffffffUL
#define __UINT_LEAST64_TYPE__ long unsigned int
#define __UINT_LEAST8_MAX__ 0xff
#define __UINT_LEAST8_TYPE__ unsigned char
#define __UINTMAX_C(c) c ## UL
#define __UINTMAX_MAX__ 0xffffffffffffffffUL
#define __UINTMAX_TYPE__ long unsigned int
#define __UINTPTR_MAX__ 0xffffffffffffffffUL
#define __UINTPTR_TYPE__ long unsigned int
#define __unix 1
#define __unix__ 1
#define unix 1
#define __USER_LABEL_PREFIX__
#define __VERSION__ "9.3.0"
#define __WCHAR_MAX__ 0x7fffffff
#define __WCHAR_MIN__ (-__WCHAR_MAX__ - 1)
#define __WCHAR_TYPE__ int
#define __WCHAR_WIDTH__ 32
#define __WINT_MAX__ 0xffffffffU
#define __WINT_MIN__ 0U
#define __WINT_TYPE__ unsigned int
#define __WINT_WIDTH__ 32
#define __x86_64 1
#define __x86_64__ 1
ilg@ubu20:~$
```

## Apple clang macros

```console
ilg@wks ~ % gcc --version
Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/4.2.1
Apple clang version 12.0.0 (clang-1200.0.32.28)
Target: x86_64-apple-darwin20.2.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin

ilg@wks ~ % gcc -E -dM - < /dev/null
#define _LP64 1
#define __APPLE_CC__ 6000
#define __APPLE__ 1
#define __ATOMIC_ACQUIRE 2
#define __ATOMIC_ACQ_REL 4
#define __ATOMIC_CONSUME 1
#define __ATOMIC_RELAXED 0
#define __ATOMIC_RELEASE 3
#define __ATOMIC_SEQ_CST 5
#define __BIGGEST_ALIGNMENT__ 16
#define __BLOCKS__ 1
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __CHAR16_TYPE__ unsigned short
#define __CHAR32_TYPE__ unsigned int
#define __CHAR_BIT__ 8
#define __CLANG_ATOMIC_BOOL_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR_LOCK_FREE 2
#define __CLANG_ATOMIC_INT_LOCK_FREE 2
#define __CLANG_ATOMIC_LLONG_LOCK_FREE 2
#define __CLANG_ATOMIC_LONG_LOCK_FREE 2
#define __CLANG_ATOMIC_POINTER_LOCK_FREE 2
#define __CLANG_ATOMIC_SHORT_LOCK_FREE 2
#define __CLANG_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __CONSTANT_CFSTRINGS__ 1
#define __DBL_DECIMAL_DIG__ 17
#define __DBL_DENORM_MIN__ 4.9406564584124654e-324
#define __DBL_DIG__ 15
#define __DBL_EPSILON__ 2.2204460492503131e-16
#define __DBL_HAS_DENORM__ 1
#define __DBL_HAS_INFINITY__ 1
#define __DBL_HAS_QUIET_NAN__ 1
#define __DBL_MANT_DIG__ 53
#define __DBL_MAX_10_EXP__ 308
#define __DBL_MAX_EXP__ 1024
#define __DBL_MAX__ 1.7976931348623157e+308
#define __DBL_MIN_10_EXP__ (-307)
#define __DBL_MIN_EXP__ (-1021)
#define __DBL_MIN__ 2.2250738585072014e-308
#define __DECIMAL_DIG__ __LDBL_DECIMAL_DIG__
#define __DYNAMIC__ 1
#define __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ 110000
#define __FINITE_MATH_ONLY__ 0
#define __FLT16_DECIMAL_DIG__ 5
#define __FLT16_DENORM_MIN__ 5.9604644775390625e-8F16
#define __FLT16_DIG__ 3
#define __FLT16_EPSILON__ 9.765625e-4F16
#define __FLT16_HAS_DENORM__ 1
#define __FLT16_HAS_INFINITY__ 1
#define __FLT16_HAS_QUIET_NAN__ 1
#define __FLT16_MANT_DIG__ 11
#define __FLT16_MAX_10_EXP__ 4
#define __FLT16_MAX_EXP__ 16
#define __FLT16_MAX__ 6.5504e+4F16
#define __FLT16_MIN_10_EXP__ (-4)
#define __FLT16_MIN_EXP__ (-13)
#define __FLT16_MIN__ 6.103515625e-5F16
#define __FLT_DECIMAL_DIG__ 9
#define __FLT_DENORM_MIN__ 1.40129846e-45F
#define __FLT_DIG__ 6
#define __FLT_EPSILON__ 1.19209290e-7F
#define __FLT_EVAL_METHOD__ 0
#define __FLT_HAS_DENORM__ 1
#define __FLT_HAS_INFINITY__ 1
#define __FLT_HAS_QUIET_NAN__ 1
#define __FLT_MANT_DIG__ 24
#define __FLT_MAX_10_EXP__ 38
#define __FLT_MAX_EXP__ 128
#define __FLT_MAX__ 3.40282347e+38F
#define __FLT_MIN_10_EXP__ (-37)
#define __FLT_MIN_EXP__ (-125)
#define __FLT_MIN__ 1.17549435e-38F
#define __FLT_RADIX__ 2
#define __FXSR__ 1
#define __GCC_ASM_FLAG_OUTPUTS__ 1
#define __GCC_ATOMIC_BOOL_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR_LOCK_FREE 2
#define __GCC_ATOMIC_INT_LOCK_FREE 2
#define __GCC_ATOMIC_LLONG_LOCK_FREE 2
#define __GCC_ATOMIC_LONG_LOCK_FREE 2
#define __GCC_ATOMIC_POINTER_LOCK_FREE 2
#define __GCC_ATOMIC_SHORT_LOCK_FREE 2
#define __GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1
#define __GCC_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1
#define __GNUC_MINOR__ 2
#define __GNUC_PATCHLEVEL__ 1
#define __GNUC_STDC_INLINE__ 1
#define __GNUC__ 4
#define __GXX_ABI_VERSION 1002
#define __INT16_C_SUFFIX__
#define __INT16_FMTd__ "hd"
#define __INT16_FMTi__ "hi"
#define __INT16_MAX__ 32767
#define __INT16_TYPE__ short
#define __INT32_C_SUFFIX__
#define __INT32_FMTd__ "d"
#define __INT32_FMTi__ "i"
#define __INT32_MAX__ 2147483647
#define __INT32_TYPE__ int
#define __INT64_C_SUFFIX__ LL
#define __INT64_FMTd__ "lld"
#define __INT64_FMTi__ "lli"
#define __INT64_MAX__ 9223372036854775807LL
#define __INT64_TYPE__ long long int
#define __INT8_C_SUFFIX__
#define __INT8_FMTd__ "hhd"
#define __INT8_FMTi__ "hhi"
#define __INT8_MAX__ 127
#define __INT8_TYPE__ signed char
#define __INTMAX_C_SUFFIX__ L
#define __INTMAX_FMTd__ "ld"
#define __INTMAX_FMTi__ "li"
#define __INTMAX_MAX__ 9223372036854775807L
#define __INTMAX_TYPE__ long int
#define __INTMAX_WIDTH__ 64
#define __INTPTR_FMTd__ "ld"
#define __INTPTR_FMTi__ "li"
#define __INTPTR_MAX__ 9223372036854775807L
#define __INTPTR_TYPE__ long int
#define __INTPTR_WIDTH__ 64
#define __INT_FAST16_FMTd__ "hd"
#define __INT_FAST16_FMTi__ "hi"
#define __INT_FAST16_MAX__ 32767
#define __INT_FAST16_TYPE__ short
#define __INT_FAST32_FMTd__ "d"
#define __INT_FAST32_FMTi__ "i"
#define __INT_FAST32_MAX__ 2147483647
#define __INT_FAST32_TYPE__ int
#define __INT_FAST64_FMTd__ "lld"
#define __INT_FAST64_FMTi__ "lli"
#define __INT_FAST64_MAX__ 9223372036854775807LL
#define __INT_FAST64_TYPE__ long long int
#define __INT_FAST8_FMTd__ "hhd"
#define __INT_FAST8_FMTi__ "hhi"
#define __INT_FAST8_MAX__ 127
#define __INT_FAST8_TYPE__ signed char
#define __INT_LEAST16_FMTd__ "hd"
#define __INT_LEAST16_FMTi__ "hi"
#define __INT_LEAST16_MAX__ 32767
#define __INT_LEAST16_TYPE__ short
#define __INT_LEAST32_FMTd__ "d"
#define __INT_LEAST32_FMTi__ "i"
#define __INT_LEAST32_MAX__ 2147483647
#define __INT_LEAST32_TYPE__ int
#define __INT_LEAST64_FMTd__ "lld"
#define __INT_LEAST64_FMTi__ "lli"
#define __INT_LEAST64_MAX__ 9223372036854775807LL
#define __INT_LEAST64_TYPE__ long long int
#define __INT_LEAST8_FMTd__ "hhd"
#define __INT_LEAST8_FMTi__ "hhi"
#define __INT_LEAST8_MAX__ 127
#define __INT_LEAST8_TYPE__ signed char
#define __INT_MAX__ 2147483647
#define __LDBL_DECIMAL_DIG__ 21
#define __LDBL_DENORM_MIN__ 3.64519953188247460253e-4951L
#define __LDBL_DIG__ 18
#define __LDBL_EPSILON__ 1.08420217248550443401e-19L
#define __LDBL_HAS_DENORM__ 1
#define __LDBL_HAS_INFINITY__ 1
#define __LDBL_HAS_QUIET_NAN__ 1
#define __LDBL_MANT_DIG__ 64
#define __LDBL_MAX_10_EXP__ 4932
#define __LDBL_MAX_EXP__ 16384
#define __LDBL_MAX__ 1.18973149535723176502e+4932L
#define __LDBL_MIN_10_EXP__ (-4931)
#define __LDBL_MIN_EXP__ (-16381)
#define __LDBL_MIN__ 3.36210314311209350626e-4932L
#define __LITTLE_ENDIAN__ 1
#define __LONG_LONG_MAX__ 9223372036854775807LL
#define __LONG_MAX__ 9223372036854775807L
#define __LP64__ 1
#define __MACH__ 1
#define __MMX__ 1
#define __NO_INLINE__ 1
#define __NO_MATH_INLINES 1
#define __OBJC_BOOL_IS_BOOL 0
#define __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES 3
#define __OPENCL_MEMORY_SCOPE_DEVICE 2
#define __OPENCL_MEMORY_SCOPE_SUB_GROUP 4
#define __OPENCL_MEMORY_SCOPE_WORK_GROUP 1
#define __OPENCL_MEMORY_SCOPE_WORK_ITEM 0
#define __ORDER_BIG_ENDIAN__ 4321
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __ORDER_PDP_ENDIAN__ 3412
#define __PIC__ 2
#define __POINTER_WIDTH__ 64
#define __PRAGMA_REDEFINE_EXTNAME 1
#define __PTRDIFF_FMTd__ "ld"
#define __PTRDIFF_FMTi__ "li"
#define __PTRDIFF_MAX__ 9223372036854775807L
#define __PTRDIFF_TYPE__ long int
#define __PTRDIFF_WIDTH__ 64
#define __REGISTER_PREFIX__
#define __SCHAR_MAX__ 127
#define __SEG_FS 1
#define __SEG_GS 1
#define __SHRT_MAX__ 32767
#define __SIG_ATOMIC_MAX__ 2147483647
#define __SIG_ATOMIC_WIDTH__ 32
#define __SIZEOF_DOUBLE__ 8
#define __SIZEOF_FLOAT__ 4
#define __SIZEOF_INT128__ 16
#define __SIZEOF_INT__ 4
#define __SIZEOF_LONG_DOUBLE__ 16
#define __SIZEOF_LONG_LONG__ 8
#define __SIZEOF_LONG__ 8
#define __SIZEOF_POINTER__ 8
#define __SIZEOF_PTRDIFF_T__ 8
#define __SIZEOF_SHORT__ 2
#define __SIZEOF_SIZE_T__ 8
#define __SIZEOF_WCHAR_T__ 4
#define __SIZEOF_WINT_T__ 4
#define __SIZE_FMTX__ "lX"
#define __SIZE_FMTo__ "lo"
#define __SIZE_FMTu__ "lu"
#define __SIZE_FMTx__ "lx"
#define __SIZE_MAX__ 18446744073709551615UL
#define __SIZE_TYPE__ long unsigned int
#define __SIZE_WIDTH__ 64
#define __SSE2_MATH__ 1
#define __SSE2__ 1
#define __SSE3__ 1
#define __SSE4_1__ 1
#define __SSE_MATH__ 1
#define __SSE__ 1
#define __SSP__ 1
#define __SSSE3__ 1
#define __STDC_HOSTED__ 1
#define __STDC_NO_THREADS__ 1
#define __STDC_UTF_16__ 1
#define __STDC_UTF_32__ 1
#define __STDC_VERSION__ 201112L
#define __STDC__ 1
#define __UINT16_C_SUFFIX__
#define __UINT16_FMTX__ "hX"
#define __UINT16_FMTo__ "ho"
#define __UINT16_FMTu__ "hu"
#define __UINT16_FMTx__ "hx"
#define __UINT16_MAX__ 65535
#define __UINT16_TYPE__ unsigned short
#define __UINT32_C_SUFFIX__ U
#define __UINT32_FMTX__ "X"
#define __UINT32_FMTo__ "o"
#define __UINT32_FMTu__ "u"
#define __UINT32_FMTx__ "x"
#define __UINT32_MAX__ 4294967295U
#define __UINT32_TYPE__ unsigned int
#define __UINT64_C_SUFFIX__ ULL
#define __UINT64_FMTX__ "llX"
#define __UINT64_FMTo__ "llo"
#define __UINT64_FMTu__ "llu"
#define __UINT64_FMTx__ "llx"
#define __UINT64_MAX__ 18446744073709551615ULL
#define __UINT64_TYPE__ long long unsigned int
#define __UINT8_C_SUFFIX__
#define __UINT8_FMTX__ "hhX"
#define __UINT8_FMTo__ "hho"
#define __UINT8_FMTu__ "hhu"
#define __UINT8_FMTx__ "hhx"
#define __UINT8_MAX__ 255
#define __UINT8_TYPE__ unsigned char
#define __UINTMAX_C_SUFFIX__ UL
#define __UINTMAX_FMTX__ "lX"
#define __UINTMAX_FMTo__ "lo"
#define __UINTMAX_FMTu__ "lu"
#define __UINTMAX_FMTx__ "lx"
#define __UINTMAX_MAX__ 18446744073709551615UL
#define __UINTMAX_TYPE__ long unsigned int
#define __UINTMAX_WIDTH__ 64
#define __UINTPTR_FMTX__ "lX"
#define __UINTPTR_FMTo__ "lo"
#define __UINTPTR_FMTu__ "lu"
#define __UINTPTR_FMTx__ "lx"
#define __UINTPTR_MAX__ 18446744073709551615UL
#define __UINTPTR_TYPE__ long unsigned int
#define __UINTPTR_WIDTH__ 64
#define __UINT_FAST16_FMTX__ "hX"
#define __UINT_FAST16_FMTo__ "ho"
#define __UINT_FAST16_FMTu__ "hu"
#define __UINT_FAST16_FMTx__ "hx"
#define __UINT_FAST16_MAX__ 65535
#define __UINT_FAST16_TYPE__ unsigned short
#define __UINT_FAST32_FMTX__ "X"
#define __UINT_FAST32_FMTo__ "o"
#define __UINT_FAST32_FMTu__ "u"
#define __UINT_FAST32_FMTx__ "x"
#define __UINT_FAST32_MAX__ 4294967295U
#define __UINT_FAST32_TYPE__ unsigned int
#define __UINT_FAST64_FMTX__ "llX"
#define __UINT_FAST64_FMTo__ "llo"
#define __UINT_FAST64_FMTu__ "llu"
#define __UINT_FAST64_FMTx__ "llx"
#define __UINT_FAST64_MAX__ 18446744073709551615ULL
#define __UINT_FAST64_TYPE__ long long unsigned int
#define __UINT_FAST8_FMTX__ "hhX"
#define __UINT_FAST8_FMTo__ "hho"
#define __UINT_FAST8_FMTu__ "hhu"
#define __UINT_FAST8_FMTx__ "hhx"
#define __UINT_FAST8_MAX__ 255
#define __UINT_FAST8_TYPE__ unsigned char
#define __UINT_LEAST16_FMTX__ "hX"
#define __UINT_LEAST16_FMTo__ "ho"
#define __UINT_LEAST16_FMTu__ "hu"
#define __UINT_LEAST16_FMTx__ "hx"
#define __UINT_LEAST16_MAX__ 65535
#define __UINT_LEAST16_TYPE__ unsigned short
#define __UINT_LEAST32_FMTX__ "X"
#define __UINT_LEAST32_FMTo__ "o"
#define __UINT_LEAST32_FMTu__ "u"
#define __UINT_LEAST32_FMTx__ "x"
#define __UINT_LEAST32_MAX__ 4294967295U
#define __UINT_LEAST32_TYPE__ unsigned int
#define __UINT_LEAST64_FMTX__ "llX"
#define __UINT_LEAST64_FMTo__ "llo"
#define __UINT_LEAST64_FMTu__ "llu"
#define __UINT_LEAST64_FMTx__ "llx"
#define __UINT_LEAST64_MAX__ 18446744073709551615ULL
#define __UINT_LEAST64_TYPE__ long long unsigned int
#define __UINT_LEAST8_FMTX__ "hhX"
#define __UINT_LEAST8_FMTo__ "hho"
#define __UINT_LEAST8_FMTu__ "hhu"
#define __UINT_LEAST8_FMTx__ "hhx"
#define __UINT_LEAST8_MAX__ 255
#define __UINT_LEAST8_TYPE__ unsigned char
#define __USER_LABEL_PREFIX__ _
#define __VERSION__ "Apple LLVM 12.0.0 (clang-1200.0.32.28)"
#define __WCHAR_MAX__ 2147483647
#define __WCHAR_TYPE__ int
#define __WCHAR_WIDTH__ 32
#define __WINT_MAX__ 2147483647
#define __WINT_TYPE__ int
#define __WINT_WIDTH__ 32
#define __amd64 1
#define __amd64__ 1
#define __apple_build_version__ 12000032
#define __block __attribute__((__blocks__(byref)))
#define __clang__ 1
#define __clang_major__ 12
#define __clang_minor__ 0
#define __clang_patchlevel__ 0
#define __clang_version__ "12.0.0 (clang-1200.0.32.28)"
#define __code_model_small_ 1
#define __core2 1
#define __core2__ 1
#define __llvm__ 1
#define __nonnull _Nonnull
#define __null_unspecified _Null_unspecified
#define __nullable _Nullable
#define __pic__ 2
#define __seg_fs __attribute__((address_space(257)))
#define __seg_gs __attribute__((address_space(256)))
#define __strong
#define __tune_core2__ 1
#define __unsafe_unretained
#define __weak __attribute__((objc_gc(weak)))
#define __x86_64 1
#define __x86_64__ 1
ilg@wks ~ %
```
