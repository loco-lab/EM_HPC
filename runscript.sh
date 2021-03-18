#!/bin/bash

# David Lewis
# Arizona State University
# 2021

# Set default variables
filename=${filename:-none}
numcores=${numcores:-1}
numthreads=${numthreads:-1}
numgpu=${numgpu:-0}
starttime=$(date +"%c")
outputdirdate=$(date +"%m_%d_%Y_%H_%M_%S")

# Loop over any passed parameters
while [ $# -gt 0 ]; do

  if [[ $1 == *"--"* ]]; then
    param="${1/--/}"
    # Check if parameter is valid
    if [ $param != 'filename' ] && [ $param != 'numcores' ] && [ $param != 'numthreads' ] && [ $param != 'numgpu' ]; then
        echo "Warning: Parameter $param not recognized."
    else
        declare $param=$2
        echo $1 $2
    fi
  fi
  shift
done

# Check if filename is provided
if [ $filename = 'none' ]; then
  echo "Error: no filename provided. Please input a filename with  the --filename parameter."
  exit 1
fi

outputdirbase=$(basename "$filename" .cst)

echo "Start time: $starttime"
echo "Dir base: $outputdirbase"
echo "Dir suffix: $outputdirdate"
echo "Running CST job."
echo "Filename: $filename"
echo "Cores: $numcores"
echo "Threads: $numthreads"
echo "GPU: $numgpu"

# make directory for output
# make directory for output
outputdirfull=$outputdirbase\_$outputdirdate
if [ -d 'CST_Results' ]; then
    mkdir ./CST_Results/$outputdirfull
else
    mkdir ./CST_Results
    mkdir ./CST_Results/$outputdirfull
fi
#run CST
\time -f "Program: %C\nTotal time: %E\nUser Mode (s) %U\nKernel Mode (s) %S\nCPU: %P" /opt/cst/CST_Studio_Suite_2020/cst_design_environment --m --r --num-threads $numthreads --num-cpudevices $numcores --withgpu $numgpu "$filename" | tee ./CST_Results/$outputdirfull/runlog.txt

#copy files
cp -R $outputdirbase ./CST_Results/$outputdirfull
endtime=$(date +"%c")

#output job data to summary txt file
cat >> ./CST_Results/$outputdirfull/jobdata.txt << EOL
"Start time: $starttime"
"End time: $endtime"
"Dir base: $outputdirbase"
"Dir suffix: $outputdirdate"
"Running CST job."
"Filename: $filename"
"Cores: $numcores"
"Threads: $numthreads"
"GPU: $numgpu"
EOL
