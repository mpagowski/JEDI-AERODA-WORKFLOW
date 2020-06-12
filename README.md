# workflow-aeroDA
# JEDI-AERODA-WORKFLOW
# JEDI-AERODA-WORKFLOW
This document describes the steps of setting-up and running the workflow on Hera machine 
--- Bo Huang (bo.huang@noaa.gov)
--- June 12 2020

(1) Prepare IC for the first cycle during the model spin-up
	(1.1) /scratch1/BMC/gsd-fv3-dev/MAPP_2018/common/share-BoHuang/getGFSIC/
	(1.2) This script grabs GFS control and ensemble analysis files at $CDATE (e.g., 2015121000 in your experiment) cycle from HPSS, and converts them to ${CASE_HIGH} for the control and ${CASE_ENKF} for the ensemble. These converted files will be six tiles at NETCDF format and will be used to initialize a cold-start run.
	(1.3) Given the analysis time, GFS analysis files are located at different pans/directories on HPSS. It is specified inside the script. This script shall be able to detect the location automatically based on ${CDATE}. As for the ensemble analysis files, their name convention starts with either sanl* or siganl* that vary with the analysis time. Please take a look at the files first and modify accordingly in the script if needed.

(2) Prepare GFS control and ensemble analysis files at NEMS format for Met increment calculation in the model spin-up and DA cycling
	(2.1) /scratch1/BMC/gsd-fv3-dev/MAPP_2018/common/share-BoHuang/grabGFSAna
	(2.2) This script downloads GFS control and ensemble analysis files at NEMS format from HPSS. These files will be first converted to NETCDF format in (3) and used for Met increment calculation during the model spin-up and DA cycling.
	(2.3) As mentioned in (1.3), their location on HPSS varies with the analysis time. Refer to the script in (1.4) for their location at a particular ${CDATE} and change $oldexp and $hpssTop in the scripts here accordingly. The ensemble analysis files have different name conventions as well at different analysis time (e.g., sanl* versus siganl*). Please take a look first and modify accordingly in the scripts.

(3) Convert GFS NEMS-format analysis in (2) to NETCDF
	(3.1) /scratch1/BMC/gsd-fv3-dev/MAPP_2018/common/share-BoHuang/GFSNEMS2NC

(4) Workflow for model spin-up and DA cycling
	(4.1) dr-work-modis in this current directory for assimilation of MODIS AOD obs from aqua and terra satellites.
	(4.2) dr-work-modis dirctory  contains a rococo xml file (jedi-3denvar-aeroDA-modis.xml) and general configuration files (config.*).
		(4.2.a) To set up your own running directory, ${PSLOT}, ${TOPRUNDIR} need to be defined in *.xml file.
		(4.2.b) In the beginning of *.xml file, it defines the cycling period and the directory for observations, model, etc.
		(4.2.c) The following of the *.xml file defeine the step-by-step tasks including 
			(c1)  gdasprepmet and gdasensprepmet: prepare control and ensemble  met variables from GFS analyses in (2);
			(c2)  gdasprepchem: prepare emission files for later forecast;
			(c3)  gdascalcinc and gdasenscalcinc: calculate the control and ensemble analysis met increment;
			(c4)  gdasanal and gdaseupd: perform envar and enkf aerosol update;
			(c5)  gdasemeananl: calculate ensemble mean of aerosol analysis;
			(c6)  gdashxaodanl: calculate AOD hofx of control and ensemble mean aerosol analysis;
			(c7)  seasbinda2fcst: change the sea salt bin orders from the GOCART model (e.g., analysis files) to FV3 model (e.g., backgorund files) for the following background forecast;
			(c8)  gdasfcst and gdasefmn: run control and ensemble background forecasts;
			(c9)  gdasemean: calculate background ensembl emean;
                        (c10) seasbinfcst2da: change the sea salt bin orders from FV3 model to  the GOCART model to FV3 for the 3denvar and enkf update in next cycle;
			(c11) gdashxaod: calculate AOD hofx of control and ensemble aerosol background.
			(c12) cleandata: clean up unnecessary data and backup necessary data to HPSS.

		(4.2.d) To configure your own experiment, some parameters in config.base and config.anal (or more config.* files) in this directory need to be modified (e.g. ensemble size=40 instead of 20 in our running).
		(4.2.e) After ${PSLOT}, ${TOPRUNDIR} are defined in (4.2.a), create the directory accordingly and copy dr-work-modis directory as ${TOPRUNDIR}/${PSLOT}/dr-work.  
		(4.2.f) Create ${TOPRUNDIR}/${PSLOT}/dr-data, and copy the initial conditions from (1) there. This direcotyr will be used to store the data from the cycling. 
		(4.2.g) About rococo job submission, please refer to the following website (https://github.com/christopherwharrop/rocoto/wiki/Documentation )
	(4.3) The required scirpts for cycling are stored in /ush, scripts and the link of required executables are at /exec
	(4.4) To run free-forecast or spin-up without DA (e.g.,2015121000-2015123118), the same workflow applies by turning off gdasanal,gdaseupd, gdasemeananl, gdashxaodanl, seasbinda2fcst, seasbinfcst2da and gdashxaod, and modifying the dependency accordingly. 
