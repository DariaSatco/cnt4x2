#!/bin/bash
#PBS -l nodes=1:ppn=16
#PBS -l walltime=00:05:00
#PBS -q workq

module load Compilers/Intel/psxe_2016.4 QCh/QE/6.2.0/psxe2016.4

export ESPRESSO_TMPDIR=/home/Daria.Satco/tmp/
export ESPRESSO_ROOT=/opt/frontend/QCh/espresso/6.2/psxe2016.4/
export OMP_NUM_THREADS=2
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Just an example to run QE using 4 MPI processes (NO threads) distributed among 2 compute nodes 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#=> num_nodes=2
#=> mpi_processes_per_node=2
#=> omp_threads_per_mpi_processes=1
#=> total_cores=2x2x1=4
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#cd ${PBS_O_WORKDIR}

#The parameters below are specified by hand 
QE_MPI_PN=2
QE_MPI_PT=1
QE_MODULE="pw.x"
myfile='/home/Daria.Satco/QE_calc/cnt4x2'
out_file='/home/Daria.Satco/QE_calc/cnt4x2'
#mpirun -np 16 ${ESPRESSO_ROOT}/bin/${QE_MODULE} -i $myfile/cnt42.scf.in  > $out_file/cnt42.scf.out
#echo 'scf done!'
#mpirun -np 16 ${ESPRESSO_ROOT}/bin/${QE_MODULE} -i $myfile/cnt42.nscf.in > $out_file/cnt42.nscf.out
#echo 'nscf done!'
mpirun -np 16 ${ESPRESSO_ROOT}/bin/dos.x < $myfile/cnt42.dos.in > $out_file/cnt42.dos.out
echo 'dos done!'
mpirun -np 16 ${ESPRESSO_ROOT}/bin/bands.x < $myfile/cnt42.bands.in > $out_file/cnt42.bands.out
echo 'bands done!'
#${ESPREESO_ROOT}/bin/plotband.x < cnt42.plotband
#echo 'plotband done!'

