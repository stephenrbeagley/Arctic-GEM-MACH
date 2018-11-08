SHELL = /bin/sh

INCLUDE_DIR=../CHEMLIB/$(ARCH)
FC          = s.compile

FFLAGS_Linux_x86-64/pgi9xx = -O 2   -openmp -includes $(INCLUDE_DIR)
FFLAGS_AIX-powerpc7        = -O 2   -openmp -includes $(INCLUDE_DIR)

FFLAGS_DEBUG_AIX-powerpc7        = "-debug -defines="-DDEBUG_OUTPUT" -includes $(INCLUDE_DIR) -openmp -optf=\"-qcheck -qflttrap=zero:imp:ov:und:inv:en -qhalt=w -qlinedebug -qxflag=dvz\""
FFLAGS_DEBUG_Linux_x86-64/pgi9xx  = "-O 0 -debug -defines="-DDEBUG_OUTPUT" -includes $(INCLUDE_DIR) -openmp -optf=\"-C -Kieee -Ktrap=align -Ktrap=denorm -Ktrap=divz -Ktrap=fp -Ktrap=inv -Ktrap=ovf -Ktrap=unf\""

NBJOBS_Linux_x86-64/pgi9xx = 8
NBJOBS_AIX-powerpc7        =16


LIBNAME     = libgemmach.a
LIBARCHIVE  = ../CHEMLIB/$(ARCH)


.PHONY: clean distclean debug

.SUFFIXES: $(SUFFIXES) .ftn90

# Modules and interface: must be compiled first!
# Also, chm_utils_mod must be compiled first in the modules, since it is included by some other modules
.FMODULES = 	chm_utils_mod.ftn90 \
		chm_headers_mod.ftn90 \
                chm_mie_data_mod.ftn90 \
		chm_nml_mod.ftn90 \
		chm_consphychm_mod.ftn90 \
		chm_species_info_mod.ftn90 \
		chm_mjrpts_lnklst_mod.ftn90 \
		chm_mjrpts_species_idx_mod.ftn90 \
		chm_mjrpts_sortinfo_mod.ftn90 \
		chm_species_idx_mod.ftn90 \
		chm_datime_mod.ftn90 \
		chm_ptopo_grid_mod.ftn90 \
		chm_buses_mod.ftn90 \
		chm_phyvar_mod.ftn90 \
		mach_aurams_headers_mod.ftn90 \
		mach_cam_headers_mod.ftn90 \
		mach_headers_mod.ftn90 \
		mach_cam_utils_mod.ftn90 \
		mach_incld_headers_mod.ftn90 \
		mach_incld_mod.ftn90 \
		mach_hetv_headers_mod.ftn90 \
		mach_pkg_adom2_mod.ftn90 \
		mach_pkg_cam2bins_mod.ftn90 \
		mach_pkg_cam12bins_mod.ftn90 \
		mach_pkg_misc_mod.ftn90 \
		mach_pkg_debug_mod.ftn90 \
		mach_gas_chemicbi_mod.ftn90 \
		mach_gas_drydep_mod.ftn90 \
		mach_gas_headers_mod.ftn90 \
		mach_cam_pre_mod.ftn90


