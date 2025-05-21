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