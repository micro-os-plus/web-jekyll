---
layout: page
permalink: /micro-os-plus/iii/predefined-macros/
title: Predefined compiler macros
author: Liviu Ionescu

date: 2015-08-05 13:48:01 +0000

---

## Platform dependencies

If some parts of the code are platform dependent, test the following preprocessor definitions:

    #if defined(__APPLE__)
    #if defined(__linux__)
    #if defined(__x86_64__)

To check the compiler:

    #if defined (__GNUC__)
    #if __GNUC__ == 4 && __GNUC_MINOR__ == 7
    #if defined(__clang__)

To check the size of the pointer:

    #if __SIZEOF_POINTER__ == __SIZEOF_INT__
    #elif __SIZEOF_POINTER__ == __SIZEOF_LONG__
    #elif __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__

To check if there are no **long long** variables:

    #if !defined(__SIZEOF_LONG_LONG)

To check if the compiling unit is C++:

    #if defined (__cplusplus)

To check if the compiling unit is an assembly file:

    #if defined(__ASSEMBLER__)

To check if optimisation is enabled (more than -O0):

    #if defined(__OPTIMIZE__)

To check if optimisation for size is enabled (-Os):

    #if defined(__OPTIMIZE_SIZE__)

To check if no inlines are enabled:

    #if defined(__NO_INLINE__)

To see the GCC defines use:

    g++ -dM -E - < /dev/null
    clang++ -dM -E - < /dev/null

## ARM Cortex-M

When compiling Cortex-M applications, GCC 4.8 provides the following built-in definitions.

### ARM Cortex-M0/M0+

    $ ./arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex' | sort
    #define __ARMEL__ 1
    #define __ARM_ARCH 6
    #define __ARM_ARCH_6M__ 1
    #define __ARM_ARCH_ISA_THUMB 1
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FP 12
    #define __ARM_NEON_FP 4
    #define __ARM_PCS 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 4
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.9.3 20150303 (release) [ARM/embedded-4_9-branch revision 221220]"
    #define __arm__ 1
    #define __thumb__ 1

### ARM Cortex-M3

    $ ./arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex' | sort
    #define __ARMEL__ 1
    #define __ARM_32BIT_STATE 1
    #define __ARM_ARCH 7
    #define __ARM_ARCH_7M__ 1
    #define __ARM_ARCH_EXT_IDIV__ 1
    #define __ARM_ARCH_ISA_THUMB 2
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FEATURE_CLZ 1
    #define __ARM_FEATURE_LDREX 7
    #define __ARM_FEATURE_QBIT 1
    #define __ARM_FEATURE_SAT 1
    #define __ARM_FEATURE_UNALIGNED 1
    #define __ARM_FP 12
    #define __ARM_NEON_FP 4
    #define __ARM_PCS 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 4
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.9.3 20150303 (release) [ARM/embedded-4_9-branch revision 221220]"
    #define __arm__ 1
    #define __thumb2__ 1
    #define __thumb__ 1

### ARM Cortex-M4

    $ ./arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft \
    -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp__|version|abi' | sort
    #define __ARMEL__ 1
    #define __ARM_32BIT_STATE 1
    #define __ARM_ARCH 7
    #define __ARM_ARCH_7EM__ 1
    #define __ARM_ARCH_EXT_IDIV__ 1
    #define __ARM_ARCH_ISA_THUMB 2
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FEATURE_CLZ 1
    #define __ARM_FEATURE_DSP 1
    #define __ARM_FEATURE_LDREX 7
    #define __ARM_FEATURE_QBIT 1
    #define __ARM_FEATURE_SAT 1
    #define __ARM_FEATURE_SIMD32 1
    #define __ARM_FEATURE_UNALIGNED 1
    #define __ARM_FP 12
    #define __ARM_NEON_FP 4
    #define __ARM_PCS 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 4
    #define __GXX_ABI_VERSION 1002
    #define __SOFTFP__ 1
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.9.3 20150303 (release) [ARM/embedded-4_9-branch revision 221220]"
    #define __VFP_FP__ 1
    #define __arm__ 1
    #define __thumb2__ 1
    #define __thumb__ 1

    $ ./arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard \
    -mfpu=fpv4-sp-d16 -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp__|version|abi' | sort
    #define __ARMEL__ 1
    #define __ARM_32BIT_STATE 1
    #define __ARM_ARCH 7
    #define __ARM_ARCH_7EM__ 1
    #define __ARM_ARCH_EXT_IDIV__ 1
    #define __ARM_ARCH_ISA_THUMB 2
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FEATURE_CLZ 1
    #define __ARM_FEATURE_DSP 1
    #define __ARM_FEATURE_FMA 1
    #define __ARM_FEATURE_LDREX 7
    #define __ARM_FEATURE_QBIT 1
    #define __ARM_FEATURE_SAT 1
    #define __ARM_FEATURE_SIMD32 1
    #define __ARM_FEATURE_UNALIGNED 1
    #define __ARM_FP 4
    #define __ARM_NEON_FP 4
    #define __ARM_PCS_VFP 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 4
    #define __GXX_ABI_VERSION 1002
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.9.3 20150303 (release) [ARM/embedded-4_9-branch revision 221220]"
    #define __VFP_FP__ 1
    #define __arm__ 1
    #define __thumb2__ 1
    #define __thumb__ 1

### ARM Cortex-M7

    $ ./arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -mfloat-abi=soft \
    -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex|fp__|version|abi' | sort
    #define __ARMEL__ 1
    #define __ARM_32BIT_STATE 1
    #define __ARM_ARCH 7
    #define __ARM_ARCH_7EM__ 1
    #define __ARM_ARCH_EXT_IDIV__ 1
    #define __ARM_ARCH_ISA_THUMB 2
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FEATURE_CLZ 1
    #define __ARM_FEATURE_DSP 1
    #define __ARM_FEATURE_LDREX 7
    #define __ARM_FEATURE_QBIT 1
    #define __ARM_FEATURE_SAT 1
    #define __ARM_FEATURE_SIMD32 1
    #define __ARM_FEATURE_UNALIGNED 1
    #define __ARM_FP 12
    #define __ARM_NEON_FP 4
    #define __ARM_PCS 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 4
    #define __GXX_ABI_VERSION 1002
    #define __SOFTFP__ 1
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.9.3 20150303 (release) [ARM/embedded-4_9-branch revision 221220]"
    #define __VFP_FP__ 1
    #define __arm__ 1
    #define __thumb2__ 1
    #define __thumb__ 1

## Freestanding

To check if -ffreestanding was defined, you can use the following:

    #define __STDC_HOSTED__ 0

By default, i.e. with -fhosted defined, the value is 1.

## C++ Exceptions

To check if a C++ program is compiled with -fexceptions, use:

    #define __EXCEPTIONS 1

## Other macros

    #define __CHAR_UNSIGNED__ 1
    #define __LP64__ 1

## Warnings

When compiling third party sources, it might be necessary to temporarily disable some warnings:

    // [ILG]
    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Wundef"
    #pragma GCC diagnostic ignored "-Wsign-conversion"

    // [ILG]
    #pragma GCC diagnostic pop

    // [ILG]
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundef"

    // [ILG]
    #pragma clang diagnostic pop
