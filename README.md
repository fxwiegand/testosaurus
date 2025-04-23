# testosaurus

## Overview
**testosaurus** is a minimal example workflow using simulated data to demonstrate the functionality of `predictosaurus`. It includes steps for data simulation, alignment, variant analysis, and visualization.

## Workflow Steps
1. **Simulation**:
   - Generate reference sequences and simulate variants and reads using `mason`.

2. **Alignment**:
   - Index the reference with `bwa-mem2`, align reads, and index BAM files with `samtools`.

3. **Variant Analysis**:
   - Estimate alignment properties, preprocess variants, and call variants using `varlociraptor`.

4. **Predictosaurus Analysis**:
   - Build a graph, process data, and generate HTML visualizations.

5. **Additional Visualization**:
   - Create pileup plots with `alignoth`.

## Dependencies
The workflow uses tools managed via Conda:
- `mason`, `bwa-mem2`, `samtools`, `varlociraptor`, `predictosaurus`, `alignoth`

Conda environments are defined in the `envs/` directory.

## Input Files
- `config.yaml`: Simulation parameters.
- `resources/scenarios/single.yaml`: Variant calling scenario.
- `resources/predictosaurus/features.gff`: Feature annotations.

## Output Files
- Variants: `results/variants.vcf`
- Aligned reads: `results/mapped/reads.bam`
- Observations: `results/observations/observations.vcf`
- Variant calls: `results/variant-calls/single.vcf`
- Visualizations: `results/predictosaurus/gene1.html`, `results/alignoth/pileup.html`

## Execution
Run the workflow with Snakemake:

```bash
snakemake --use-conda --cores <number_of_cores>
```