.FFILES = 	chm_emis_assignfld.ftn90 \
		chm_debu.ftn90 \
		chm_emis_file_inquire.ftn90 \
		chm_exe.ftn90 \
		chm_fst_closefile.ftn90 \
		chm_fst_openfile.ftn90 \
		chm_fst_splitname.ftn90 \
		chm_gesdict.ftn90 \
		chm_emis_getbmf.ftn90 \
		chm_getbus.ftn90 \
		chm_getphybus_struct.ftn90 \
		chm_inctphychm.ftn90 \
		chm_ini.ftn90 \
		chm_load_emissions.ftn90 \
		chm_mjrpts_assign_fld.ftn90 \
		chm_mjrpts_fstread.ftn90 \
		chm_mjrpts_get_emissions.ftn90 \
		chm_mjrpts_get_llnode.ftn90 \
		chm_mjrpts_get_stkinfo.ftn90 \
		chm_mjrpts_mask.ftn90 \
		chm_mjrpts_printlist.ftn90 \
		chm_mjrpts_proc.ftn90 \
		chm_mjrpts_rearrange.ftn90 \
		chm_mjrpts_translate.ftn90 \
		chm_mjrpts_trim.ftn90 \
		chm_mjrpts_xref_sortlist.ftn90 \
		chm_pkg_fields_init.ftn90 \
		chm_plumerise_prep.ftn90 \
		chm_put2perbus.ftn90 \
		chm_q_sort.ftn90 \
		chm_read_nml.ftn90 \
		chm_splitst.ftn90 \
		chm_stop.ftn90 \
		mach_aurams_calpres.ftn90 \
		mach_aurams_cldcv2d.ftn90 \
		mach_aurams_cwc_per_bin.ftn90 \
		mach_aurams_prntrow.ftn90 \
		mach_aurams_tsysms.ftn90 \
                mach_bin_number.ftn90 \
		mach_biog_emissions.ftn90 \
		mach_biog_main.ftn90 \
		mach_biog_parcalc.ftn90 \
		mach_calc_season.ftn90 \
		mach_cam_aeroact.ftn90 \
		mach_cam_aerocld.ftn90 \
		mach_cam_aeroprop.ftn90 \
		mach_cam_cas.ftn90 \
		mach_pm_chem.ftn90 \
		mach_cam_coagd.ftn90 \
		mach_cam_condsoa.ftn90 \
		mach_cam_drydepo.ftn90 \
		mach_cam_drypar.ftn90 \
                mach_cam_flux.ftn90 \
                mach_cam_gasdepflux.ftn90 \
                mach_gasdepflux.ftn90 \
		mach_cam_intrsec_inner.ftn90 \
		mach_cam_intrsec1_inner.ftn90 \
		mach_cam_intrsec1_outer.ftn90 \
		mach_cam_intrsec_outer.ftn90 \
		mach_cam_pre.ftn90 \
		mach_cam_rain.ftn90 \
		mach_cam_scaveng.ftn90 \
		mach_cam_sfss.ftn90 \
		mach_cam_sulfate.ftn90 \
		mach_cam_tenddist.ftn90 \
		mach_cam_main.ftn90 \
		mach_diff_boundary.ftn90 \
		mach_diff_flux.ftn90 \
		mach_diffusion.ftn90 \
                mach_emit_col.ftn90 \
		mach_gas_chemi.ftn90 \
		mach_gas_drive.ftn90 \
		mach_gas_drydep_main.ftn90 \
		mach_gas_drydep_solver.ftn90 \
		mach_gas_drydep_stat.ftn90 \
		mach_gas_jcorr.ftn90 \
		mach_gas_main.ftn90 \
		mach_gas_soa_yield.ftn90 \
		mach_gas_uprate.ftn90 \
		mach_hetv_activity.ftn90 \
		mach_hetv_case1.ftn90 \
		mach_hetv_case10.ftn90 \
		mach_hetv_case11.ftn90 \
		mach_hetv_case12.ftn90 \
		mach_hetv_case2.ftn90 \
		mach_hetv_case3.ftn90 \
		mach_hetv_case4.ftn90 \
		mach_hetv_case5.ftn90 \
		mach_hetv_case6.ftn90 \
		mach_hetv_case7.ftn90 \
		mach_hetv_case8.ftn90 \
		mach_hetv_case9.ftn90 \
		mach_hetv_corrhno3.ftn90 \
		mach_hetv_hetchem.ftn90 \
		mach_hetv_hetvcall.ftn90 \
		mach_hetv_main.ftn90 \
		mach_hetv_poly3v.ftn90 \
		mach_hetv_rebin.ftn90 \
		mach_hetv_water.ftn90 \
		mach_incld_concmp.ftn90 \
		mach_incld_diffun.ftn90 \
		mach_incld_dochem.ftn90 \
		mach_incld_fff.ftn90 \
		mach_incld_findh.ftn90 \
		mach_incld_fn_dtnew.ftn90 \
		mach_incld_funeq.ftn90 \
		mach_incld_main.ftn90 \
		mach_incld_intrqf.ftn90 \
		mach_incld_intsca_il.ftn90 \
		mach_incld_rates.ftn90 \
		mach_incld_shift3d_aero.ftn90 \
		mach_incld_soleq.ftn90 \
		mach_incld_steady.ftn90 \
		mach_incld_steady1.ftn90 \
		mach_incld_upaqr.ftn90 \
		mach_incld_upaqr1.ftn90 \
		mach_incld_upaqr2.ftn90 \
		mach_input_check.ftn90 \
		mach_landuse.ftn90 \
		mach_main.ftn90 \
		mach_maketend.ftn90 \
		mach_output.ftn90 \
                mach_perm_transfer.ftn90 \
		mach_plumerise.ftn90 \
		mach_plumerise_apply.ftn90 \
		mach_plumerise_weight.ftn90 \
                mach_plumerise_weight4fire.ftn90 \
                mach_sat_zero.ftn90 \
                mach_transfer_col.ftn90 \
		mach_tridiag.ftn90 \
		mach_updatdyn.ftn90


.OFILES  = $(.FFILES:.ftn90=.o)

.OMODULES = $(.FMODULES:.ftn90=.o)

.ftn90.o:
	$(FC) $(FFLAGS_$(BASE_ARCH)) -src $<

all: ${.OMODULES} $(.OFILES)
	$(MAKE) lib

fast:
	$(MAKE) $(.OMODULES)
	$(MAKE) -k -j $(NBJOBS_$(BASE_ARCH)) $(.OFILES)
	$(MAKE) lib

debugfast:
	$(MAKE) FFLAGS_$(BASE_ARCH)=$(FFLAGS_DEBUG_$(BASE_ARCH)) $(.OMODULES)
	$(MAKE) -k -j $(NBJOBS_$(BASE_ARCH)) FFLAGS_$(BASE_ARCH)=$(FFLAGS_DEBUG_$(BASE_ARCH)) $(.OFILES)
	$(MAKE) lib

debug:
	$(MAKE) FFLAGS_$(BASE_ARCH)=$(FFLAGS_DEBUG_$(ARCH)) all

lib:
	ar rv $(LIBNAME) ${.OMODULES} $(.OFILES); \
	mkdir -p $(LIBARCHIVE)/ ; \
	cp $(LIBNAME) $(LIBARCHIVE)/ ; \
	cp *.mod $(LIBARCHIVE)/ ;

distclean: clean
	rm -fr $(MOD) *~ *.a $(LIBARCHIVE)/*

clean:
	rm -fr *.o *.f90 .fo gmon.out $(MOD)*.c $(MOD)*.o *.mod rii_files
