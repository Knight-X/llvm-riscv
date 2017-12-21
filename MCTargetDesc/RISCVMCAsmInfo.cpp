#include "RISCVMCAsmInfo.h"
#include "llvm/ADT/Triple.h"
using namespace llvm;

void RISCVMCAsmInfo::anchor() {}

RISCVMCAsmInfo::RISCVMCAsmInfo(const Triple &TT) {
  CodePointerSize = CalleeSaveStackSlotSize = TT.isArch64Bit() ? 8 : 4;
  CommentString = "#";
  AlignmentIsInBytes = false;
  SupportsDebugInformation = true;
  ExceptionsType = ExceptionHandling::DwarfCFI;
  DwarfRegNumForCFI = true;
}
