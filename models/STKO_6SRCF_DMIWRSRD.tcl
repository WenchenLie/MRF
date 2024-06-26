# --------------------------------------------------------------------------------
# -------------------------------- STKO_templete ---------------------------------
# -------------------- Generated by: MRFHelper (Version 1.2) ---------------------
# --------------------------------------------------------------------------------


wipe all;
model basic -ndm 2 -ndf 3;

# Basic model variables
set maxRunTime 600.0;  # $$$
set EQ 1;  # $$$
set PO 0;  # $$$
set ShowAnimation 1;  # $$$
set MPCO 0;  # $$$

# Ground motion information
set MainFolder "H:/MRF_results/test/4SMRF";  # $$$
set GMname "th5";  # $$$
set SubFolder "th5";  # $$$
set GMdt 0.01;  # $$$
set GMpoints 5590;  # $$$
set GMduration 55.89;  # $$$
set FVduration 30;  # $$$
set EqSF 5.0;  # $$$
set GMFile "F:/MRF/GMs/$GMname.th";  # $$$
set subroutines "F:/MRF/subroutines";  # $$$
set temp "F:/MRF/temp";  # $$$

# Sourcing subroutines
cd $subroutines;
source DisplayModel3D.tcl;
source DisplayPlane.tcl;
source Spring_Zero.tcl;
source Spring_Rigid.tcl;
source PanelZone.tcl
source BeamHinge.tcl
source ColumnHinge.tcl
source TimeHistorySolver.tcl;
source PushoverAnalysis.tcl;

# Results folders
file mkdir $MainFolder;
file mkdir $MainFolder/$SubFolder;



# TODO ------------------------- Import STKO files -------------------------------

cd "F:/MRF/models/6SRCF_DMIW_STKOfiles"
# Import nodes
source nodes.tcl;
# Import materials
source materials.tcl;
# Import sections
source sections.tcl;
# Import elements
source elements.tcl;
# Write constraints from analysis_steps.tcl
fix 72 1 1 1
fix 60 1 1 1
fix 69 1 1 1
fix 71 1 1 1
equalDOF 6 5   1
equalDOF 26 7   1
equalDOF 26 8   1
equalDOF 31 14   1
equalDOF 31 15   1
equalDOF 6 17   1
equalDOF 49 20   1
equalDOF 26 25   1
equalDOF 31 34   1
equalDOF 62 41   1
equalDOF 62 42   1
equalDOF 49 47   1
equalDOF 49 50   1
equalDOF 62 57   1
equalDOF 75 73   1
equalDOF 75 74   1
equalDOF 75 76   1
# Building information
set NStory 6;
set NBay 3;
set HBuilding 24300.0;
set story_heights [list 4300 4000 4000 4000 4000 4000];
# Write control node of each floor
set MF_FloorNodes [list 62 31 26 6 49 75];
set base_nodes [list 60 72 69 71]
# Columns or walls tag
# set shear_ele(1) [list 177 213 201 206]
set shear_ele(1) [list 177 213 201 206 1001 2001 3001 4001]
set shear_ele(2) [list 171 180 121 186]
set shear_ele(3) [list 98 90 42 35]
set shear_ele(4) [list 67 68 17 25]
set shear_ele(5) [list 167 70 5 44]
set shear_ele(6) [list 157 178 138 146]
# Story masses
set story_mass [list 82.16 87.258 87.258 89.538 89.538 90.618]
# RSRD material
# uniaxialMaterial SteelMPF 1000 28.e6 28.e6 4100.e6 0.017 0.017 20.0 0.83 0.15 0.089 1 0.089 1;
uniaxialMaterial UVCuniaxial 999 3409.21 8.73 12.25 1.09 0 1 2 359.02 812.36 598.9 143.37;
uniaxialMaterial Parallel 1000 999 -factors 4e6;
uniaxialMaterial MinMax 1001 1000 -min -0.1 -max 0.1;
uniaxialMaterial Elastic 99999 1.e13;
# Fuse link (W16x67)
set I_link 397084780.0;
set A_link 12645.136;
set E 206000.0;
set d 1000.0;  # distance from RSRD pin to floor line
node 1011 0.0     $d; node 1012 0.0     $d; node 1013 0.0     [expr 4300.0 - $d]; node 1014 0.0     [expr 4300.0 - $d];  # Axis 1
node 1021 6000.0  $d; node 1022 6000.0  $d; node 1023 6000.0  [expr 4300.0 - $d]; node 1024 6000.0  [expr 4300.0 - $d];  # Axis 2
node 1031 9000.0  $d; node 1032 9000.0  $d; node 1033 9000.0  [expr 4300.0 - $d]; node 1034 9000.0  [expr 4300.0 - $d];  # Axis 3
node 1041 15000.0 $d; node 1042 15000.0 $d; node 1043 15000.0 [expr 4300.0 - $d]; node 1044 15000.0 [expr 4300.0 - $d];  # Axis 4
geomTransf PDelta 1000
# Axis 1
element elasticBeamColumn 1001 60 1011 $A_link $E $I_link 1000;
element zeroLength 1002 1011 1012 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 1003 1012 1013 $A_link $E $I_link 1000;
element zeroLength 1004 1013 1014 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 1005 1014 57 $A_link $E $I_link 1000;
recorder Element -file $MainFolder/$SubFolder/RSRD_1B.out -ele 1002 material 3 stressStrain; 
recorder Element -file $MainFolder/$SubFolder/RSRD_1T.out -ele 1004 material 3 stressStrain; 
# Axis 2
element elasticBeamColumn 2001 72 1021 $A_link $E $I_link 1000;
element zeroLength 2002 1021 1022 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 2003 1022 1023 $A_link $E $I_link 1000;
element zeroLength 2004 1023 1024 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 2005 1024 62 $A_link $E $I_link 1000;
recorder Element -file $MainFolder/$SubFolder/RSRD_2B.out -ele 2002 material 3 stressStrain; 
recorder Element -file $MainFolder/$SubFolder/RSRD_2T.out -ele 2004 material 3 stressStrain; 
# Axis 3
element elasticBeamColumn 3001 69 1031 $A_link $E $I_link 1000;
element zeroLength 3002 1031 1032 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 3003 1032 1033 $A_link $E $I_link 1000;
element zeroLength 3004 1033 1034 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 3005 1034 41 $A_link $E $I_link 1000;
recorder Element -file $MainFolder/$SubFolder/RSRD_3B.out -ele 3002 material 3 stressStrain; 
recorder Element -file $MainFolder/$SubFolder/RSRD_3T.out -ele 3004 material 3 stressStrain; 
# Axis 4
element elasticBeamColumn 4001 71 1041 $A_link $E $I_link 1000;
element zeroLength 4002 1041 1042 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 4003 1042 1043 $A_link $E $I_link 1000;
element zeroLength 4004 1043 1044 -mat 99999 99999 1001 -dir 1 2 3;
element elasticBeamColumn 4005 1044 42 $A_link $E $I_link 1000;
recorder Element -file $MainFolder/$SubFolder/RSRD_4B.out -ele 4002 material 3 stressStrain; 
recorder Element -file $MainFolder/$SubFolder/RSRD_4T.out -ele 4004 material 3 stressStrain; 


