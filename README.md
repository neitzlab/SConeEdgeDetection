# An S-cone circuit for edge detection in the primate retina

 Data and code used in our recent paper on S-cone OFF midget bipolar and ganglion cells.

>Sara Patterson, James Kuchenbecker, James Anderson, Andrea Bordt, David Marshak, Maureen Neitz, Jay Neitz (2019) [An S-cone circuit for edge detection in the primate retina.][paper] *Scientific Reports*, 9, 11913.

The electrophysiology and morphology data is included, along with representative 3D reconstructions of each cell type. Other reconstructions are still involved in other unpublished projects and will be added as soon as those projects are complete. The 3D reconstructions and published figures were created in Matlab, but I've provided several alternative file formats that can be opened with free software or online (see Dependencies below for more info).
  

#### Contents:
* `em_statistics.m` - Contains raw data and analysis for all quantified morphological features: midget bipolar cell ribbon synapse counts, midget bipolar cell soma diameters, horizontal cell primary dendrite diameters and horizontal cell soma diameters.
* `em_renders.m` - Contains code to extract `.json` files and render neurons from the original annotation data through SBFSEM-tools. See info on the `.stl` and `.vtk` files below for simpler options to view the 3D reconstructions.
* `ephys_figures.m` - Extracts and plots the electrophysiology data: impulse response functions, spatial tuning curves and spike responses to S-cone isolating stimuli.
  
#### Dependencies
To build and view the 3D reconstructions as created for the published figures, you will need:
* Matlab 2015b or higher
* [SBFSEM-tools][sbfsemrepo], an open-source Matlab toolbox for connectomics visualization and analysis

Each neuron is also provided as `.stl` and `.vtk` files to provide alternatives for those without Matlab:
* The `.stl` files are the easiest option and individual files can be opened in most 3D programs (for example, 3D Paint on PCs) or even [online][viewstl].
* A 3D view software capable of opening `.vtk` files. The advantage here is viewing several neurons simultaneously. I use [Paraview][paraview].

#### More information:
* [Information][viking] on the annotation software, developed by Jamie Anderson in the Marc and Jones labs.
* [Information][sbfsemrepo] on the 3D analysis and visualization software, developed by Sara Patterson in the Neitz lab.
* Questions or comments: sarap44@uw.edu


[sbfsemrepo]: <https://github.com/sarastokes/sbfsem-tools>
[viking]: <http://connectomes.utah.edu>
[paraview]: <https://paraview.org>
[paper]: <https://www.nature.com/articles/s41598-019-48042-2>
[viewstl]: <https://viewstl.com>