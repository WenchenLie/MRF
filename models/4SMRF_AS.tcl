# --------------------------------------------------------------------------------
# ----------------------------------- 4SMRF_AS -----------------------------------
# -------------------- Generated by: MRFHelper (Version 1.2) ---------------------
# --------------------------------------------------------------------------------


wipe all;
model basic -ndm 2 -ndf 3;

# Basic model variables
set global RunTime;
set global StartTime;
set global MaxRunTime;
set MaxRunTime 600.0;  # $$$
set StartTime [clock seconds];
set RunTime 0.0;
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

# Results folders
file mkdir $MainFolder;
file mkdir $MainFolder/EigenAnalysis;
file mkdir $MainFolder/$SubFolder;

# Basic parameters
set NStory 4;
set NBay 3;
set E 206000.00;
set mu 0.3;
set fy_beam 345.00;
set fy_column 345.00;
uniaxialMaterial Elastic 9 1.e-9;
uniaxialMaterial Elastic 99 1.e12;
geomTransf Linear 1;
geomTransf PDelta 2;
geomTransf Corotational 3;
set A_Stiff 1.e8;
set I_Stiff 1.e13;

# Building geometry
set Floor1 0.0;
set Floor2 4300.0;
set Floor3 8300.0;
set Floor4 12300.0;
set Floor5 16300.0;

set Axis1 0.0;
set Axis2 6100.0;
set Axis3 12200.0;
set Axis4 18300.0;
set Axis5 24400.0;

set HBuilding 16300.0;
set story_heights [list 4300 4000 4000 4000];


# ------------------------------------ Nodes -------------------------------------

# Support nodes
node 10010100 $Axis1 $Floor1;
node 10010200 $Axis2 $Floor1;
node 10010300 $Axis3 $Floor1;
node 10010400 $Axis4 $Floor1;
node 10010500 $Axis5 $Floor1;

# Leaning column grid nodes
node 10020500 $Axis5 $Floor2;
node 10030500 $Axis5 $Floor3;
node 10040500 $Axis5 $Floor4;
node 10050500 $Axis5 $Floor5;

# Leaning column connected nodes
node 10020502 $Axis5 $Floor2;
node 10020501 $Axis5 $Floor2;
node 10030502 $Axis5 $Floor3;
node 10030501 $Axis5 $Floor3;
node 10040502 $Axis5 $Floor4;
node 10040501 $Axis5 $Floor4;
node 10050502 $Axis5 $Floor5;

# Moment frame column nodes
node 10010101 $Axis1 $Floor1;  node 10010201 $Axis2 $Floor1;  node 10010301 $Axis3 $Floor1;  node 10010401 $Axis4 $Floor1;
node 10020102 $Axis1 [expr $Floor2 - 607.06/2];  node 10020202 $Axis2 [expr $Floor2 - 607.06/2];  node 10020302 $Axis3 [expr $Floor2 - 607.06/2];  node 10020402 $Axis4 [expr $Floor2 - 607.06/2];
node 10020101 $Axis1 [expr $Floor2 + 607.06/2];  node 10020201 $Axis2 [expr $Floor2 + 607.06/2];  node 10020301 $Axis3 [expr $Floor2 + 607.06/2];  node 10020401 $Axis4 [expr $Floor2 + 607.06/2];
node 10030102 $Axis1 [expr $Floor3 - 607.06/2];  node 10030202 $Axis2 [expr $Floor3 - 607.06/2];  node 10030302 $Axis3 [expr $Floor3 - 607.06/2];  node 10030402 $Axis4 [expr $Floor3 - 607.06/2];
node 10030101 $Axis1 [expr $Floor3 + 607.06/2];  node 10030201 $Axis2 [expr $Floor3 + 607.06/2];  node 10030301 $Axis3 [expr $Floor3 + 607.06/2];  node 10030401 $Axis4 [expr $Floor3 + 607.06/2];
node 10040102 $Axis1 [expr $Floor4 - 462.28/2];  node 10040202 $Axis2 [expr $Floor4 - 462.28/2];  node 10040302 $Axis3 [expr $Floor4 - 462.28/2];  node 10040402 $Axis4 [expr $Floor4 - 462.28/2];
node 10040101 $Axis1 [expr $Floor4 + 462.28/2];  node 10040201 $Axis2 [expr $Floor4 + 462.28/2];  node 10040301 $Axis3 [expr $Floor4 + 462.28/2];  node 10040401 $Axis4 [expr $Floor4 + 462.28/2];
node 10050102 $Axis1 [expr $Floor5 - 462.28/2];  node 10050202 $Axis2 [expr $Floor5 - 462.28/2];  node 10050302 $Axis3 [expr $Floor5 - 462.28/2];  node 10050402 $Axis4 [expr $Floor5 - 462.28/2];

