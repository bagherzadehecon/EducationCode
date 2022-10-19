

////////////// Data Processed + Majors Identifiers
clear

use "CombinedNew.dta"




////////////// Comparison Between income distributions in some majors and all




twoway (histogram income24_simple, color(green)) (histogram  income24_simple if 108<PSTRANFIELDCCMCODE0101PSTR & PSTRANFIELDCCMCODE0101PSTR<112,fcolor(none) lcolor(black)), legend(order(1 "General" 2 "Communications and Tech"))


twoway (histogram income25_simple, color(green)) (histogram  income25_simple if 108<PSTRANFIELDCCMCODE0101PSTR & PSTRANFIELDCCMCODE0101PSTR<112,fcolor(none) lcolor(black)), legend(order(1 "General" 2 "Communications and Tech"))





twoway (kdensity income24_simple, color(green)) (kdensity income24_simple if 108<PSTRANFIELDCCMCODE0101PSTR & PSTRANFIELDCCMCODE0101PSTR<112,fcolor(none) lcolor(black)), legend(order(1 "General" 2 "Communications and Tech"))


twoway (kdensity income25_simple, color(green)) (kdensity income25_simple if 108<PSTRANFIELDCCMCODE0101PSTR & PSTRANFIELDCCMCODE0101PSTR<112,fcolor(none) lcolor(black)), legend(order(1 "General" 2 "Communications and Tech"))





twoway (kdensity income24_simple, color(green)) (kdensity income24_simple if 108<PSTRANFIELDCCMCODE0101PSTR & PSTRANFIELDCCMCODE0101PSTR<112,fcolor(none) lcolor(black)), xline(27843.85, lcol(green)) xline( 36693.17 , lcol(black)) legend(order(1 "General" 2 "Communications and Tech"))


twoway (kdensity income25_simple, color(green)) (kdensity income25_simple if 108<PSTRANFIELDCCMCODE0101PSTR & PSTRANFIELDCCMCODE0101PSTR<112,fcolor(none) lcolor(black)), xline(27843.85, lcol(green)) xline( 39410.26, lcol(black)) legend(order(1 "General" 2 "Communications and Tech"))





egen empDotCom24 = mean(employed_24) if 109<PSTRANFIELDCCMCODE0101PSTR & PSTRANFIELDCCMCODE0101PSTR<112
egen emp24 = mean(employed_24)
gen empRatioDotCom24 = empDotCom24/emp24







////////////// Race and Age Stat

graph pie, over(KEYRACEETHNICITY1997) sort descending


graph pie, over(KEYBDATEY1997) sort descending


graph pie, over(r0536402) sort descending


graph pie, over(r1482600) sort descending








////////////// Main Stat (Race, Region, ...)  Data Processed + Majors Identifiers

clear


use "CombinedNew.dta"


gen major = PSTRANFIELDCCMCODE0101PSTR + 100


gen Dotmajor = 210.major + 211.major






///////////// mix all rounds




gen Dotmajorall = 110.PSTRANFIELDCCMCODE0101PSTR + 110.PSTRANFIELDCCMCODE0102PSTR+ 110.PSTRANFIELDCCMCODE0103PSTR+ 110.PSTRANFIELDCCMCODE0104PSTR+ 110.PSTRANFIELDCCMCODE0105PSTR+ 110.PSTRANFIELDCCMCODE0201PSTR +110.PSTRANFIELDCCMCODE0202PSTR +110.PSTRANFIELDCCMCODE0203PSTR+ 110.PSTRANFIELDCCMCODE0204PSTR +110.PSTRANFIELDCCMCODE0301PSTR +110.PSTRANFIELDCCMCODE0302PSTR+ 110.PSTRANFIELDCCMCODE0303PSTR +110.PSTRANFIELDCCMCODE0304PSTR +110.PSTRANFIELDCCMCODE0305PSTR+ 110.PSTRANFIELDCCMCODE0401PSTR +110.PSTRANFIELDCCMCODE0402PSTR +110.PSTRANFIELDCCMCODE0501PSTR+ 110.PSTRANFIELDCCMCODE0601PSTR+ 111.PSTRANFIELDCCMCODE0101PSTR + 111.PSTRANFIELDCCMCODE0102PSTR+ 111.PSTRANFIELDCCMCODE0103PSTR+ 111.PSTRANFIELDCCMCODE0104PSTR+ 111.PSTRANFIELDCCMCODE0105PSTR+ 111.PSTRANFIELDCCMCODE0201PSTR +111.PSTRANFIELDCCMCODE0202PSTR +111.PSTRANFIELDCCMCODE0203PSTR+ 111.PSTRANFIELDCCMCODE0204PSTR +111.PSTRANFIELDCCMCODE0301PSTR +111.PSTRANFIELDCCMCODE0302PSTR+ 111.PSTRANFIELDCCMCODE0303PSTR +111.PSTRANFIELDCCMCODE0304PSTR +111.PSTRANFIELDCCMCODE0305PSTR+ 111.PSTRANFIELDCCMCODE0401PSTR +111.PSTRANFIELDCCMCODE0402PSTR +111.PSTRANFIELDCCMCODE0501PSTR+ 111.PSTRANFIELDCCMCODE0601PSTR


