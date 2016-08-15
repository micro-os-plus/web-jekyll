---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/How_to_test/
title: How to test
author: Liviu Ionescu

date: 2013-09-05 22:42:56 +0000

---

Repository cloning
------------------

Once the prerequisites are satisfied, create a dedicated folder for the tests, clone the repositories and run the script. In addition to the µOS++ SE repository, a second repository, containing the **XCDL build tools**, is required.

    mkdir -p ~/work/uOS
    cd ~/work/uOS

    git clone http://git.code.sf.net/p/micro-os-plus/second micro-os-plus-se.git
    git clone http://git.code.sf.net/p/xcdl/python xcdl-python.git

If you already have local clones of the repositories, you can only update them:

    cd ~/work/uOS

    (cd micro-os-plus-se.git; git pull)
    (cd xcdl-python.git; git pull)

How to run the POSIX tests
--------------------------

As already mentioned, one of the early µOS++ design decision was to include a POSIX synthetic platform, running on OS X and GNU/Linux. In this configuration, each µOS++ application is executed within the context of a POSIX process, running as a command line application.

Each test can be compiled in multiple configurations, with various toolchains, with 32/64-bit, for *Debug* or *Release*.

### All tests

To run a sequence of all available POSIX tests, use the **runPosixTests.sh** script. The list of tests is currently static, defined at the beginning of the script.

This script accepts some optional arguments:

-   **--dest folder** - to specify where the build folders will be created, usually in a temporary folder. Without it the build folder will be created in the current folder.
-   **--full** - to ask for all possible variants of each test

To perform a quick test, using only the default compiler, run the following commands:

    rm -rf /tmp/uOS/build
    /bin/bash micro-os-plus-se.git/scripts/runPosixTests.sh --dest /tmp/uOS/build

(the remove command is useful if you already performed the tests before, and want a clean run).

If the quick tests pass, it is recommended to run the full version, that includes all known compilers, in both 32 and 64 bit versions.

    /bin/bash micro-os-plus-se.git/scripts/runPosixTests.sh --dest /tmp/uOS/build --full

### One or some tests (stress tests)

Due to their duration, there are some stress tests that were not included in the main group.

However it is quite easy to run only a single test, or a given list of tests, by providing the names to the script:

    /bin/bash micro-os-plus-se.git/scripts/runPosixTests.sh --dest /tmp/uOS/build --full sleepstress mutexstress

### One single variant of a test

For debugging purposes, here is the command to build a single configuration:

    /bin/bash xcdl-python.git/scripts/xcdlBuild.sh --repository=micro-os-plus-se.git/packages \
    --build_dir=/tmp/uOS/build --build_dir=/tmp/uOS/build \
    --build_config=linux_yields_x64_gcc_Debug -Wr,-x,junit.xml run

### Sample output

Being based on **make**, the first time when the runTests.sh script is executed, each test will first build the executable from the sources, then execute it. Running the script again will only execute the tests.

If the machine used to run this script returns x86_64 for `uname -m`, it is assumed to be a 64-bit machine and the 64-bit versions of all tests are also executed.

On OS X, if `/opt/local/bin/g++-mp-4.7` exists and is executable, then the MacPorts GCC 4.7 tests are included. A similar test is performed for MacPorts GCC 4.8. However be sure that **+universal** was used to build these packages, otherwise the tests will fail to run the 32-bit executables on a 64-bit machine.

The output produced by the *Debug* version of a test looks like:


    XCDL metadata processed in 30ms.

    XCDL build started, using toolchain 'OS X Apple Debug LLVM x86_64'...

    cd build/osx_trace_x64_llvm_Debug
    PATH=/usr/sbin:/sbin:/bin:/usr/bin

    make run
    Running XCDL target: trace.elf

    os::diag::Trace::Trace() @00000001097BABE8

    livius.net / Trace v1.1.1, Mar 30 2013 21:27:09
    uOS++ v5.1.7630, clang 4.2 (clang-425.0.24) x86_64
    POSIX synthetic, running on x86_64 Darwin 12.3.0

    hal::posix::infra::TestSuiteImplementation::TestSuiteImplementation() @00000001097BACC0
    os::infra::TestSuite::TestSuite() @00000001097BAC88

    START:"Starting tests from 'portable/diagnostics/tests/src/trace.cpp'"
    STAT:PASS,"All 208 checks passed! :-) "

    int main(int, char **) returns 0
    os::infra::TestSuite::~TestSuite() @00000001097BAC88
    hal::posix::infra::TestSuiteImplementation::~TestSuiteImplementation() @00000001097BACC0
    virtual os::diag::Trace::~Trace() @00000001097BABE8
    Finished running target: trace.elf

    XCDL build completed in 37ms.

The output produced by the *Release* version of the same test is slightly less verbose:


    XCDL metadata processed in 24ms.

    XCDL build started, using toolchain 'OS X Apple Release LLVM x86_64'...

    cd build/osx_trace_x64_llvm_Release
    PATH=/usr/sbin:/sbin:/bin:/usr/bin

    make run
    Running XCDL target: trace.elf

    START:"Starting tests from 'portable/diagnostics/tests/src/trace.cpp'"
    STAT:PASS,"All 208 checks passed! :-) "

    Finished running target: trace.elf

    XCDL build completed in 31ms.

### The XML output

All tests return the FAIL information as the non-zero POSIX exit code, so the script will break as soon as one of the tests fails.

In other words, the completion of the runTests.sh is a guarantee that all tests were built without warnings and all assertions passed.

In addition to this PASS/FAIL information, the testing framework is also able to generate jUnit XML files for each test, to be used in continuous integration environments, like Jenkins.

To activate this, the runTests.sh script automatically adds `-Wr,-x,junit.xml` to run builds, which will be passed by make down to the the executable as `-x junit.xml`.

The resulting file looks like the following:

     <testsuites><testsuite>
     <testcase classname="os::infra::TestSuite" name="check true constant"/>
     <testcase classname="os::infra::TestSuite" name="check false constant"><failure/></testcase>
     <testcase classname="os::infra::TestSuite" name="a passed test"/>
     <testcase classname="os::infra::TestSuite" name="a failed test"><failure/></testcase>
     </testsuite></testsuites>

How to build the Cortex-M tests
===============================

Use a different toolchain
-------------------------

Although the current procedure recommends to fully define new toolchains and to refer to them in the build configurations, there might be cases when you would want to test a build with other toolchain versions, located in different folders.

The current version of the build script uses a sequence like this:

    PATH_ARM="/usr/local/gcc-arm-none-eabi-4_7/bin"

    if [ -x "$PATH_ARM/arm-none-eabi-g++" ]
    then
        (PATH=$PATH_ARM:$PATH; runTestCollection "linux_aep_gcc" )
    fi

Changing the script for a different toolchain is easy, just update the PATH_ARM variable to the new location and rerun.

It is also perfectly possible to run the tests with multiple toolchains in the same script, just duplicate the above code and update the path for each instance.

Please note that for such a change to be functional, the toolchains must be compatible, i.e. executables should be prefixed with 'arm-none-eabi-' and in general must be the standard GNU modern versions of GCC.

Perform the build tests
-----------------------

If you properly installed the cross toolchains, you can run the script to build various tests:

    cd work/uOS
    /bin/bash micro-os-plus-se.git/scripts/buildCross.sh --dest /tmp/uOS/buildCross

How to build the AVR8 tests
===========================

TBD
