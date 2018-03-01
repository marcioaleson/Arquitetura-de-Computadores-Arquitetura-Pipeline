package tipo is

type ESTADO is(soma,subtract,load,store,opAnd,opOr,opNor,opXor,mult,divisao,nop,slt,opSll,opSrl,srav,opSra,srlv,sllv,LUI,MVHMFL,sltiu);
type ISA		is (add,addu,sub,subu,mult,multu,aand,oor,xxor,nnor,div,slt,srli,slli,srai,ssrl,ssll,ssra,mfhi,mflo,jr,desconhecida,addi
,addiu, lw, sw , andi, ori, slti, lb, lh, lbu,lhu,sb, sh,lui,beq,bne,jump, jumpAndLink,divu,sltiu,bgez,nop,slll);
end package;