# Moment frame beam nodes
node 10020104 [expr $Axis1 + 311.15] $Floor2;  node 10020205 [expr $Axis2 - 313.69] $Floor2;  node 10020204 [expr $Axis2 + 313.69] $Floor2;  node 10020305 [expr $Axis3 - 313.69] $Floor2;  node 10020304 [expr $Axis3 + 313.69] $Floor2;  node 10020405 [expr $Axis4 - 311.15] $Floor2;
node 10030104 [expr $Axis1 + 311.15] $Floor3;  node 10030205 [expr $Axis2 - 313.69] $Floor3;  node 10030204 [expr $Axis2 + 313.69] $Floor3;  node 10030305 [expr $Axis3 - 313.69] $Floor3;  node 10030304 [expr $Axis3 + 313.69] $Floor3;  node 10030405 [expr $Axis4 - 311.15] $Floor3;
node 10040104 [expr $Axis1 + 303.53] $Floor4;  node 10040205 [expr $Axis2 - 306.07] $Floor4;  node 10040204 [expr $Axis2 + 306.07] $Floor4;  node 10040305 [expr $Axis3 - 306.07] $Floor4;  node 10040304 [expr $Axis3 + 306.07] $Floor4;  node 10040405 [expr $Axis4 - 303.53] $Floor4;
node 10050104 [expr $Axis1 + 303.53] $Floor5;  node 10050205 [expr $Axis2 - 306.07] $Floor5;  node 10050204 [expr $Axis2 + 306.07] $Floor5;  node 10050305 [expr $Axis3 - 306.07] $Floor5;  node 10050304 [expr $Axis3 + 306.07] $Floor5;  node 10050405 [expr $Axis4 - 303.53] $Floor5;

# Beam spring nodes (If RBS length equal zero, beam spring nodes will not be generated)





# Column splice ndoes
node 10030107 $Axis1 [expr $Floor3 + 0.5 * 4000.00];  node 10030207 $Axis2 [expr $Floor3 + 0.5 * 4000.00];  node 10030307 $Axis3 [expr $Floor3 + 0.5 * 4000.00];  node 10030407 $Axis4 [expr $Floor3 + 0.5 * 4000.00];

# Beam splice ndoes






# ----------------------------------- Elements -----------------------------------

set n 10.;

# Column elements
element elasticBeamColumn 10010101 10010101 10020102 19548.35 $E [expr ($n+1)/$n*1248694276.80] 2;  element elasticBeamColumn 10010201 10010201 10020202 27741.88 $E [expr ($n+1)/$n*1906339929.25] 2;  element elasticBeamColumn 10010301 10010301 10020302 27741.88 $E [expr ($n+1)/$n*1906339929.25] 2;  element elasticBeamColumn 10010401 10010401 10020402 19548.35 $E [expr ($n+1)/$n*1248694276.80] 2;
element elasticBeamColumn 10020101 10020101 10030102 19548.35 $E [expr ($n+1)/$n*1248694276.80] 2;  element elasticBeamColumn 10020201 10020201 10030202 27741.88 $E [expr ($n+1)/$n*1906339929.25] 2;  element elasticBeamColumn 10020301 10020301 10030302 27741.88 $E [expr ($n+1)/$n*1906339929.25] 2;  element elasticBeamColumn 10020401 10020401 10030402 19548.35 $E [expr ($n+1)/$n*1248694276.80] 2;
element elasticBeamColumn 10030102 10030101 10030107 19548.35 $E [expr ($n+1)/$n*1248694276.80] 2;  element elasticBeamColumn 10030202 10030201 10030207 27741.88 $E [expr ($n+1)/$n*1906339929.25] 2;  element elasticBeamColumn 10030302 10030301 10030307 27741.88 $E [expr ($n+1)/$n*1906339929.25] 2;  element elasticBeamColumn 10030402 10030401 10030407 19548.35 $E [expr ($n+1)/$n*1248694276.80] 2;
element elasticBeamColumn 10030103 10030107 10040102 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;  element elasticBeamColumn 10030203 10030207 10040202 15935.45 $E [expr ($n+1)/$n*986468478.67] 2;  element elasticBeamColumn 10030303 10030307 10040302 15935.45 $E [expr ($n+1)/$n*986468478.67] 2;  element elasticBeamColumn 10030403 10030407 10040402 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;
element elasticBeamColumn 10040101 10040101 10050102 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;  element elasticBeamColumn 10040201 10040201 10050202 15935.45 $E [expr ($n+1)/$n*986468478.67] 2;  element elasticBeamColumn 10040301 10040301 10050302 15935.45 $E [expr ($n+1)/$n*986468478.67] 2;  element elasticBeamColumn 10040401 10040401 10050402 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;

# Beam elements
element elasticBeamColumn 10020104 10020104 10020205 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;  element elasticBeamColumn 10020204 10020204 10020305 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;  element elasticBeamColumn 10020304 10020304 10020405 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;
element elasticBeamColumn 10030104 10030104 10030205 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;  element elasticBeamColumn 10030204 10030204 10030305 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;  element elasticBeamColumn 10030304 10030304 10030405 14451.58 $E [expr ($n+1)/$n*874085993.76] 2;
element elasticBeamColumn 10040104 10040104 10040205 11354.82 $E [expr ($n+1)/$n*409571722.79] 2;  element elasticBeamColumn 10040204 10040204 10040305 11354.82 $E [expr ($n+1)/$n*409571722.79] 2;  element elasticBeamColumn 10040304 10040304 10040405 11354.82 $E [expr ($n+1)/$n*409571722.79] 2;
element elasticBeamColumn 10050104 10050104 10050205 11354.82 $E [expr ($n+1)/$n*409571722.79] 2;  element elasticBeamColumn 10050204 10050204 10050305 11354.82 $E [expr ($n+1)/$n*409571722.79] 2;  element elasticBeamColumn 10050304 10050304 10050405 11354.82 $E [expr ($n+1)/$n*409571722.79] 2;

