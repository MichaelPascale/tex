#!/bin/tcsh

# Perform a mail merge on a form-letter.
# Copyright (c) 2021, Michael Pascale.

# Set a template file and a tab-separated replacements table.
set template = template.txt
set table = replacements.tsv

# Set the index of the name column.
set n = 1
set names = `tail -n+2 $table | cut -f$n`

# Extract the column names from the replacements table.
set fields = `head -n1 $table`

# Create the output directory.
mkdir -p output

# For each row in the replacement table.
@ i = `cat $table | wc -l` - 1
while ($i > 0)
    # Copy the template.
    set out = "output/$names[$i]_$template"
    cp $template $out

    # Loop through each column.
    set j = 1
    while ($j <= $#fields)

        # Read the field and its replacement.
        set field = $fields[$j]
        set values = "`tail -n+2 $table | cut -f$j`"
    
        # Replace the field with the specified value.
        sed -i "s/$field/$values[$i]/g" $out

        @ j++
    end

    @ i--
end