
#ifndef LLVM_LIB_TARGET_RISCV_MCTARGETDESC_RISCVMCASMINFO_H
#define LLVM_LIB_TARGET_RISCV_MCTARGETDESC_RISCVMCASMINFO_H

#include "llvm/MC/MCAsmInfoELF.h"

namespace llvm {
class Triple;

class RISCVMCAsmInfo : public MCAsmInfoELF {
  void anchor() override;

public:
  explicit RISCVMCAsmInfo(const Triple &TargetTriple);
};

} // namespace llvm

#endif