# Panel zones
# PanelNone Floor Axis X Y E mu fy_column A_stiff I_stiff d_col d_beam tp tf bf transfTag type_ position check ""
PanelZone 2 1 $Axis1 $Floor2 $E $mu $fy_column $A_Stiff $I_Stiff 622.30 607.06 20.32 24.89 228.60 2 1 "L";  PanelZone 2 2 $Axis2 $Floor2 $E $mu $fy_column $A_Stiff $I_Stiff 627.38 607.06 40.32 27.69 327.66 2 1 "I";  PanelZone 2 3 $Axis3 $Floor2 $E $mu $fy_column $A_Stiff $I_Stiff 627.38 607.06 40.32 27.69 327.66 2 1 "I";  PanelZone 2 4 $Axis4 $Floor2 $E $mu $fy_column $A_Stiff $I_Stiff 622.30 607.06 20.32 24.89 228.60 2 1 "R";
PanelZone 3 1 $Axis1 $Floor3 $E $mu $fy_column $A_Stiff $I_Stiff 622.30 607.06 20.32 24.89 228.60 2 1 "L";  PanelZone 3 2 $Axis2 $Floor3 $E $mu $fy_column $A_Stiff $I_Stiff 627.38 607.06 40.32 27.69 327.66 2 1 "I";  PanelZone 3 3 $Axis3 $Floor3 $E $mu $fy_column $A_Stiff $I_Stiff 627.38 607.06 40.32 27.69 327.66 2 1 "I";  PanelZone 3 4 $Axis4 $Floor3 $E $mu $fy_column $A_Stiff $I_Stiff 622.30 607.06 20.32 24.89 228.60 2 1 "R";
PanelZone 4 1 $Axis1 $Floor4 $E $mu $fy_column $A_Stiff $I_Stiff 607.06 462.28 17.53 17.27 228.35 2 1 "L";  PanelZone 4 2 $Axis2 $Floor4 $E $mu $fy_column $A_Stiff $I_Stiff 612.14 462.28 34.16 19.56 229.11 2 1 "I";  PanelZone 4 3 $Axis3 $Floor4 $E $mu $fy_column $A_Stiff $I_Stiff 612.14 462.28 34.16 19.56 229.11 2 1 "I";  PanelZone 4 4 $Axis4 $Floor4 $E $mu $fy_column $A_Stiff $I_Stiff 607.06 462.28 17.53 17.27 228.35 2 1 "R";
PanelZone 5 1 $Axis1 $Floor5 $E $mu $fy_column $A_Stiff $I_Stiff 607.06 462.28 17.53 17.27 228.35 2 1 "LT";  PanelZone 5 2 $Axis2 $Floor5 $E $mu $fy_column $A_Stiff $I_Stiff 612.14 462.28 34.16 19.56 229.11 2 1 "T";  PanelZone 5 3 $Axis3 $Floor5 $E $mu $fy_column $A_Stiff $I_Stiff 612.14 462.28 34.16 19.56 229.11 2 1 "T";  PanelZone 5 4 $Axis4 $Floor5 $E $mu $fy_column $A_Stiff $I_Stiff 607.06 462.28 17.53 17.27 228.35 2 1 "RT";

# RBS elements (If RBS length equal zero, RBS element will not be generated)





# Beam hinges
# BeamHinge SpringID NodeI NodeJ E fy_beam Ix d htw bftf ry L Ls Lb My type_ {check ""}
BeamHinge 10020109 11020104 10020104 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;  BeamHinge 10020210 10020205 11020202 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;  BeamHinge 10020209 11020204 10020204 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5472.6 2736.3 2736.3 1130707416.00 2;  BeamHinge 10020310 10020305 11020302 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5472.6 2736.3 2736.3 1130707416.00 2;  BeamHinge 10020309 11020304 10020304 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;  BeamHinge 10020410 10020405 11020402 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;
BeamHinge 10030109 11030104 10030104 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;  BeamHinge 10030210 10030205 11030202 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;  BeamHinge 10030209 11030204 10030204 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5472.6 2736.3 2736.3 1130707416.00 2;  BeamHinge 10030310 10030305 11030302 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5472.6 2736.3 2736.3 1130707416.00 2;  BeamHinge 10030309 11030304 10030304 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;  BeamHinge 10030410 10030405 11030402 $E $fy_beam 874085993.76 607.06 48.95 6.61 48.75 5475.2 2737.6 2737.6 1130707416.00 2;
BeamHinge 10040109 11040104 10040104 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;  BeamHinge 10040210 10040205 11040202 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;  BeamHinge 10040209 11040204 10040204 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5487.9 2743.9 2743.9 695385060.84 2;  BeamHinge 10040310 10040305 11040302 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5487.9 2743.9 2743.9 695385060.84 2;  BeamHinge 10040309 11040304 10040304 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;  BeamHinge 10040410 10040405 11040402 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;
BeamHinge 10050109 11050104 10050104 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;  BeamHinge 10050210 10050205 11050202 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;  BeamHinge 10050209 11050204 10050204 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5487.9 2743.9 2743.9 695385060.84 2;  BeamHinge 10050310 10050305 11050302 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5487.9 2743.9 2743.9 695385060.84 2;  BeamHinge 10050309 11050304 10050304 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;  BeamHinge 10050410 10050405 11050402 $E $fy_beam 409571722.79 462.28 38.55 5.44 42.85 5490.4 2745.2 2745.2 695385060.84 2;

