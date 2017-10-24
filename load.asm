addi	t0, zero, 0x0FFF
stw		t0,	0x1000(zero)
ldw		t1, 0x1000(zero)
stw		t1, 0x2000(zero)
break