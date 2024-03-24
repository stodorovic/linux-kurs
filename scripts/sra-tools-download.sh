#!/bin/bash

# promeni radni direktorijum
cd $HOME

# skini instalaciju sra toolkit-a
wget -O Kurs/sratools-setup-apt.sh https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.1.0/setup-apt.sh

# instaliraj sra toolkit
sudo sh Kurs/sratools-setup-apt.sh 

# promeni radni direktorijum
cd $HOME/Kurs

# obrisi instalacioni fajl
rm sratools-setup-apt.sh 

# dodaj sra toolkit u PATH (samo za ovaj shell skirpt)
source /etc/profile.d/sra-tools.sh

# napravi poddirektorijum fastq u Kursu
mkdir -p $HOME/Kurs/fastq

# promeni radni direktorijum
cd $HOME/Kurs/fastq

# skini fastq fajlove
fasterq-dump SRR11648416