# Column hinges
# Column SpringID NodeI NodeJ E Ix d htw ry L Lb My PPy SF_PPy pinned check ""
ColumnHinge 10010107 10010100 10010101 $E 1248694276.80 622.30 39.16 50.34 3996.47 3996.47 1582990382.40 0.1062 1.25 1;  ColumnHinge 10010207 10010200 10010201 $E 1906339929.25 627.38 33.11 76.59 3996.47 3996.47 2363178499.44 0.0499 1.25 1;  ColumnHinge 10010307 10010300 10010301 $E 1906339929.25 627.38 33.11 76.59 3996.47 3996.47 2363178499.44 0.0499 1.25 1;  ColumnHinge 10010407 10010400 10010401 $E 1248694276.80 622.30 39.16 50.34 3996.47 3996.47 1582990382.40 0.1062 1.25 1;
ColumnHinge 10020108 10020102 11020101 $E 1248694276.80 622.30 39.16 50.34 3996.47 3996.47 1582990382.40 0.1062 1.25 1;  ColumnHinge 10020208 10020202 11020201 $E 1906339929.25 627.38 33.11 76.59 3996.47 3996.47 2363178499.44 0.0499 1.25 1;  ColumnHinge 10020308 10020302 11020301 $E 1906339929.25 627.38 33.11 76.59 3996.47 3996.47 2363178499.44 0.0499 1.25 1;  ColumnHinge 10020408 10020402 11020401 $E 1248694276.80 622.30 39.16 50.34 3996.47 3996.47 1582990382.40 0.1062 1.25 1;
ColumnHinge 10020107 11020103 10020101 $E 1248694276.80 622.30 39.16 50.34 3392.94 3392.94 1582990382.40 0.0783 1.25 1;  ColumnHinge 10020207 11020203 10020201 $E 1906339929.25 627.38 33.11 76.59 3392.94 3392.94 2363178499.44 0.0368 1.25 1;  ColumnHinge 10020307 11020303 10020301 $E 1906339929.25 627.38 33.11 76.59 3392.94 3392.94 2363178499.44 0.0368 1.25 1;  ColumnHinge 10020407 11020403 10020401 $E 1248694276.80 622.30 39.16 50.34 3392.94 3392.94 1582990382.40 0.0783 1.25 1;
ColumnHinge 10030108 10030102 11030101 $E 1248694276.80 622.30 39.16 50.34 3392.94 3392.94 1582990382.40 0.0783 1.25 1;  ColumnHinge 10030208 10030202 11030201 $E 1906339929.25 627.38 33.11 76.59 3392.94 3392.94 2363178499.44 0.0368 1.25 1;  ColumnHinge 10030308 10030302 11030301 $E 1906339929.25 627.38 33.11 76.59 3392.94 3392.94 2363178499.44 0.0368 1.25 1;  ColumnHinge 10030408 10030402 11030401 $E 1248694276.80 622.30 39.16 50.34 3392.94 3392.94 1582990382.40 0.0783 1.25 1;
ColumnHinge 10030107 11030103 10030101 $E 1248694276.80 622.30 39.16 50.34 3465.33 3465.33 1582990382.40 0.0506 1.25 1;  ColumnHinge 10030207 11030203 10030201 $E 1906339929.25 627.38 33.11 76.59 3465.33 3465.33 2363178499.44 0.0238 1.25 1;  ColumnHinge 10030307 11030303 10030301 $E 1906339929.25 627.38 33.11 76.59 3465.33 3465.33 2363178499.44 0.0238 1.25 1;  ColumnHinge 10030407 11030403 10030401 $E 1248694276.80 622.30 39.16 50.34 3465.33 3465.33 1582990382.40 0.0506 1.25 1;
ColumnHinge 10040108 10040102 11040101 $E 874085993.76 607.06 48.95 48.75 3465.33 3465.33 1130707416.00 0.0685 1.25 1;  ColumnHinge 10040208 10040202 11040201 $E 986468478.67 612.14 45.87 49.66 3465.33 3465.33 1266392305.92 0.0414 1.25 1;  ColumnHinge 10040308 10040302 11040301 $E 986468478.67 612.14 45.87 49.66 3465.33 3465.33 1266392305.92 0.0414 1.25 1;  ColumnHinge 10040408 10040402 11040401 $E 874085993.76 607.06 48.95 48.75 3465.33 3465.33 1130707416.00 0.0685 1.25 1;
ColumnHinge 10040107 11040103 10040101 $E 874085993.76 607.06 48.95 48.75 3537.72 3537.72 1130707416.00 0.0310 1.25 1;  ColumnHinge 10040207 11040203 10040201 $E 986468478.67 612.14 45.87 49.66 3537.72 3537.72 1266392305.92 0.0188 1.25 1;  ColumnHinge 10040307 11040303 10040301 $E 986468478.67 612.14 45.87 49.66 3537.72 3537.72 1266392305.92 0.0188 1.25 1;  ColumnHinge 10040407 11040403 10040401 $E 874085993.76 607.06 48.95 48.75 3537.72 3537.72 1130707416.00 0.0310 1.25 1;
ColumnHinge 10050108 10050102 11050101 $E 874085993.76 607.06 48.95 48.75 3537.72 3537.72 1130707416.00 0.0310 1.25 1;  ColumnHinge 10050208 10050202 11050201 $E 986468478.67 612.14 45.87 49.66 3537.72 3537.72 1266392305.92 0.0188 1.25 1;  ColumnHinge 10050308 10050302 11050301 $E 986468478.67 612.14 45.87 49.66 3537.72 3537.72 1266392305.92 0.0188 1.25 1;  ColumnHinge 10050408 10050402 11050401 $E 874085993.76 607.06 48.95 48.75 3537.72 3537.72 1130707416.00 0.0310 1.25 1;

# Rigid links
element truss 10020404 11020404 10020500 $A_Stiff 99;
element truss 10030404 11030404 10030500 $A_Stiff 99;
element truss 10040404 11040404 10040500 $A_Stiff 99;
element truss 10050404 11050404 10050500 $A_Stiff 99;

