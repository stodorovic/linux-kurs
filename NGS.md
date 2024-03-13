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
