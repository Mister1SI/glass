section .data
	help: db "glass: file preprocessor", 11, \
		`usage: don\'t use it\'s kinda bad`, 10, 0
	string: db "Apple", 10, 0	
	nl: db 10

section .bss
	argc: resq 1
	argv: resq 1
	dest: resq 1

section .text
global _start
_start:

	; Get argc
	mov rdi, [rsp + 8]
	mov [argc], rdi

	cmp rdi, 0
	je print_help

	; Get argv
	lea rsi, [rsp + 16]
	mov [argv], rsi

	mov rsi, [rsi]
	call prints

	mov rax, 1
	mov rdi, 1
	mov rsi, nl
	mov rdx, 1
	syscall
	
	mov rsi, string
	call prints

	mov rsi, string
	mov rdi, dest
	mov rcx, 7
	cld
	rep movsb

	mov rsi, dest
	call prints
	
	jmp exit
	

	print_help: 
	mov rsi, help
	call prints
	jmp exit

	exit:
	mov rax, 60
	xor rdi, rdi
	syscall


prints:
	prints_loop:
	mov al, [rsi]
	test al, al
	jz prints_done
	mov rdx, 1
	mov rdi, 1
	mov rax, 1
	syscall
	inc rsi
	jmp prints_loop
	prints_done:
	ret
