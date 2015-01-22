################################################################################
#
# Mike's simpler Makefile from Nvidia's version 
#
################################################################################

include ./findcudalib.mk

# Location of the CUDA Toolkit
CUDA_PATH   ?= /usr/local/cuda-5.5


# Internal flags
NVCCFLAGS   := -m${OS_SIZE}
CCFLAGS     :=
NVCCLDFLAGS :=
LDFLAGS     :=


# Extra user flags
EXTRA_NVCCFLAGS   ?=
EXTRA_NVCCLDFLAGS ?=
EXTRA_LDFLAGS     ?=
EXTRA_CCFLAGS     ?=


# Debug build flags
ifeq ($(dbg),1)
	NVCCFLAGS += -g -G
	TARGET := debug
else
	TARGET := release
endif

ALL_CCFLAGS :=
ALL_CCFLAGS += $(NVCCFLAGS)
ALL_CCFLAGS += $(addprefix -Xcompiler ,$(CCFLAGS))
ALL_CCFLAGS += $(EXTRA_NVCCFLAGS)
ALL_CCFLAGS += $(addprefix -Xcompiler ,$(EXTRA_CCFLAGS))

ALL_LDFLAGS :=
ALL_LDFLAGS += $(ALL_CCFLAGS)
ALL_LDFLAGS += $(NVCCLDFLAGS)
ALL_LDFLAGS += $(addprefix -Xlinker ,$(LDFLAGS))
ALL_LDFLAGS += $(EXTRA_NVCCLDFLAGS)
ALL_LDFLAGS += $(addprefix -Xlinker ,$(EXTRA_LDFLAGS))


# Common includes and paths for CUDA
#INCLUDES  := -I../../common/inc
#INCLUDES  := -I../common/inc 
INCLUDES  := -I/usr/local/cuda/samples/common/inc
LIBRARIES :=


# CUDA code generation flags
GENCODE_SM20    := -gencode arch=compute_20,code=sm_20
GENCODE_SM30    := -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=\"sm_35,compute_35\"
GENCODE_FLAGS   := $(GENCODE_SM10) $(GENCODE_SM20) $(GENCODE_SM30)

LIBRARIES += -lcufft


# Target rules
all: build

build: simpleCUFFT

simpleCUFFT.o: simpleCUFFT.cu
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ -c $<

simpleCUFFT: simpleCUFFT.o
	$(NVCC) $(ALL_LDFLAGS) -o $@ $+ $(LIBRARIES)

run: build
	./simpleCUFFT

clean:
	rm -f simpleCUFFT.o simpleCUFFT

