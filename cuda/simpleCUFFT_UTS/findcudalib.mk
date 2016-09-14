################################################################################
#  Mike's findcudalib.mk is used to find the locations for CUDA libraries. 
#  This is my modified one from the Nvidia supplied one 
################################################################################

# Flags to detect 32-bit or 64-bit OS platform
OS_SIZE = $(shell uname -m | sed -e "s/i.86/32/" -e "s/x86_64/64/" -e "s/armv7l/32/")
OS_ARCH = $(shell uname -m | sed -e "s/i386/i686/")

# OS platform is set for Linux but find distribution.
# First search lsb_release.

# lsb_release -i -s  <-- this will return say 'Fedora' 
DISTRO  = $(shell lsb_release -i -s 2>/dev/null | tr "[:upper:]" "[:lower:]")

# lsb_release -r -s  <-- this will return say "17"
DISTVER = $(shell lsb_release -r -s 2>/dev/null)

ifeq ("$(DISTRO)",'') 
    # second search and parse /etc/issue
    DISTRO = $(shell more /etc/issue | awk '{print $$1}' | sed '1!d' | sed -e "/^$$/d" 2>/dev/null | tr "[:upper:]" "[:lower:]")
    DISTVER= $(shell more /etc/issue | awk '{print $$2}' | sed '1!d' 2>/dev/null
endif

ifeq ("$(DISTRO)",'') 
    # third, we can search in /etc/os-release or /etc/{distro}-release
    DISTRO = $(shell awk '/ID/' /etc/*-release | sed 's/ID=//' | grep -v "VERSION" | grep -v "ID" | grep -v "DISTRIB")
    DISTVER= $(shell awk '/DISTRIB_RELEASE/' /etc/*-release | sed 's/DISTRIB_RELEASE=//' | grep -v "DISTRIB_RELEASE")
endif

# Common binaries
GCC   ?= g++
CLANG ?= /usr/bin/clang

# MRL TODO
NVCC ?= $(CUDA_PATH)/bin/nvcc -ccbin $(GCC)

# Take command line flags that override any of these settings
ifeq ($(i386),1)
	OS_SIZE = 32
	OS_ARCH = i686
endif

ifeq ($(x86_64),1)
	OS_SIZE = 64
	OS_ARCH = x86_64
endif

# Each Linux Distribuion has a set of different paths. This applies
# especially when using the Linux RPM/Debian packages.
ifeq ("$(DISTRO)","ubuntu")
    CUDAPATH  ?= /usr/lib/nvidia-current
    CUDALINK  ?= -L/usr/lib/nvidia-current
    DFLT_PATH  = /usr/lib
endif
ifeq ("$(DISTRO)","debian")
    CUDAPATH  ?= /usr/lib/nvidia-current
    CUDALINK  ?= -L/usr/lib/nvidia-current
    DFLT_PATH  = /usr/lib
endif
ifeq ("$(DISTRO)","fedora")
  ifeq ($(OS_SIZE),64)
    CUDAPATH  ?= /usr/lib64/nvidia
    CUDALINK  ?= -L/usr/lib64/nvidia
    DFLT_PATH  = /usr/lib64
  else
    CUDAPATH  ?=
    CUDALINK  ?=
    DFLT_PATH  = /usr/lib
  endif
endif
ifeq ("$(DISTRO)","redhat")
  ifeq ($(OS_SIZE),64)
    CUDAPATH  ?= /usr/lib64/nvidia
    CUDALINK  ?= -L/usr/lib64/nvidia
    DFLT_PATH  = /usr/lib64
  else
    CUDAPATH  ?=
    CUDALINK  ?=
    DFLT_PATH  = /usr/lib
  endif
endif
ifeq ("$(DISTRO)","red")
  ifeq ($(OS_SIZE),64)
    CUDAPATH  ?= /usr/lib64/nvidia
    CUDALINK  ?= -L/usr/lib64/nvidia
    DFLT_PATH  = /usr/lib64
  else
    CUDAPATH  ?=
    CUDALINK  ?=
    DFLT_PATH  = /usr/lib
  endif
endif
ifeq ("$(DISTRO)","redhatenterpriseworkstation")
  ifeq ($(OS_SIZE),64)
    CUDAPATH  ?= /usr/lib64/nvidia
    CUDALINK  ?= -L/usr/lib64/nvidia
    DFLT_PATH ?= /usr/lib64
  else
    CUDAPATH  ?=
    CUDALINK  ?=
    DFLT_PATH ?= /usr/lib
  endif
endif
ifeq ("$(DISTRO)","centos")
  ifeq ($(OS_SIZE),64)
    CUDAPATH  ?= /usr/lib64/nvidia
    CUDALINK  ?= -L/usr/lib64/nvidia
    DFLT_PATH  = /usr/lib64
  else
    CUDAPATH  ?=
    CUDALINK  ?=
    DFLT_PATH  = /usr/lib
  endif
endif
  
# Search for Linux distribution path for libcuda.so
CUDALIB ?= $(shell find $(CUDAPATH) $(DFLT_PATH) -name libcuda.so -print 2>/dev/null)

ifeq ("$(CUDALIB)",'')
    $(info >>> WARNING - CUDA Driver libcuda.so is not found.  Please check and re-install the NVIDIA driver. <<<)
    EXEC=@echo "[@]"
endif

