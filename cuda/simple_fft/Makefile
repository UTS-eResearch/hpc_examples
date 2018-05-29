################################################################################
#
# Mike's simpler Makefile from Nvidia's version 
#
################################################################################

include ./findcudalib.mk

# Location of the CUDA Toolkit
CUDA_PATH   ?= /usr/local/cuda

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
INCLUDES  := -I/usr/local/cuda/samples/common/inc
LIBRARIES :=

# CUDA code generation flags
# Unsupported gpu architecture 'compute_20'
# GENCODE_SM20    := -gencode arch=compute_20,code=sm_20
GENCODE_SM30    := -gencode arch=compute_30,code=sm_30 
GENCODE_SM35    := -gencode arch=compute_35,code=\"sm_35,compute_35\"
GENCODE_FLAGS   := $(GENCODE_SM30) $(GENCODE_SM35)

LIBRARIES += -lcufft

# Target rules
all: build

build: simple_FFT

simple_FFT.o: simple_FFT.cu
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -o $@ -c $<

simple_FFT: simple_FFT.o
	$(NVCC) $(ALL_LDFLAGS) -o $@ $+ $(LIBRARIES)

run: build
	./simple_FFT

clean:
	rm -f simple_FFT.o simple_FFT