gen DotCommajorall = 0
replace DotCommajorall = 1 if Dotmajorall>0



//////////////////



//// Unemployement


local a 24

local cycle post2007_
 
 
* Self-Efficacy
local skills1 "asvab fac_se asvab_`cycle'`a' fac_se_`cycle'`a' `cycle'`a' "
local skills2 "asvab fac_se asvab_fac_se `cycle'`a' asvab_`cycle'`a' fac_se_`cycle'`a' asvab_fac_se_`cycle'`a'"
local non "_se"
local non_desc "Self-Efficacy Index"

local controls "female black hispanic mixedRace higrade_mom higrade_mom_ms health_poor  both_bio12 bio_mom_oth_dad12 bio_dad_oth_mom12 bio_mom_only bio_dad_only missing12"


eststo clear




////////////// Enrollment



eststo: reg income`a' i.major asvab fac_se post2007_`a' `controls' , robust


eststo: reg income`a' i.major asvab fac_se asvab_fac_se post2007_`a' `controls' , robust
 

eststo: reg income`a' i.major asvab fac_se asvab_fac_se asvab2 fac_se2 post2007_`a' `controls' , robust

   
esttab using EnrollmentReg.tex, ///
 replace se brackets label b(%9.2f) star(* 0.10 ** 0.05 *** 0.01) r2 aic bic booktabs ///
 title("Income" "Age: `a' Cycle Variable: `cycle' Non-Cognitive Measure: `non_desc'") ///
 addnote("Source: NLSY 1997. The mean of the outcome variable is `mean'." "Controls include an indicator for being female, black, hispanic, or mixed race," "an indicator for poor health status at baseline mother's highest grade completed," "and indicators for missing mother's education and baseline health status.") ///
 drop(`controls')  nomtitles nocons compress ///
 rename(fac_se selfefficacy_youth asvab_fac_me asvab_mentalHealthScale_y asvab_fac_se asvab_selfefficacy_youth fac_se_`cycle'`a' selfefficacy_`cycle'`a' asvab_fac_se_`cycle'`a' asvab_selfeff_`cycle'`a' fac_me mentalHealthScale_y fac_me_`cycle'`a' mentalHealth_`cycle'`a' asvab_fac_me_`cycle'`a' asvab_mental_`cycle'`a' noncogfactor big5 asvab_noncogfactor asvab_big5 noncogfactor_`cycle'`a' big5_`cycle'`a' asvab_big5_`cycle'`a' asvab_noncogfactor_`cycle'`a') ///
 mlabels ("w/ Controls" "w/ Controls" "" "" "w/ Controls" "w/ Controls" "w/ Controls" "w/ Controls" )




eststo clear


////////////// Enrollment Com/Tech



eststo: reg income`a' DotCommajorall asvab fac_se post2007_`a' `controls' , robust


eststo: reg income`a' DotCommajorall asvab fac_se asvab_fac_se post2007_`a' `controls' , robust
 

eststo: reg income`a' DotCommajorall asvab fac_se asvab_fac_se asvab2 fac_se2 post2007_`a' `controls' , robust

   
esttab using EnrollmentRegCom.tex, ///
 replace se brackets label b(%9.2f) star(* 0.10 ** 0.05 *** 0.01) r2 aic bic booktabs ///
 title("Income" "Age: `a' Cycle Variable: `cycle' Non-Cognitive Measure: `non_desc'") ///
 addnote("Source: NLSY 1997. The mean of the outcome variable is `mean'." "Controls include an indicator for being female, black, hispanic, or mixed race," "an indicator for poor health status at baseline mother's highest grade completed," "and indicators for missing mother's education and baseline health status.") ///
 drop(`controls')  nomtitles nocons compress ///
 rename(fac_se selfefficacy_youth asvab_fac_me asvab_mentalHealthScale_y asvab_fac_se asvab_selfefficacy_youth fac_se_`cycle'`a' selfefficacy_`cycle'`a' asvab_fac_se_`cycle'`a' asvab_selfeff_`cycle'`a' fac_me mentalHealthScale_y fac_me_`cycle'`a' mentalHealth_`cycle'`a' asvab_fac_me_`cycle'`a' asvab_mental_`cycle'`a' noncogfactor big5 asvab_noncogfactor asvab_big5 noncogfactor_`cycle'`a' big5_`cycle'`a' asvab_big5_`cycle'`a' asvab_noncogfactor_`cycle'`a') ///
 mlabels ("w/ Controls" "w/ Controls" "" "" "w/ Controls" "w/ Controls" "w/ Controls" "w/ Controls" )





eststo clear

////////////// Enrollment*Skill Interaction Com/Tech


gen intmajorskill210 = 210.major#asvab

gen intmajorskill211 = 211.major#asvab



eststo: reg income`a' DotCommajorall asvab DotCommajorall#c.asvab fac_se post2007_`a' `controls' , robust


eststo: reg income`a' DotCommajorall asvab DotCommajorall#c.asvab fac_se asvab_fac_se post2007_`a' `controls' , robust
 

eststo: reg income`a' DotCommajorall asvab DotCommajorall#c.asvab fac_se asvab_fac_se asvab2 fac_se2 post2007_`a' `controls' , robust

   
esttab using EnrollmentRegComInteraction.tex, ///
 replace se brackets label b(%9.2f) star(* 0.10 ** 0.05 *** 0.01) r2 aic bic booktabs ///
 title("Income" "Age: `a' Cycle Variable: `cycle' Non-Cognitive Measure: `non_desc'") ///
 addnote("Source: NLSY 1997. The mean of the outcome variable is `mean'." "Controls include an indicator for being female, black, hispanic, or mixed race," "an indicator for poor health status at baseline mother's highest grade completed," "and indicators for missing mother's education and baseline health status.") ///
 drop(`controls')  nomtitles nocons compress ///
 rename(fac_se selfefficacy_youth asvab_fac_me asvab_mentalHealthScale_y asvab_fac_se asvab_selfefficacy_youth fac_se_`cycle'`a' selfefficacy_`cycle'`a' asvab_fac_se_`cycle'`a' asvab_selfeff_`cycle'`a' fac_me mentalHealthScale_y fac_me_`cycle'`a' mentalHealth_`cycle'`a' asvab_fac_me_`cycle'`a' asvab_mental_`cycle'`a' noncogfactor big5 asvab_noncogfactor asvab_big5 noncogfactor_`cycle'`a' big5_`cycle'`a' asvab_big5_`cycle'`a' asvab_noncogfactor_`cycle'`a') ///
 mlabels ("w/ Controls" "w/ Controls" "" "" "w/ Controls" "w/ Controls" "w/ Controls" "w/ Controls" )



 
 
 
 
 
 
 
 

eststo clear

////////////// Just Major



eststo: reg income`a'  DotCommajorall, robust


eststo: reg income`a'  DotCommajorall asvab female black hispanic mixedRace , robust
 

   
esttab using OnlyEnroll.tex, ///
 replace se brackets label b(%9.2f) star(* 0.10 ** 0.05 *** 0.01) r2 aic bic booktabs ///
 title("Income" "Age: `a' Cycle Variable: `cycle' Non-Cognitive Measure: `non_desc'") ///
 addnote("Source: NLSY 1997. The mean of the outcome variable is `mean'." "Controls include an indicator for being female, black, hispanic, or mixed race," "an indicator for poor health status at baseline mother's highest grade completed," "and indicators for missing mother's education and baseline health status.") ///
 nomtitles nocons compress ///
 rename(fac_se selfefficacy_youth asvab_fac_me asvab_mentalHealthScale_y asvab_fac_se asvab_selfefficacy_youth fac_se_`cycle'`a' selfefficacy_`cycle'`a' asvab_fac_se_`cycle'`a' asvab_selfeff_`cycle'`a' fac_me mentalHealthScale_y fac_me_`cycle'`a' mentalHealth_`cycle'`a' asvab_fac_me_`cycle'`a' asvab_mental_`cycle'`a' noncogfactor big5 asvab_noncogfactor asvab_big5 noncogfactor_`cycle'`a' big5_`cycle'`a' asvab_big5_`cycle'`a' asvab_noncogfactor_`cycle'`a') ///
 mlabels ("w/ Controls" "w/ Controls" "" "" "w/ Controls" "w/ Controls" "w/ Controls" "w/ Controls" )


 


 

eststo clear

////////////// Just Major


eststo: reg income`a'  i.major, robust


eststo: reg income`a'  i.major asvab female black hispanic mixedRace , robust
 

   
esttab using JustEnrollAll.tex, ///
 replace se brackets label b(%9.2f) star(* 0.10 ** 0.05 *** 0.01) r2 aic bic booktabs ///
 title("Income" "Age: `a' Cycle Variable: `cycle' Non-Cognitive Measure: `non_desc'") ///
 addnote("Source: NLSY 1997. The mean of the outcome variable is `mean'." "Controls include an indicator for being female, black, hispanic, or mixed race," "an indicator for poor health status at baseline mother's highest grade completed," "and indicators for missing mother's education and baseline health status.") ///
 nomtitles nocons compress ///
 rename(fac_se selfefficacy_youth asvab_fac_me asvab_mentalHealthScale_y asvab_fac_se asvab_selfefficacy_youth fac_se_`cycle'`a' selfefficacy_`cycle'`a' asvab_fac_se_`cycle'`a' asvab_selfeff_`cycle'`a' fac_me mentalHealthScale_y fac_me_`cycle'`a' mentalHealth_`cycle'`a' asvab_fac_me_`cycle'`a' asvab_mental_`cycle'`a' noncogfactor big5 asvab_noncogfactor asvab_big5 noncogfactor_`cycle'`a' big5_`cycle'`a' asvab_big5_`cycle'`a' asvab_noncogfactor_`cycle'`a') ///
 mlabels ("w/ Controls" "w/ Controls" "" "" "w/ Controls" "w/ Controls" "w/ Controls" "w/ Controls" )


 




