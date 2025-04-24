rule generate_reference:
    output:
        fasta="results/ref.fasta"
    log:
        "logs/generate_reference.log"
    run:
        import random
        seq = ''.join(random.choices('ACGT', k=1000))
        with open(output.fasta, 'w') as f:
            f.write(">ref\n" + seq + "\n")


rule index_reference:
    input:
        "results/ref.fasta"
    output:
        "results/ref.fasta.fai"
    log:
        "logs/index_reference.log"
    wrapper:
        "v6.0.0/bio/samtools/faidx"


rule simulate_variants:
    input:
        ref="results/ref.fasta"
    output:
        vcf="results/variants.vcf"
    conda:
        "../envs/mason.yaml"
    log:
        "logs/simulate_variants.log"
    params:
        snp_rate=config["mason"]["snp_rate"],
        haplotypes=config["mason"]["haplotypes"],
        seed=config["mason"]["seed"]
    shell:
        """
        mason_variator \
            -ir {input.ref} \
            -ov {output.vcf} \
            --snp-rate {params.snp_rate} \
            --seed {params.seed} \
            -n {params.haplotypes} \
            > {log} 2>&1
        """


rule simulate_reads:
    input:
        ref="results/ref.fasta",
        vcf="results/variants.vcf"
    output:
        r1="results/reads/reads_1.fq",
        r2="results/reads/reads_2.fq"
    conda:
        "../envs/mason.yaml"
    log:
        "logs/simulate_reads.log"
    params:
        num_reads=config["mason"]["number_of_reads"],
        read_length=config["mason"]["read_length"],
    shell:
        """
        mason_simulator \
            -ir {input.ref} \
            -iv {input.vcf} \
            -n {params.num_reads} \
            --illumina-read-length {params.read_length} \
            -o {output.r1} \
            -or {output.r2} \
            > {log} 2>&1
        """
