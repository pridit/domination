// by Xeno
#define THIS_FILE "x_weaponcargo_oa.sqf"
#include "x_setup.sqf"
private "_vec";

#define __awc(wtype,wcount) _vec addWeaponCargo [#wtype,wcount];
#define __amc(mtype,mcount) _vec addMagazineCargo [#mtype,mcount];

PARAMS_1(_vec);

clearMagazineCargo _vec;
clearWeaponCargo _vec;

// Weapons: Operation Arrowhead - Rifles
__awc(AK_74, 10)
__awc(AK_74_GL, 10)
__awc(AK_74_GL_kobra, 10)
__awc(AK_47_M, 10)
__awc(AK_47_S, 10)
__awc(AKS_74, 10)
__awc(AKS_74_GOSHAWK, 10)
__awc(AKS_74_kobra, 10)
__awc(AKS_74_NSPU, 10)
__awc(AKS_74_pso, 10)
__awc(AKS_74_U, 10)
__awc(FN_FAL, 10)
__awc(FN_FAL_ANPVS4, 10)
__awc(G36A_camo, 10)
__awc(G36C_camo, 10)
__awc(G36_C_SD_camo, 10)
__awc(G36K_camo, 10)
__awc(LeeEnfield, 10)
__awc(M14_EP1, 10)
__awc(M16A2, 10)
__awc(M16A2GL, 10)
__awc(M4A1, 10)
__awc(M4A3_RCO_GL_EP1, 10)
__awc(M4A3_CCO_EP1, 10)
__awc(SCAR_L_CQC_CCO_SD, 10)
__awc(SCAR_L_CQC, 10)
__awc(SCAR_L_CQC_Holo, 10)
__awc(SCAR_L_CQC_EGLM_Holo, 10)
__awc(SCAR_L_STD_EGLM_RCO, 10)
__awc(SCAR_L_STD_EGLM_TWS, 10)
__awc(SCAR_L_STD_HOLO, 10)
__awc(SCAR_L_STD_Mk4CQT, 10)
__awc(SCAR_H_CQC_CCO, 10)
__awc(SCAR_H_CQC_CCO_SD, 10)
__awc(SCAR_H_STD_EGLM_Spect, 10)
__awc(SCAR_H_LNG_Sniper, 10)
__awc(SCAR_H_LNG_Sniper_SD, 10)
__awc(SCAR_H_STD_TWS_SD, 10)
__awc(Sa58P_EP1, 10)
__awc(Sa58V_EP1, 10)
__awc(Sa58V_RCO_EP1, 10)
__awc(Sa58V_CCO_EP1, 10)

// Weapons: Operation Arrowhead - Machine Guns
__awc(MG36_camo, 10)
__awc(m240_scoped_EP1, 10)
__awc(M249_EP1, 10)
__awc(M249_m145_EP1, 10)
__awc(M249_TWS_EP1, 10)
__awc(M60A4_EP1, 10)
__awc(Mk_48_DES_EP1, 10)
__awc(PK, 10)
__awc(RPK_74, 10)

// Weapons: Operation Arrowhead - Sniper Rifles
__awc(KSVK, 10)
__awc(m107, 10)
__awc(m107_TWS_EP1, 10)
__awc(M110_NVG_EP1, 10)
__awc(M110_TWS_EP1, 10)
__awc(M24_des_EP1, 10)
__awc(SVD_des_EP1, 10)
__awc(SVD, 10)
__awc(SVD_NSPU_EP1, 10)

// Weapons: Operation Arrowhead - Pistols
__awc(glock17_EP1, 10)
__awc(Colt1911, 10)
__awc(M9, 10)
__awc(M9SD, 10)
__awc(Makarov, 10)
__awc(MakarovSD, 10)
__awc(revolver_EP1, 10)
__awc(revolver_gold_EP1, 10)
__awc(Sa61_EP1, 10)
__awc(UZI_EP1, 10)
__awc(UZI_SD_EP1, 10)

// Weapons: Operation Arrowhead - Launchers
__awc(Javelin, 10)
__awc(Stinger, 10)
__awc(Igla, 10)
__awc(M136, 10)
__awc(M47Launcher_EP1, 10)
__awc(MAAWS, 10)
__awc(MetisLauncher, 10)
__awc(RPG7V, 10)
__awc(RPG18, 10)
__awc(Strela, 10)

// Weapons: Operation Arrowhead - Grenade Launchers
__awc(Mk13_EP1, 10)
__awc(M32_EP1, 10)
__awc(M79_EP1, 10)

// Weapons: British Armed Forces
__awc(BAF_L85A2_RIS_Holo, 10)
__awc(BAF_L85A2_UGL_Holo, 10)
__awc(BAF_L85A2_RIS_SUSAT, 10)
__awc(BAF_L85A2_UGL_SUSAT, 10)
__awc(BAF_L85A2_RIS_ACOG, 10)
__awc(BAF_L85A2_UGL_ACOG, 10)
__awc(BAF_L85A2_RIS_CWS, 10)
__awc(BAF_L86A2_ACOG, 10)
__awc(BAF_L110A1_Aim, 10)
__awc(BAF_L7A2_GPMG, 10)
__awc(BAF_AS50_scoped, 10)
__awc(BAF_AS50_TWS, 10)
__awc(BAF_LRR_scoped, 10)
__awc(BAF_LRR_scoped_W, 10)
__awc(BAF_NLAW_Launcher, 10)

