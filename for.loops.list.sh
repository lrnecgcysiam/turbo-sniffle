

for n in {0..85};
do
    echo "document.getElementById("orientation_1_Alphabetized").getElementsByClassName("categoryLabel")[$n].textContent.replaceAll(" ","").replaceAll("\n","");"
done
