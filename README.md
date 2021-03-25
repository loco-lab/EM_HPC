# LOCO EM Simulation Repository

This repository is for definition files and other associated files for ASU software containers intended to be built and transferred to HPC resources.

These containers are currently built using Singularity 3.7.1.

Building these containers requires sudo privileges and a working installation of Singularity 3.7.

To build a container from the definition file, run the following command:

```shell
sudo singularity build containername.sif containername.def
```

The created container may then be run on the local machine in a shell.

```shell
singularity shell containername.sif
```

The scripts in this repo consists of two files: a runscript and a wrapper. 

The wrapper sets up the batch job with SLURM, instructing it to run with the runscript. The sbatch command in this script can be edited to pass parameters into both sbatch and CST; any parameters passed in will override the ones inside the runscript. After the job finishes, the wrapper gets information about the job using 'sacct' and appends it to the generated joboutput.txt file.

The runscript sets up an SSH connection with the license server, opens a singularity container, and runs CST with the passed-in parameters. For CST to run, the user must first edit the runscript to replace the placeholder USERNAME with a valid Enterprise username.

For SSH to properly forward the ports in a batch job, the user must first set up a valid SSH keypair if none exists. This can be done with the "ssh-keygen -t rsa" command. After the keys are made, the public key can then be moved to Enterprise using the command "ssh-copy-id USERNAME@enterprise.sese.asu.edu".

After this, the runscript will be able to automatically forward the proper ports and run as a batch job.




