; Procedure for finding the maximum in an array
; Only works with positive numbers
; rcx - array pointer
; rdx - array size
.code
search_max proc
	push rbp                ; save RBP
	mov rbp, rsp            ; init frame ptr
	sub rsp, 4              ; reserve 4b in stack
	mov ebx, 4              ; sizeof int
	mov [rbp - 4], ebx      ; save sizeof int
	mov eax, [rcx]          ; first element
start_while:                	; start loop 
	cmp eax, [rcx]          ; compare max and current element
	jna assign              ; if the current maximum is less 
	jmp without_assign      ; else
assign:                     
	mov eax, [rcx]          ; update current maximum
without_assign:             
	dec rdx                 
	jz end_while            
	add rcx, [rbp - 4]      ; next element
	jmp start_while
end_while:
	mov rsp, rbp            ; restore stack pointer
	pop rbp                 ; restore base pointer
	ret                     ; return max element (RAX)
search_max endp
end
