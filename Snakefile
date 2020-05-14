rule fastqc:
    input:
        "inputs/{sample}.fastq.gz"
    output:
        "outputs/fastqc_outputs/{sample}_fastqc.html"
    conda:
        "envs/environment.yaml"
    shell:
        "fastqc {input} -o ./outputs/fastqc_outputs/"

rule multiqc:
    input:
        "outputs/fastqc_outputs/"
    output:
        "outputs/multiqc_outputs/multiqc_report.html"
    conda:
        "envs/environment.yaml"
    shell:
        "multiqc outputs/fastqc_outputs -o outputs/multiqc_outputs"

rule bbduk:
    input:
        "inputs/{sample}.fastq.gz"
    output:
        "outputs/bbduk_outputs/{sample}_trimmed.fastq.gz"
    conda:
        "envs/environment.yaml"
    shell:
        "bbduk.sh in={input} out={output} ref=inputs/adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo qtrim=r trimq=10"

rule fastqc_trimmed:
    input:
        "outputs/bbduk_outputs/{sample}.fastq.gz"
    output:
        "outputs/fastqc_trim_outputs/{sample}_fastqc.html"
    conda:
        "envs/environment.yaml"
    shell:
        "fastqc {input} -o ./outputs/fastqc_trim_outputs/"

rule multiqc_trim:
    input:
        "outputs/fastqc_trim_outputs/"
    output:
        "outputs/multiqc_trim_outputs/multiqc_report.html"
    conda:
        "envs/environment.yaml"
    shell:
        "multiqc outputs/fastqc_trim_outputs -o outputs/multiqc_trim_outputs"
