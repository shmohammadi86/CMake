function(setup_hardware_tests)
  if(CTEST_HARDWARE_ALLOC_ENABLED)
    add_test(NAME HardwareSetup COMMAND "${CMAKE_COMMAND}" -E remove -f "${CMAKE_BINARY_DIR}/cthwalloc.log")
  endif()
endfunction()

function(add_hardware_test name sleep_time proc)
  if(CTEST_HARDWARE_ALLOC_ENABLED)
    add_test(NAME "${name}" COMMAND "${CTHWALLOC_COMMAND}" write "${CMAKE_BINARY_DIR}/cthwalloc.log" "${name}" "${sleep_time}" "${proc}")
    set_property(TEST "${name}" PROPERTY DEPENDS HardwareSetup)
  else()
    add_test(NAME "${name}" COMMAND "${CTHWALLOC_COMMAND}" write "${CMAKE_BINARY_DIR}/cthwalloc.log" "${name}" "${sleep_time}")
  endif()
  set_property(TEST "${name}" PROPERTY RESOURCE_GROUPS "${proc}")
  list(APPEND HARDWARE_TESTS "${name}")
  set(HARDWARE_TESTS "${HARDWARE_TESTS}" PARENT_SCOPE)
endfunction()

function(cleanup_hardware_tests)
  if(CTEST_HARDWARE_ALLOC_ENABLED)
    file(WRITE "${CMAKE_BINARY_DIR}/hwtests.txt" "${HARDWARE_TESTS}")
  endif()
endfunction()
