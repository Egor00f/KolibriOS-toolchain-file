# Just macro that create working executable for kolibrios
# after ld you must run objcopy. else it not make working executable. Why? idk.

macro(add_kolibri_executable EXE_TARGET SOURCES)

	add_executable(${EXE_TARGET} ${SOURCES})

	add_custom_command(
		TARGET ${EXE_TARGET} POST_BUILD
		COMMAND ${CMAKE_STRIP} ARGS -S ${EXE_TARGET}
		COMMAND ${CMAKE_OBJCOPY} ARGS ${EXE_TARGET} -O binary
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
	)

endmacro()
