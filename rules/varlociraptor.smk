rule varlociraptor_alignment_properties:
    input:
        ref="results/ref.fasta",
        ref_idx="results/ref.fasta.fai",
        alignments="results/mapped/reads.bam",
        aln_idx="results/mapped/reads.bam.bai",
    output:
        "results/alignment-properties/reads.json",
    log:
        "logs/varlociraptor/alignment-properties/reads.log",
    wrapper:
        "v6.0.0/bio/varlociraptor/estimate-alignment-properties"

rule varlociraptor_preprocess:
    input:
        ref="results/ref.fasta",
        alignment_properties="results/alignment-properties/reads.json",
        alignments="results/mapped/reads.bam",
        candidate_variants="results/variants.vcf",
    output:
        "results/observations/observations.bcf",
    log:
        "logs/varlociraptor/preprocess/reads.log",
    wrapper:
        "v6.0.0/bio/varlociraptor/preprocess-variants"

rule varlociraptor_call:
    input:
        observations=["results/observations/observations.bcf"],
        scenario="resources/scenarios/single.yaml",
    output:
        "results/variant-calls/single.bcf",
    log:
        "logs/varlociraptor/call-variants/single.log",
    params:
        samples=["sample"],
    wrapper:
        "v6.0.0/bio/varlociraptor/call-variants"


rule bcf_view_sample_file:
    input:
        "{prefix}.bcf",
    output:
        "{prefix}.vcf",
    log:
        "logs/{prefix}.vcf.log",
    wrapper:
        "v6.0.0/bio/bcftools/view"
