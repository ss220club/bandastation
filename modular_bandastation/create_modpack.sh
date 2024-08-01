#!/bin/bash

COLOR_RESET='\033[0m'
COLOR_GREEN='\033[32m'
COLOR_BLUE='\033[36m'

mod_name=""
mod_name_upper=""
mod_name=""

script_dir=$(dirname "$0")
modpack_dir="_modpack_example"
modpacks_dir="modpacks"

while [ -z "$mod_name" ]; do
  echo -e "${COLOR_GREEN}| ${COLOR_RESET}Название мода пишется строчными буквами, а также с"
  echo -e "${COLOR_GREEN}| ${COLOR_RESET}использованием подчёркиваний вместо пробелов или тире."
  echo -e "${COLOR_GREEN}| ${COLOR_RESET}Пример: my_awesome_modpack"
  echo -en "${COLOR_BLUE}> ${COLOR_RESET}Введи название мода: "
  read mod_name
  echo

  mod_name=$(echo "$mod_name" | sed -E 's/\s|-/_/g' | tr '[:upper:]' '[:lower:]')

  echo -e "${COLOR_GREEN}| ${COLOR_RESET}Выбранное название: ${mod_name}"
  echo -en "${COLOR_BLUE}> ${COLOR_RESET}Всё верно? (Y/n) "
  read confirmation
  echo

  confirmation=${confirmation:-y}
  if [ "${confirmation,,}" != "y" ]; then
    mod_name=""
  fi
done

if [ ! -d "$script_dir/$modpack_dir" ]; then
  echo "Папка "$script_dir/$modpack_dir" не найдена. Убедись что она существует и попробуй ещё раз."
  exit 1
fi

if [ -d "$script_dir/$modpacks_dir/$mod_name" ]; then
  echo "Папка $script_dir/$modpacks_dir/$mod_name уже существует."
  exit 1
fi

mkdir -p "$script_dir/$modpacks_dir/$mod_name"
cp "$script_dir/$modpack_dir/"* "$script_dir/$modpacks_dir/$mod_name/" -r

# Rename files
for file in "$script_dir/$modpacks_dir/$mod_name"/*example*; do
  new_name=$(echo "$file" | sed -E "s/$modpack_dir/_$mod_name/")
  mv "$file" "$new_name"
done

# Process and update content of all the files
for file in "$script_dir/$modpacks_dir/$mod_name"/*; do
  sed -i'' -e "s/EXAMPLE/$mod_name_upper/g" -e "s/example/$mod_name/g" "$file"
done

echo "Готово! Файлы для мода $mod_name созданы."
echo "Находятся они в папке $script_dir/$modpacks_dir/$mod_name."
