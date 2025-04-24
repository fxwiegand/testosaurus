rule alignoth_plot:
    input:
        bam="results/mapped/reads.bam",
        bam_index="results/mapped/reads.bam.bai",
        ref="results/ref.fasta"
    output:
        html="results/alignoth/pileup.html"
    log:
        "logs/alignoth/alignoth.log"
    conda:
        "../envs/alignoth.yaml"
    shell:
        """
        alignoth -b {input.bam} -r {input.ref} -g ref:1-1000 --html > {output.html} 2> {log}
        """
