
SET(CMAKE_SYSTEM_NAME KolibriOS)
SET(CMAKE_SYSTEM_PROCESSOR x86)
SET(CMAKE_CROSSCOMPILING 1)

if(CMAKE_HOST_WIN32)
    SET(TOOLCHAIN_PATH
		"C:/MinGW/msys/1.0/home/autobuild/tools/win32"
	)
else()
	set(TOOLCHAIN_PATH
		"/home/autobuild/tools/win32"
	)
endif()

# Compiler
find_program (CMAKE_C_COMPILER	
	kos32-gcc
	PATHS ${TOOLCHAIN_PATH}/bin
	REQUIRED 
)

find_program (CMAKE_CXX_COMPILER	
	kos32-g++
	PATHS ${TOOLCHAIN_PATH}/bin
	REQUIRED 
)

find_program (CMAKE_C_LINKER
	kos32-ld
	PATHS ${TOOLCHAIN_PATH}/bin
	REQUIRED
)

find_program (CMAKE_AR
	kos32-ar
	PATHS ${TOOLCHAIN_PATH}/bin
	REQUIRED
)

find_program (CMAKE_STRIP
	kos32-strip
	PATHS ${TOOLCHAIN_PATH}/bin
	REQUIRED
)

find_program (CMAKE_OBJCOPY	
	kos32-objcopy
	PATHS ${TOOLCHAIN_PATH}/bin
	REQUIRED
)

SET(CMAKE_C_ARCHIVE_FINISH   "<CMAKE_AR> -s -c <TARGET>")
SET(CMAKE_CXX_ARCHIVE_FINISH "<CMAKE_AR> -s -c <TARGET>")

set(CMAKE_C_STANDARD_COMPUTED_DEFAULT "11")
set(CMAKE_CXX_STANDARD_COMPUTED_DEFAULT "11")

set(CMAKE_C_COMPILER_VERSION "5.4.0")
set(CMAKE_CXX_COMPILER_VERSION "5.4.0")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)


set(CMAKE_C_COMPILER_FORCED TRUE)
set(CMAKE_CXX_COMPILER_FORCED TRUE)

if(NOT KOLIBRIOS_REPO)
	set(KOLIBRIOS_REPO ${CMAKE_CURRENT_SOURCE_DIR}/../../kolibrios)
endif()

get_filename_component(REPO ${KOLIBRIOS_REPO} REALPATH)

set(SDK_DIR ${REPO}/contrib/sdk)
set(NewLib_DIR ${SDK_DIR}/sources/newlib)
set(Libstdcpp_DIR ${SDK_DIR}/sources/libstdc++-v3)

add_compile_options(-fno-ident -fomit-frame-pointer -U__WIN32__ -U_Win32 -U_WIN32 -U__MINGW32__ -UWIN32 -I${NewLib_DIR}/libc/include -I${Libstdcpp_DIR}/include)

add_link_options(-static -S --image-base 0 -nostdlib -T ${NewLib_DIR}/app.lds -L${TOOLCHAIN_PATH}/lib -L${TOOLCHAIN_PATH}/mingw32/lib -L${SDK_DIR}/lib --subsystem native)

set(CMAKE_C_LINK_EXECUTABLE   "<CMAKE_LINKER> <LINK_FLAGS> -o <TARGET> <OBJECTS> --start-group -lgcc -lc.dll <LINK_LIBRARIES> --end-group <CMAKE_C_LINK_FLAGS>" CACHE STRING "KOLIBRIOS C LINK EXECUTABLE")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_LINKER> <LINK_FLAGS> -o <TARGET> <OBJECTS> --start-group -lgcc -lc.dll -lstdc++ -lsupc++ <LINK_LIBRARIES> --end-group <CMAKE_CXX_LINK_FLAGS>" CACHE STRING "KOLIBRIOS CXX LINK EXECUTABLE")