# Leaning column
element elasticBeamColumn 10010501 10010500 10020502 $A_Stiff $E $I_Stiff 2;
element elasticBeamColumn 10020501 10020501 10030502 $A_Stiff $E $I_Stiff 2;
element elasticBeamColumn 10030501 10030501 10040502 $A_Stiff $E $I_Stiff 2;
element elasticBeamColumn 10040501 10040501 10050502 $A_Stiff $E $I_Stiff 2;

# Leaning column hinges
Spring_Rigid 10020508 10020502 10020500;
Spring_Zero 10020507 10020500 10020501;
Spring_Rigid 10030508 10030502 10030500;
Spring_Zero 10030507 10030500 10030501;
Spring_Rigid 10040508 10040502 10040500;
Spring_Zero 10040507 10040500 10040501;
Spring_Rigid 10050508 10050502 10050500;

# --------------------------------- Constraints ----------------------------------

# Support
fix 10010100 1 1 1;
fix 10010200 1 1 1;
fix 10010300 1 1 1;
fix 10010400 1 1 1;
fix 10010500 1 1 0;

# Soil constraint
# (No soil constraint)

# Rigid diaphragm
equalDOF 11020204 11020104 1;  equalDOF 11020204 11020304 1;  equalDOF 11020204 11020404 1;
equalDOF 11030204 11030104 1;  equalDOF 11030204 11030304 1;  equalDOF 11030204 11030404 1;
equalDOF 11040204 11040104 1;  equalDOF 11040204 11040304 1;  equalDOF 11040204 11040404 1;
equalDOF 11050204 11050104 1;  equalDOF 11050204 11050304 1;  equalDOF 11050204 11050404 1;

# ---------------------------------- Recorders -----------------------------------

# Mode properties
recorder Node -file $MainFolder/EigenAnalysis/EigenVectorsMode1.out -node 11020204 11030204 11040204 11050204 -dof 1 "eigen 1";
recorder Node -file $MainFolder/EigenAnalysis/EigenVectorsMode2.out -node 11020204 11030204 11040204 11050204 -dof 1 "eigen 2";
recorder Node -file $MainFolder/EigenAnalysis/EigenVectorsMode3.out -node 11020204 11030204 11040204 11050204 -dof 1 "eigen 3";
recorder Node -file $MainFolder/EigenAnalysis/EigenVectorsMode4.out -node 11020204 11030204 11040204 11050204 -dof 1 "eigen 4";

# Time
recorder Node -file $MainFolder/$SubFolder/Time.out -time -node 10010100 -dof 1 disp;

# Support reactions
recorder Node -file $MainFolder/$SubFolder/Support1.out -node 10010100 -dof 1 2 3 reaction;
recorder Node -file $MainFolder/$SubFolder/Support2.out -node 10010200 -dof 1 2 3 reaction;
recorder Node -file $MainFolder/$SubFolder/Support3.out -node 10010300 -dof 1 2 3 reaction;
recorder Node -file $MainFolder/$SubFolder/Support4.out -node 10010400 -dof 1 2 3 reaction;
recorder Node -file $MainFolder/$SubFolder/Support5.out -node 10010500 -dof 1 2 3 reaction;

# Story drift ratio
recorder Drift -file $MainFolder/$SubFolder/SDR1.out -iNode 10010100 -jNode 11020204 -dof 1 -perpDirn 2;
recorder Drift -file $MainFolder/$SubFolder/SDR2.out -iNode 11020204 -jNode 11030204 -dof 1 -perpDirn 2;
recorder Drift -file $MainFolder/$SubFolder/SDR3.out -iNode 11030204 -jNode 11040204 -dof 1 -perpDirn 2;
recorder Drift -file $MainFolder/$SubFolder/SDR4.out -iNode 11040204 -jNode 11050204 -dof 1 -perpDirn 2;
recorder Drift -file $MainFolder/$SubFolder/SDR_Roof.out -iNode 10010100 -jNode 11050204 -dof 1 -perpDirn 2;

# Floor acceleration
recorder Node -file $MainFolder/$SubFolder/RFA1.out -node 10010100 -dof 1 accel;
recorder Node -file $MainFolder/$SubFolder/RFA2.out -node 11020204 -dof 1 accel;
recorder Node -file $MainFolder/$SubFolder/RFA3.out -node 11030204 -dof 1 accel;
recorder Node -file $MainFolder/$SubFolder/RFA4.out -node 11040204 -dof 1 accel;
recorder Node -file $MainFolder/$SubFolder/RFA5.out -node 11050204 -dof 1 accel;

# Floor velocity
recorder Node -file $MainFolder/$SubFolder/RFV1.out -node 10010100 -dof 1 vel;
recorder Node -file $MainFolder/$SubFolder/RFV2.out -node 11020204 -dof 1 vel;
recorder Node -file $MainFolder/$SubFolder/RFV3.out -node 11030204 -dof 1 vel;
recorder Node -file $MainFolder/$SubFolder/RFV4.out -node 11040204 -dof 1 vel;
recorder Node -file $MainFolder/$SubFolder/RFV5.out -node 11050204 -dof 1 vel;

# Floor displacement
recorder Node -file $MainFolder/$SubFolder/Disp1.out -node 10010100 -dof 1 disp;
recorder Node -file $MainFolder/$SubFolder/Disp2.out -node 11020204 -dof 1 disp;
recorder Node -file $MainFolder/$SubFolder/Disp3.out -node 11030204 -dof 1 disp;
recorder Node -file $MainFolder/$SubFolder/Disp4.out -node 11040204 -dof 1 disp;
recorder Node -file $MainFolder/$SubFolder/Disp5.out -node 11050204 -dof 1 disp;

