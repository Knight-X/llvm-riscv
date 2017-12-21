#include "MCTargetDesc/RISCVMCTargetDesc.h"
#include "llvm/MC/MCELFObjectWriter.h"
#include "llvm/MC/MCFixup.h"
#include "llvm/MC/MCObjectWriter.h"
#include "llvm/Support/ErrorHandling.h"


using namespace llvm;

namespace {
class RISCVELFObjectWriter : public MCELFObjectTargetWriter {
public:
  RISCVELFObjectWriter(uint8_t OSABI, bool Is64Bit);

  ~RISCVELFObjectWriter() override;

protected:
  unsigned getRelocType(MCContext &Ctx, const MCValue &Target,
                        const MCFixup &Fixup, bool IsPCRel) const override;
};
}

RISCVELFObjectWriter::RISCVELFObjectWriter(uint8_t OSABI, bool Is64Bit)
    : MCELFObjectTargetWriter(Is64Bit, OSABI, ELF::EM_RISCV,
                                true) {}

RISCVELFObjectWriter::~RISCVELFObjectWriter() {}


unsigned RISCVELFObjectWriter::getRelocType(MCContext &Ctx,
                                            const MCValue &Target,
                                            const MCFixup &Fixup,
                                            bool IsPCRel) const {
  report_fatal_error("invalid fixup kind!");
}


std::unique_ptr<MCObjectWriter>
llvm::createRISCVELFObjectWriter(raw_pwrite_stream &OS, uint8_t OSABI,
                                 bool Is64Bit) {
  return createELFObjectWriter(
      llvm::make_unique<RISCVELFObjectWriter>(OSABI, Is64Bit), OS,
      /*IsLittleEndian=*/true);
}