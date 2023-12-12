.data
    A: .zero 1600
    counter_zero: .space 4
    copy_A: .zero 1600
    counter: .space 4
    ASCII_vector: .space 40
    stringIndex: .space 4
    M: .space 4
    N: .space 4
    P: .space 4
    constant: .space 4
    size_array: .space 4
    current_StepM: .space 4
    integer_array: .space 80
    hexa_input: .space 20
    current_Character: .space 1
    starting_hexa: .asciz "0x"
    final_Step: .space 4
    current_Step: .space 4
    life_counter: .long 0
    rowIndex: .space 4
    columnIndex: .space 4
    currentRow: .space 4
    currentColumn: .space 4
    query_N: .space 4
    query_M: .space 4
    K: .space 4
    O: .space 4
    number_of_loops: .space 4
    rightHand: .space 4
    message: .space 10
    final_binary_code: .space 400
    binary_code: .space 400
    binary_codeIndex: .space 4
    size: .space 4
    power: .space 4
    sum: .space 4
    stringSize: .space 4
    register_copy: .space 4
    alive_counter: .space 4
    up_neighbor: .space 4
    down_neighbor: .space 4
    left_neighbor: .space 4
    right_neighbor: .space 4
    up_left_neighbor: .space 4
    up_right_neighbor: .space 4
    down_left_neighbor: .space 4
    down_right_neighbor: .space 4
    formatPrintf: .asciz "%d"
    formatScanf: .asciz "%d"
    formatScanfString: .asciz "%s"
    formatPrintfCharacter: .asciz "%c"
    formatNewLine: .asciz "\n"
    formatPrintfString: .asciz "%s"
.text
.global main
main:
    mov $A, %edi
    mov $copy_A, %esi
et_input:

    push $M
    push $formatScanf
    call scanf
    addl $8, %esp

    push $N
    push $formatScanf
    call scanf
    addl $8, %esp

    push $P
    push $formatScanf
    call scanf
    addl $8, %esp

    movl $0, %ecx
    addl $2, M
    addl $2, N
    input_values:
        cmp P, %ecx
        je et_lastInput 
        
        push %ecx
        push $rowIndex
        push $formatScanf
        call scanf 
        addl $8, %esp
        push $columnIndex
        push $formatScanf
        call scanf 
        addl $8, %esp
        pop %ecx

        incl rowIndex
        incl columnIndex
        mov rowIndex, %eax
        mull N
        addl columnIndex, %eax
        movl $1, (%edi, %eax, 4)

        incl %ecx
        jmp input_values

et_lastInput:
    movl M, %ebx
    movl %ebx, query_M
    subl $2, query_M

    movl N, %ebx
    movl %ebx, query_N
    subl $2, query_N

    push $K
    push $formatScanf
    call scanf
    addl $8, %esp

    push $O
    push $formatScanf
    call scanf
    addl $8, %esp

loop_K:

    movl K, %ecx
    cmp $0, %ecx
    je et_crypt

et_Task:

    movl $1, currentRow
    loopTask_rows:
        movl currentRow, %ecx
        cmp query_M, %ecx
        jg et_copy
        movl $1, %ecx
        loopTask_columns:
            cmp query_N, %ecx
            jg et_newRow

            movl $0, alive_counter
            movl %ecx, currentColumn

            movl $0, %edx
            movl currentRow, %eax
            mull N
            addl currentColumn, %eax
            movl %eax, register_copy
            UP:
                subl N, %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne DOWN
                incl alive_counter
            DOWN:
                movl register_copy, %eax
                addl N, %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne LEFT
                incl alive_counter
            LEFT:
                movl register_copy, %eax
                decl %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne RIGHT
                incl alive_counter
            RIGHT:
                movl register_copy, %eax
                incl %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne UP_LEFT
                incl alive_counter
            UP_LEFT:
                movl register_copy, %eax
                subl N, %eax
                decl %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne UP_RIGHT
                incl alive_counter
            UP_RIGHT:
                movl register_copy, %eax
                subl N, %eax
                incl %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne DOWN_LEFT
                incl alive_counter
            DOWN_LEFT:
                movl register_copy, %eax
                addl N, %eax
                decl %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne DOWN_RIGHT
                incl alive_counter
            DOWN_RIGHT:
                movl register_copy, %eax
                addl N, %eax
                incl %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne et_Switch
                incl alive_counter
            et_Switch:
                movl register_copy, %eax
                movl (%edi, %eax, 4), %ecx
                cmp $1, %ecx
                jne et_secondCase
            lowerThanTwo:
                movl alive_counter, %ecx
                cmp $2, %ecx
                jge moreThanThree
                movl $0, (%esi, %eax, 4)
                jmp et_continue
            moreThanThree:
                movl alive_counter, %ecx
                cmp $3, %ecx
                jle correct_case
                movl $0, (%esi, %eax, 4)
                jmp et_continue
            correct_case:
                movl $1, (%esi, %eax, 4)
                jmp et_continue
            et_secondCase:
                movl alive_counter, %ecx
                cmp $3, %ecx
                jne notThree
                movl $1, (%esi, %eax, 4)
                jmp et_continue
            notThree:
                movl alive_counter, %ecx
                movl $0, (%esi, %eax, 4)
            et_continue:
                movl currentColumn, %ecx
                incl %ecx
                jmp loopTask_columns
