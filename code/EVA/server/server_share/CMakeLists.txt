FILE(GLOB SRC *.c *.cpp *.h)
FILE(GLOB SRC_PROTO_MSG         msg_proto/*.h msg_proto/*.cc)
FILE(GLOB SRC_LUA               lua/*.h lua/*.cpp)
FILE(GLOB SRC_LUABIND           bin_luabind/*.h bin_luabind/*.cpp)
FILE(GLOB SRC_LUACJson          cjson/*.h cjson/*.cpp)
FILE(GLOB SRC_PBC               pbc/*.h pbc/*.cpp)
FILE(GLOB SRC_LUAMySQL          lua_mysql/*.h lua_mysql/*.cpp)
FILE(GLOB SRC_LUANET            lua_net/*.h lua_net/*.cpp)

SOURCE_GROUP("MessageProto"     FILES ${SRC_PROTO_MSG})
SOURCE_GROUP("Lua"              FILES ${SRC_LUA})
SOURCE_GROUP("LuaBind"          FILES ${SRC_LUABIND})
SOURCE_GROUP("LuaCJson"         FILES ${SRC_LUACJson})
SOURCE_GROUP("LuaPBC"           FILES ${SRC_PBC})
SOURCE_GROUP("LuaMySQL"         FILES ${SRC_LUAMySQL})
SOURCE_GROUP("LuaNet"           FILES ${SRC_LUANET})

NL_TARGET_LIB(servershare ${SRC} ${SRC_PROTO_MSG} ${SRC_LUA} ${SRC_LUABIND} ${SRC_LUACJson} ${SRC_PBC}  ${SRC_LUAMySQL} ${SRC_LUANET})

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/server/src/server_share ${OPENSSL_INCLUDE_DIR} ${ZLIB_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${LIBXML2_INCLUDE_DIR} ${MYSQL_INCLUDE_DIR} ${LUA_INCLUDE_DIR} ${PROTOBUF_INCLUDE_DIR} ${PBC_INCLUDE_DIR} ${CURL_INCLUDE_DIR})

TARGET_LINK_LIBRARIES(  servershare
						nelmisc
						nelnet
                        ${OPENSSL_LIBRARIES}
                        ${CURL_LIBRARY}
                        ${LIBXML2_LIBRARIES}
						${LUA_LIBRARIES}
#						${PBC_LIBRARY}
						${MYSQL_LIBRARIES}
                        ${ZLIB_LIBRARIE_RELEASE}
                        )

NL_DEFAULT_PROPS(servershare "Base, Library: Service Shared")
NL_ADD_RUNTIME_FLAGS(servershare)
NL_ADD_LIB_SUFFIX(servershare)

ADD_DEFINITIONS(${LIBXML2_DEFINITIONS})

IF(WITH_PCH)
  ADD_NATIVE_PRECOMPILED_HEADER(servershare ${CMAKE_CURRENT_SOURCE_DIR}/stdpch.h ${CMAKE_CURRENT_SOURCE_DIR}/stdpch.cpp)
ENDIF(WITH_PCH)

#INSTALL(TARGETS servershare LIBRARY DESTINATION ${EVA_LIB_PREFIX} ARCHIVE DESTINATION ${EVA_LIB_PREFIX} COMPONENT libraries)
IF((WITH_INSTALL_LIBRARIES AND WITH_STATIC) OR NOT WITH_STATIC)
  INSTALL(TARGETS servershare LIBRARY DESTINATION lib ARCHIVE DESTINATION lib COMPONENT libraries)
ENDIF((WITH_INSTALL_LIBRARIES AND WITH_STATIC) OR NOT WITH_STATIC)


