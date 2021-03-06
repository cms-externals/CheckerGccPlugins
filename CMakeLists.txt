# Copyright (C) 2002-2018 CERN for the benefit of the CMS collaboration
cmake_minimum_required(VERSION 3.10)
# The name of the package:
project( CheckerGccPlugins )

# Only do anything for a GCC compiler:
if( NOT CMAKE_COMPILER_IS_GNUCXX )
   return()
endif()

# Since this package doesn't depend on any other CMS packages,
# in release recompilation mode don't even go further than this.
if( CMS_RELEASE_MODE )
   return()
endif()

# Disable the -Wl,--no-undefined linker flag for the library:
string( REPLACE "-Wl,--no-undefined" ""
   CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS}" )

# Set up the build of the library:
file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cxx)
add_library( checker_gccplugins MODULE
   ${SOURCES} )
target_compile_options( checker_gccplugins
   PRIVATE -fno-rtti -Wno-deprecated-copy)
target_compile_options( checker_gccplugins
   PRIVATE -iwithprefix plugin/include )

enable_testing()

function( CheckerGccPlugins_test1 testName mode )

  set( _fullName ${testName}_${mode} )
  set( _checkerTestFlags ${CMAKE_CXX_FLAGS_${mode}} )
  configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/test/checker_test.sh.in
                  ${CMAKE_CURRENT_BINARY_DIR}/CheckerGccPlugins_${_fullName}.sh
                  @ONLY )

  find_program( BASH_EXECUTABLE bash )

  set(POST_EXEC_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/test/post.sh ${_fullName} '' ${CMAKE_CURRENT_SOURCE_DIR}/share/${testName}_test.ref")

  configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/test/unit_test_executor.sh.in
                  ${CMAKE_CURRENT_BINARY_DIR}/${_fullName}.sh
                  @ONLY )
  add_test( NAME ${_fullName}_ctest
                  COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${_fullName}.sh)

endfunction( CheckerGccPlugins_test1 )


function( CheckerGccPlugins_test testName )
CheckerGccPlugins_test1( ${testName} RELEASE )
CheckerGccPlugins_test1( ${testName} DEBUG )
endfunction( CheckerGccPlugins_test )


#CheckerGccPlugins_test( gaudi_inheritance )
#CheckerGccPlugins_test( divcheck )
#CheckerGccPlugins_test( naming )
#CheckerGccPlugins_test( check_ts1 )
CheckerGccPlugins_test( thread1 )
CheckerGccPlugins_test( thread2 )
CheckerGccPlugins_test( thread3 )
CheckerGccPlugins_test( thread4 )
CheckerGccPlugins_test( thread5 )
CheckerGccPlugins_test( thread6 )
CheckerGccPlugins_test( thread7 )
CheckerGccPlugins_test( thread8 )
CheckerGccPlugins_test( thread9 )
#CheckerGccPlugins_test( thread10 )
CheckerGccPlugins_test( thread11 )
CheckerGccPlugins_test( thread12 )
CheckerGccPlugins_test( thread13 )
CheckerGccPlugins_test( thread14 )
CheckerGccPlugins_test( thread15 )
CheckerGccPlugins_test( thread16 )
CheckerGccPlugins_test( thread17 )
CheckerGccPlugins_test( thread18 )
#CheckerGccPlugins_test( usingns1 )
#CheckerGccPlugins_test( usingns2 )
#CheckerGccPlugins_test( usingns3 )
#CheckerGccPlugins_test( usingns4 )
#CheckerGccPlugins_test( usingns5 )
#CheckerGccPlugins_test( usingns6 )
#CheckerGccPlugins_test( usingns7 )
