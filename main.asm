section .data
	msg: db "Hello", 10
	len_msg equ $ - msg

	help: db "glass: file preprocessor", 10, \
		`usage: don\'t use it\'s kinda bad`, 10
	len_help equ $ - help

section .bss
	argc: resb 4
	argv: resb 8

section .text
global _start
_start:

	; Get argc
	mov rdi, [rsp + 8]
	mov [argc], rdi

	; Get argv
	mov rsi, rsp
	mov [argv], rsi
	add rsi, 16		; Skip argc and argv[0]

	cmp rdi, 1
	je print_help

	print_help: 
	mov rax, 1
	mov rdi, 1
	mov rsi, help
	mov rdx, len_help
	syscall
	jmp exit

	exit:
	mov rax, 60
	mov rdi, 0
	syscall

