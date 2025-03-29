i=0  # Initialize counter

for problem in sql/*; do
    psql < "$problem"
    
    i=$((i + 1))  # Increment counter

    if [ "$i" -eq 1 ]; then
        break
    fi
done