cd $subroutines;
# ---------------------------------- Recorders -----------------------------------

# Time
recorder Node -file $MainFolder/$SubFolder/Time.out -time -node [lindex $base_nodes 0] -dof 1 disp;

# Support reactions
set idx 1;
foreach tag $base_nodes {
    recorder Node -file $MainFolder/$SubFolder/Support$idx.out -node $tag -dof 1 2 3 reaction;
    incr idx
}

# Story drift ratio
for {set idx 0} {$idx < $NStory} {incr idx} {
    if {$idx == 0} {set tag_b [lindex $base_nodes 0]} else {set tag_b [lindex $MF_FloorNodes [expr $idx - 1]]}
    set tag_t [lindex $MF_FloorNodes $idx]
    recorder Drift -file $MainFolder/$SubFolder/SDR[expr $idx + 1].out -iNode $tag_b -jNode $tag_t -dof 1 -perpDirn 2;
}
recorder Drift -file $MainFolder/$SubFolder/SDR_Roof.out -iNode [lindex $base_nodes 0] -jNode [lindex $MF_FloorNodes [expr [llength $MF_FloorNodes] - 1]] -dof 1 -perpDirn 2;

# Floor acceleration
recorder Node -file $MainFolder/$SubFolder/RFA1.out -node [lindex $base_nodes 0] -dof 1 accel;
for {set idx 0} {$idx < $NStory} {incr idx} {
    recorder Node -file $MainFolder/$SubFolder/RFA[expr $idx + 2].out -node [lindex $MF_FloorNodes $idx] -dof 1 accel;
}

# Floor velocity
recorder Node -file $MainFolder/$SubFolder/RFV1.out -node [lindex $base_nodes 0] -dof 1 vel;
for {set idx 0} {$idx < $NStory} {incr idx} {
    recorder Node -file $MainFolder/$SubFolder/RFV[expr $idx + 2].out -node [lindex $MF_FloorNodes $idx] -dof 1 vel;
}

# Floor displacement
recorder Node -file $MainFolder/$SubFolder/Disp1.out -node [lindex $base_nodes 0] -dof 1 disp;
for {set idx 0} {$idx < $NStory} {incr idx} {
    recorder Node -file $MainFolder/$SubFolder/Disp[expr $idx + 2].out -node [lindex $MF_FloorNodes $idx] -dof 1 disp;
}

# Shear forces
for {set idx 0} {$idx < $NStory} {incr idx} {
    set j 1;
    foreach tag $shear_ele([expr $idx + 1]) {
        recorder Element -file $MainFolder/$SubFolder/Shear[expr $idx + 1]_$j.out -ele $tag force;
        incr j;
    }
}

# MPCO recorder
if {$MPCO == 1} {
    recorder mpco $MainFolder$SubFolder/result.mpco -N displacement acceleration modesOfVibration -E material.stress material.strain;
}


# -------------------------------- Eigen analysis --------------------------------

