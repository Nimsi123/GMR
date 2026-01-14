#!/bin/bash

# Parallel retargeting script for tt4d_mixtape_genmo files
# Runs up to 10 processes in parallel

INPUT_DIR=~/GMR/demo_data/tt4d_mixtape_genmo
OUTPUT_DIR=~/GMR/retargeted_demo_data/tt4d_mixtape_genmo

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Maximum number of parallel jobs
MAX_JOBS=10

# Counter for running jobs
job_count=0

# Array to track PIDs
pids=()

# Function to wait for a slot to become available
wait_for_slot() {
    while [ ${#pids[@]} -ge $MAX_JOBS ]; do
        # Check each PID and remove completed ones
        new_pids=()
        for pid in "${pids[@]}"; do
            if kill -0 "$pid" 2>/dev/null; then
                new_pids+=("$pid")
            fi
        done
        pids=("${new_pids[@]}")
        
        # If still at max, sleep briefly
        if [ ${#pids[@]} -ge $MAX_JOBS ]; then
            sleep 1
        fi
    done
}

# Loop over all .pt files in the input directory
for pt_file in "$INPUT_DIR"/*.pt; do
    # Skip if no files match
    [ -e "$pt_file" ] || continue
    
    # Get the base filename without path
    filename=$(basename "$pt_file")
    # Replace .pt with .pkl for output
    output_filename="${filename%.pt}.pkl"
    output_path="$OUTPUT_DIR/$output_filename"
    
    # Wait for a slot to become available
    wait_for_slot
    
    echo "Starting retargeting: $filename"
    
    # Run the retargeting script in background
    MUJOCO_GL=egl python scripts/gvhmr_to_robot.py \
        --gvhmr_pred_file "$pt_file" \
        --robot unitree_g1 \
        --record_video \
        --headless \
        --save_path "$output_path" &
    
    # Store the PID
    pids+=($!)
done

# Wait for all remaining jobs to complete
echo "Waiting for remaining jobs to complete..."
for pid in "${pids[@]}"; do
    wait "$pid"
done

echo "All retargeting jobs completed!"

