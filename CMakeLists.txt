add_llvm_target(RISCVCodeGen
  RISCVTargetMachine.cpp
  )
set(LLVM_TARGET_DEFINITIONS RISCV.td)

tablegen(LLVM RISCVGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM RISCVGenInstrInfo.inc -gen-instr-info)
tablegen(LLVM RISCVGenMCCodeEmitter.inc -gen-emitter)
tablegen(LLVM RISCVGenAsmMatcher.inc -gen-asm-matcher)
tablegen(LLVM RISCVGenAsmWriter.inc -gen-asm-writer)
tablegen(LLVM RISCVGenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM RISCVGenDisassemblerTables.inc -gen-disassembler)

add_public_tablegen_target(RISCVCommonTableGen)
add_subdirectory(TargetInfo)
add_subdirectory(InstPrinter)
add_subdirectory(MCTargetDesc)
add_subdirectory(AsmParser)
add_subdirectory(Disassembler)

