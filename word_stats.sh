#!/usr/bin/env bash

# Основний скрипт:
#  - приймає шлях до .txt файлу (книжки)
#  - перевіряє, що файл існує
#  - підключає бібліотеку
#  - викликає функцію extract_word_stats з бібліотеки
#  - записує результат у output.txt

# 1. Перевіряємо, що є хоча б 1 аргумент
if [ $# -lt 1 ]; then
  echo "Помилка: не передано шлях до файлу з книжкою."
  echo "Приклад запуску:"
  echo "  ./word_stats.sh book.txt"
  exit 1
fi

input_file="$1"

# 2. Перевіряємо, що файл існує
if [ ! -f "$input_file" ]; then
  echo "Помилка: файл '$input_file' не існує."
  exit 1
fi

# 3. Знаходимо директорію, де лежить скрипт (щоб коректно підключити бібліотеку)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 4. Підключаємо бібліотеку з функцією extract_word_stats
#    Після цього виклик extract_word_stats стає доступним як звичайна функція
source "$SCRIPT_DIR/lib_text.sh"

# 5. Викликаємо функцію з бібліотеки і переадресовуємо її вивід у output.txt
#    Усе, що надрукує extract_word_stats, запишеться в файл output.txt
extract_word_stats "$input_file" > "$SCRIPT_DIR/output.txt"

echo "Готово! Результат записано у файл: $SCRIPT_DIR/output.txt"
