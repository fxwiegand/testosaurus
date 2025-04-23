rule bwa_mem2_index:
    input:
        ref="results/ref.fasta"
    output:
        "results/bwa_index/ref.fasta.0123",
        "results/bwa_index/ref.fasta.amb",
        "results/bwa_index/ref.fasta.ann",
        "results/bwa_index/ref.fasta.bwt.2bit.64",
        "results/bwa_index/ref.fasta.pac"
    log:
        "logs/bwa-mem2_index/ref.log"
    wrapper:
        "v6.0.0/bio/bwa-mem2/index"


rule bwa_mem2_align:
    input:
        reads=["results/reads/reads_1.fq", "results/reads/reads_2.fq"],
        idx=multiext("results/bwa_index/ref.fasta", ".amb", ".ann", ".bwt.2bit.64", ".pac", ".0123")
    output:
        "results/mapped/reads.bam"
    log:
        "logs/bwa-mem2_align/reads.log"
    params:
        extra=r"-R '@RG\tID:sample\tSM:sample'",
        sort="samtools",
        sort_order="coordinate"
    threads: 8
    wrapper:
        "v6.0.0/bio/bwa-mem2/mem"

rule samtools_index:
    input:
        "results/mapped/reads.bam"
    output:
        "results/mapped/reads.bam.bai"
    log:
        "logs/samtools/index_reads.log"
    wrapper:
        "v6.0.0/bio/samtools/index"
