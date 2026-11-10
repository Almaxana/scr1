# Сборка и запуск
Из корневой папки
 ```
 make clean
 make run_verilator_wf TARGETS="riscv_isa" TRACE=1
 ```
 # Посмотреть wave
 Из build (желательно из обычного терминала, а не vs code)
 ```
 gtkwave ./simx.vcd
 ```

# Создание дизассемблера
```
riscv64-unknown-elf-objdump -D build/verilator_AHB_MAX_imc_IPIC_1_TCM_1_VIRQ_1_TRACE_0/sub.elf > sub.dump
```
