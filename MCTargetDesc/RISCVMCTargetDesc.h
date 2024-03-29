#ifndef LLVM_LIB_TARGET_RISCV_MCTARGETDESC_RISCVMCTARGETDESC_H
#define LLVM_LIB_TARGET_RISCV_MCTARGETDESC_RISCVMCTARGETDESC_H

#include "llvm/Config/config.h"
#include "llvm/MC/MCTargetOptions.h"
#include "llvm/Support/DataTypes.h"
#include <memory>

namespace llvm {
class MCAsmBackend;
class MCCodeEmitter;
class MCContext;
class MCInstrInfo;
class MCObjectWriter;
class MCRegisterInfo;
class MCSubtargetInfo;
class StringRef;
class Target;
class Triple;
class raw_ostream;

Target &getTheRISCV32Target();
Target &getTheRISCV64Target();

MCCodeEmitter *createRISCVMCCodeEmitter(const MCInstrInfo &MCII,
                                        const MCRegisterInfo &MRI,
                                        MCContext &Ctx);

MCAsmBackend *createRISCVAsmBackend(const Target &T, const MCRegisterInfo &MRI,
                                    const Triple &TT, StringRef CPU,
                                    const MCTargetOptions &Options);

std::unique_ptr<MCObjectWriter>
createRISCVELFObjectWriter(raw_pwrite_stream &OS, uint8_t OSABI, bool Is64Bit);
}

// Defines symbolic names for RISC-V registers.
#define GET_REGINFO_ENUM
#include "RISCVGenRegisterInfo.inc"

// Defines symbolic names for RISC-V instructions.
#define GET_INSTRINFO_ENUM
#include "RISCVGenInstrInfo.inc"

#define GET_SUBTARGETINFO_ENUM
#include "RISCVGenSubtargetInfo.inc"
#endif