// Weapons: Private Military Company
__awc(AA12_PMC, 10)
__awc(m8_Carbine, 10)
__awc(m8_CarbineGL, 10)
__awc(m8_Compact, 10)
__awc(m8_Sharpshooter, 10)
__awc(m8_SAW, 10)

// Ammo: Guns
__amc(200Rnd_556x45_M249, 100)
__amc(200Rnd_556x45_L110A1, 100)
__amc(100Rnd_556x45_M249, 100)
__amc(100Rnd_556x45_BetaCMag, 100)
__amc(100Rnd_762x51_M240, 100)
__amc(100Rnd_762x54_PK, 100)
__amc(75Rnd_545x39_RPK, 100)
__amc(30Rnd_9x19_UZI, 100)
__amc(30Rnd_9x19_UZI_SD, 100)
__amc(30Rnd_545x39_AK, 100)
__amc(30Rnd_545x39_AKSD, 100)
__amc(30Rnd_556x45_Stanag, 100)
__amc(30Rnd_556x45_StanagSD, 100)
__amc(30Rnd_556x45_G36, 100)
__amc(30Rnd_556x45_G36SD, 100)
__amc(20Rnd_556x45_Stanag, 100)
__amc(30Rnd_762x39_AK47, 100)
__amc(30Rnd_762x39_SA58, 100)
__amc(30Rnd_762x39_SA58, 100)
__amc(20Rnd_762x51_B_SCAR, 100)
__amc(20Rnd_762x51_DMR, 100)
__amc(20Rnd_762x51_FNFAL, 100)
__amc(20Rnd_762x51_SB_SCAR, 100)
__amc(20Rnd_B_765x17_Ball, 100)
__amc(20Rnd_B_AA12_Pellets, 100)
__amc(20Rnd_B_AA12_74Slug, 100)
__amc(20Rnd_B_AA12_HE, 100)
__amc(17Rnd_9x19_glock17, 100)
__amc(15Rnd_9x19_M9, 100)
__amc(15Rnd_9x19_M9SD, 100)
__amc(10Rnd_127x99_m107, 100)
__amc(10Rnd_762x54_SVD, 100)
__amc(8Rnd_9x18_Makarov, 100)
__amc(8Rnd_9x18_MakarovSD, 100)
__amc(7Rnd_45ACP_1911, 100)
__amc(6Rnd_45ACP, 100)
__amc(5Rnd_86x70_L115A1, 100)
__amc(5Rnd_127x99_AS50, 100)
__amc(5Rnd_127x108_KSVK, 100)
__amc(5Rnd_762x51_M24, 100)
__amc(1Rnd_HE_GP25, 100)
__amc(10x_303, 100)

// Ammo: Launchers
__amc(Javelin, 50)
__amc(Stinger, 50)
__amc(Igla, 50)
__amc(M136, 50)
__amc(Dragon_EP1, 50)
__amc(MAAWS_HEAT, 50)
__amc(MAAWS_HEDP, 50)
__amc(AT13, 50)
__amc(PG7V, 50)
__amc(PG7VL, 50)
__amc(PG7VR, 50)
__amc(OG7, 50)
__amc(RPG18, 50)
__amc(Strela, 50)
__amc(NLAW, 50)

// Ammo: Grenade Launchers
__amc(6Rnd_HE_M203, 50)
__amc(1Rnd_HE_M203, 50)

// Ammo: Smoke Grenades
__amc(1Rnd_Smoke_GP25, 20)
__amc(1Rnd_SmokeRed_GP25, 20)
__amc(1Rnd_SmokeGreen_GP25, 20)
__amc(1Rnd_SmokeYellow_GP25, 20)
__amc(1Rnd_Smoke_M203, 50)
__amc(1Rnd_SmokeRed_M203, 50)
__amc(1Rnd_SmokeGreen_M203, 50)
__amc(1Rnd_SmokeYellow_M203, 50)

// Ammo: Flare Grenades
__amc(FlareWhite_GP25, 20)
__amc(FlareGreen_GP25, 20)
__amc(FlareRed_GP25, 20)
__amc(FlareYellow_GP25, 20)
__amc(FlareWhite_M203, 50)
__amc(FlareGreen_M203, 50)
__amc(FlareRed_M203, 50)
__amc(FlareYellow_M203, 50)

// Equipment
__awc(Laserdesignator, 5)
__awc(Binocular_Vector, 5)
__awc(NVGoggles, 5)

// Miscellaneous
__amc(HandGrenade, 50)
__amc(HandGrenade_West, 50)
__amc(HandGrenade_East, 50)
__amc(SmokeShell, 20)
__amc(SmokeShellGreen, 20)
__amc(SmokeShellYellow, 20)
__amc(SmokeShellOrange, 20)
__amc(SmokeShellPurple, 20)
__amc(SmokeShellBlue, 20)
__amc(PipeBomb, 50)
__amc(Mine, 50)
__amc(MineE, 50)
__amc(IR_Strobe_Marker, 50)
__amc(Laserbatteries, 50)