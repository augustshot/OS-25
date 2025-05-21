<div align="center">

# Лабораторные работы по курсу «Операционные системы» (2025)

</div>

***

## Содержание

1. [Лабораторная работа №1. Исследование компилятора gcc, язык ассемблера. Связь процесса и операционной системы. Makefile, git.](#lab1)
2. [Лабораторная работа №2. Установка Linux.](#lab2)
3. [Лабораторная работа №3a. Реализация скрипта bash.](#lab3)

***

## <a id="lab1">Лабораторная работа №1</a>
### Исследование компилятора gcc, язык ассемблера, cвязь процесса и операционной системы, makefile, git

Код программы вычисления факториала ([factorial.cpp](/lab1/factorial.cpp)):

```cpp
#include <iostream>
using namespace std;

int factorial(int n){
    return (n > 1) ? n * factorial(n - 1) : 1;
}

int main(){
    int num = 7;
    cout << "factorial of " << num << " is " << factorial(num) << endl;
}
```



Скомпилированный командой  ```gcc -S -O2 -o factorialO2.s factorial.cpp``` (второй уровень оптимизации) [ассемблер-код](/lab1/factorialO2.s):

```ASM
	.file	"factorial.cpp"    ; Исходный файл программы
	.intel_syntax noprefix      ; Использование синтаксиса Intel 
	.text                       ; Начало секции кода

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

	; Основная секция кода
	.text
	.p2align 4
	.globl	_Z9factoriali      ; Объявление функции factorial
	.def	_Z9factoriali;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z9factoriali   
_Z9factoriali:
.LFB2242:
	.seh_endprologue           
	
	; Реализация функции вычисления факториала
	mov	eax, 1               ; Инициализация результата 1 
	cmp	ecx, 1               ; Сравнение входного аргумента с 1
	jle	.L3                  ; Если n <= 1, перейти к возврату
	
	; Цикл вычисления факториала
	.p2align 4,,10            
	.p2align 3
.L5:
	mov	edx, ecx             ; Сохраняем текущее n в edx
	sub	ecx, 1               ; n--
	imul	eax, edx         ; Умножаем результат на текущее n
	cmp	ecx, 1               ; Сравниваем n с 1
	jne	.L5                  ; Если n != 1, продолжаем цикл
	
.L3:                         
	ret                     
	.seh_endproc          

	.def	__main;	.scl	2;	.type	32;	.endef 

	.section .rdata,"dr"
.LC0:
	.ascii "factorial of \0"   ; Строка для вывода
.LC1:
	.ascii " is \0"            ; Строка для вывода

	.section	.text.startup,"x"
	.p2align 4
	.globl	main              ; Объявление main
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
	
	; Основное тело функции
	call	__main            
	
	; Вывод строки "factorial of "
	mov	rcx, QWORD PTR .refptr._ZSt4cout[rip]  ; Загружаем cout
	lea	rdx, .LC0[rip]                        ; Адрес строки
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc  ; operator<<
	
	; Вывод числа 7
	mov	edx, 7              ; Число для вывода
	mov	rcx, rax            ; Передаем cout 
	call	_ZNSolsEi          ; operator<< 
	
	; Вывод строки " is "
	lea	rdx, .LC1[rip]      ; Адрес строки
	mov	rcx, rax            ; Передаем cout
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc  ; operator<<
	
	; Вывод результата 
	mov	edx, 5040           ; Компилятор вычислил 7! = 5040 на этапе компиляции (агрессивная оптимизация)
	mov	rcx, rax            ; Передаем cout
	call	_ZNSolsEi        ; operator<<
	
	; Подготовка к выводу перевода строки (endl)
	mov	rbx, rax            
	mov	rax, QWORD PTR [rax]  
	mov	rax, QWORD PTR -24[rax]  
	mov	rsi, QWORD PTR 240[rbx+rax]  
	test	rsi, rsi          ; Проверка на NULL
	je	.L13               ; Если NULL - ошибка
	
	; Проверка, был ли символ '\n' уже преобразован
	cmp	BYTE PTR 56[rsi], 0  
	je	.L10               ; Если нет - переходим к инициализации
	
	; Если символ уже преобразован
	movsx	edx, BYTE PTR 67[rsi]  ; Загружаем '\n'
.L11:
	; Вывод символа новой строки
	mov	rcx, rbx            ; Передаем cout
	call	_ZNSo3putEc        ; Выводим символ
	mov	rcx, rax            
	call	_ZNSo5flushEv      ; Сброс буфера
	
	xor	eax, eax           
	add	rsp, 40             
	pop	rbx                
	pop	rsi                 
	ret                    
	
.L10:  ; Инициализация преобразования символа
	mov	rcx, rsi           
	call	_ZNKSt5ctypeIcE13_M_widen_initEv  
	mov	rax, QWORD PTR [rsi]  
	mov	edx, 10             ; '\n' 
	lea	rcx, _ZNKSt5ctypeIcE8do_widenEc[rip]  
	mov	rax, QWORD PTR 48[rax]  
	cmp	rax, rcx       
	je	.L11          
	
	
	mov	edx, 10             ; '\n'
	mov	rcx, rsi           
	call	rax             
	movsx	edx, al           ; Преобразуем результат
	jmp	.L11                ; Переход к выводу
	
.L13:  ; Обработка ошибки
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
```

Агрессивную оптимизацию можно отследить по тому, что значение 7! = 5040 было вычислено на этапе компиляции и затем просто подставлено напрямую в код.

***

Структура [проекта](/lab1/factorial):
```
factorial/
├── include/
│   └── factorial.h       # заголовочный файл
├── src/
│   ├── factorial.cpp     # реализация факториала
│   └── main.cpp          # главная программа
└── Makefile              # файл сборки
```

#### include/factorial.h:
```cpp
#ifndef FACTORIAL_H
#define FACTORIAL_H

int factorial(int n);

#endif
```

#### src/factorial.cpp:
```cpp
#include "factorial.h"

int factorial(int n){
    return (n > 1) ? n * factorial(n - 1) : 1;
}
```
#### src/main.cpp:
```cpp
#include <iostream>
#include "factorial.h"
using namespace std;

int main(){
    int num = 7;
    cout << "factorial of " << num << " is " << factorial(num) << endl;
}
```
#### Makefile:
```
# Компилятор и флаги
CXX := g++
CXXFLAGS := -std=c++11 -Wall -Wextra -Iinclude 
TARGET := factorial

# Исходные файлы и объекты
SRC_DIR := src
SRC := $(SRC_DIR)/factorial.cpp $(SRC_DIR)/main.cpp
OBJ_DIR := obj
OBJ := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRC))

# Правило по умолчанию
all: $(TARGET)

# Сборка исполняемого файла
$(TARGET): $(OBJS)
	$(CXX) $(LDFLAGS) $^ -o $@

# Компиляция исходных файлов
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Создание папки для объектных файлов
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Очистка
clean:
	rm -rf $(OBJ_DIR) $(TARGET)

.PHONY: all clean
```
***
### Добавление параллельного процесса средствами Linux/Windows, синхронизация доступа к общему ресурсу
Новая структура [проекта](/lab1/factorial_better):
```
factorial_better/
├── include/
│   ├── factorial.h       
│   └── shared.h          # заголовочный файл для работы с shmem и семафорами
├── src/
│   ├── factorial.cpp     
│   ├── shared.cpp        # модуль для работы с разделяемой памятью
│   └── main.cpp          # главная программа (модифицирована)
└── Makefile              # обновлён для поддержки многопроцессности
```

#### include/shared.h:
```cpp
#ifndef SHARED_H
#define SHARED_H

#include <semaphore.h>

struct SharedData {
    int value;            // Разделяемая ячейка данных
    sem_t write_sem;      // Семафор записи
    sem_t read_sem;       // Семафор чтения
};

void setup_shared_memory(SharedData** shared, const char* name);
void cleanup_shared_memory(SharedData* shared, const char* name);

#endif
```

#### src/main.cpp:
```cpp
#include <iostream>
#include <sys/wait.h>
#include "factorial.h"
#include "shared.h"

int main() {
    const char* SHMEM_NAME = "/fact_shmem";
    SharedData* shared = nullptr;

    setup_shared_memory(&shared, SHMEM_NAME);

    pid_t pid = fork();
    if (pid == -1) {
        perror("fork failed");
        return 1;
    }

    if (pid > 0) {                     // родительский процесс
        sem_wait(&shared->write_sem);  // семафор записи
        shared->value = 5;             // запись значения
        cout << "[Parent] Wrote value: " << shared->value << endl;
        sem_post(&shared->read_sem);   // разрешение чтения

        wait(nullptr);              
        cleanup_shared_memory(shared, SHMEM_NAME);
    } 
    else {                             // дочерний процесс
        sem_wait(&shared->read_sem);   // ожидание разрешения на чтение
        int n = shared->value;         // чтение значения
        cout << "[Child] Factorial of " << n 
                  << " is " << factorial(n) << endl;
        sem_post(&shared->write_sem);  // освобождение для следующей записи
        exit(0);
    }

    return 0;
}
```
#### Makefile:
``` Makefile
# Компилятор и флаги
CXX := g++
CXXFLAGS := -std=c++11 -Wall -Wextra -Iinclude 
TARGET := factorial
# Исходные файлы и объекты
SRC_DIR := src
SRC := $(SRC_DIR)/factorial.cpp $(SRC_DIR)/main.cpp
OBJ_DIR := obj
OBJ := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRC))

# Правило по умолчанию
all: $(TARGET)
# Сборка исполняемого файла
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ -lrt  
# Компиляция исходных файлов
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@
# Создание папки для объектных файлов
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)
# Очистка
clean:
	rm -rf $(OBJ_DIR) $(TARGET) /dev/shm/*sem* /dev/shm/fact_shmem

.PHONY: all clean

```

***

## <a id="lab2">Лабораторная работа №2</a>
### Установка Arch Linux (выполнялась совместно с [Totodor](https://github.com/Totodor))
Установка производилась по шагам из [wiki](https://wiki.archlinux.org/title/Install_Arch_Linux_from_existing_Linux "Install Arch Linux from existing Linux"), а также с помощью [гайда](https://github.com/dydojopka/ArchLinux-Bootstrap-Guide), созданного моим коллегой. 😉

Запись процесса установки доступна по [ссылке](https://drive.google.com/file/d/1Zt1fB4W3O8ubAOsCFvV-k286qIU7SWgn/view?usp=sharing):

[![bootstrappint arch linux](http://d.zaix.ru/NjNe.png)](https://drive.google.com/file/d/1Zt1fB4W3O8ubAOsCFvV-k286qIU7SWgn/view)

Для более удобного выполнения лабораторной работы №3 (и эстетической составляющей) также [был установлен](https://drive.google.com/file/d/1xrcM-wCmhnf60ltXFw6ly6FGt_5XduXi/view?usp=sharing) графический интерфейс Gnome:

[![gnome install](http://d.zaix.ru/NjNh.png)](https://drive.google.com/file/d/1xrcM-wCmhnf60ltXFw6ly6FGt_5XduXi/view?usp=sharing)

###### P.S.: процесс установки был произведен полностью (arch + gnome) аж 3 раза:
###### - тренировочная установка
###### - установка под запись... в которой запись велась не на том окне
###### - финальная удачная установка под запись
***
## <a id="lab3">Лабораторная работа №3</a>
### Реализация скрипта bash
Для выполнения лабораторной работы №3 было выбрано следующее задание:
> 1. Скопировать все изображения в папку резервного хранения.

[bash-скрипт](/lab3/backup.sh):
```
#!/bin/bash

# проверка аргументов
if [ "$#" -eq 0 ]; then
    source_dir="."
elif [ "$#" -eq 1 ]; then
    source_dir="$1"
else
    echo "Ошибка: Неверное количество аргументов" >&2
    echo "Использование: $0 [исходная_папка]" >&2
    exit 1
fi

# проверка существования исходной директории
if [ ! -d "$source_dir" ]; then
    echo "Ошибка: Директория '$source_dir' не существует" >&2
    exit 2
fi

# определение папки, в которую будет производиться копирование
backup_dir="image_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir" || {
    echo "Ошибка: Невозможно создать папку $backup_dir" >&2
    exit 3
}

# поиск и копирование файлов
formats=("*.jpg" "*.jpeg" "*.jp2" "*.png" "*.gif" "*.bmp" "*.webp")
echo "Поиск изображений в: $(realpath "$source_dir")"
base_dir=$(realpath "$source_dir")

find "$source_dir" -type f \( -name "${formats[0]}" \
    $(printf -- "-o -name %s " "${formats[@]:1}") \) \
    -exec sh -c '
        file="$1"
        rel_path=$(realpath --relative-to="$2" "$file")
        mkdir -p "$3/$(dirname "$rel_path")"
        cp "$file" "$3/$rel_path"
    ' sh {} "$base_dir" "$backup_dir" \;

# проверка результата
count=$(find "$backup_dir" -type f | wc -l)
echo "Резервное копирование завершено!"
echo "Скопировано файлов: $count"
echo "Резервная копия доступна в: $(realpath "$backup_dir")"
```

Для проверки с помощью общих папок VirtualBox 3 изображения были перенесены в /home/images, а затем с помощью программы скопированы в папку резервного копирования, созданную в директории самого скрипта:
![backup](http://d.zaix.ru/NkbG.png)
На скриншоте видны исходная и конечная папки, а также необходимая команда в консоли: 
```bash backup.sh /home/images/ ```
