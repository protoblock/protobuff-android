PROTO_PREFIX=/tmp/protobuf-SEDME
include $(CLEAR_VARS)
# C++ full library
# =======================================================
#include $(CLEAR_VARS)


LOCAL_MODULE := libprotobuf
LOCAL_CFLAGS := -D_REENTRANT -DOS_ANDROID -DLEVELDB_PLATFORM_POSIX -DNDEBUG  -std=c++11
LOCAL_CPP_FEATURES += exceptions
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_C_INCLUDES := $(PROTO_PREFIX) \
					$(PROTO_PREFIX)/src \
					$(PROTO_PREFIX)/src/google/protobuf/stubs \
					bionic \
					$(JNI_H_INCLUDE)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
    $(CC_LITE_SRC_FILES) \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/strutil.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/substitute.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/structurally_valid.cc \
    $(PROTO_PREFIX)/src/google/protobuf/descriptor.cc  \
    $(PROTO_PREFIX)/src/google/protobuf/descriptor.pb.cc \
    $(PROTO_PREFIX)/src/google/protobuf/descriptor_database.cc \
    $(PROTO_PREFIX)/src/google/protobuf/dynamic_message.cc \
    $(PROTO_PREFIX)/src/google/protobuf/extension_set_heavy.cc \
    $(PROTO_PREFIX)/src/google/protobuf/generated_message_reflection.cc  \
    $(PROTO_PREFIX)/src/google/protobuf/message.cc  \
    $(PROTO_PREFIX)/src/google/protobuf/reflection_ops.cc \
    $(PROTO_PREFIX)/src/google/protobuf/service.cc  \
    $(PROTO_PREFIX)/src/google/protobuf/text_format.cc \
    $(PROTO_PREFIX)/src/google/protobuf/unknown_field_set.cc \
    $(PROTO_PREFIX)/src/google/protobuf/wire_format.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/gzip_stream.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/printer.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/tokenizer.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/zero_copy_stream_impl.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/importer.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/parser.cc

LOCAL_SHARED_LIBRARIES := \
    libz libcutils libutils
LOCAL_LDLIBS := -lz
# stlport conflicts with the host stl library
ifneq ($(TARGET_SIMULATOR),true)
	LOCAL_C_INCLUDES += external/stlport/stlport
	LOCAL_SHARED_LIBRARIES += libstlport
endif

# Define the header files to be copied
#LOCAL_COPY_HEADERS := \
#    $(PROTO_PREFIX)/src/google/protobuf/stubs/once.h \
#    $(PROTO_PREFIX)/src/google/protobuf/stubs/common.h \
#    $(PROTO_PREFIX)/src/google/protobuf/io/coded_stream.h \
#    $(PROTO_PREFIX)/src/google/protobuf/generated_message_util.h \
#    $(PROTO_PREFIX)/src/google/protobuf/repeated_field.h \
#    $(PROTO_PREFIX)/src/google/protobuf/extension_set.h \
#    $(PROTO_PREFIX)/src/google/protobuf/wire_format_lite_inl.h
#
#LOCAL_COPY_HEADERS_TO := $(LOCAL_MODULE)

LOCAL_CFLAGS := -DGOOGLE_PROTOBUF_NO_RTTI



CC_LITE_SRC_FILES := \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/common.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/once.cc \
	$(PROTO_PREFIX)/src/google/protobuf/stubs/hash.cc \
    $(PROTO_PREFIX)/src/google/protobuf/extension_set.cc \
    $(PROTO_PREFIX)/src/google/protobuf/generated_message_util.cc \
    $(PROTO_PREFIX)/src/google/protobuf/message_lite.cc \
    $(PROTO_PREFIX)/src/google/protobuf/repeated_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/wire_format_lite.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/coded_stream.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/zero_copy_stream.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/zero_copy_stream_impl_lite.cc

COMPILER_SRC_FILES :=  \
    $(PROTO_PREFIX)/src/google/protobuf/descriptor.cc \
    $(PROTO_PREFIX)/src/google/protobuf/descriptor.pb.cc \
    $(PROTO_PREFIX)/src/google/protobuf/descriptor_database.cc \
    $(PROTO_PREFIX)/src/google/protobuf/dynamic_message.cc \
    $(PROTO_PREFIX)/src/google/protobuf/extension_set.cc \
    $(PROTO_PREFIX)/src/google/protobuf/extension_set_heavy.cc \
    $(PROTO_PREFIX)/src/google/protobuf/generated_message_reflection.cc \
    $(PROTO_PREFIX)/src/google/protobuf/generated_message_util.cc \
    $(PROTO_PREFIX)/src/google/protobuf/message.cc \
    $(PROTO_PREFIX)/src/google/protobuf/message_lite.cc \
    $(PROTO_PREFIX)/src/google/protobuf/reflection_ops.cc \
    $(PROTO_PREFIX)/src/google/protobuf/repeated_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/service.cc \
    $(PROTO_PREFIX)/src/google/protobuf/text_format.cc \
    $(PROTO_PREFIX)/src/google/protobuf/unknown_field_set.cc \
    $(PROTO_PREFIX)/src/google/protobuf/wire_format.cc \
    $(PROTO_PREFIX)/src/google/protobuf/wire_format_lite.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/code_generator.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/command_line_interface.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/importer.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/main.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/parser.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/plugin.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/plugin.pb.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/subprocess.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/zip_writer.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_enum.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_enum_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_extension.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_file.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_generator.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_helpers.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_message.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_message_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_primitive_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_service.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/cpp/cpp_string_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_enum.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_enum_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_extension.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_file.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_generator.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_helpers.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_message.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_message_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_primitive_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/java/java_service.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_enum.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_enum_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_file.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_generator.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_helpers.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_message.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_message_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/javamicro/javamicro_primitive_field.cc \
    $(PROTO_PREFIX)/src/google/protobuf/compiler/python/python_generator.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/coded_stream.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/gzip_stream.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/printer.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/tokenizer.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/zero_copy_stream.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/zero_copy_stream_impl.cc \
    $(PROTO_PREFIX)/src/google/protobuf/io/zero_copy_stream_impl_lite.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/common.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/hash.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/once.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/structurally_valid.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/strutil.cc \
    $(PROTO_PREFIX)/src/google/protobuf/stubs/substitute.cc

include $(BUILD_SHARED_LIBRARY)