set pi [expr 2.0*asin(1.0)];
set nEigen $NStory
set lambdaN [eigen [expr $nEigen]];
for {set idx 0} {$idx < $NStory} {incr idx} {
    set lambda([expr $idx + 1]) [lindex $lambdaN $idx]
    set w([expr $idx + 1]) [expr pow($lambda([expr $idx + 1]), 0.5)]
    set T([expr $idx + 1]) [expr round(2.0*$pi/$w([expr $idx + 1]) *1000.)/1000.];
}
puts "T1 = $T(1) s";
puts "T2 = $T(2) s";
puts "T3 = $T(3) s";

set mode [list]
for {set i 1} {$i <= $NStory} {incr i} {
    foreach tag $MF_FloorNodes {
        lappend mode [expr [nodeEigenvector $tag $i 1]]
    }
    set file_mode [open "$MainFolder/$SubFolder/mode$i.out" w]
    foreach val $mode {puts $file_mode $val}
    close $file_mode
    if {$i == 1} {set mode_list $mode}
    set mode [list]
};

set file_T [open "$MainFolder/$SubFolder/Period.out" w];
for {set idx 1} {$idx <= $NStory} {incr idx} {
    puts $file_T $T($idx);
}
close $file_T;


# --------------------------- Static gravity analysis ----------------------------

pattern Plain 100 Linear {

    # TODO Write gravity load from analysis_steps.tcl
	load 42 0.0 -242400.0 0.0
	load 57 0.0 -242400.0 0.0
	load 41 0.0 -273700.0 0.0
	load 62 0.0 -273700.0 0.0
	load 14 0.0 -231200.0 0.0
	load 34 0.0 -231200.0 0.0
	load 15 0.0 -257600.0 0.0
	load 31 0.0 -257600.0 0.0
	load 8 0.0 -243000.0 0.0
	load 25 0.0 -243000.0 0.0
	load 7 0.0 -274400.0 0.0
	load 26 0.0 -274400.0 0.0
	load 5 0.0 -233800.0 0.0
	load 17 0.0 -233800.0 0.0
	load 3 0.0 -263700.0 0.0
	load 6 0.0 -263700.0 0.0
	load 47 0.0 -240100.0 0.0
	load 50 0.0 -240100.0 0.0
	load 20 0.0 -272300.0 0.0
	load 49 0.0 -272300.0 0.0
	load 74 0.0 -197900.0 0.0
	load 76 0.0 -197900.0 0.0
	load 73 0.0 -267500.0 0.0
	load 75 0.0 -267500.0 0.0

}

wipeAnalysis
constraints Plain;
numberer RCM;
system BandGeneral;
test NormDispIncr 1.0e-5 60;
algorithm Newton;
integrator LoadControl 0.1;
analysis Static;
analyze 10;
loadConst -time 0.0;


# ---------------------------- Time history analysis -----------------------------

if {$ShowAnimation == 1} {DisplayModel3D DeformedShape 5.00 100 100 1000 1500};

if {$EQ == 1} {

    # Rayleigh damping
    set zeta 0.05;
    set a0 [expr $zeta*2.0*$w(1)*$w(3)/($w(1) + $w(3))];
    set a1 [expr $zeta*2.0/($w(1) + $w(3))];
    rayleigh $a0 0.0 $a1 0.0;

    # Ground motion acceleration file input
    set g 9810.0;
    set AccelSeries "Series -dt $GMdt -filePath $GMFile -factor [expr $EqSF * $g]";
    pattern UniformExcitation 200 1 -accel $AccelSeries;
    set totTime [expr $GMduration + $FVduration];
    set CollapseDrift 0.1;
    set MaxAnalysisDrift 0.5;
    set result [TimeHistorySolver $GMdt $GMduration $story_heights $MF_FloorNodes $CollapseDrift $MaxAnalysisDrift $GMname $maxRunTime $temp];
    set status [lindex $result 0];
    set controlled_time [lindex $result 1];
    puts "Running status: $status";
    puts "Controlled time: $controlled_time";

}


# ------------------------------ Pushover analysis -------------------------------

if {$PO == 1} {

    pattern Plain 222 Linear {
        for {set idx 0} {$idx < $NStory} {incr idx} {
            set m [lindex $story_mass $idx]
            set F [expr $m * [lindex $mode_list $idx]]
            load [lindex $MF_FloorNodes $idx] $F 0.0 0.0
        }
    };
    set CtrlNode [lindex $MF_FloorNodes [expr [llength $MF_FloorNodes] - 1]];
    set maxRoofDrift 0.1;  # $$$
    set Dmax [expr $maxRoofDrift * $HBuilding];
    set Dincr [expr 0.5];
    set result [PushoverAnalysis $CtrlNode $Dmax $Dincr $maxRunTime];
    set status [lindex $result 0];
    set roofDisp [lindex $result 1];
    puts "Running status: $status";
    puts "Roof displacement: $roofDisp";
    puts "Roof drift ratio: [expr $roofDisp / $HBuilding]";

}
set CollapseDrift 0.1;  # $$$
wipe all;
