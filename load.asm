addi	t0, zero, 0x0FFF
slli	t0, t0	,0x0C
addi	t0, t0, 0x0FFF
slli	t0, t0	,0x08
addi	t0, t0, 0x0FF
stw		t0, 0x2000(zero)
stw		t0, 0x2004(zero)
stw		t0, 0x2008(zero)
break