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
#if defined(__x86_64__)
```

To check the compiler:

```c
#if defined (__GNUC__)
#if __GNUC__ == 4 && __GNUC_MINOR__ == 7
#if defined(__clang__)
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
#define __GXX_ABI_VERSION 1009
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
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
#define __GXX_ABI_VERSION 1009
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
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
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1009
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1
```

### ARM Cortex-M4

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
#define __GXX_ABI_VERSION 1009
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
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
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 12
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1009
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
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
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 12
#define __ARM_PCS_VFP 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1009
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
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
#define __GXX_ABI_VERSION 1009
#define __SOFTFP__ 1
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
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
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 12
#define __ARM_PCS 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1009
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
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
#define __ARM_FEATURE_DSP 1
#define __ARM_FEATURE_IDIV 1
#define __ARM_FEATURE_LDREX 7
#define __ARM_FEATURE_QBIT 1
#define __ARM_FEATURE_SAT 1
#define __ARM_FEATURE_SIMD32 1
#define __ARM_FEATURE_UNALIGNED 1
#define __ARM_FP 12
#define __ARM_PCS_VFP 1
#define __ARM_SIZEOF_MINIMAL_ENUM 1
#define __ARM_SIZEOF_WCHAR_T 4
#define __GXX_ABI_VERSION 1009
#define __STDC_VERSION__ 201112L
#define __THUMBEL__ 1
#define __THUMB_INTERWORK__ 1
#define __VERSION__ "5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496]"
#define __VFP_FP__ 1
#define __arm__ 1
#define __thumb2__ 1
#define __thumb__ 1
```

## Floating point

To check if hardware floating point is enabled (`-mfloat-abi=softfp` or `-mfloat-abi=hard`):

```c
#define __ARM_FP 12
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
