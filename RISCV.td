include "llvm/Target/Target.td"


def Feature64Bit : SubtargetFeature<"64bit", "HasRV64", "true",
                                    "Implements RV64">;
def RV64         : HwMode<"+64bit">;
def RV32         : HwMode<"-64bit">;

include "RISCVRegisterInfo.td"
include "RISCVInstrInfo.td"


def : ProcessorModel<"generic-rv32", NoSchedModel, []>;

def : ProcessorModel<"generic-rv64", NoSchedModel, [Feature64Bit]>;

def RISCVInstrInfo : InstrInfo;

def RISCVAsmParser : AsmParser {
  let ShouldEmitMatchRegisterAltName = 1;
}


def RISCV : Target {
  let InstructionSet = RISCVInstrInfo;
  let AssemblyParsers = [RISCVAsmParser];
}


