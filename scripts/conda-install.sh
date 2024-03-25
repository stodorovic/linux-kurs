#!/bin/bash

if [ -x "$CONDA_EXE" ]; then
        source `dirname $CONDA_EXE`/../etc/profile.d/conda.sh
elif [ -x /opt/conda/bin/conda ]; then
        source /opt/conda/etc/profile.d/conda.sh
elif [ -x $HOME/miniconda3/bin/conda ]; then
        source $HOME/miniconda3/etc/profile.d/conda.sh
fi

if [ ! -x "$CONDA_EXE" ]; then
        echo -e "\nInstalling miniconda\n"

        mkdir -p ~/miniconda3
        wget https://repo.anaconda.com/miniconda/Miniconda3-py311_24.1.2-0-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
        bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
        rm -rf ~/miniconda3/miniconda.sh

        source $HOME/miniconda3/etc/profile.d/conda.sh
        conda init bash
fi

echo -e "\nActivate base environment\n"
conda activate base

conda update -n base conda --all -y

echo -e "\nInstalling imgge-kurs environment\n"
conda env update --name imgge-kurs --file $HOME/Kurs/imgge-kurs.yml --prune

conda clean --all -y
pip3 cache purge
