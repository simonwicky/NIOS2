addi	t0, zero, 0xFFF
addi	t1,zero,0xC
addi	t2,zero, 0x8
sll		t0,	t0,	t1
addi	t0, t0, 0xFFF
sll		t0,	t0,	t2
addi	t0, t0, 0xFF
#stw		t0, 0x2000(zero)
stw		t0, 0x2004(zero)
stw		t0, 0x2008(zero)
break