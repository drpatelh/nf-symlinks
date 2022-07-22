# nf-symlinks

POC repo to test NF behaviour with symlinks

Change the `--outdir` parameter to an S3 path if using AWS (default: `./results`).

## Running locally

```
$ nextflow run main.nf

N E X T F L O W  ~  version 22.04.3
Launching `main.nf` [festering_kalman] DSL2 - revision: e08b4abc40
executor >  local (2)
[b3/ab067b] process > symlink_files  [100%] 1 of 1 ✔
[6b/ec94c4] process > symlink_in_dir [100%] 1 of 1 ✔
```

```
$ tree work results

work
├── 6b
│   └── ec94c4ceb7a251b88853c73c271f43
│       ├── original_dir
│       │   ├── original.txt -> nf-symlinks/work/b3/ab067b1878f834ffb1255045191f92/original.txt
│       │   └── softlink_1.txt -> nf-symlinks/work/b3/ab067b1878f834ffb1255045191f92/original.txt
│       └── softlink_2.txt -> nf-symlinks/work/b3/ab067b1878f834ffb1255045191f92/original.txt
└── b3
    └── ab067b1878f834ffb1255045191f92
        ├── original.txt
        ├── softlink_1.txt -> original.txt
        └── softlink_2.txt -> original.txt
results
├── original.txt
├── original_dir
│   ├── original.txt
│   └── softlink_1.txt
├── softlink_1.txt
└── softlink_2.txt
```
