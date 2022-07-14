FILE=inputfile
if [ -f "$FILE" ]; then
    rm "$FILE"
else 
:
fi
for n in {1..10}
do
randomNumber=$(shuf -i 1-100 -n1)
echo $n $randomNumber >> inputfile
done
awk ' {print;} NR % 1 == 0 { print "<br>"; }' inputfile > actual_inputfile 
