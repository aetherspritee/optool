subroutine manual()
  write(*,'("	    _______________________________________________")')
  write(*,'("")')
  write(*,'("			   OPTOOL USER GUIDE")')
  write(*,'("")')
  write(*,'("	     Carsten Dominik, based on work by Michiel Min")')
  write(*,'("	    _______________________________________________")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("			 July 2020, version 1.0")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Introduction")')
  write(*,'("============")')
  write(*,'("")')
  write(*,'("  This tool allows to produce complex dust particle opacities right from")')
  write(*,'("  the command line. It is derived[1] from Michiel Min s [OpacityTool]")')
  write(*,'("  for the [DIANA] program.  optool  adds a much more flexible command")')
  write(*,'("  line interface, a curated list of built-in materials, easy access to")')
  write(*,'("  external material properties, more output options, and significant")')
  write(*,'("  speed gains.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Capabilities")')
  write(*,'("~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("  - stand-alone tool, fully command line driven, no input files need to")')
  write(*,'("    be edited")')
  write(*,'("  - flexible command line interface to specify input in a compact and")')
  write(*,'("    simple way")')
  write(*,'("  - full scattering matrix output in several formats, including for")')
  write(*,'("    RADMC-3D")')
  write(*,'("  - combining materials through mixing into a complex grain with")')
  write(*,'("    porosity")')
  write(*,'("  - DHS method to model shape effects and low-porosity aggregates")')
  write(*,'("  - a useful collection of compiled-in materials for standard")')
  write(*,'("    applications in astronomy")')
  write(*,'("  - an easy way to use external refractive index data for more")')
  write(*,'("    specialized applications")')
  write(*,'("  - multi-core support through OpenMP to make even complex computations")')
  write(*,'("    very fast")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Terms of use")')
  write(*,'("~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("   optool  is distributed under the [MIT license] and can be used,")')
  write(*,'("  changed and redistributed freely.  The implemented physics is the same")')
  write(*,'("  as in [OpacityTool]. As a reference for this tool, please point to the")')
  write(*,'("  [GitHub repository]. If you use it to publish papers, please cite the")')
  write(*,'("  papers establishing the methods used, as well as to the original")')
  write(*,'("  laboratory papers that published the refractive index measurements.")')
  write(*,'("")')
  write(*,'("  -  optool : [ https://github.com/cdominik/optool.git ]")')
  write(*,'("  - DHS model for irregular grains: [Min et al. 2005, A&A, 432, 909]")')
  write(*,'("  - DIANA standard Opacities: [Woitke, Min et al. 2016, A&A 586, 103]")')
  write(*,'("  - Third party software: [Toon et al. 1981, Applied Optics 20, 3657]")')
  write(*,'("  - References to [refractive index data] used in your particular")')
  write(*,'("    application.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Examples")')
  write(*,'("========")')
  write(*,'("")')
  write(*,'("  A simple grain made only of the default pyroxene, for the default")')
  write(*,'("  grain size distribution ($a^{-3.5}$ powerlaw from 0.05 to 3000mum), on")')
  write(*,'("  the default wavelength grid (0.05mum to 1cm).")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool pyr")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  Include the scattering matrix in the produced output")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool pyr -s")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  Reproduce the DIANA standard dust model, using a specific pyroxene")')
  write(*,'("  (70% Mg) and carbon, in a mass ratio 0.87/0.13, and with a porosity of")')
  write(*,'("  25%.")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool pyr-mg70 0.87  c 0.13  -p 0.25")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  List the built-in materials")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool -c")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  Add an ice mantle (built-in data from Warren+08) that is 20% of the")')
  write(*,'("  core mass")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool pyr-mg70 0.87  c 0.13  -m ice-w 0.2  -p 0.25")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  Like the previous example, but use ice refractive index data from a")')
  write(*,'("  separate file.")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool pyr-mg70 0.87  c 0.13  -p 0.25  -m data/ice_hudgins.dat 0.2")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  Pure ice grains in a narrow size distribution from 1 to 3 microns,")')
  write(*,'("  with 15 sample sizes following an $f(a)\propto a^{-2.5}$ powerlaw size")')
  write(*,'("  distribution. Also, restrict the wavelength range to 10-100mum, and")')
  write(*,'("  turn off DHS to get perfect spheres.")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool ice  -a 1 3 2.5 15  -l 10 100 -fmax 0")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  For silicon carbide, compute the opacity of a single grains size")')
  write(*,'("  (2.5mum) at lambda=8.9mum.")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool -a 2.5 -l 8.9 sic")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  Represent the default dust model (DIANA, you also get this when you do")')
  write(*,'("  not give any materials at all) in 42 grain sizes, and produce input")')
  write(*,'("  files for RADMC-3D, one for each grain size, with full scattering")')
  write(*,'("  matrix, chopping 3 degrees from the scattering peak.")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool -na 42 -d -s -radmc -chop 3")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  Use the Bruggeman rule to blend refractive index data of three")')
  write(*,'("  orientations of a crystaline material, using the wavelength grid given")')
  write(*,'("  in one of those files. Output to  blended.lnk .")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | optool -b gra_x.lnk 0.33 gra_y.lnk 0.33 gra_z.lnk 0.33 -l gra_x.lnk")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Compiling  optool ")')
  write(*,'("==================")')
  write(*,'("")')
  write(*,'("  On most systems, you can download and compile  optool  with these")')
  write(*,'("  simple steps, using the freely available GNU FORTRAN compiler")')
  write(*,'("  [ gfortran ].")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | git clone https://github.com/cdominik/optool.git")')
  write(*,'("  | cd optool")')
  write(*,'("  | make")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  The executable is called  optool , and you should put it on your")')
  write(*,'("  execution path.  To use the [Intel fortran compiler], to use multiple")')
  write(*,'("  cores[2] for speed, or to be able to write FITS files[3], use one or")')
  write(*,'("  more of the following parameters during compilation:")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | make ifort=true        # use the Intel fortran compiler iFort")')
  write(*,'("  | make multi=true        # enable multicore support")')
  write(*,'("  | make  fits=true        # add support for writing FITS files")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  You can also find binaries for Mac and Linux at [my homepage].")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("command line arguments")')
  write(*,'("======================")')
  write(*,'("")')
  write(*,'("   -h   ")')
  write(*,'("        Show a compact help message about command line options.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Grain composition and geometry")')
  write(*,'("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("   -c ")')
  write(*,'("        List available built-in materials (the keys for the *-c* and")')
  write(*,'("        *-m* options).")')
  write(*,'("")')
  write(*,'("   [-c] KEY-or-FILE1 [MFRAC] ")')
  write(*,'("          Specify a material to include in the grain.   KEYorFILE  can")')
  write(*,'("        be the [key for a builtin material], or the path to the correct")')
  write(*,'("         lnk  file.  MFRAC  is the /mass/ fraction (default 1.0) of the")')
  write(*,'("        material. You can give up to 10 materials to build up the grain.")')
  write(*,'("        Mass fractions do not have to add up to one, they will be")')
  write(*,'("        renormalized.  All materials will be mixed together using the")')
  write(*,'("        /Bruggeman/ rule, and vacuum can be added through the")')
  write(*,'("        porosity. A *-c* switch before each  KEY-or-FILE  is optional.")')
  write(*,'("")')
  write(*,'("   -m KEY-or-FILE [MFRAC] ")')
  write(*,'("          Like *-c*, but use this material as grain mantle that will be")')
  write(*,'("        added using the /Maxwell-Garnett/ rule.  Only one *-m* switch is")')
  write(*,'("        allowed.")')
  write(*,'("")')
  write(*,'("   -p POROSITY [P_MANTLE] ")')
  write(*,'("          Porosity, the /volume/ fraction of vacuum, a number smaller")')
  write(*,'("        than 1.  The default is 0.  A single value will apply to both")')
  write(*,'("        core and mantle, but a second value will be specific for the")')
  write(*,'("        mantle (and may be 0).")')
  write(*,'("")')
  write(*,'("   -fmax VHMAX ")')
  write(*,'("          Maximum /volume/ fraction of the inner hole for the DHS")')
  write(*,'("        approach.  The default is 0.8.  Zero means to use solid spheres,")')
  write(*,'("        i.e. perfectly regular grains.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Grain size distribution")')
  write(*,'("~~~~~~~~~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("   -a AMIN [AMAX [APOW [NA]]] ")')
  write(*,'("          Specify (minimum) grain radius, and optionally maximum grain")')
  write(*,'("        radius, the size distribution powerlaw and the number of size")')
  write(*,'("        bins.  You may also use options to set individual values with")')
  write(*,'("        *-amin*, *-amax*, *-apow*, *-na*. The defaults are 0.05 mum,")')
  write(*,'("        3000 mum, 3.5, and /10 per size decade with a fixed minimum of")')
  write(*,'("        5/, respectively.  If only a single size is specified with *-a*,")')
  write(*,'("        then a_max=a_min and n_a=1 are implied.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Wavelength grid")')
  write(*,'("~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("   -l LMIN [LMAX [NLAM]] ")')
  write(*,'("          Specifiy the (minimum) wavelength, and optionally the maximum")')
  write(*,'("        wavelength and the number of wavelengths points for the")')
  write(*,'("        construction of the wavelength grid.  The default values are")')
  write(*,'("        0.05 mum, 10000 mum, and 300, respectively.  You may also use")')
  write(*,'("        the options *-lmin*, *-lmax*, and *-nlam* (or *-nl*) to set")')
  write(*,'("        individual values.  If only one wavelength is specified with")')
  write(*,'("        *-l*, then lambda_max=lambda_min and n_lambda=1 are implied.")')
  write(*,'("")')
  write(*,'("   -l FILE ")')
  write(*,'("          Read the wavelength grid from  FILE .  The file may start with")')
  write(*,'("        comment lines, and the first non-comment line needs to contain")')
  write(*,'("        the number of wavelength values in the data block below it. In")')
  write(*,'("        the data block, the first column is expected to hold the")')
  write(*,'("        wavelength values, in mum. For example, an [ lnk ] file could be")')
  write(*,'("        used here.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Controlling the output")')
  write(*,'("~~~~~~~~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("  The standard output is the file  dustkappa.dat , with the opacities")')
  write(*,'("  and the asymmetry parameter /g/. The following options control and")')
  write(*,'("  extend the [output].")')
  write(*,'("")')
  write(*,'("   -o [DIR] ")')
  write(*,'("          Put the output files in directory  DIR  instead of the current")')
  write(*,'("        working directory.  ./output  will be used if  DIR  is not")')
  write(*,'("        specified.")')
  write(*,'("")')
  write(*,'("   -s [NANG] ")')
  write(*,'("          Include the full scattering matrix in the output.  NANG  can")')
  write(*,'("        optionally specify the number of equally-spaced [angular grid")')
  write(*,'("        points] to cover the range of angles between 0 and 180 degrees.")')
  write(*,'("        The default for  NANG  is 180 and should normally not be")')
  write(*,'("        changed.")')
  write(*,'("")')
  write(*,'("   -chop [NDEG] ")')
  write(*,'("          Cut out the first  NDEG  (2 if unspecified) degrees of the")')
  write(*,'("        [forward scattering peak] and compensate by a reduction in the")')
  write(*,'("        scattering cross section.")')
  write(*,'("")')
  write(*,'("   -d [NSUB] ")')
  write(*,'("          Divide the computation up into  NA  parts to produce a file")')
  write(*,'("        for each grain size.  Each size will actually be an average over")')
  write(*,'("        a small range of  NSUB  grains around the real size, to smear")')
  write(*,'("        out resonances.  The default for  NSUB  is 5.")')
  write(*,'("")')
  write(*,'("   -fits ")')
  write(*,'("          Write  dustkappa.fits  with the absorption cross sections and")')
  write(*,'("        scattering matrix elements, instead of ASCII output.  With the")')
  write(*,'("         -d  switch,  NA  files will be written.")')
  write(*,'("")')
  write(*,'("   -radmc [LABEL] ")')
  write(*,'("          RADMC-3D uses a different angular grid and normalization for")')
  write(*,'("        the [scattering matrix], so the output has to be adapted for it.")')
  write(*,'("        The extension of the files will be changed to  .inp , and if you")')
  write(*,'("        specify  LABEL , it will be used in the file name(s).")')
  write(*,'("")')
  write(*,'("   -t [TMIN [TMAX [NT]]] ")')
  write(*,'("          Compute mean opacities per g of dust mass, kappa_Planck and")')
  write(*,'("        kappa_Rosseland, in the given temperature interval, in  nt ")')
  write(*,'("        logarithmic steps, with output to  dustkapmean.dat . The")')
  write(*,'("        parameters default to 10K, 10000K, and 200, respectively.")')
  write(*,'("")')
  write(*,'("   -b ")')
  write(*,'("          Only write the refractive index data resulting the mixing")')
  write(*,'("        process to  blended.lnk .")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Material properties")')
  write(*,'("===================")')
  write(*,'("")')
  write(*,'("   optool  needs refractive index data to work.  For your convenience, a")')
  write(*,'("  useful list of materials is compiled into  optool , but you can also")')
  write(*,'("  find and use other data.  No matter where the data is from, you should")')
  write(*,'("  /always/ cite the original laboratory papers.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Built-in materials")')
  write(*,'("~~~~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("  To access one of the built-in materials, specify the corresponding key")')
  write(*,'("  string like  pyr-mg70  instead of the path to an  lnk  file. In each")')
  write(*,'("  material class I have selected a useful default, accessible with an")')
  write(*,'("  even simpler generic key.")')
  write(*,'("")')
  write(*,'("  -c Key    -c Key      Material                 State      rho   Reference    ")')
  write(*,'(" generic   full key                                      g/cm^3                ")')
  write(*,'("-------------------------------------------------------------------------------")')
  write(*,'("           pyr-mg100   MgSiO_3                  amorph     2.71  [Dorschner+95]")')
  write(*,'("           pyr-mg95    Mg_0.95  Fe_0.05  SiO_3  amorph     2.74  [Dorschner+95]")')
  write(*,'("           pyr-mg80    Mg_0.8  Fe_0.2  SiO_3    amorph      2.9  [Dorschner+95]")')
  write(*,'(" pyr       pyr-mg70    Mg_0.7  Fe_0.3  SiO_3    amorph     3.01  [Dorschner+95]")')
  write(*,'("           pyr-mg60    Mg_0.6  Fe_0.4  SiO_3    amorph      3.1  [Dorschner+95]")')
  write(*,'("           pyr-mg50    Mg_0.5  Fe_0.5  SiO_3    amorph      3.2  [Dorschner+95]")')
  write(*,'("           pyr-mg40    Mg_0.4  Fe_0.6  SiO_3    amorph      3.3  [Dorschner+95]")')
  write(*,'(" ens       pyr-c-mg96  Mg_0.96  Fe_0.04  SiO3   cryst       2.8  [Jäger+98]   ")')
  write(*,'("-------------------------------------------------------------------------------")')
  write(*,'(" ol        ol-mg50     MgFeSiO_4                amorph     3.71  [Dorschner+95]")')
  write(*,'("           ol-mg40     Mg_0.8 Fe_1.2 SiO_4      amorph     3.71  [Dorschner+95]")')
  write(*,'(" for       ol-c-mg100  Mg_2 SiO_4               cryst      3.33  [Steyer+74]   ")')
  write(*,'("-------------------------------------------------------------------------------")')
  write(*,'(" c         c-z         C                        amorph?     1.8  [Zubko+96]    ")')
  write(*,'("           c-p         C                        amorph      1.8  [Preibisch+93]")')
  write(*,'(" gra       c-gra       C graphite               cryst     2.16?  uncertain     ")')
  write(*,'("           c-org       CHON organics            amorph      1.4  uncertain     ")')
  write(*,'("           c-nano      C nano-diamond           cryst       2.3  [Mutschke+04] ")')
  write(*,'("-------------------------------------------------------------------------------")')
  write(*,'(" ice       ice-w       Water ice                cryst      0.92  [Warren+08]   ")')
  write(*,'("-------------------------------------------------------------------------------")')
  write(*,'(" iron      fe-c        Fe                       metal      7.87  [Henning+96]  ")')
  write(*,'("           fes         FeS                      metal      4.83  [Henning+96]  ")')
  write(*,'("           sic         SiC                      cryst      3.22  [Laor93]      ")')
  write(*,'("-------------------------------------------------------------------------------")')
  write(*,'(" cor       cor-c       Al_2  O_3                cryst       4.0  [Koike+95]    ")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("External refractory index files ( lnk  files)")')
  write(*,'("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("   optool  can use external refractive index data in files with the")')
  write(*,'("  following format:")')
  write(*,'("  - The file may start with several comment lines (lines starting with")')
  write(*,'("     ! ,  # , or  * ).")')
  write(*,'("  - The next line contains two numbers, the number of wavelengths")')
  write(*,'("    $N_\lambda$ and the specific weight rho of the material in g/cm^3")')
  write(*,'("  - Then follow three columns of data: lambda[mum], and the real and")')
  write(*,'("    imaginary parts of the refractive index, $n$ and $k$.")')
  write(*,'("")')
  write(*,'("  You can find refractive index data in the [Jena database], and")')
  write(*,'("  associated with original papers in the literature. Don t forget to add")')
  write(*,'("  the line with $N_\lambda$ and rho!  If for some reason it is not")')
  write(*,'("  convenient to add that line to the file,  optool  will count the lines")')
  write(*,'("  for you and you can specify the density after the mass fraction, like")')
  write(*,'("  this:  optool -c path/to/file.lnk 0.7 3.42 ")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Output files")')
  write(*,'("============")')
  write(*,'("")')
  write(*,'("  dustkappa.dat")')
  write(*,'("          This is an ASCII file containing the basic opacity results. It")')
  write(*,'("        starts with a comment section describing the dust model,")')
  write(*,'("        followed by the format number (3, currently), followed by the")')
  write(*,'("        number of wavelengths in the grid, both on lines by themselves.")')
  write(*,'("        Then follows a block with these columns:")')
  write(*,'("")')
  write(*,'("        1. wavelength lambda [micron]")')
  write(*,'("        2. mass absorption cross section kappa_abs [cm^2/g]")')
  write(*,'("        3. mass scattering cross section kappa_sca [cm^2/g]")')
  write(*,'("        4. asymmetry parameter /g/")')
  write(*,'("")')
  write(*,'("  dustkapscatmat.dat")')
  write(*,'("          ASCII file with cross sections and full scattering matrix.")')
  write(*,'("        The comment section at the start of the file explains the")')
  write(*,'("        structure. See [the appendix] for information about the")')
  write(*,'("        normalization of the scattering matrix.  And see the  -radmc ")')
  write(*,'("        switch which will modify the output to make sure it can be used")')
  write(*,'("        as an input file for [RADMC-3D].")')
  write(*,'("")')
  write(*,'("  dustkappa.fits")')
  write(*,'("          The FITS-file (ending in ’.fits’) is written instead of the")')
  write(*,'("        ASCII output when using the  -fits  switch. It has two HDU")')
  write(*,'("        blocks. The first block contains the cross sections per unit")')
  write(*,'("        mass. This is a N_lambda * 4 matrix with these columns:")')
  write(*,'("")')
  write(*,'("        1. wavelengths in [mum]")')
  write(*,'("        2. mass extinction cross section kappa_ext in [cm^2/g]")')
  write(*,'("        3. mass absorption cross section kappa_abs in [cm^2/g]")')
  write(*,'("        4. mass scattering cross section kappa_sca in [cm^2/g]")')
  write(*,'("")')
  write(*,'("        The second HDU block contains the scattering matrix elements. It")')
  write(*,'("        is a N_lambda * 6 * N_ang matrix, containing the 6 elements of")')
  write(*,'("        the scattering matrix for N_ang equidistant scattering angles")')
  write(*,'("        from forward scattering (element 0) to backward scattering")')
  write(*,'("        (element N_ang-1), for each wavelength value. The stored matrix")')
  write(*,'("        elements are F_11, F_12, F_22, F_33, F_34, and F_44.")')
  write(*,'("")')
  write(*,'("  dustkapmean.dat")')
  write(*,'("          This file will only be written with the  -t  switch. It")')
  write(*,'("        contains 3 columns: (1) T [K], (2) kappa_Planck, (3) kappa_Ross,")')
  write(*,'("        both in cm^2 per gram of /dust/. Note that dust evaporation is")')
  write(*,'("        not considered, and that a wide wavelengths coverage is needed")')
  write(*,'("        for good results.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Inspecting the computed optical properties")')
  write(*,'("==========================================")')
  write(*,'("")')
  write(*,'("  To try out  optool  you could use one of these commands")')
  write(*,'("")')
  write(*,'("  ,----")')
  write(*,'("  | make test             # for a simple size-integrated opacity computation")')
  write(*,'("  |     ... or ...")')
  write(*,'("  | make testdiv          # for opacities as a function of grain size")')
  write(*,'("   ----")')
  write(*,'("")')
  write(*,'("  [./misc/inspect.png]")')
  write(*,'("")')
  write(*,'("  The commands will run  optool  with the standard DIANA material")')
  write(*,'("  properties, and then use the python script  optool_plot.py  to plot")')
  write(*,'("  the computed opacities.  You will get:")')
  write(*,'("  - a plot showing the opacities kappa_abs, kappa_sca, and kappa_ext as")')
  write(*,'("    a function of wavelength, along with the asymmetry parameter /g/.")')
  write(*,'("    Note that the red /g/ curve does not have its own scale, imagine the")')
  write(*,'("    /y/ axis going from 0 to 1 for /g/.")')
  write(*,'("  - a plot showing the scattering matrix elements as a function of")')
  write(*,'("    scattering angle, and with sliders to go through grain sizes and")')
  write(*,'("    wavelengths.  The /y/ axis of the plot is actually log_10(|F_ij|),")')
  write(*,'("    so the downward peaks are actually places where the matrix element")')
  write(*,'("    goes through zero.")')
  write(*,'("")')
  write(*,'("  If you want to run the plotter yourself,  ipython -i")')
  write(*,'("  path/to/optool_plot.py  is the correct command to do so, from the")')
  write(*,'("  directory where the output files are located.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Acknowledgments")')
  write(*,'("===============")')
  write(*,'("")')
  write(*,'("  - [Michiel Min] for the [DIANA OpacityTool] and all the incredible")')
  write(*,'("    work that went into it.  optool  is a direct derivative of that tool")')
  write(*,'("    and reuses almost all of its code.")')
  write(*,'("  - [Charléne Lefévre] for [SIGMA], which triggered me to add a grain")')
  write(*,'("    mantle using the Maxwell Garnett rule.")')
  write(*,'("  - [Kees Dullemond] for his python plotting routine  viewarr ")')
  write(*,'("    ([available on github]), and code for computing Planck and Rosseland")')
  write(*,'("    means opacities.")')
  write(*,'("  - [Jeroen Bouwman] for some pointers to refractive index data.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Appendix")')
  write(*,'("========")')
  write(*,'("")')
  write(*,'("Units")')
  write(*,'("~~~~~")')
  write(*,'("")')
  write(*,'("  Due to conventions in our field, the input and output of  optool  uses")')
  write(*,'("  the following units")')
  write(*,'("  - *microns* for grain sizes and wavelengths")')
  write(*,'("  - *g/cm^3* for mass densities of materials")')
  write(*,'("  - *cm^2 g^-1* for opacities kappa_abs, kappa_sca, and kappa_ext")')
  write(*,'("  - *sr^-1* or *cm^2 g^-1 sr^-1* for the scattering matrix elements, see")')
  write(*,'("    below.")')
  write(*,'("  - *Kelvin* for temperatures")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Scattering Matrix: The fine print")')
  write(*,'("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("Phase function normalization")')
  write(*,'("----------------------------")')
  write(*,'("")')
  write(*,'("  A number of different normalizations for the scattering matrix are")')
  write(*,'("  being used in the literature and in computational tools. The")')
  write(*,'("  differences are significant, and it is important to be aware of the")')
  write(*,'("  choice. For  optool  we are using a convention in which the average")')
  write(*,'("  over all directions of the 1-1 element of the scattering matrix equals")')
  write(*,'("  unity, i.e.")')
  write(*,'("")')
  write(*,'("  \begin{equation}")')
  write(*,'("  \label{eq:1}")')
  write(*,'("  \oint_{(4\pi)} F_{11}(\lambda,\Theta) d\Omega = 4\pi")')
  write(*,'("  \end{equation}")')
  write(*,'("")')
  write(*,'("  See [Hovenier (2004)] for a discussion of this normalization.")')
  write(*,'("   optool  can also produce output for [RADMC-3D] which uses a different")')
  write(*,'("  normalization, namely")')
  write(*,'("")')
  write(*,'("  \begin{equation}")')
  write(*,'("  \label{eq:2}")')
  write(*,'("  \oint_{(4\pi)} Z_{11}(\lambda,\Theta) d\Omega = \kappa_{\rm sca}(\lambda)")')
  write(*,'("  \end{equation}")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Forward-scattering peak")')
  write(*,'("-----------------------")')
  write(*,'("")')
  write(*,'("  Particles that are much larger than the wavelength of the considered")')
  write(*,'("  radiation can show extreme forward scattering, to an extend that a")')
  write(*,'("  very significant fraction of the /scattered/ radiation is sent into")')
  write(*,'("  just a few degrees around the forward direction (scattering angle")')
  write(*,'("  zero).  This can be difficult to handle for radiative transfer codes")')
  write(*,'("  which have limited angular resolution or limited sampling.  Some codes")')
  write(*,'("  have an internal way to deal with this. [MCMax3D], for example, has")')
  write(*,'("  the  nspike  keyword to deal with this issue. Others, like RADMC-3D")')
  write(*,'("  require this to be taken care of by the process that creates the")')
  write(*,'("  opacity files.  This is the purpose of the  -chop  switch in")')
  write(*,'("   optool . It specifies a number of degrees (for example 3 might be a")')
  write(*,'("  good value) around the forward scattering direction. Inside that cone,")')
  write(*,'("  the scattering matrix gets limited to the value at the edge of the")')
  write(*,'("  cone.  To compensate and ensure energy conservation, the scattering")')
  write(*,'("  cross section will be reduced accordingly, and, depending on the")')
  write(*,'("  chosen normalization, the scattering matrix itself may also have to be")')
  write(*,'("  scaled.  As a result, the radiation that would be /scattered/ into")')
  write(*,'("  this narrow range of angles will be treated as if it did have /no")')
  write(*,'("  interaction at all/ with the grain.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Angular grid")')
  write(*,'("------------")')
  write(*,'("")')
  write(*,'("   optool  uses an angular grid in one degree steps from 0 to 180")')
  write(*,'("  degrees.  The full degrees are the cell /interfaces/ of that")')
  write(*,'("  grid.  optool  computes the scattering matrix at the cell /midpoints/,")')
  write(*,'("  i.e. at 0.5degree, 1.5degree etc to 179.5degree, for a total of 180")')
  write(*,'("  values.  The scattering matrix is normalized in this way, so that a")')
  write(*,'("  numerical integral gives the correct result.")')
  write(*,'("")')
  write(*,'("  However, if you are using  optool  to produce scattering cross")')
  write(*,'("  sections of RADMC-3D, the conventions are different.  RADMC-3D")')
  write(*,'("  requires the values of the scattering matrix on the cell /boundaries/,")')
  write(*,'("  so at 0degree, 1degree etc to 180degree, for a total of 181 values.")')
  write(*,'("  For the input files for RADMC-3D, we interpolate and extend the")')
  write(*,'("  computed values to the cell boundaries.  With strongly")')
  write(*,'("  forward-scattering grains, this does require a small renormalization")')
  write(*,'("  to make sure the the full solid angle integration gives again accurate")')
  write(*,'("  results.  optool  is handling this renormalization fully")')
  write(*,'("  automatically.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("How to ingest refractive index data for another material")')
  write(*,'("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")')
  write(*,'("")')
  write(*,'("  Additional refractive index data tables can be compiled into the code.")')
  write(*,'("  Here is how:")')
  write(*,'("")')
  write(*,'("  1. Give your  lnk  file a name exactly like")')
  write(*,'("      pyr-mg70-Dorschner1995.lnk , where  pyr-mg70  is the key to access")')
  write(*,'("     the material and  Dorschner1995  (the text after the final  - ) is")')
  write(*,'("     the reference.")')
  write(*,'("  2. Put this file into the  lnk_data  directory.")')
  write(*,'("  3. Optionally edit  lnk_data/lnk-help.txt , so that  optool -c ?  will")')
  write(*,'("     list the new material.  Note that, in order to define generic keys,")')
  write(*,'("     optool looks for pairs like  genkey -> fullkey  in this file.")')
  write(*,'("  4. Run  make ingest  to update  ref_ind.f90 , now including your new")')
  write(*,'("     material.")')
  write(*,'("  5. Recompile and install the code.")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("Bibliography")')
  write(*,'("============")')
  write(*,'("")')
  write(*,'("  - Dorschner, J. et al. 1995, A&A 300, 503")')
  write(*,'("  - Henning, Th. and Stognienko, R. 1996, A&A 311,291")')
  write(*,'("  - Hovenier, J, 2004, [Report available on ADS].")')
  write(*,'("  - Jäger, C. et al. 1998, A&A 339, 904")')
  write(*,'("  - Koike, C. et al. 1995, Icarus 114, 203")')
  write(*,'("  - Laor, A. and Draine, B., ApJ 402, 441")')
  write(*,'("  - Lefèvre, C.; Min,M. et al. 2020, A&A (submitted)")')
  write(*,'("  - Min, M. et al. 2005, A&A, 432, 909")')
  write(*,'("  - Min, M. et al. 2016, A&A, 585, 13")')
  write(*,'("  - Mutschke, H. et al. 2004, A&A 423, 983")')
  write(*,'("  - Toon, O. & Ackerman,T. 1981, Applied Optics 20, 3657")')
  write(*,'("  - Woitke, P.; Min, M. et al. 2016, A&A 586, 103")')
  write(*,'("  - Preibisch, Th. et al. 1993, A&A 279, 577")')
  write(*,'("  - Steyer, T. 1974, PhD Thesis, The University of Arizona")')
  write(*,'("  - Warren, S. and Brandt,R. 2008, JGRD,113, D14220")')
  write(*,'("  - Zubko, V. et al. 1996, MNRAS 282,1321")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
  write(*,'("")')
end subroutine manual
