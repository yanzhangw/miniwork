cmake_minimum_required(VERSION 3.10 FATAL_ERROR)  # 约束 CMake 最小版本

set(CUDA_PATH "/usr/local/cuda")
set(CMAKE_CUDA_COMPILER "${CUDA_PATH}/bin/nvcc")
set(CMAKE_BUILD_TYPE Debug)  # 控制编译类型
project(demo LANGUAGES CXX CUDA)  # 这里指定 CXX CUDA 才能实现交叉编译

# 设置 C++ 支持的标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# setting compiler flags 在 Debug 和 Release 下都会执行
set(CMAKE_C_FLAGS    "${CMAKE_C_FLAGS} -fopenmp")
set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fopenmp")
set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS}  \
                      -gencode=arch=compute_75,code=\\\"sm_75,compute_75\\\" \
                      -gencode=arch=compute_80,code=\\\"sm_80,compute_80\\\" \
                      -gencode=arch=compute_86,code=\\\"sm_86,compute_86\\\" \
                        ")

set(CMAKE_CUDA_ARCHITECTURES 70 75 80 86)  # // 目标架构
message("-- Assign GPU architecture (sm=70 75 80 86)")

# 在 Debug 模型下的编译器标志
set(CMAKE_C_FLAGS_DEBUG    "${CMAKE_C_FLAGS_DEBUG}    -O0 -Wall -fsanitize=address")
set(CMAKE_CXX_FLAGS_DEBUG  "${CMAKE_CXX_FLAGS_DEBUG}  -O0 -g -Wall -fsanitize=address")
set(CMAKE_CUDA_FLAGS_DEBUG "${CMAKE_CUDA_FLAGS_DEBUG} -O0 -G -Xcompiler -Wall")

# 设置 Release 模式下编译器的标志
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_DEBUG} -O3")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
set(CMAKE_CUDA_FLAGS_RELEASE "${CMAKE_CUDA_FLAGS_RELEASE} -Xcompiler -O3")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# 设置公共的头文件
set(COMMON_HEADER_DIRS
  ${CUDA_PATH}/include
  ./include/
)

# 设置公共的库文件
set(COMMON_LIB_DIRS
  ${CUDA_PATH}/lib64
)

include_directories(
  ${COMMON_HEADER_DIRS}
)

link_directories(
  ${COMMON_LIB_DIRS}
)

add_executable(main ./demo.cpp)