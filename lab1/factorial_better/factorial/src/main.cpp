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