#!/usr/bin/env bash
# Define a function to display the script's usage information
display_help() {
    echo "Usage: $0 <project-name>"
    echo "Description: Initialize new project with given name."
    exit 1
}

project_name=$(basename "$PWD")
while getopts "n:" opt; do
  case "$opt" in
    n)
      project_name="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 [-n name]" >&2
      exit 1
      ;;
  esac
done

kebab_to_snake() {
  local input="$1"
  # Replace all hyphens with underscores
  local output="${input//-/_}"
  echo "$output"
}

project_name_kebab="$project_name"
project_name_snake=$(kebab_to_snake "$project_name")


script_dir=$(dirname "$0")
default_project=$script_dir/proj-default

echo "Initializing new project with name $project_name_kebab"
cp -r $default_project/* .
mv ./src/source_package ./src/$project_name_snake
sed -i "s/project_name/$project_name_snake/g" pyproject.toml
sed -i "s/project-name/$project_name_kebab/g" environment.yml
$script_dir/create-env.sh
