#!/bin/bash

#convert files to nifti/MIF

subj=@@@@
export OMP_NUM_THREADS=8

WORKDIR=~/Desktop/DTI-Analysis/BL/
SUBJDIR=${WORKDIR}/work/$subj

mkdir -p ${SUBJDIR}

cd $SUBJDIR

mrconvert ${WORKDIR}/Raw/$subj/BL/BL-DTI/DWI_REVPE_P_A_B3000_* PA.mif -strides +1,2,3,4 -force -nthreads 8

mrconvert ${WORKDIR}/Raw/$subj/BL/BL-DTI/EP2D_DIFF_MDDW_64_P2_* DWI.mif -strides +1,2,3,4 -force -nthreads 8

mrconvert ${WORKDIR}/Raw/$subj/BL/BL-DTI/T1_MPRAGE_SAG_P2_1_0_ISO_* T1.nii -strides +1,2,3 -force -nthreads 8

mrconvert ${WORKDIR}/Raw/$subj/BL/BL-DTI/T2_SPC_DA-FL_SAG_P2_1_0_* T2.nii -strides +1,2,3 -force -nthreads 8


#converting done.

#degibbs DWI images

mrdegibbs DWI.mif DWIunringed.mif -force -nthreads 8

mrdegibbs PA.mif PAunringed.mif -force -nthreads 8

#denoise DWI images

dwidenoise DWIunringed.mif DWIunringed-denoised.mif -force -nthreads 8

dwidenoise PAunringed.mif PAunringed-denoised.mif -force -nthreads 8

#extract the b0 images from the DWI sequence (AP)

dwiextract DWIunringed-denoised.mif APb0s.mif -bzero -force -nthreads 8

#distortion and eddy correction

mrcat APb0s.mif PAunringed-denoised.mif allb0s.mif -axis 3 -force -nthreads 8

dwifslpreproc DWIunringed-denoised.mif DWIunringed-denoised-undistorted-noeddycurrents.mif -rpe_pair -pe_dir AP -se_epi allb0s.mif -export_grad_mrtrix adjencoding.b -eddy_options " --repol --data_is_shelled --slm=linear " -nthreads 8 -force -eddyqc_all dwipreproc

# create mask from mean of b0s after eddy correction

dwiextract DWIunringed-denoised-undistorted-noeddycurrents.mif -nthreads 8 -bzero - | mrmath -axis 3 - mean DWIunringed-denoised-undistorted-noeddycurrents-b0.mif -force -nthreads 8

bet2 DWIunringed-denoised-undistorted-noeddycurrents-b0.mif DWIunringed-denoised-undistorted-noeddycurrents-b0-brain -m -f 0.15

#bias correction

dwibiascorrect -ants -mask DWIunringed-denoised-undistorted-noeddycurrents-b0-brain_mask.nii.gz DWIunringed-denoised-undistorted-noeddycurrents.mif DWIunringed-denoised-undistorted-noeddycurrents-biascorrected.mif -nthreads 8 -force

# calculate tensors and metrics

dwi2tensor DWIunringed-denoised-undistorted-noeddycurrents-biascorrected.mif difftensor.nii -mask DWIunringed-denoised-undistorted-noeddycurrents-b0-brain_mask.nii.gz -nthreads 8 -force

tensor2metric difftensor.nii -fa fa.nii -adc md.nii -ad ad.nii -rd rd.nii -mask DWIunringed-denoised-undistorted-noeddycurrents-b0-brain_mask.nii.gz -nthreads 8 -force


