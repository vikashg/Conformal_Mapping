
start=23697080
end_idx=23697240

for i in $(seq $start $end_idx)
do 
    qdel $i
done