et_newRow:
    incl currentRow
    jmp loopTask_rows
et_copy:
    decl K
    movl $0, %edx
    movl M, %eax
    mull N
    mov %eax, size
    movl $0, %ecx
    loop_copy:
        cmp size, %ecx
        je loop_K
        movl (%esi, %ecx, 4), %eax
        movl %eax, (%edi, %ecx, 4)
        incl %ecx
        jmp loop_copy

et_crypt:
    
    mov O, %ecx
    cmp $0, %ecx
    jne et_decrypt

    push $message
    push $formatScanfString
    call scanf
    addl $8, %esp

    mov $message, %esi
    mov $binary_code, %edi 
    movl $0, current_Step
    crypt_loop:
        movl current_Step, %eax
        movb (%esi, %eax, 1), %ah
        movzbl %ah, %ecx
        cmp $0, %ecx
        je xor_crypt
        movl current_Step, %eax
        movl %ecx, (%edi, %eax, 4)
        incl current_Step
        jmp crypt_loop
xor_crypt:
    movl $A, %esi
    movl $binary_code, %edi
    movl current_Step, %eax
    movl %eax, size_array

    movl $0, current_Step
    movl $0, current_StepM
    movl $0, sum
    movl $128, power

    for_integersC:
        movl current_Step, %ecx
        cmp size_array, %ecx
        je et_final_crypt
        for_MC:
            movl current_StepM, %ecx
            cmp $0, %ecx
            je continue_for_MC

            movl %ecx, %eax
            movl $0, %edx
            movl $8, %ebx
            divl %ebx
            movl %edx, %ecx
            cmp $0, %ecx

            je increaseC
            continue_for_MC:

            movl current_StepM, %eax
            movl size, %ebx
            movl $0, %edx
            divl %ebx

            movl (%esi, %edx, 4), %eax
            movl power, %ebx
            movl $0, %edx
            mull %ebx

            addl %eax, sum

            movl power, %eax
            movl $0, %edx
            movl $2, %ebx
            divl %ebx
            movl %eax, power

            incl current_StepM
            jmp for_MC
increaseC:
    movl current_Step, %ecx
    movl (%edi, %ecx, 4), %eax

    xorl sum, %eax
    movl %eax, (%edi, %ecx, 4)

    movl current_StepM, %eax
    movl size, %ebx
    movl $0, %edx
    divl %ebx

    movl (%esi, %edx, 4), %eax
    movl $128, %ebx
    movl $0, %edx
    mull %ebx

    movl $0, sum
    addl %eax, sum
    movl $64, power

    incl current_Step
    incl current_StepM
    jmp for_integersC

