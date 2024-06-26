# --------------------------------------------------------------------------------
# -------------------------------- STKO_templete ---------------------------------
# ----------------------- Generated by: STKO (Version 2.0) -----------------------
# --------------------------------------------------------------------------------



wipe all;
model basic -ndm 2 -ndf 3;

# Basic model variables
set maxRunTime 600.0;  # $$$
set analysis_type "TH";  # $$$
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
set EqSF 2.0;  # $$$
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
source CyclicPushover.tcl;

# Results folders
file mkdir $MainFolder;
file mkdir $MainFolder/$SubFolder;



# TODO ------------------------- Import STKO files -------------------------------

cd "F:/MRF/models/6SRCF_TMIW_STKOfiles"
# Import nodes
source nodes.tcl;
# Import materials
source materials.tcl;
# Import sections
source sections.tcl;
# Import elements
source elements.tcl;
# Write constraints from analysis_steps.tcl
fix 17 1 1 1
fix 27 1 1 1
fix 28 1 1 1
fix 22 1 1 1
equalDOF 14 1   1
equalDOF 19 2   1
equalDOF 12 3   1
equalDOF 19 4   1
equalDOF 24 5   1
equalDOF 23 6   1
equalDOF 14 7   1
equalDOF 23 8   1
equalDOF 12 9   1
equalDOF 11 10   1
equalDOF 24 13   1
equalDOF 14 15   1
equalDOF 19 16   1
equalDOF 12 18   1
equalDOF 24 20   1
equalDOF 11 21   1
equalDOF 23 25   1
equalDOF 11 26   1
# Building information
set NStory 6;
set NBay 3;
set HBuilding 24300.0;
set story_heights [list 4300 4000 4000 4000 4000 4000];
# Write control node of each floor
set MF_FloorNodes [list 11 12 14 19 24 23];
set base_nodes [list 22 17 27 28]
# Columns or walls tag
set shear_ele(1) [list 120 82 227 232]
set shear_ele(2) [list 115 55 46 216 207 209 208 211]
set shear_ele(3) [list 110 66 135 2 212 204 210 200]
set shear_ele(4) [list 77 166 125 7 202 201 203 1]
set shear_ele(5) [list 99 161 130 12 214 198 215 197]
set shear_ele(6) [list 186 181 144 17 205 213 206 199]
# Story masses
set story_mass [list 83.61 82.53 82.53 80.23 80.23 82.16]




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
	load 16 0.0 242400.0 0.0
	load 27 0.0 242400.0 0.0
	load 15 0.0 -273700.0 0.0
	load 17 0.0 -273700.0 0.0
	load 11 0.0 -231200.0 0.0
	load 26 0.0 -231200.0 0.0
	load 4 0.0 -257600.0 0.0
	load 10 0.0 -257600.0 0.0
	load 6 0.0 -243000.0 0.0
	load 22 0.0 -243000.0 0.0
	load 1 0.0 -274400.0 0.0
	load 5 0.0 -274400.0 0.0
	load 13 0.0 -233800.0 0.0
	load 23 0.0 -233800.0 0.0
	load 2 0.0 -263700.0 0.0
	load 12 0.0 -263700.0 0.0
	load 19 0.0 -240100.0 0.0
	load 20 0.0 -240100.0 0.0
	load 3 0.0 -272300.0 0.0
	load 14 0.0 -272300.0 0.0
	load 9 0.0 -197900.0 0.0
	load 24 0.0 -197900.0 0.0
	load 7 0.0 -267500.0 0.0
	load 8 0.0 -267500.0 0.0

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

if {$analysis_type == "TH"} {

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
    set CollapseDrift 0.1;  # $$$
    set MaxAnalysisDrift 0.5;
    set result [TimeHistorySolver $GMdt $totTime $story_heights $MF_FloorNodes $CollapseDrift $MaxAnalysisDrift $GMname $maxRunTime $temp];
    set status [lindex $result 0];
    set controlled_time [lindex $result 1];
    puts "Running status: $status";
    puts "Controlled time: $controlled_time";

# ------------------------------ Pushover analysis -------------------------------

} elseif {$analysis_type == "PO"} {

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

# ------------------------------- Cyclic pushover --------------------------------

} elseif {$analysis_type == "CP"} {

    set RDR_path [list 0 0.02 -0.02 0];  # $$$
    pattern Plain 222 Linear {
        for {set idx 0} {$idx < $NStory} {incr idx} {
            set m [lindex $story_mass $idx]
            set F [expr $m * [lindex $mode_list $idx]]
            load [lindex $MF_FloorNodes $idx] $F 0.0 0.0
        }
    };
    set CtrlNode [lindex $MF_FloorNodes [expr [llength $MF_FloorNodes] - 1]];
    set Dincr 0.5;
    CyclicPushover $CtrlNode $RDR_path $HBuilding $Dincr $maxRunTime;

}

wipe all;
