class RISCVOpcode<bits<7> val> {
  bits<7> Value = val;
}

def OPC_LOAD : RISCVOpcode<0b0000011>;
def OPC_LOAD_FP   : RISCVOpcode<0b0000111>;
def OPC_MISC_MEM  : RISCVOpcode<0b0001111>;
def OPC_OP_IMM    : RISCVOpcode<0b0010011>;
def OPC_AUIPC     : RISCVOpcode<0b0010111>;
def OPC_OP_IMM_32 : RISCVOpcode<0b0011011>;
def OPC_STORE     : RISCVOpcode<0b0100011>;
def OPC_STORE_FP  : RISCVOpcode<0b0100111>;
def OPC_AMO       : RISCVOpcode<0b0101111>;
def OPC_OP        : RISCVOpcode<0b0110011>;
def OPC_LUI       : RISCVOpcode<0b0110111>;
def OPC_OP_32     : RISCVOpcode<0b0111011>;
def OPC_MADD      : RISCVOpcode<0b1000011>;
def OPC_MSUB      : RISCVOpcode<0b1000111>;
def OPC_NMSUB     : RISCVOpcode<0b1001011>;
def OPC_NMADD     : RISCVOpcode<0b1001111>;
def OPC_OP_FP     : RISCVOpcode<0b1010011>;
def OPC_BRANCH    : RISCVOpcode<0b1100011>;
def OPC_JALR      : RISCVOpcode<0b1100111>;
def OPC_JAL       : RISCVOpcode<0b1101111>;
def OPC_SYSTEM    : RISCVOpcode<0b1110011>;


class RVInst<dag outs, dag ins, string opcodestr, string argstr,
			list<dag> pattern>
    : Instruction {
   field bits<32> Inst;
   field bits<32> SoftFail = 0;

   let Size = 4;
   bits<7> Opcode = 0;

   let Inst{6-0} = Opcode;
   
   let Namespace = "RISCV";

   dag OutOperandList = outs;

   dag InOperandList = ins;

   let AsmString = opcodestr;

   let Pattern = pattern;
}

class Pseudo<dag outs, dag ins, list<dag> pattern>
  : RVInst<outs, ins, "", "", pattern> {
    let isPseudo = 1;
    let isCodeGenOnly = 1;
  }


class RVInstR<bits<7> funct7, bits<3> funct3, RISCVOpcode opcode, dag outs,
    dag ins, string opcodestr, string argstr>
  : RVInst<outs, ins, opcodestr, argstr, []> {
  bits<5> rs2;
  bits<5> rs1;
  bits<5> rd;

  let Inst{31-25} = funct7;
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
 }


class RVInstI<bits<3> funct3, RISCVOpcode opcode, dag outs, dag ins,
              string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, []> {
  bits<12> imm12;
  bits<5> rs1;
  bits<5> rd;

  let Inst{31-20} = imm12;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}

class RVInstIShift<bit arithshift, bits<3> funct3, RISCVOpcode opcode,
                   dag outs, dag ins, string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, []> {
  bits<6> shamt;
  bits<5> rs1;
  bits<5> rd;

  let Inst{31} = 0;
  let Inst{30} = arithshift;
  let Inst{29-26} = 0;
  let Inst{25-20} = shamt;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}

class RVInstS<bits<3> funct3, RISCVOpcode opcode, dag outs, dag ins,
              string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, []> {
  bits<12> imm12;
  bits<5> rs2;
  bits<5> rs1;

  let Inst{31-25} = imm12{11-5};
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-7} = imm12{4-0};
  let Opcode = opcode.Value;
}

class RVInstB<bits<3> funct3, RISCVOpcode opcode, dag outs, dag ins,
              string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, []> {
  bits<12> imm12;
  bits<5> rs2;
  bits<5> rs1;

  let Inst{31} = imm12{11};
  let Inst{30-25} = imm12{9-4};
  let Inst{24-20} = rs2;
  let Inst{19-15} = rs1;
  let Inst{14-12} = funct3;
  let Inst{11-8} = imm12{3-0};
  let Inst{7} = imm12{10};
  let Opcode = opcode.Value;
}

class RVInstU<RISCVOpcode opcode, dag outs, dag ins, string opcodestr,
              string argstr>
    : RVInst<outs, ins, opcodestr, argstr, []> {
  bits<20> imm20;
  bits<5> rd;

  let Inst{31-12} = imm20;
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}

class RVInstJ<RISCVOpcode opcode, dag outs, dag ins, string opcodestr,
              string argstr>
    : RVInst<outs, ins, opcodestr, argstr, []> {
  bits<20> imm20;
  bits<5> rd;

  let Inst{31} = imm20{19};
  let Inst{30-21} = imm20{9-0};
  let Inst{20} = imm20{10};
  let Inst{19-12} = imm20{18-11};
  let Inst{11-7} = rd;
  let Opcode = opcode.Value;
}
