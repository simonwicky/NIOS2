addi	t0, zero, 0x0001
addi	t1, zero, 0x0002
add		t2, t0, t1
stw		t2, 0x2000(zero)
break