rule predictosaurus_build:
    input:
        calls="results/variant-calls/single.bcf",
        observations="results/observations/observations.bcf"
    output:
        graph="results/predictosaurus/graph.duckdb"
    log:
        "logs/predictosaurus/build.log"
    params:
        mpp=config["predictosaurus"]["min-prob-present"],
    conda:
        "../envs/predictosaurus.yaml"
    shell:
        "predictosaurus build --calls {input.calls} "
        "--observations sample={input.observations} "
        "--min-prob-present {params.mpp} "
        "--output {output.graph} -v > {log} 2>&1"


rule predictosaurus_process:
    input:
        features=workflow.source_path("../resources/predictosaurus/features.gff"),
        reference="results/ref.fasta",
        graph="results/predictosaurus/graph.duckdb"
    output:
        paths="results/predictosaurus/paths.duckdb"
    log:
        "logs/predictosaurus/process.log"
    conda:
        "../envs/predictosaurus.yaml"
    shell:
        "predictosaurus process --features {input.features} "
        "--reference {input.reference} "
        "--graph {input.graph} "
        "--output {output.paths} -v > {log} 2>&1"


rule predictosaurus_plot:
    input:
        paths="results/predictosaurus/paths.duckdb"
    output:
        tsv="results/predictosaurus/scores.tsv"
    log:
        "logs/predictosaurus/plot.log"
    conda:
        "../envs/predictosaurus.yaml"
    shell:
        "predictosaurus plot --input {input.paths} "
        "--output {output.tsv} -v > {log} 2>&1"
