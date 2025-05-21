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