et_final_crypt:
    push $starting_hexa
    push $formatPrintfString
    call printf
    addl $8, %esp
    movl $binary_code, %edi
    movl $0, current_Step
    final_crypt_xor:
        movl current_Step, %ecx
        cmp size_array, %ecx
        je et_exit

        movl (%edi, %ecx, 4), %eax

        movzbl %al, %edx
        movzbl %al, %ecx

        shrl $4, %edx
        andl $0xF, %ecx

        leftN:
            cmp $10, %edx
            jge leftL
            push %ecx
            push %edx
            push $formatPrintf
            call printf
            addl $8, %esp
            pop %ecx
            jmp rightN
        leftL:
            addl $55, %edx
            push %ecx
            push %edx
            push $formatPrintfCharacter
            call printf
            addl $8, %esp
            pop %ecx
            jmp rightN
        rightN:
            cmp $10, %ecx
            jge rightL
            push %ecx
            push $formatPrintf
            call printf
            addl $8, %esp
            jmp continue_final_crypt_xor
        rightL:
            addl $55, %ecx
            push %ecx
            push $formatPrintfCharacter
            call printf
            addl $8, %esp
        continue_final_crypt_xor:
        incl current_Step
        jmp final_crypt_xor
et_decrypt:
    push $hexa_input
    push $formatScanfString
    call scanf
    addl $8, %esp

    mov $hexa_input, %esi
    mov $integer_array, %edi
    movl $2, current_Step

    decrypt_loop:
        movl current_Step, %eax
        movb (%esi, %eax, 1), %ah
        movzbl %ah, %ecx
        cmp $0, %ecx
        je xor_decrypt
        aboveChar:
            movl current_Step, %eax
            cmp $57, %ecx
            jg isLetter
            subl $48, %ecx
            subl $2, %eax
            movl %ecx, (%edi, %eax, 4)
            jmp continue_decrypt_loop
        isLetter:
            movl current_Step, %eax
            sub $55, %ecx
            subl $2, %eax
            movl %ecx, (%edi, %eax, 4)
            addl $8, %esp
        continue_decrypt_loop:
        incl current_Step
        jmp decrypt_loop
xor_decrypt:

    mov $A, %esi
    mov $integer_array, %edi

    movl $0, sum
    movl $8, power
    movl current_Step, %eax
    subl $2, %eax
    movl %eax, size_array
    movl $0, current_Step
    movl $0, current_StepM

    for_integers:
        movl current_Step, %ecx
        cmp size_array, %ecx
        je et_final_decrypt
        for_M:
            notZ:
            movl current_StepM, %ecx
            cmp $0, %ecx
            je continue_for_M
            
            movl %ecx, %eax
            movl $0, %edx
            movl $4, %ebx
            divl %ebx
            movl %edx, %ecx
            cmp $0, %ecx
            je increase
            
            continue_for_M:
            movl current_StepM, %eax
            movl size, %ebx
            movl $0, %edx
            divl %ebx

            movl (%esi, %edx, 4), %ebx
            movl %ebx, %eax
            movl $0, %edx
            movl power, %ebx
            mull %ebx
            addl %eax, sum

            movl power, %eax
            movl $2, %ebx
            movl $0, %edx
            divl %ebx
            movl %eax, power

            incl current_StepM
            jmp for_M
increase:
    movl current_Step, %ecx
    movl (%edi, %ecx, 4), %eax

    xorl sum, %eax
    movl %eax, (%edi, %ecx, 4)

    movl current_StepM, %eax
    movl size, %ebx
    movl $0, %edx
    divl %ebx

    movl (%esi, %edx, 4), %ebx
    movl %ebx, %eax
    movl $8, %ebx
    mull %ebx

    movl %eax, sum
    movl $4, %eax
    movl %eax, power

    incl current_Step
    incl current_StepM
    jmp for_integers
    
et_final_decrypt:
    movl $1, %ecx
    final_decrypt_xor:
        cmp size_array, %ecx
        jg et_exit

        movl %ecx, %ebx
        decl %ebx

        movl (%edi, %ebx, 4), %eax
        movl (%edi, %ecx, 4), %edx

        shl $4, %eax
        orl %edx, %eax

        push %ecx
        push %eax
        push $formatPrintfCharacter
        call printf
        addl $8, %esp
        pop %ecx

        addl $2, %ecx
        jmp final_decrypt_xor

et_exit:
    push $formatNewLine
    call printf
    addl $4, %esp
    mov $1, %eax
    mov $0, %ebx
    int $0x80