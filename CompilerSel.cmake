########
# CompilerSel
########

if (NOT DEFINED CMAKE_CompilerSel_GUARD)
  set(          CMAKE_CompilerSel_GUARD ON)

function(compiler_sel)
  if ("${COMPILER_SEL}" STREQUAL "gcc")
    find_program(GCC gcc)
    find_program(GXX g++)
    
    #set(ENV{CC}  ${GCC} PARENT_SCOPE)
    #set(ENV{CXX} ${GXX} PARENT_SCOPE)
    #set(CMAKE_C_COMPILER   ${GCC} PARENT_SCOPE)
    #set(CMAKE_CXX_COMPILER ${GXX} PARENT_SCOPE)
    set(CMAKE_C_COMPILER   ${GCC} CACHE INTERNAL "")
    set(CMAKE_CXX_COMPILER ${GXX} CACHE INTERNAL "")
  elseif("${COMPILER_SEL}" STREQUAL "clang")
    find_program(CLANG   clang)
    
    find_program(CLANGXX_LIBCXX clang++-libc++)
    if (CLANGXX_LIBCXX) ## if (CLANGXX_LIBCXX AND OFF) # to try out the else() branch below
      set(         CLANGXX ${CLANGXX_LIBCXX})
    else()
      find_program(CLANGXX clang++)
      #set(CMAKE_CXX_FLAGS        "${CMAKE_CXX_FLAGS}        -stdlib=libc++")
      #set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc++abi" )

      # https://cmake.org/pipermail/cmake/2005-September/007177.html
      SET(MYPROJ_CXX_FLAGS_CompilerSel "-stdlib=libc++" CACHE STRING "common C++ build flags")
      SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${MYPROJ_CXX_FLAGS_CompilerSel}" CACHE INTERNAL "Internal flags do not edit" FORCE)

      SET(MYPROJ_EXE_LINKER_FLAGS_CompilerSel "-lc++abi" CACHE STRING "exe linker flags")
      SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${MYPROJ_EXE_LINKER_FLAGS_CompilerSel}" CACHE INTERNAL "Internal flags do not edit" FORCE)
      
    endif()
    
    #set(ENV{CC}  ${CLANG}   PARENT_SCOPE)
    #set(ENV{CXX} ${CLANGXX} PARENT_SCOPE)
    #set(CMAKE_C_COMPILER   ${CLANG}   PARENT_SCOPE)
    #set(CMAKE_CXX_COMPILER ${CLANGXX} PARENT_SCOPE)
    set(CMAKE_C_COMPILER   ${CLANG}   CACHE INTERNAL "")
    set(CMAKE_CXX_COMPILER ${CLANGXX} CACHE INTERNAL "")
  endif()

endfunction()

compiler_sel()
project(gooo) #!!!!!!!!!!!!!!!!!!!!!!!!!
message("Compiler Sel: \$ENV{CC}                  == $ENV{CC}")
message("              \$ENV{CXX}                 == $ENV{CXX}")
message("              \${CMAKE_C_COMPILER}       == ${CMAKE_C_COMPILER}")
message("              \${CMAKE_CXX_COMPILER}     == ${CMAKE_CXX_COMPILER}")
message("              \${CMAKE_CXX_FLAGS}        == ${CMAKE_CXX_FLAGS}")
message("              \${CMAKE_EXE_LINKER_FLAGS} == ${CMAKE_EXE_LINKER_FLAGS}")

endif()
