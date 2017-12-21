#ifndef LLVM_LIB_TARGET_RISCV_MCTARGETDESC_RISCVBASEINFO_H
#define LLVM_LIB_TARGET_RISCV_MCTARGETDESC_RISCVBASEINFO_H

#include "RISCVMCTargetDesc.h"

namespace llvm {

namespace RISCVII {
enum {
  InstFormatPseudo = 0,
  InstFormatR = 1,
  InstFormatI = 2,
  InstFormatS = 3,
  InstFormatB = 4,
  InstFormatU = 5,
  InstFormatOther = 6,

  InstFormatMask = 15
};
enum {
  MO_None,
  MO_LO,
  MO_HI,
  MO_PCREL_HI,
};
}


namespace RISCVFenceField {
enum FenceField {
  I = 8,
  O = 4,
  R = 2,
  W = 1
};
}
}
#endif
