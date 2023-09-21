; сравнение строки с паттерном
; * - любая последовательность символов
; ? - любой символ
; input rcx -  ссылка на строку
; input rdx - ссылка на паттерн
; return 1 - если строка соответствует паттерну
; return 0 - если строка не соответствует



.code
option casemap:none					              ; чувствительность к регистру
match proc							                  ; процедура сравнения
	push rbp						                    ; создание фрейма стека
	mov rbp, rsp
	sub rsp, 16						                  ; резервировать 16
	mov [rbp - 4],  dword ptr '*'	          ; *
	mov [rbp - 8],	dword ptr '?'	          ; ?
	mov [rbp - 12], dword ptr 0		          ; 0
	mov [rbp - 16], dword ptr 0

while_true:							                  ; главный цикл
	mov al, byte ptr [rcx]
	mov bl, byte ptr [rdx]
	cmp al, byte ptr [rbp - 12]		          ; конец строки
	jne not_end						                  ; если не конец строки, продолжить проверку
	cmp bl, byte ptr [rbp - 12]		          ; конец строки
	jne false						                    ; если нет, то строка не соответствует паттерну
	jmp true						                    ; иначе соответствует
not_end:
	cmp bl, byte ptr [rbp - 8]		          ; 
	jne not_astrisk					                ; если символ != *
	mov [rbp - 16], dword ptr 0
while_astrisk:
	
not_astrisk:
	cmp bl, byte ptr [rbp-8]		            ; ?
	je quest						                    ; если символ == ?
	cmp al, bl					                    ; символы должы быть равны
	jne false						                    ; если нет, то вернуть 0
	jmp next_step
quest:
	cmp bl, byte ptr [rbp - 12]		          ; если строка завершена
	je false						                    ;	то не соответствует
next_step:
	inc rcx							                    ; переход к следующему символу строки
	inc rdx							                    ; переход к следующему символу паттерна
	jmp while_true					                ; повторить цикл
true:
	mov rax, 1						                  ; процедура вернет 1
	jmp quit						                    ; завершить выполнение
false:
	xor rax, rax					                  ; процедура вернет 0
quit:
	mov rsp, rbp					                  ; восстановить указатель стека
	pop rbp							                    ; восстановаить базовый указатель
	ret								                      ; завершить выполнение, вернуть значение rax
match endp
end
