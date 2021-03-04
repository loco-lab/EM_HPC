#LOCO EM Simulation Repository

This repository is for definition files and other associated files for ASU software containers intended to be built and transferred to HPC resources.

These containers are currently built using Singularity 3.7.1.

Building these containers requires sudo privileges and a working installation of Singularity 3.7.

To build a container from the definition file, run the following command:

'''shell
sudo singularity build containername.sif containername.def
'''

The created container may then be run on the local machine in a shell.

'''shell
singularity shell containername.sif
'''
