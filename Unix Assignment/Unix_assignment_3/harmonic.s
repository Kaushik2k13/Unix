 
.data
	format: .asciz  "%d\n"
.bss
	a:  .quad   0
	b:  .quad   0
	c:  .quad   0
	d:  .quad   0
	e:  .quad   0
	f:  .quad   0
	g:  .quad   0
	h:  .quad   0
	i:  .quad   0
	j:  .quad   0
	k:  .quad   0
	l:  .quad   0
	m:  .quad   0
	n:  .quad   0
	o:  .quad   0
	p:  .quad   0
	q:  .quad   0
	r:  .quad   0
	s:  .quad   0
	t:  .quad   0
	u:  .quad   0
	v:  .quad   0
	w:  .quad   0
	x:  .quad   0
	y:  .quad   0
	z:  .quad   0
.text
.globl main            


	
main:
	pushq	$1000000
	popq	n
	pushq	$100000000
	popq	s
	pushq	$0
	popq	a
L000:
	pushq	n
	pushq	$0
	popq	%rbx
	popq	%rax
	cmp	%rax,	%rbx
	jge	L001
	pushq	a
	pushq	s
	pushq	n
	xor	%rax,	%rax
	xor	%rbx,	%rbx
	xor	%rdx,	%rdx
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	popq	%rbx
	popq	%rax
	add	%rax,	%rbx
	pushq	%rbx
	popq	a
	pushq	n
	pushq	$1
	popq	%rbx
	popq	%rax
	sub	%rbx,	%rax
	pushq	%rax
	popq	n
	jmp	L000
L001:
	pushq	a
	pushq	s
	pushq	$1000
	xor	%rax,	%rax
	xor	%rbx,	%rbx
	xor	%rdx,	%rdx
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	xor	%rax,	%rax
	xor	%rbx,	%rbx
	xor	%rdx,	%rdx
	popq	%rbx
	popq	%rax
	idivq	%rbx
	pushq	%rax
	movq	$format,	%rdi
	popq	%rsi
	pushq	$0
	call	printf
	popq	%rsi
	movq    $1,      %rdi   
    call    exit 
