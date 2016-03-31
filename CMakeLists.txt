CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.6)

FIND_PACKAGE(Torch REQUIRED)
FIND_PACKAGE(PNG REQUIRED)


SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")


SET(src png_indexed.c)
include_directories (${PNG_INCLUDE_DIR})
ADD_TORCH_PACKAGE(png_indexed "${src}" "${luasrc}" "Image Processing")
TARGET_LINK_LIBRARIES(png_indexed luaT TH ${PNG_LIBRARIES})
IF(LUALIB)
    TARGET_LINK_LIBRARIES(png_indexed ${LUALIB})
ENDIF()

SET(luasrc init.lua)

ADD_TORCH_PACKAGE(indexedpng "${src}" "${luasrc}" "Image Processing")
TARGET_LINK_LIBRARIES(indexedpng luaT TH)
IF(LUALIB)
  TARGET_LINK_LIBRARIES(indexedpng ${LUALIB})
ENDIF()
INSTALL(FILES "README.md" DESTINATION "${Torch_INSTALL_LUA_PATH_SUBDIR}/indexedpng")
