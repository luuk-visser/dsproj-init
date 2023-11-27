# Define a function to display the script's usage information
vi environment.yml
mamba env create -f environment.yml
eval "$(conda shell.bash hook)"
env_name=$(head -n 1 environment.yml | awk '{print $2}')
conda activate $env_name
mamba env update -f $(dirname "$0")/editor-env.yml
