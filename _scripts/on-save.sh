# Run On Save for Visual Studio Code (+ auto save in VSCODE)
# https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave

# list of resources
# https://stackoverflow.com/questions/14643531/changing-contents-of-a-file-through-shell-script
# https://stackoverflow.com/questions/25486667/sed-without-backup-file

#!/bin/bash
fullfilename=$1
filename=$(basename "$fullfilename")
fname="${filename%.*}"
date=$(date +"%Y-%m-%d")

# check frontmatter (update or create) 
# remove "qs" options to debug
existingFrontmatterRegex="^\-{3}\s*\n(\n|.)*?^\-{3}\s*$"
if ! pcregrep -qsM $existingFrontmatterRegex $fullfilename
then
    # check first line only (the "1" before "s")
    sed -i '' "1s/\(^.*\)/---\n---\n\1/" $fullfilename
fi

# check last-modified inside frontmatter (update or create)
lastModifiedRegex="^\-{3}\s*\n(\n|.)*?^last-modified:.*(\n|.)*?^\-{3}\s*$"
if pcregrep -qsM $lastModifiedRegex $fullfilename
then
    sed -i '' "s/last-modified:.*/last-modified: "$date"/" $fullfilename
else
    sed -i '' "1s/^--- */---\nlast-modified: "$date"/" $fullfilename
fi

# check filename pattern (update or ERROR)
fnameRegex="^[0-9]{12}.*$"
if [[ $fname =~ $fnameRegex ]]  
then
    id=$fname
    YYYY=${fname:0:4}
    MM=${fname:4:2}
    DD=${fname:6:2}
    author_id=${fname:12:${#fname}} # from position 12 to the end
else
    id="ERROR wrong filename pattern YYYYMMDDHHMMauthor_id (author_id is optional)"
    YYYY="YYYY"
    MM="MM"
    DD="DD"
fi

# check creation date inside frontmatter (update or create)
createdRegex="^\-{3}\s*\n(\n|.)*?^created:.*(\n|.)*?^\-{3}\s*$"
if pcregrep -qsM $createdRegex $fullfilename
then
    sed -i '' "s/created:.*/created: "$YYYY"-"$MM"-"$DD"/" $fullfilename
else
    sed -i '' "1s/^--- */---\ncreated: "$YYYY"-"$MM"-"$DD"/" $fullfilename
fi

# check id (= filename) inside frontmatter (update or create)
idRegex="^\-{3}\s*\n(\n|.)*?^id:.*(\n|.)*?^\-{3}\s*$"
if pcregrep -qsM $idRegex $fullfilename
then
    sed -i '' "s/id:.*/id: $id/" $fullfilename
else
    sed -i '' "1s/^--- */---\nid: $id/" $fullfilename
fi

echo "done!"

# TODO
# puc simplificar codi? es repeteix molt el update or create
# i si vull canviar metadata directament, puc modificar el filename al guardar?
# ordenar frontmatter alfabeticament?