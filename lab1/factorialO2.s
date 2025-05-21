	.file	"factorial.cpp"
	.intel_syntax noprefix
	.text
	.section	.text$_ZNKSt5ctypeIcE8do_widenEc,"x"
	.linkonce discard
	.align 2
	.p2align 4
	.globl	_ZNKSt5ctypeIcE8do_widenEc
	.def	_ZNKSt5ctypeIcE8do_widenEc;	.scl	2;	.type	32;	.endef
	.seh_proc	_ZNKSt5ctypeIcE8do_widenEc
_ZNKSt5ctypeIcE8do_widenEc:
.LFB1995:
	.seh_endprologue
	mov	eax, edx
	ret
	.seh_endproc
	.text
	.p2align 4
	.globl	_Z9factoriali
	.def	_Z9factoriali;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z9factoriali
_Z9factoriali:
.LFB2242:
	.seh_endprologue
	mov	eax, 1
	cmp	ecx, 1
	jle	.L3
	.p2align 4,,10
	.p2align 3
.L5:
	mov	edx, ecx
	sub	ecx, 1
	imul	eax, edx
	cmp	ecx, 1
	jne	.L5
.L3:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "factorial of \0"
.LC1:
	.ascii " is \0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB2243:
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	mov	rcx, QWORD PTR .refptr._ZSt4cout[rip]
	lea	rdx, .LC0[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	mov	edx, 7
	mov	rcx, rax
	call	_ZNSolsEi
	lea	rdx, .LC1[rip]
	mov	rcx, rax
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	mov	edx, 5040
	mov	rcx, rax
	call	_ZNSolsEi
	mov	rbx, rax
	mov	rax, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rax]
	mov	rsi, QWORD PTR 240[rbx+rax]
	test	rsi, rsi
	je	.L13
	cmp	BYTE PTR 56[rsi], 0
	je	.L10
	movsx	edx, BYTE PTR 67[rsi]
.L11:
	mov	rcx, rbx
	call	_ZNSo3putEc
	mov	rcx, rax
	call	_ZNSo5flushEv
	xor	eax, eax
	add	rsp, 40
	pop	rbx
	pop	rsi
	ret
.L10:
	mov	rcx, rsi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv
	mov	rax, QWORD PTR [rsi]
	mov	edx, 10
	lea	rcx, _ZNKSt5ctypeIcE8do_widenEc[rip]
	mov	rax, QWORD PTR 48[rax]
	cmp	rax, rcx
	je	.L11
	mov	edx, 10
	mov	rcx, rsi
	call	rax
	movsx	edx, al
	jmp	.L11
.L13:
	call	_ZSt16__throw_bad_castv
	nop
	.seh_endproc
	.ident	"GCC: (Rev3, Built by MSYS2 project) 13.2.0"
	.def	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc;	.scl	2;	.type	32;	.endef
	.def	_ZNSolsEi;	.scl	2;	.type	32;	.endef
	.def	_ZNSo3putEc;	.scl	2;	.type	32;	.endef
	.def	_ZNSo5flushEv;	.scl	2;	.type	32;	.endef
	.def	_ZNKSt5ctypeIcE13_M_widen_initEv;	.scl	2;	.type	32;	.endef
	.def	_ZSt16__throw_bad_castv;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr._ZSt4cout, "dr"
	.globl	.refptr._ZSt4cout
	.linkonce	discard
.refptr._ZSt4cout:
	.quad	_ZSt4cout