# Shear forces
recorder Element -file $MainFolder/$SubFolder/Shear1_1.out -ele 10010101 force;  recorder Element -file $MainFolder/$SubFolder/Shear1_2.out -ele 10010201 force;  recorder Element -file $MainFolder/$SubFolder/Shear1_3.out -ele 10010301 force;  recorder Element -file $MainFolder/$SubFolder/Shear1_4.out -ele 10010401 force;
recorder Element -file $MainFolder/$SubFolder/Shear2_1.out -ele 10020101 force;  recorder Element -file $MainFolder/$SubFolder/Shear2_2.out -ele 10020201 force;  recorder Element -file $MainFolder/$SubFolder/Shear2_3.out -ele 10020301 force;  recorder Element -file $MainFolder/$SubFolder/Shear2_4.out -ele 10020401 force;
recorder Element -file $MainFolder/$SubFolder/Shear3_1.out -ele 10030102 force;  recorder Element -file $MainFolder/$SubFolder/Shear3_2.out -ele 10030202 force;  recorder Element -file $MainFolder/$SubFolder/Shear3_3.out -ele 10030302 force;  recorder Element -file $MainFolder/$SubFolder/Shear3_4.out -ele 10030402 force;
recorder Element -file $MainFolder/$SubFolder/Shear4_1.out -ele 10040101 force;  recorder Element -file $MainFolder/$SubFolder/Shear4_2.out -ele 10040201 force;  recorder Element -file $MainFolder/$SubFolder/Shear4_3.out -ele 10040301 force;  recorder Element -file $MainFolder/$SubFolder/Shear4_4.out -ele 10040401 force;

# Column springs
recorder Element -file $MainFolder/$SubFolder/ColSpring1_1T.out -ele 10010107 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring1_2T.out -ele 10010207 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring1_3T.out -ele 10010307 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring1_4T.out -ele 10010407 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/ColSpring2_1B.out -ele 10020108 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring2_2B.out -ele 10020208 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring2_3B.out -ele 10020308 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring2_4B.out -ele 10020408 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/ColSpring2_1T.out -ele 10020107 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring2_2T.out -ele 10020207 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring2_3T.out -ele 10020307 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring2_4T.out -ele 10020407 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/ColSpring3_1B.out -ele 10030108 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring3_2B.out -ele 10030208 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring3_3B.out -ele 10030308 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring3_4B.out -ele 10030408 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/ColSpring3_1T.out -ele 10030107 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring3_2T.out -ele 10030207 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring3_3T.out -ele 10030307 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring3_4T.out -ele 10030407 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/ColSpring4_1B.out -ele 10040108 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring4_2B.out -ele 10040208 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring4_3B.out -ele 10040308 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring4_4B.out -ele 10040408 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/ColSpring4_1T.out -ele 10040107 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring4_2T.out -ele 10040207 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring4_3T.out -ele 10040307 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring4_4T.out -ele 10040407 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/ColSpring5_1B.out -ele 10050108 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring5_2B.out -ele 10050208 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring5_3B.out -ele 10050308 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/ColSpring5_4B.out -ele 10050408 material 3 stressStrain;

# Beam springs
recorder Element -file $MainFolder/$SubFolder/BeamSpring2_1R.out -ele 10020109 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring2_2L.out -ele 10020210 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring2_2R.out -ele 10020209 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring2_3L.out -ele 10020310 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring2_3R.out -ele 10020309 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring2_4L.out -ele 10020410 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/BeamSpring3_1R.out -ele 10030109 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring3_2L.out -ele 10030210 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring3_2R.out -ele 10030209 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring3_3L.out -ele 10030310 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring3_3R.out -ele 10030309 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring3_4L.out -ele 10030410 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/BeamSpring4_1R.out -ele 10040109 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring4_2L.out -ele 10040210 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring4_2R.out -ele 10040209 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring4_3L.out -ele 10040310 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring4_3R.out -ele 10040309 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring4_4L.out -ele 10040410 material 3 stressStrain;
recorder Element -file $MainFolder/$SubFolder/BeamSpring5_1R.out -ele 10050109 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring5_2L.out -ele 10050210 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring5_2R.out -ele 10050209 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring5_3L.out -ele 10050310 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring5_3R.out -ele 10050309 material 3 stressStrain;  recorder Element -file $MainFolder/$SubFolder/BeamSpring5_4L.out -ele 10050410 material 3 stressStrain;

# Panel zone springs (if any)
recorder Element -file $MainFolder/$SubFolder/PZ2_1.out -ele 11020100 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ2_2.out -ele 11020200 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ2_3.out -ele 11020300 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ2_4.out -ele 11020400 material 1 stressStrain;
recorder Element -file $MainFolder/$SubFolder/PZ3_1.out -ele 11030100 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ3_2.out -ele 11030200 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ3_3.out -ele 11030300 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ3_4.out -ele 11030400 material 1 stressStrain;
recorder Element -file $MainFolder/$SubFolder/PZ4_1.out -ele 11040100 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ4_2.out -ele 11040200 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ4_3.out -ele 11040300 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ4_4.out -ele 11040400 material 1 stressStrain;
recorder Element -file $MainFolder/$SubFolder/PZ5_1.out -ele 11050100 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ5_2.out -ele 11050200 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ5_3.out -ele 11050300 material 1 stressStrain;  recorder Element -file $MainFolder/$SubFolder/PZ5_4.out -ele 11050400 material 1 stressStrain;

