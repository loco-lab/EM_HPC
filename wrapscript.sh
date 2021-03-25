#!/bin/bash

#This script wraps around the runscript.job script to allow accounting information to be obtained after the job completes.

#run batch job. sbatch parameters set here override parameters inside the runscript.
sbatch -W runscript.job --filename test_dipole_antenna.cst --container ./containers/asucst_v0.0.2.sif

wait

#output run info to job file
jobid=$(cat jobid.txt)
echo "$jobid"
outputdirfull=$(cat outputdirfull.txt)
echo "$outputdirfull"
sacct -j $jobid --format JobID,Elapsed,AllocCPUs,AllocNodes,CPUTime,systemCPU,UserCPU,TotalCPU,MaxRSS >> ./CST_Results/$outputdirfull/jobdata.txt
rm jobid.txt
rm outputdirfull.txt

