configfile: "config.yaml"

include: "rules/simulate.smk"
include: "rules/align.smk",
include: "rules/varlociraptor.smk"
include: "rules/predictosaurus.smk"
include: "rules/alignoth.smk"

rule all:
    input:
        "results/variants.vcf",
        "results/mapped/reads.bam",
        "results/predictosaurus/gene1.html",
        "results/observations/observations.vcf",
        "results/variant-calls/single.vcf",
        "results/alignoth/pileup.html",
