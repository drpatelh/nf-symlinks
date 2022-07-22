#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Change this to an S3 path if using AWS
params.outdir = './results'
 
process symlink_files {
    publishDir "${params.outdir}", mode: 'copy' 

    container 'ubuntu:20.04'

    output:
    path 'original.txt'  , emit: original
    path 'softlink_1.txt', emit: softlink_1
    path 'softlink_2.txt', emit: softlink_2

    script:
    """
    echo "Supercalifragilisticexpialidocious" > original.txt
    ln -s original.txt softlink_1.txt
    ln -s original.txt softlink_2.txt
    """
}

process symlink_in_dir {
    publishDir "${params.outdir}", mode: 'copy' 

    container 'ubuntu:20.04'

    input:
    path original, stageAs: 'original_dir/*'
    path softlink_1, stageAs: 'original_dir/*'
    path softlink_2

    output:
    path 'original_dir', emit: original_dir
    
    script:
    """
    echo "Nothing to see here"
    """
}

workflow {

    symlink_files ()

    symlink_in_dir (
        symlink_files.out.original,
        symlink_files.out.softlink_1,
        symlink_files.out.softlink_2
    )

}