# MPCO recorder
if {$MPCO == 1} {
    recorder mpco $MainFolder$SubFolder/result.mpco -N displacement acceleration modesOfVibration -E material.stress material.strain;
}

# ------------------------------------- Mass -------------------------------------

# Moment frame mass
set g 9810.0;
mass 11020104 16.895 1.e-9 1.e-9;  mass 11020204 11.263 1.e-9 1.e-9;  mass 11020304 11.263 1.e-9 1.e-9;  mass 11020404 16.895 1.e-9 1.e-9;
mass 11030104 16.727 1.e-9 1.e-9;  mass 11030204 11.151 1.e-9 1.e-9;  mass 11030304 11.151 1.e-9 1.e-9;  mass 11030404 16.727 1.e-9 1.e-9;
mass 11040104 16.727 1.e-9 1.e-9;  mass 11040204 11.151 1.e-9 1.e-9;  mass 11040304 11.151 1.e-9 1.e-9;  mass 11040404 16.727 1.e-9 1.e-9;
mass 11050104 14.486 1.e-9 1.e-9;  mass 11050204 9.657 1.e-9 1.e-9;  mass 11050304 9.657 1.e-9 1.e-9;  mass 11050404 14.486 1.e-9 1.e-9;

# Leaning column mass
mass 10020500 266.601 1.e-9 1.e-9;
mass 10030500 265.817 1.e-9 1.e-9;
mass 10040500 265.817 1.e-9 1.e-9;
mass 10050500 255.360 1.e-9 1.e-9;


# -------------------------------- Eigen analysis --------------------------------

set pi [expr 2.0*asin(1.0)];
set nEigen 4
set lambdaN [eigen [expr $nEigen]];
set lambda1 [lindex $lambdaN 0];
set lambda2 [lindex $lambdaN 1];
set lambda3 [lindex $lambdaN 2];
set lambda4 [lindex $lambdaN 3];
set w1 [expr pow($lambda1, 0.5)];
set w2 [expr pow($lambda2, 0.5)];
set w3 [expr pow($lambda3, 0.5)];
set w4 [expr pow($lambda4, 0.5)];
set T1 [expr round(2.0*$pi/$w1 *1000.)/1000.];
set T2 [expr round(2.0*$pi/$w2 *1000.)/1000.];
set T3 [expr round(2.0*$pi/$w3 *1000.)/1000.];
set T4 [expr round(2.0*$pi/$w4 *1000.)/1000.];
puts "T1 = $T1 s";
puts "T2 = $T2 s";
puts "T3 = $T3 s";

set fileX [open "$MainFolder/EigenAnalysis/EigenPeriod.out" w];
puts $fileX $T1;
puts $fileX $T2;
puts $fileX $T3;
puts $fileX $T4;
close $fileX;


# --------------------------- Static gravity analysis ----------------------------

