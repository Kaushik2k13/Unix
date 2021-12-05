 
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
	pushq	$1000001
	popq	n
	pushq	$100000000
	popq	s
	pushq	$0
	popq	a
	pushq	$0
	popq	t
L000:
	pushq	n
	pushq	$0
	popq	%rbx
	popq	%rax
	cmp	%rax,	%rbx
	jge	L001
	pushq	t
	pushq	$0
	popq	%rbx
	popq	%rax
	cmp	%rax,	%rbx
	jne	L002
	pushq	n
	popq	d
	pushq	$1
	popq	t
	jmp	L003
L002:
	pushq	n
	popq	%r8
	neg	%r8
	pushq	%r8
	popq	d
	pushq	$0
	popq	t
L003:
	pushq	a
	pushq	s
	pushq	d
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
	pushq	$2
	popq	%rbx
	popq	%rax
	sub	%rbx,	%rax
	pushq	%rax
	popq	n
	jmp	L000
L001:
	pushq	a
	pushq	s
	pushq	$100000
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
	pushq	$4
	popq	%rbx
	popq	%rax
	imulq	%rax,	%rbx
	pushq	%rbx
	movq	$format,	%rdi
	popq	%rsi
	pushq	$0
	call	printf
	popq	%rsi
	movq    $1,      %rdi   
    call    exit 
