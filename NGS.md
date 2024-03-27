## wget - referentni
```console
wget http://10.10.10.10/linux/vezbe/af.tar.gz
```

```console
fastq-dump --gzip --split-files SRR11648416
```

```console
fasterq-dump SRR11648416
```

## Trimovanje
```console
fastp --average_qual 28 -w 2 -i fastq/V300114179_L04_80_80_1.fq.gz -I fastq/V300114179_L04_80_80_2.fq.gz \
  -o clean/uzorak1_1.fq.gz -O clean/uzorak1_2.fq.gz -j reports/uzorak1.json -h reports/uzorak1.html \
  --adapter_sequence=AAGTCGGAGGCCAAGCGGTCTTAGGAAGACAA --adapter_sequence_r2=AAGTCGGATCGTAGCCATGTCGTTCTGTGAGCCAAGGAGTTG
```
## Poravnanje
```console
bwa mem -t 4 -R '@RG\tID:uzorak1\tPL:DNBSEQ\tPU:uzorak1\tLB:mutPCR\tSM:uzorak1' \
  reference/sequence.fasta clean/uzorak1_?.fq.gz | \
  samtools view -b  | \
  samtools sort > bam/uzorak1_sortiran.bam
```
## Freebayes
```console
freebayes -p 4 -q 25 -m 60 --min-coverage 30 -f reference/sequence.fasta bam/uzorak1_filter.bam > vcf/uzorak1_raw.vcf
```
```console
bcftools filter -i'QUAL>20 && INFO/DP>10' vcf/uzorak1_raw.vcf.gz > vcf/uzorak1_filter.vcf
```
```console
bcftools consensus -f reference/sequence.fasta vcf/uzorak1_filter.vcf.gz > fasta/uzorak1.fasta
```

```console
bwa index reference/af.fasta

bwa mem -t 4 reference/af.fasta fastq/SRR11648416_?.fastq | samtools sort > bam/SRR11648416.bam
samtools index bam/SRR11648416.bam

samtools stats bam/SRR11648416.bam > reports/SRR11648416_stats.txt
samtools depth bam/SRR11648416.bam > reports/SRR11648416_depth.txt
samtools idxstats bam/SRR11648416.bam > reports/SRR11648416_total_stats.txt

qualimap bamqc -bam bam/SRR11648416.bam -outdir reports/SRR11648416_qualimap

featureCounts -p -C -B -M -t exon -g gene_id -a reference/af.gff3 -o reports/SRR11648416_FC_counts.txt bam/SRR11648416.bam
featureCounts -T 5  --ignoreDup -p -C -B -M -t 'gene' --extraAttributes 'biotype' -a reference/af.gff3 -o reports/SRR11648416_FC_biotip_counts.txt bam/SRR11648416.bam
featureCounts -T 5  --ignoreDup -p -C -B -M -t 'ncRNA_gene' --extraAttributes 'biotype' -a reference/af.gff3 -o reports/SRR11648416_FC_biotip_counts.txt bam/SRR11648416.bam
````