pattern Plain 100 Linear {

    # Moment frame loads
    load 11020101 0. -188314.9 0.;      load 11020201 0. -125543.6 0.;      load 11020301 0. -125543.6 0.;      load 11020401 0. -188314.9 0.;
    load 11030101 0. -186667.9 0.;      load 11030201 0. -124445.6 0.;      load 11030301 0. -124445.6 0.;      load 11030401 0. -186667.9 0.;
    load 11040101 0. -186667.9 0.;      load 11040201 0. -124445.6 0.;      load 11040301 0. -124445.6 0.;      load 11040401 0. -186667.9 0.;
    load 11050101 0. -154661.2 0.;      load 11050201 0. -103107.8 0.;      load 11050301 0. -103107.8 0.;      load 11050401 0. -154661.2 0.;

    # gravity frame loads
    load 10020500 0. -3078215.5 0.;
    load 10030500 0. -3070145.2 0.;
    load 10040500 0. -3070145.2 0.;
    load 10050500 0. -2761607.2 0.;

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

if {$ShowAnimation == 1} {DisplayModel3D DeformedShape 5.00 100 100 1600 1000};

if {$EQ == 1} {

    # Rayleigh damping
    set zeta 0.02;
    set a0 [expr $zeta*2.0*$w1*$w3/($w1 + $w3)];
    set a1 [expr $zeta*2.0/($w1 + $w3)];
    set a1_mod [expr $a1*(1.0+$n)/$n];
    set beam_Ids [list 10020104 10020204 10020304 10030104 10030204 10030304 10040104 10040204 10040304 10050104 10050204 10050304];
    set column_Ids [list 10010101 10010201 10010301 10010401 10020101 10020201 10020301 10020401 10030102 10030103 10030202 10030203 10030302 10030303 10030402 10030403 10040101 10040201 10040301 10040401];
    set mass_Ids [list 11020104 11020204 11020304 11020404 11030104 11030204 11030304 11030404 11040104 11040204 11040304 11040404 11050104 11050204 11050304 11050404 10020500 10030500 10040500 10050500];
    # region 1 -ele {*}$beam_Ids -rayleigh 0.0 0.0 $a1_mod 0.0;
    # region 2 -ele {*}$column_Ids -rayleigh 0.0 0.0 $a1_mod 0.0;
    # region 3 -ele {*}$mass_Ids -rayleigh $a0 0.0 0.0 0.0;
    rayleigh $a0 0.0 $a1 0.0;

    # Ground motion acceleration file input
    set AccelSeries "Series -dt $GMdt -filePath $GMFile -factor [expr $EqSF * $g]";
    pattern UniformExcitation 200 1 -accel $AccelSeries;
    set MF_FloorNodes [list 11020204 11030204 11040204 11050204];
    set GMduration [expr $GMdt*$GMpoints];
    set NumSteps [expr round(($GMduration + $FVduration)/$GMdt)];
    set totTime [expr $GMdt*$NumSteps];
    set dtAnalysis [expr 1.0*$GMdt];
    set CollapseDrift 0.1;
    set MaxAnalysisDrift 0.5;
    set maxRunTime 600.0;
    set result [TimeHistorySolver $GMdt $GMduration $story_heights $MF_FloorNodes $CollapseDrift $MaxAnalysisDrift $GMname $maxRunTime $temp];
    set status [lindex $result 0];
    set controlled_time [lindex $result 1];
    puts "Running status: $status";
    puts "Controlled time: $controlled_time";

}


# ------------------------------ Pushover analysis -------------------------------

if {$PO == 1} {

    set m2 322.918;
    set m3 321.573;
    set m4 321.573;
    set m5 303.647;

    set file [open "$MainFolder/EigenAnalysis/EigenVectorsMode1.out" r];
    set first_line [gets $file];
    close $file
    set mode_list [split $first_line];
    set F2 [expr $m2 * [lindex $mode_list 0]];
    set F3 [expr $m3 * [lindex $mode_list 1]];
    set F4 [expr $m4 * [lindex $mode_list 2]];
    set F5 [expr $m5 * [lindex $mode_list 3]];
    pattern Plain 222 Linear {
        load 11020204 $F2 0.0 0.0;
        load 11030204 $F3 0.0 0.0;
        load 11040204 $F4 0.0 0.0;
        load 11050204 $F5 0.0 0.0;
    };
    set CtrlNode 11050204;
    set maxRoofDrift 0.1;  # $$$
    set Dmax [expr $maxRoofDrift * $Floor5];
    set Dincr [expr 0.5];
    set maxRunTime 600.0;
    set result [PushoverAnalysis $CtrlNode $Dmax $Dincr $maxRunTime];
    set status [lindex $result 0];
    set roofDisp [lindex $result 1];
    puts "Running status: $status";
    puts "Roof displacement: $roofDisp";
    puts "Roof drift ratio: [expr $roofDisp / $HBuilding]";

}

wipe all;

# ----------------------------- Building information -----------------------------
#
# Moment resisting frame model information
# Frame name: 4SMRF_AS
# Generation time: 2024-04-09 01:08:09.868941
# All units are in [N, mm, t]
# 
# 
# --------------- 1. Building Geometry ---------------
# 
# Building height: 16300
# Number of story: 4
# Number of bays: 3
# Plane dimensions [mm]: 42700 x 30500
# Number of moment frames: 2
# External column tributary area [mm]: 9150 x 3050
# Internal column tributary area [mm]: 6100 x 3050
# 
# 
# --------------- 2. Structural Components ---------------
# 
# Beam sections:
#  Floor  Bay-1  Bay-2  Bay-3
#      2 W24x76 W24x76 W24x76
#      3 W24x76 W24x76 W24x76
#      4 W18x60 W18x60 W18x60
#      5 W18x60 W18x60 W18x60
# 
# Column sections:
#  Story  Axis-1  Axis-2  Axis-3  Axis-4
#      1 W24x103 W24x146 W24x146 W24x103
#      2 W24x103 W24x146 W24x146 W24x103
#      3 W24x103 W24x146 W24x146 W24x103
#      4  W24x76  W24x84  W24x84  W24x76
# 
# Stories with column splices: 3
# 
# Doubler plate thickness [mm]:
#  Floor  Axis-1  Axis-2  Axis-3  Axis-4
#      2    6.35 23.8125 23.8125    6.35
#      3    6.35 23.8125 23.8125    6.35
#      4    6.35 22.2250 22.2250    6.35
#      5    6.35 22.2250 22.2250    6.35
# 
# 
# --------------- 3. Load and Material ---------------
# 
# Material properties:
# 	Young's modulus [MPa]: 206000
# 	Nominal yield strength of beams [MPa]: 345
# 	Nominal yield strength of columns [MPa]: 345
# 	Possion ratio: 0.3
# 
# Load [MPa]:
# Story/Floor   Dead    Live  Cladding
#         1/2 0.0043 0.00240    0.0012
#         2/3 0.0043 0.00240    0.0012
#         3/4 0.0043 0.00240    0.0012
#         4/5 0.0043 0.00096    0.0012
# 
# Load and mass combination coefficients:
#         Dead  Live  Cladding
# Weight  1.05  0.25      1.05
# Mass    1.00  0.00      1.00
# 
# Axial compressive ratio of columns:
# Story   Axis-1   Axis-2   Axis-3   Axis-4
#    1b 0.106212 0.049895 0.049895 0.106212
#    1t 0.106212 0.049895 0.049895 0.106212
#    2b 0.078289 0.036778 0.036778 0.078289
#    2t 0.078289 0.036778 0.036778 0.078289
#    3b 0.050611 0.023775 0.023775 0.050611
#    3t 0.068460 0.041390 0.041390 0.068460
#    4b 0.031020 0.018755 0.018755 0.031020
#    4t 0.031020 0.018755 0.018755 0.031020
# 
# Seiemic weight of considered 2D frame: 14367.82 kN
# Seiemic mass of considered 2D frame: 1269.71 t
# 
# 
# --------------- 4. Connection and Boundary Condition ---------------
# 
# Base support: Fixed
# Beam-to-column connection: Fully constrained connection
# Consider panel zone deformation: Yes (Parallelogram)
# 

