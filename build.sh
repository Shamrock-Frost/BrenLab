#!/bin/bash

opam exec -- forester build --dev --root BSM-0001 trees/
for filename in output/*.xml; do
gawk -i inplace -F '<source-path>' '
NR <= 2 { print }
NR >  2 { 
    printf("%s", $1)
    for(i = 2; i <= NF; i++) { 
        s = substr($i, 8)
        j = index(s, "<")
        path = substr(s,1,j-1)
        after = substr(s, j)
        gsub("/","\\", path)
        printf("<source-path>C:\\%s%s", path, after)
    }
}' $filename
done

