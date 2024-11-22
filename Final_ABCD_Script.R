# The following script provides information regarding importing, merging, recoding, and scoring data from the ABCD study
# The current race data is pulled from ripple. Please stick to using this race data and parent eligibility race data instead of child report
# A data dictionary has been provided on dropbox that corresponds with each variable that exists in this data 

# Set directory to where all of your data files are saved
setwd("//Users/amanpreetbhogal/Documents/Research2024/Final_ABCD_Data/ABCD_completed_csv")

# Import this data into R 
Teen_Survey <- read.csv("ABCD_Teen_Survey_FullData_R.csv")
Parent_Survey <- read.csv("ABCD_Parent_Survey_FullData_R.csv")
Teen_Eligibility_Survey <- read.csv("ABCD_Teen_Eligibility_FullData_R.csv")
Parent_Eligibility_Survey <- read.csv("ABCD_Parent_Eligibility_FullData_R.csv")
Visit_0_Data <- read.csv("ABCD_Visit_0_FullData_R.csv")
Visit_1_Data <- read.csv("ABCD_Visit_1_FullData_R.csv")
Visit_2_Data <- read.csv("ABCD_Visit_2_FullData_R.csv")
Teen_Trauma_Interview_Data <- read.csv("Teen_Trauma_Interview_FullData_R.csv")
Parent_Trauma_Interview_Data <- read.csv("Parent_Trauma_Interview_FullData_R.csv")
CBCL <- read.csv("ABCD_CBCL_FullData_R.csv")
Race_Data <- read.csv("Race_FullData_R.csv")

# Remove the first row of data
Filtered_Teen_Survey <- Teen_Survey[-1, ]
Filtered_Parent_Survey <- Parent_Survey[-1, ]
Filtered_Teen_Eligibility <- Teen_Eligibility_Survey[-1, ]
Filtered_Parent_Eligibility_Survey <- Parent_Eligibility_Survey[-1, ]
Filtered_Visit_0_Data <- Visit_0_Data[-1, ]
Filtered_Visit_1_Data <- Visit_1_Data[-1, ]
Filtered_Visit_2_Data <- Visit_2_Data[-1, ]

# Install and load dpylr
install.packages(dplyr)
library(dplyr)

# Define a mapping of old variable names to new names
## Rename multiple variables at once
rename_mapping_Teen_Survey <- list(start_date_teensurvey = "StartDate",
                                   end_date_teensurvey = "EndDate",
                                   response_type_teensurvey = "Status",
                                   ip_address_teensurvey = "IPAddress",
                                   progress_teensurvey = "Progress",
                                   duration_seconds_teensurvey = "Duration..in.seconds.", #note had to manually rename this one
                                   finished_survey_teensurvey = "Finished",
                                   recorded_date_teensurvey = "RecordedDate",
                                   response_id_teensurvey = "ResponseId",
                                   recipient_last_name_teensurvey = "RecipientLastName",
                                   sid_teensurvey = "RecipientFirstName",
                                   recipient_email_teensurvey = "RecipientEmail",
                                   external_data_reference_teensurvey = "ExternalReference",
                                   location_latitude_teensurvey = "LocationLatitude",
                                   location_longitude_teensurvey = "LocationLongitude",
                                   distribution_channel_teensurvey = "DistributionChannel",
                                   user_language_teensurvey = "UserLanguage",
                                   sid = "Q6",
                                   gender_teensurvey = "Q1",
                                   gender_other_teensurvey = "Q1_3_TEXT",
                                   age_teensurvey = "Q2",
                                   grade_teensurvey = "Q3",
                                   school_teensurvey = "Q4",
                                   race_teensurvey = "Q5",
                                   race_other_teensurvey = "Q5_5_TEXT",
                                   scared_c_q01_teensurvey = "Q16",
                                   scared_c_q02_teensurvey = "Q17",
                                   scared_c_q03_teensurvey = "Q18",
                                   scared_c_q04_teensurvey = "Q19",
                                   scared_c_q05_teensurvey = "Q20",
                                   scared_c_q06_teensurvey = "Q21",
                                   scared_c_q07_teensurvey = "Q22",
                                   scared_c_q08_teensurvey = "Q23",
                                   scared_c_q09_teensurvey = "Q24",
                                   scared_c_q10_teensurvey = "Q25",
                                   scared_c_q11_teensurvey = "Q26",
                                   scared_c_q12_teensurvey = "Q27",
                                   scared_c_q13_teensurvey = "Q28",
                                   scared_c_q14_teensurvey = "Q29",
                                   scared_c_q15_teensurvey = "Q30",
                                   scared_c_q16_teensurvey = "Q31",
                                   scared_c_q17_teensurvey = "Q32",
                                   scared_c_q18_teensurvey = "Q33",
                                   scared_c_q19_teensurvey = "Q34",
                                   scared_c_q20_teensurvey = "Q35",
                                   scared_c_q21_teensurvey = "Q36",
                                   scared_c_q22_teensurvey = "Q37",
                                   scared_c_q23_teensurvey = "Q38",
                                   scared_c_q24_teensurvey = "Q39",
                                   scared_c_q25_teensurvey = "Q40",
                                   scared_c_q26_teensurvey = "Q41",
                                   scared_c_q27_teensurvey = "Q42",
                                   scared_c_q28_teensurvey = "Q43",
                                   scared_c_q29_teensurvey = "Q44",
                                   scared_c_q30_teensurvey = "Q45",
                                   scared_c_q31_teensurvey = "Q46",
                                   scared_c_q32_teensurvey = "Q47",
                                   scared_c_q33_teensurvey = "Q48",
                                   scared_c_q34_teensurvey = "Q49",
                                   scared_c_q35_teensurvey = "Q50",
                                   scared_c_q36_teensurvey = "Q51",
                                   scared_c_q37_teensurvey = "Q52",
                                   scared_c_q38_teensurvey = "Q53",
                                   scared_c_q39_teensurvey = "Q54",
                                   scared_c_q40_teensurvey = "Q55",
                                   scared_c_q41_teensurvey = "Q56",
                                   camm_c_q01_teensurvey = "Q100",
                                   camm_c_q02_teensurvey = "Q101",
                                   camm_c_q03_teensurvey = "Q102",
                                   camm_c_q04_teensurvey = "Q103",
                                   camm_c_q05_teensurvey = "Q104",
                                   camm_c_q06_teensurvey = "Q105",
                                   camm_c_q07_teensurvey = "Q106",
                                   camm_c_q08_teensurvey = "Q107",
                                   camm_c_q09_teensurvey = "Q108",
                                   camm_c_q10_teensurvey = "Q109",
                                   cdi_c_q01_teensurvey = "Q229",
                                   cdi_c_q02_teensurvey = "Q230",
                                   cdi_c_q03_teensurvey = "Q231",
                                   cdi_c_q04_teensurvey = "Q232",
                                   cdi_c_q05_teensurvey = "Q233",
                                   cdi_c_q06_teensurvey = "Q234",
                                   cdi_c_q07_teensurvey = "Q235",
                                   cdi_c_q08_teensurvey = "Q236",
                                   cdi_c_q09_teensurvey = "Q237",
                                   cdi_c_q10_teensurvey = "Q238",
                                   cdi_c_q11_teensurvey = "Q240",
                                   pracy_c_q01_younger_teensurvey = "Q427_1",
                                   pracy_c_q02_younger_teensurvey = "Q427_2",
                                   pracy_c_q03_younger_teensurvey = "Q427_3",
                                   pracy_c_q04_younger_teensurvey = "Q427_4",
                                   pracy_c_q05_younger_teensurvey = "Q427_5",
                                   pracy_c_q06_younger_teensurvey = "Q427_6",
                                   pracy_c_q07_younger_teensurvey = "Q427_7",
                                   pracy_c_q08_younger_teensurvey = "Q427_8",
                                   pracy_c_q09_younger_teensurvey = "Q427_9",
                                   pracy_c_q10_younger_teensurvey = "Q427_10",
                                   pracy_c_q01_older_teensurvey = "Q428_1",
                                   pracy_c_q02_older_teensurvey = "Q428_2",
                                   pracy_c_q03_older_teensurvey = "Q428_3",
                                   pracy_c_q04_older_teensurvey = "Q428_4",
                                   pracy_c_q05_older_teensurvey = "Q428_5",
                                   pracy_c_q06_older_teensurvey = "Q428_6",
                                   pracy_c_q07_older_teensurvey = "Q428_7",
                                   pracy_c_q08_older_teensurvey = "Q428_8",
                                   pracy_c_q09_older_teensurvey = "Q428_9",
                                   pracy_c_q10_older_teensurvey = "Q428_10",
                                   mctq_c_q01_teensurvey = "Q387",
                                   mctq_c_q02_teensurvey = "Q389",
                                   mctq_c_q03_teensurvey = "Q391_1",
                                   mctq_c_q04_teensurvey = "Q391_2",
                                   mctq_c_q05_teensurvey = "Q391_3",
                                   mctq_c_q06_teensurvey = "Q391_4",
                                   mctq_c_q07_teensurvey = "Q391_5",
                                   mctq_c_q08_teensurvey = "Q393",
                                   mctq_c_q09_teensurvey = "Q395_1",
                                   mctq_c_q10_teensurvey = "Q395_2",
                                   mctq_c_q11_teensurvey = "Q395_3",
                                   mctq_c_q12_teensurvey = "Q395_4",
                                   mctq_c_q13_teensurvey = "Q395_5",
                                   mctq_c_q14_teensurvey = "Q397",
                                   mctq_c_q15_teensurvey = "Q399",
                                   mctq_c_q16_teensurvey = "Q401_1",
                                   mctq_c_q17_teensurvey = "Q401_2",
                                   pcrs_c_q01_teensurvey = "Q346",
                                   pcrs_c_q02_teensurvey = "Q347",
                                   pcrs_c_q03_teensurvey = "Q348",
                                   pcrs_c_q04_teensurvey = "Q349",
                                   pcrs_c_q05_teensurvey = "Q350",
                                   pcrs_c_q06_teensurvey = "Q351",
                                   pcrs_c_q07_teensurvey = "Q352",
                                   pcrs_c_q08_teensurvey = "Q353",
                                   pcrs_c_q09_teensurvey = "Q354",
                                   pcrs_c_q10_teensurvey = "Q355",
                                   pcrs_c_q11_teensurvey = "Q356",
                                   pcrs_c_q12_teensurvey = "Q357",
                                   pcrs_c_q13_teensurvey = "Q358",
                                   pcrs_c_q14_teensurvey = "Q359",
                                   pcrs_c_q15_teensurvey = "Q360",
                                   peds_ql_c_q01_teensurvey = "Q404",
                                   peds_ql_c_q02_teensurvey = "Q405",
                                   peds_ql_c_q03_teensurvey = "Q406",
                                   peds_ql_c_q04_teensurvey = "Q407",
                                   peds_ql_c_q05_teensurvey = "Q409",
                                   peds_ql_c_q06_teensurvey = "Q412",
                                   peds_ql_c_q07_teensurvey = "Q413",
                                   peds_ql_c_q08_teensurvey = "Q414",
                                   peds_ql_c_q09_teensurvey = "Q416",
                                   peds_ql_c_q10_teensurvey = "Q417",
                                   peds_ql_c_q11_teensurvey = "Q418",
                                   peds_ql_c_q12_teensurvey = "Q419",
                                   peds_ql_c_q13_teensurvey = "Q422",
                                   peds_ql_c_q14_teensurvey = "Q423",
                                   peds_ql_c_q15_teensurvey = "Q424",
                                   tanner_stages_f_c_q01_teensurvey = "Q311",
                                   tanner_stages_f_c_q02_teensurvey = "Q312",
                                   tanner_stages_f_c_q03_teensurvey = "Q313",
                                   tanner_stages_f_c_q04_teensurvey = "Q314",
                                   tanner_stages_f_c_q05_teensurvey = "Q315",
                                   tanner_stages_m_c_q01_teensurvey = "Q318",
                                   tanner_stages_m_c_q02_teensurvey = "Q319",
                                   fad_c_q01_teensurvey = "Q421_1",
                                   fad_c_q02_teensurvey = "Q421_2",
                                   fad_c_q03_teensurvey = "Q421_3",
                                   fad_c_q04_teensurvey = "Q421_4",
                                   fad_c_q05_teensurvey = "Q421_5",
                                   fad_c_q06_teensurvey = "Q421_6",
                                   fad_c_q07_teensurvey = "Q425_1",
                                   fad_c_q08_teensurvey = "Q425_2",
                                   fad_c_q09_teensurvey = "Q425_3",
                                   fad_c_q10_teensurvey = "Q425_4",
                                   fad_c_q11_teensurvey = "Q425_5",
                                   fad_c_q12_teensurvey = "Q425_6",
                                   physical_activity_c_q01_teensurvey = "Q429",
                                   physical_activity_c_q02_teensurvey = "Q431",
                                   physical_activity_c_q03_teensurvey = "Q432")

rename_mapping_Parent_Survey <- list(start_date_parentsurvey = "StartDate",
                                     end_date_parentsurvey = "EndDate",
                                     response_type_parentsurvey = "Status",
                                     ip_address_parentsurvey = "IPAddress",
                                     progress_parentsurvey = "Progress",
                                     duration_seconds_parentsurvey = "Duration..in.seconds.", #note had to manually rename this one
                                     finished_survey_parentsurvey = "Finished",
                                     recorded_date_parentsurvey = "RecordedDate",
                                     response_id_parentsurvey = "ResponseId",
                                     recipient_last_name_parentsurvey = "RecipientLastName",
                                     sid_parentsurvey = "RecipientFirstName",
                                     recipient_email_parentsurvey = "RecipientEmail",
                                     external_data_reference_parentsurvey = "ExternalReference",
                                     location_latitude_parentsurvey = "LocationLatitude",
                                     location_longitude_parentsurvey = "LocationLongitude",
                                     distribution_channel_parentsurvey = "DistributionChannel",
                                     user_language_parentsurvey = "UserLanguage",
                                     sid = "Q538",
                                     pcrs_p_q01_parentsurvey = "Q299",
                                     pcrs_p_q02_parentsurvey = "Q300",
                                     pcrs_p_q03_parentsurvey = "Q301",
                                     pcrs_p_q04_parentsurvey = "Q302",
                                     pcrs_p_q05_parentsurvey = "Q303",
                                     pcrs_p_q06_parentsurvey = "Q304",
                                     pcrs_p_q07_parentsurvey = "Q266",
                                     pcrs_p_q08_parentsurvey = "Q267",
                                     pcrs_p_q09_parentsurvey = "Q268",
                                     pcrs_p_q10_parentsurvey = "Q269",
                                     pcrs_p_q11_parentsurvey = "Q270",
                                     pcrs_p_q12_parentsurvey = "Q271",
                                     pcrs_p_q13_parentsurvey = "Q272",
                                     pcrs_p_q14_parentsurvey = "Q273",
                                     pcrs_p_q15_parentsurvey = "Q274",
                                     peds_ql_p_q01_parentsurvey = "Q345_1",
                                     peds_ql_p_q02_parentsurvey = "Q345_2",
                                     peds_ql_p_q03_parentsurvey = "Q345_3",
                                     peds_ql_p_q04_parentsurvey = "Q345_4",
                                     peds_ql_p_q05_parentsurvey = "Q345_5",
                                     peds_ql_p_q06_parentsurvey = "Q222_1",
                                     peds_ql_p_q07_parentsurvey = "Q222_2",
                                     peds_ql_p_q08_parentsurvey = "Q222_3",
                                     peds_ql_p_q09_parentsurvey = "Q222_4",
                                     peds_ql_p_q10_parentsurvey = "Q223_1",
                                     peds_ql_p_q11_parentsurvey = "Q223_2",
                                     peds_ql_p_q12_parentsurvey = "Q223_3",
                                     peds_ql_p_q13_parentsurvey = "Q224_1",
                                     peds_ql_p_q14_parentsurvey = "Q224_2",
                                     peds_ql_p_q15_parentsurvey = "Q224_3",
                                     bdi_p_q01_parentsurvey = "Q113",
                                     bdi_p_q02_parentsurvey = "Q114",
                                     bdi_p_q03_parentsurvey = "Q115",
                                     bdi_p_q04_parentsurvey = "Q116",
                                     bdi_p_q05_parentsurvey = "Q117",
                                     bdi_p_q06_parentsurvey = "Q118",
                                     bdi_p_q07_parentsurvey = "Q119",
                                     bdi_p_q08_parentsurvey = "Q120",
                                     bdi_p_q09_parentsurvey = "Q121",
                                     bdi_p_q10_parentsurvey = "Q122",
                                     bdi_p_q11_parentsurvey = "Q123",
                                     bdi_p_q12_parentsurvey = "Q124",
                                     bdi_p_q13_parentsurvey = "Q125",
                                     bdi_p_q14_parentsurvey = "Q126",
                                     bdi_p_q15_parentsurvey = "Q127",
                                     bdi_p_q16_parentsurvey = "Q128",
                                     bdi_p_q17_parentsurvey = "Q129",
                                     bdi_p_q18_parentsurvey = "Q130",
                                     bdi_p_q19_parentsurvey = "Q131",
                                     bdi_p_q20_parentsurvey = "Q132",
                                     clerq_p_q01_parentsurvey = "Q231",
                                     clerq_p_q02_parentsurvey = "Q399",
                                     clerq_p_q03_parentsurvey = "Q401",
                                     clerq_p_q04_parentsurvey = "Q398",
                                     clerq_p_q05_parentsurvey = "Q400",
                                     clerq_p_q06_parentsurvey = "Q402",
                                     clerq_p_q07_parentsurvey = "Q403",
                                     clerq_p_q08_parentsurvey = "Q403_1_TEXT",
                                     clerq_p_q09_parentsurvey = "Q404",
                                     clerq_p_q10_parentsurvey = "Q404_1_TEXT",
                                     clerq_p_q11_parentsurvey = "Q405",
                                     clerq_p_q12_parentsurvey = "Q396_1",
                                     clerq_p_q13_parentsurvey = "Q396_2",
                                     clerq_p_q14_parentsurvey = "Q396_3",
                                     clerq_p_q15_parentsurvey = "Q396_4",
                                     clerq_p_q16_parentsurvey = "Q409",
                                     clerq_p_q17_parentsurvey = "Q408",
                                     clerq_p_q18_parentsurvey = "Q410",
                                     gender_p_parentsurvey = "Q212",
                                     demographic_p_q01_parentsurvey = "Q345_1.1",
                                     demographic_p_q02_parentsurvey = "Q345_2.1",
                                     demographic_p_q03_parentsurvey = "Q345_3.1",
                                     demographic_p_q04_parentsurvey = "Q345_4.1",
                                     demographic_p_q05_parentsurvey = "Q345_5.1",
                                     demographic_p_q06_parentsurvey = "Q345_5_TEXT",
                                     demographic_p_q07_parentsurvey = "Q183",
                                     demographic_p_q08_parentsurvey = "Q183_5_TEXT",
                                     demographic_p_q09_parentsurvey = "Q183_7_TEXT",
                                     demographic_p_q10_parentsurvey = "Q343",
                                     demographic_p_q11_parentsurvey = "Q343_5_TEXT",
                                     demographic_p_q12_parentsurvey = "Q343_7_TEXT",
                                     demographic_p_q13_parentsurvey = "Q185",
                                     demographic_p_q14_parentsurvey = "Q185_3_TEXT",
                                     demographic_p_q15_parentsurvey = "Q186.1_1", #manually rename
                                     demographic_p_q16_parentsurvey = "Q186.1_2", #manually rename
                                     demographic_p_q17_parentsurvey = "Q186.1_3", #manually rename
                                     demographic_p_q18_parentsurvey = "Q186.1_4", #manually rename
                                     demographic_p_q19_parentsurvey = "Q186.1_5", #manually rename
                                     demographic_p_q20_parentsurvey = "Q186.1_6", #manually rename
                                     demographic_p_q21_parentsurvey = "Q186.1_7", #manually rename
                                     demographic_p_q22_parentsurvey = "Q186.1_7_TEXT", #manually rename
                                     demographic_p_q23_parentsurvey = "Q186.2_1", #manually rename
                                     demographic_p_q24_parentsurvey = "Q186.2_2", #manually rename
                                     demographic_p_q25_parentsurvey = "Q186.2_3", #manually rename
                                     demographic_p_q26_parentsurvey = "Q186.2_4", #manually rename
                                     demographic_p_q27_parentsurvey = "Q186.2_5", #manually rename
                                     demographic_p_q28_parentsurvey = "Q186.2_6", #manually rename
                                     demographic_p_q29_parentsurvey = "Q186.2_7", #manually rename
                                     demographic_p_q30_parentsurvey = "Q186.2_7_TEXT", #manually rename
                                     demographic_p_q31_parentsurvey = "Q187",
                                     demographic_p_q32_parentsurvey = "Q188",
                                     demographic_p_q33_parentsurvey = "Q190",
                                     demographic_p_q34_parentsurvey = "Q192",
                                     demographic_p_q35_parentsurvey = "Q197",
                                     demographic_p_q36_parentsurvey = "Q189",
                                     demographic_p_q37_parentsurvey = "Q199",
                                     demographic_p_q38_parentsurvey = "Q200",
                                     demographic_p_q39_parentsurvey = "Q201",
                                     demographic_p_q40_parentsurvey = "Q395",
                                     demographic_p_q41_parentsurvey = "Q396",
                                     demographic_p_q42_parentsurvey = "Q313_4",
                                     demographic_p_q43_parentsurvey = "Q313_5",
                                     demographic_p_q44_parentsurvey = "Q313_6",
                                     demographic_p_q45_parentsurvey = "Q313_7",
                                     demographic_p_q46_parentsurvey = "Q313_7_TEXT",
                                     fad_p_q01_parentsurvey = "Q332_1",
                                     fad_p_q02_parentsurvey = "Q332_2",
                                     fad_p_q03_parentsurvey = "Q332_3",
                                     fad_p_q04_parentsurvey = "Q332_4",
                                     fad_p_q05_parentsurvey = "Q332_5",
                                     fad_p_q06_parentsurvey = "Q332_6",
                                     fad_p_q07_parentsurvey = "Q332_7",
                                     fad_p_q08_parentsurvey = "Q332_8",
                                     fad_p_q09_parentsurvey = "Q332_9",
                                     fad_p_q10_parentsurvey = "Q332_10",
                                     fad_p_q11_parentsurvey = "Q332_11",
                                     fad_p_q12_parentsurvey = "Q332_12",
                                     mctq_p_q01_parentsurvey = "Q336",
                                     mctq_p_q02_parentsurvey = "Q338",
                                     mctq_p_q03_parentsurvey = "Q340_1",
                                     mctq_p_q04_parentsurvey = "Q340_2",
                                     mctq_p_q05_parentsurvey = "Q340_3",
                                     mctq_p_q06_parentsurvey = "Q340_4",
                                     mctq_p_q07_parentsurvey = "Q340_5",
                                     mctq_p_q08_parentsurvey = "Q342",
                                     mctq_p_q09_parentsurvey = "Q344_1",
                                     mctq_p_q10_parentsurvey = "Q344_2",
                                     mctq_p_q11_parentsurvey = "Q344_3",
                                     mctq_p_q12_parentsurvey = "Q344_4",
                                     mctq_p_q13_parentsurvey = "Q344_5",
                                     mctq_p_q14_parentsurvey = "Q346",
                                     mctq_p_q15_parentsurvey = "Q348",
                                     mctq_p_q16_parentsurvey = "Q350_1",
                                     mctq_p_q17_parentsurvey = "Q350_2",
                                     irrs_p_q01_parentsurvey = "Q211",
                                     irrs_p_q02_parentsurvey = "Q414",
                                     irrs_p_q03_parentsurvey = "Q414_10_TEXT",
                                     irrs_p_q04_parentsurvey = "Q417",
                                     irrs_p_q05_parentsurvey = "Q418",
                                     irrs_p_q06_parentsurvey = "Q420",
                                     irrs_p_q07_parentsurvey = "Q421",
                                     irrs_p_q08_parentsurvey = "Q422",
                                     irrs_p_q09_parentsurvey = "Q423",
                                     irrs_p_q10_parentsurvey = "Q424",
                                     irrs_p_q11_parentsurvey = "Q425",
                                     irrs_p_q12_parentsurvey = "Q426",
                                     irrs_p_q13_parentsurvey = "Q427",
                                     irrs_p_q14_parentsurvey = "Q428",
                                     irrs_p_q15_parentsurvey = "Q429",
                                     irrs_p_q16_parentsurvey = "Q430",
                                     irrs_p_q17_parentsurvey = "Q431",
                                     irrs_p_q18_parentsurvey = "Q432",
                                     irrs_p_q19_parentsurvey = "Q434",
                                     irrs_p_q20_parentsurvey = "Q435",
                                     irrs_p_q21_parentsurvey = "Q436",
                                     irrs_p_q22_parentsurvey = "Q437",
                                     irrs_p_q23_parentsurvey = "Q438",
                                     irrs_p_q24_parentsurvey = "Q439",
                                     irrs_p_q25_parentsurvey = "Q440",
                                     stai_p_q01_parentsurvey = "Q359",
                                     stai_p_q02_parentsurvey = "Q351",
                                     stai_p_q03_parentsurvey = "Q353",
                                     stai_p_q04_parentsurvey = "Q355",
                                     stai_p_q05_parentsurvey = "Q357",
                                     stai_p_q06_parentsurvey = "Q359.1",
                                     stai_p_q07_parentsurvey = "Q361",
                                     stai_p_q08_parentsurvey = "Q363",
                                     stai_p_q09_parentsurvey = "Q365",
                                     stai_p_q10_parentsurvey = "Q367",
                                     stai_p_q11_parentsurvey = "Q369",
                                     stai_p_q12_parentsurvey = "Q371",
                                     stai_p_q13_parentsurvey = "Q373",
                                     stai_p_q14_parentsurvey = "Q375",
                                     stai_p_q15_parentsurvey = "Q377",
                                     stai_p_q16_parentsurvey = "Q379",
                                     stai_p_q17_parentsurvey = "Q381",
                                     stai_p_q18_parentsurvey = "Q383",
                                     stai_p_q19_parentsurvey = "Q385",
                                     stai_p_q20_parentsurvey = "Q387",
                                     stai_p_q21_parentsurvey = "Q391",
                                     stai_p_q22_parentsurvey = "Q391.1",
                                     stai_p_q23_parentsurvey = "Q393",
                                     stai_p_q24_parentsurvey = "Q395.1",
                                     stai_p_q25_parentsurvey = "Q397",
                                     stai_p_q26_parentsurvey = "Q399.1",
                                     stai_p_q27_parentsurvey = "Q401.1",
                                     stai_p_q28_parentsurvey = "Q403.1",
                                     stai_p_q29_parentsurvey = "Q405.1",
                                     stai_p_q30_parentsurvey = "Q407",
                                     stai_p_q31_parentsurvey = "Q409.1",
                                     stai_p_q32_parentsurvey = "Q411",
                                     stai_p_q33_parentsurvey = "Q413",
                                     stai_p_q34_parentsurvey = "Q415",
                                     stai_p_q35_parentsurvey = "Q417.1",
                                     stai_p_q36_parentsurvey = "Q419",
                                     stai_p_q37_parentsurvey = "Q421.1",
                                     stai_p_q38_parentsurvey = "Q423.1",
                                     stai_p_q39_parentsurvey = "Q425.1",
                                     stai_p_q40_parentsurvey = "Q427.1",
                                     eequ_p_q01_parentsurvey = "Q182_1",
                                     eequ_p_q02_parentsurvey = "Q182_2",
                                     eequ_p_q03_parentsurvey = "Q182_3",
                                     eequ_p_q04_parentsurvey = "Q182_4",
                                     eequ_p_q05_parentsurvey = "QID1387_1",
                                     eequ_p_q06_parentsurvey = "QID1387_2",
                                     eequ_p_q07_parentsurvey = "QID1387_3",
                                     eequ_p_q08_parentsurvey = "QID1387_4",
                                     eequ_p_q09_parentsurvey = "Q183.1",
                                     eequ_p_q10_parentsurvey = "Q184",
                                     eequ_p_q11_parentsurvey = "Q6_1",
                                     eequ_p_q12_parentsurvey = "Q6_2",
                                     eequ_p_q13_parentsurvey = "Q6_3",
                                     eequ_p_q14_parentsurvey = "Q218_1",
                                     eequ_p_q15_parentsurvey = "Q218_2",
                                     eequ_p_q16_parentsurvey = "Q218_3",
                                     eequ_p_q17_parentsurvey = "Q186",
                                     eequ_p_q18_parentsurvey = "Q407_1_1",
                                     eequ_p_q19_parentsurvey = "Q407_1_3",
                                     eequ_p_q20_parentsurvey = "Q407_1_4",
                                     eequ_p_q21_parentsurvey = "Q407_1_9",
                                     eequ_p_q22_parentsurvey = "Q407_2_1",
                                     eequ_p_q23_parentsurvey = "Q407_2_3",
                                     eequ_p_q24_parentsurvey = "Q407_2_4",
                                     eequ_p_q25_parentsurvey = "Q407_2_9",
                                     eequ_p_q26_parentsurvey = "Q407_3_1",
                                     eequ_p_q27_parentsurvey = "Q407_3_3",
                                     eequ_p_q28_parentsurvey = "Q407_3_4",
                                     eequ_p_q29_parentsurvey = "Q407_3_9",
                                     eequ_p_q30_parentsurvey = "Q407_4_1",
                                     eequ_p_q31_parentsurvey = "Q407_4_3",
                                     eequ_p_q32_parentsurvey = "Q407_4_4",
                                     eequ_p_q33_parentsurvey = "Q407_4_9",
                                     eequ_p_q34_parentsurvey = "Q407_5_1",
                                     eequ_p_q35_parentsurvey = "Q407_5_3",
                                     eequ_p_q36_parentsurvey = "Q407_5_4",
                                     eequ_p_q37_parentsurvey = "Q407_5_9",
                                     eequ_p_q38_parentsurvey = "Q407_6_1",
                                     eequ_p_q39_parentsurvey = "Q407_6_3",
                                     eequ_p_q40_parentsurvey = "Q407_6_4",
                                     eequ_p_q41_parentsurvey = "Q407_6_9",
                                     eequ_p_q42_parentsurvey = "Q407_7_1",
                                     eequ_p_q43_parentsurvey = "Q407_7_3",
                                     eequ_p_q44_parentsurvey = "Q407_7_4",
                                     eequ_p_q45_parentsurvey = "Q407_7_9",
                                     eequ_p_q46_parentsurvey = "Q407_8_1",
                                     eequ_p_q47_parentsurvey = "Q407_8_3",
                                     eequ_p_q48_parentsurvey = "Q407_8_4",
                                     eequ_p_q49_parentsurvey = "Q407_8_9",
                                     eequ_p_q50_parentsurvey = "Q407_9_1",
                                     eequ_p_q51_parentsurvey = "Q407_9_3",
                                     eequ_p_q52_parentsurvey = "Q407_9_4",
                                     eequ_p_q53_parentsurvey = "Q407_9_9",
                                     eequ_p_q54_parentsurvey = "Q407_10_1",
                                     eequ_p_q55_parentsurvey = "Q407_10_3",
                                     eequ_p_q56_parentsurvey = "Q407_10_4",
                                     eequ_p_q57_parentsurvey = "Q407_10_9",
                                     eequ_p_q58_parentsurvey = "Q190_1",
                                     eequ_p_q59_parentsurvey = "Q190_2",
                                     eequ_p_q60_parentsurvey = "Q190_3",
                                     eequ_p_q61_parentsurvey = "Q190_4",
                                     eequ_p_q62_parentsurvey = "Q191",
                                     eequ_p_q63_parentsurvey = "Q192.1",
                                     eequ_p_q64_parentsurvey = "Q219_1",
                                     eequ_p_q65_parentsurvey = "Q219_2",
                                     eequ_p_q66_parentsurvey = "Q219_3",
                                     eequ_p_q67_parentsurvey = "Q220_1",
                                     eequ_p_q68_parentsurvey = "Q220_2",
                                     eequ_p_q69_parentsurvey = "Q220_3",
                                     eequ_p_q70_parentsurvey = "Q194",
                                     eequ_p_q71_parentsurvey = "Q188_1_1",
                                     eequ_p_q72_parentsurvey = "Q188_1_3",
                                     eequ_p_q73_parentsurvey = "Q188_1_4",
                                     eequ_p_q74_parentsurvey = "Q188_1_9",
                                     eequ_p_q75_parentsurvey = "Q188_2_1",
                                     eequ_p_q76_parentsurvey = "Q188_2_3",
                                     eequ_p_q77_parentsurvey = "Q188_2_4",
                                     eequ_p_q78_parentsurvey = "Q188_2_9",
                                     eequ_p_q79_parentsurvey = "Q188_3_1",
                                     eequ_p_q80_parentsurvey = "Q188_3_3",
                                     eequ_p_q81_parentsurvey = "Q188_3_4",
                                     eequ_p_q82_parentsurvey = "Q188_3_9",
                                     eequ_p_q83_parentsurvey = "Q188_4_1",
                                     eequ_p_q84_parentsurvey = "Q188_4_3",
                                     eequ_p_q85_parentsurvey = "Q188_4_4",
                                     eequ_p_q86_parentsurvey = "Q188_4_9",
                                     eequ_p_q87_parentsurvey = "Q188_5_1",
                                     eequ_p_q88_parentsurvey = "Q188_5_3",
                                     eequ_p_q89_parentsurvey = "Q188_5_4",
                                     eequ_p_q90_parentsurvey = "Q188_5_9",
                                     eequ_p_q91_parentsurvey = "Q188_6_1",
                                     eequ_p_q92_parentsurvey = "Q188_6_3",
                                     eequ_p_q93_parentsurvey = "Q188_6_4",
                                     eequ_p_q94_parentsurvey = "Q188_6_9",
                                     eequ_p_q95_parentsurvey = "Q188_7_1",
                                     eequ_p_q96_parentsurvey = "Q188_7_3",
                                     eequ_p_q97_parentsurvey = "Q188_7_4",
                                     eequ_p_q98_parentsurvey = "Q188_7_9",
                                     eequ_p_q99_parentsurvey = "Q188_8_1",
                                     eequ_p_q100_parentsurvey = "Q188_8_3",
                                     eequ_p_q101_parentsurvey = "Q188_8_4",
                                     eequ_p_q102_parentsurvey = "Q188_8_9",
                                     eequ_p_q103_parentsurvey = "Q188_9_1",
                                     eequ_p_q104_parentsurvey = "Q188_9_3",
                                     eequ_p_q105_parentsurvey = "Q188_9_4",
                                     eequ_p_q106_parentsurvey = "Q188_9_9",
                                     eequ_p_q107_parentsurvey = "Q188_10_1",
                                     eequ_p_q108_parentsurvey = "Q188_10_3",
                                     eequ_p_q109_parentsurvey = "Q188_10_4",
                                     eequ_p_q110_parentsurvey = "Q188_10_9",
                                     eequ_p_q111_parentsurvey = "Q393.1",
                                     eequ_p_q112_parentsurvey = "Q395_1_1",
                                     eequ_p_q113_parentsurvey = "Q395_1_3",
                                     eequ_p_q114_parentsurvey = "Q395_1_8",
                                     eequ_p_q115_parentsurvey = "Q395_1_4",
                                     eequ_p_q116_parentsurvey = "Q395_1_5",
                                     eequ_p_q117_parentsurvey = "Q395_1_6",
                                     eequ_p_q118_parentsurvey = "Q395_1_2",
                                     eequ_p_q119_parentsurvey = "Q395_2_1",
                                     eequ_p_q120_parentsurvey = "Q395_2_3",
                                     eequ_p_q121_parentsurvey = "Q395_2_8",
                                     eequ_p_q122_parentsurvey = "Q395_2_4",
                                     eequ_p_q123_parentsurvey = "Q395_2_5",
                                     eequ_p_q124_parentsurvey = "Q395_2_6",
                                     eequ_p_q125_parentsurvey = "Q395_2_2",
                                     eequ_p_q126_parentsurvey = "Q395_3_1",
                                     eequ_p_q127_parentsurvey = "Q395_3_3",
                                     eequ_p_q128_parentsurvey = "Q395_3_8",
                                     eequ_p_q129_parentsurvey = "Q395_3_4",
                                     eequ_p_q130_parentsurvey = "Q395_3_5",
                                     eequ_p_q131_parentsurvey = "Q395_3_6",
                                     eequ_p_q132_parentsurvey = "Q395_3_2",
                                     eequ_p_q133_parentsurvey = "Q395_4_1",
                                     eequ_p_q134_parentsurvey = "Q395_4_3",
                                     eequ_p_q135_parentsurvey = "Q395_4_8",
                                     eequ_p_q136_parentsurvey = "Q395_4_4",
                                     eequ_p_q137_parentsurvey = "Q395_4_5",
                                     eequ_p_q138_parentsurvey = "Q395_4_6",
                                     eequ_p_q139_parentsurvey = "Q395_4_2",
                                     eequ_p_q140_parentsurvey = "Q395_5_1",
                                     eequ_p_q141_parentsurvey = "Q395_5_3",
                                     eequ_p_q142_parentsurvey = "Q395_5_8",
                                     eequ_p_q143_parentsurvey = "Q395_5_4",
                                     eequ_p_q144_parentsurvey = "Q395_5_5",
                                     eequ_p_q145_parentsurvey = "Q395_5_6",
                                     eequ_p_q146_parentsurvey = "Q395_5_2",
                                     eequ_p_q147_parentsurvey = "Q395_6_1",
                                     eequ_p_q148_parentsurvey = "Q395_6_3",
                                     eequ_p_q149_parentsurvey = "Q395_6_8",
                                     eequ_p_q150_parentsurvey = "Q395_6_4",
                                     eequ_p_q151_parentsurvey = "Q395_6_5",
                                     eequ_p_q152_parentsurvey = "Q395_6_6",
                                     eequ_p_q153_parentsurvey = "Q395_6_2",
                                     eequ_p_q154_parentsurvey = "Q395_7_1",
                                     eequ_p_q155_parentsurvey = "Q395_7_3",
                                     eequ_p_q156_parentsurvey = "Q395_7_8",
                                     eequ_p_q157_parentsurvey = "Q395_7_4",
                                     eequ_p_q158_parentsurvey = "Q395_7_5",
                                     eequ_p_q159_parentsurvey = "Q395_7_6",
                                     eequ_p_q160_parentsurvey = "Q395_7_2",
                                     eequ_p_q161_parentsurvey = "Q224",
                                     eequ_p_q162_parentsurvey = "Q226",
                                     eequ_p_q163_parentsurvey = "Q227",
                                     eequ_p_q164_parentsurvey = "Q228",
                                     eequ_p_q165_parentsurvey = "Q247",
                                     eequ_p_q166_parentsurvey = "Q248",
                                     eequ_p_q167_parentsurvey = "Q249",
                                     eequ_p_q168_parentsurvey = "Q250",
                                     eequ_p_q169_parentsurvey = "Q252",
                                     eequ_p_q170_parentsurvey = "Q253",
                                     eequ_p_q171_parentsurvey = "Q255",
                                     eequ_p_q172_parentsurvey = "Q256",
                                     eequ_p_q173_parentsurvey = "Q258",
                                     eequ_p_q174_parentsurvey = "Q259",
                                     eequ_p_q175_parentsurvey = "Q260",
                                     eequ_p_q176_parentsurvey = "Q261",
                                     eequ_p_q177_parentsurvey = "Q264",
                                     eequ_p_q178_parentsurvey = "Q264_3_TEXT",
                                     eequ_p_q179_parentsurvey = "Q266.1",
                                     eequ_p_q180_parentsurvey = "Q267.1",
                                     eequ_p_q181_parentsurvey = "Q270.1",
                                     eequ_p_q182_parentsurvey = "Q272_1",
                                     eequ_p_q183_parentsurvey = "Q272_2",
                                     eequ_p_q184_parentsurvey = "Q272_3",
                                     eequ_p_q185_parentsurvey = "Q272_4",
                                     eequ_p_q186_parentsurvey = "Q272_5",
                                     eequ_p_q187_parentsurvey = "Q272_6",
                                     eequ_p_q188_parentsurvey = "Q272_7",
                                     eequ_p_q189_parentsurvey = "Q272_8",
                                     eequ_p_q190_parentsurvey = "Q273_1",
                                     eequ_p_q191_parentsurvey = "Q273_2",
                                     eequ_p_q192_parentsurvey = "Q273_3",
                                     eequ_p_q193_parentsurvey = "Q273_4",
                                     eequ_p_q194_parentsurvey = "Q273_5",
                                     eequ_p_q195_parentsurvey = "Q273_6",
                                     eequ_p_q196_parentsurvey = "Q273_7",
                                     eequ_p_q197_parentsurvey = "Q273_8",
                                     eequ_p_q198_parentsurvey = "Q273_9",
                                     eequ_p_q199_parentsurvey = "Q273_10",
                                     eequ_p_q200_parentsurvey = "Q273_11",
                                     eequ_p_q201_parentsurvey = "Q273_12",
                                     eequ_p_q202_parentsurvey = "Q274_1",
                                     eequ_p_q203_parentsurvey = "Q274_2",
                                     eequ_p_q204_parentsurvey = "Q274_3",
                                     eequ_p_q205_parentsurvey = "Q274_4",
                                     eequ_p_q206_parentsurvey = "Q346.1",
                                     eequ_p_q207_parentsurvey = "Q347",
                                     eequ_p_q208_parentsurvey = "Q265",
                                     eequ_p_q209_parentsurvey = "Q265_6_TEXT",
                                     eequ_p_q210_parentsurvey = "Q266_1",
                                     eequ_p_q211_parentsurvey = "Q266_2",
                                     eequ_p_q212_parentsurvey = "Q266_3",
                                     eequ_p_q213_parentsurvey = "Q266_4",
                                     eequ_p_q214_parentsurvey = "Q266_5",
                                     eequ_p_q215_parentsurvey = "Q266_6",
                                     eequ_p_q216_parentsurvey = "Q266_7",
                                     eequ_p_q217_parentsurvey = "Q266_8",
                                     eequ_p_q218_parentsurvey = "Q266_9",
                                     eequ_p_q219_parentsurvey = "Q266_10",
                                     eequ_p_q220_parentsurvey = "Q266_11",
                                     eequ_p_q221_parentsurvey = "Q266_12",
                                     covid19_p_q01_parentsurvey = "Q195",
                                     covid19_p_q02_parentsurvey = "Q196",
                                     covid19_p_q03_parentsurvey = "Q196_3_TEXT",
                                     covid19_p_q04_parentsurvey = "Q197.1",
                                     covid19_p_q05_parentsurvey = "Q198",
                                     covid19_p_q06_parentsurvey = "Q198_5_TEXT",
                                     covid19_p_q07_parentsurvey = "Q199.1",
                                     covid19_p_q08_parentsurvey = "Q200.1",
                                     covid19_p_q09_parentsurvey = "Q200_5_TEXT",
                                     covid19_p_q10_parentsurvey = "Q201.1",
                                     covid19_p_q11_parentsurvey = "Q202",
                                     covid19_p_q12_parentsurvey = "Q202_5_TEXT",
                                     covid19_p_q13_parentsurvey = "Q203",
                                     covid19_p_q14_parentsurvey = "Q205",
                                     covid19_p_q15_parentsurvey = "Q206",
                                     covid19_p_q16_parentsurvey = "Q208",
                                     covid19_p_q17_parentsurvey = "Q209",
                                     covid19_p_q18_parentsurvey = "Q209_1_TEXT",
                                     covid19_p_q19_parentsurvey = "Q210",
                                     covid19_p_q20_parentsurvey = "Q210_4_TEXT",
                                     mode_of_delivery_p_q01_parentsurvey = "Q214",
                                     mode_of_delivery_p_q02_parentsurvey = "Q214_6_TEXT")

rename_mapping_Parent_Eligibility_Survey <- list(
  sid = "sid",
  Notes_parenteligibilitysurvey = "Notes",
  start_date_parenteligibilitysurvey = "StartDate",
  end_date_parenteligibilitysurvey = "EndDate",
  response_type_parenteligibilitysurvey = "Status",
  ip_address_parenteligibilitysurvey = "IPAddress",
  progress_parenteligibilitysurvey = "Progress",
  duration_seconds_parenteligibilitysurvey = "Duration..in.seconds.", #had to manually rename for R
  finished_survey_parenteligibilitysurvey = "Finished",
  recorded_date_parenteligibilitysurvey = "RecordedDate",
  response_id_parenteligibilitysurvey = "ResponseId",
  recipient_last_name_parenteligibilitysurvey = "RecipientLastName",
  recipient_first_name_parenteligibilitysurvey = "RecipientFirstName",
  recipient_email_parenteligibilitysurvey = "RecipientEmail",
  external_data_reference_parenteligibilitysurvey = "ExternalReference",
  location_latitude_parenteligibilitysurvey = "LocationLatitude",
  location_longitude_parenteligibilitysurvey = "LocationLongitude",
  distribution_channel_parenteligibilitysurvey = "DistributionChannel",
  user_language_parenteligibilitysurvey = "UserLanguage",
  recaptcha_score_parenteligibilitysurvey = "Q_RecaptchaScore",
  ABCD_initial_interest_survey_q01_parenteligibilitysurvey = "Q45",
  ABCD_initial_interest_survey_q02_parenteligibilitysurvey = "Q45_10_TEXT",
  ABCD_initial_interest_survey_q03_parenteligibilitysurvey = "Q45_9_TEXT",
  ABCD_initial_interest_survey_q04_parenteligibilitysurvey = "Q45_18_TEXT",
  ABCD_initial_interest_survey_q05_parenteligibilitysurvey = "Q45_3_TEXT",
  ABCD_initial_interest_survey_q06_parenteligibilitysurvey = "Q45_5_TEXT",
  ABCD_initial_interest_survey_q07_parenteligibilitysurvey = "Q45_6_TEXT",
  consent_to_complete_parenteligibilitysurvey = "Q131",
  location_question_parenteligibilitysurvey = "Q132",
  full_name_parenteligibilitysurvey = "Q1146",
  contact_info_q01_parenteligibilitysurvey = "Q1147",
  contact_info_q02_parenteligibilitysurvey = "Q1148",
  contact_info_q03_parenteligibilitysurvey = "Q1149_4",
  contact_info_q04_parenteligibilitysurvey = "Q1149_5",
  contact_info_q05_parenteligibilitysurvey = "Q1149_6",
  contact_info_q06_parenteligibilitysurvey = "Q1149_7",
  education_info_q01_parenteligibilitysurvey = "Q161",
  education_info_q02_parenteligibilitysurvey = "Q161_6_TEXT",
  income_parenteligibilitysurvey = "Q163",
  children_count_q01_parenteligibilitysurvey = "Q1150",
  children_count_q02_parenteligibilitysurvey = "Q1150_10_TEXT",
  children_2_q01_parenteligibilitysurvey = "Q1256",
  children_2_q02_parenteligibilitysurvey = "Q1257",
  eligible_child_info_q01_parenteligibilitysurvey = "Q1209",
  eligible_child_info_q02_parenteligibilitysurvey = "Q1210",
  eligible_child_info_q03_parenteligibilitysurvey = "Q1211",
  eligible_child_info_q04_parenteligibilitysurvey = "Q1211_12_TEXT",
  eligible_child_info_q05_parenteligibilitysurvey = "Q1212",
  abcd_eligibility_q01_parenteligibilitysurvey = "Q1234",
  abcd_eligibility_q02_parenteligibilitysurvey = "Q1234_12_TEXT",
  abcd_eligibility_q03_parenteligibilitysurvey = "Q173_1",
  abcd_eligibility_q04_parenteligibilitysurvey = "Q173_2",
  abcd_eligibility_q05_parenteligibilitysurvey = "Q173_3",
  abcd_eligibility_q06_parenteligibilitysurvey = "Q1236",
  abcd_eligibility_q07_parenteligibilitysurvey = "Q1237",
  abcd_eligibility_q08_parenteligibilitysurvey = "Q1238",
  abcd_eligibility_q09_parenteligibilitysurvey = "Q1238_10_TEXT",
  abcd_eligibility_q10_parenteligibilitysurvey = "Q1239_1",
  abcd_eligibility_q11_parenteligibilitysurvey = "Q1239_2",
  abcd_eligibility_q12_parenteligibilitysurvey = "Q1240",
  abcd_eligibility_q13_parenteligibilitysurvey = "Q1241",
  abcd_eligibility_q14_parenteligibilitysurvey = "Q1242",
  abcd_eligibility_q15_parenteligibilitysurvey = "Q1242_1_TEXT",
  abcd_eligibility_q16_parenteligibilitysurvey = "Q1243_1",
  abcd_eligibility_q17_parenteligibilitysurvey = "Q1243_2",
  abcd_eligibility_q18_parenteligibilitysurvey = "Q1243_3",
  abcd_eligibility_q19_parenteligibilitysurvey = "Q1243_4",
  abcd_eligibility_q20_parenteligibilitysurvey = "Q1243_5",
  abcd_eligibility_q21_parenteligibilitysurvey = "Q1243_6",
  abcd_eligibility_q22_parenteligibilitysurvey = "Q1243_7",
  abcd_eligibility_q23_parenteligibilitysurvey = "Q1243_8",
  abcd_eligibility_q24_parenteligibilitysurvey = "Q1243_9",
  abcd_eligibility_q25_parenteligibilitysurvey = "Q1243_10",
  abcd_eligibility_q26_parenteligibilitysurvey = "Q1243_11",
  abcd_eligibility_q27_parenteligibilitysurvey = "Q1243_12",
  abcd_eligibility_q28_parenteligibilitysurvey = "Q1244",
  abcd_eligibility_q29_parenteligibilitysurvey = "Q1245",
  abcd_eligibility_q30_parenteligibilitysurvey = "Q1246",
  abcd_eligibility_q31_parenteligibilitysurvey = "Q1247",
  alc_substance_use_p_q01_parenteligibilitysurvey = "Q1248",
  alc_substance_use_p_q02_parenteligibilitysurvey = "Q1249",
  alc_substance_use_p_q03_parenteligibilitysurvey = "Q1250",
  alc_substance_use_p_q04_parenteligibilitysurvey = "Q158",
  alc_substance_use_p_q05_parenteligibilitysurvey = "Q166",
  residential_history_q01_parenteligibilitysurvey = "Q1099",
  residential_history_q02_parenteligibilitysurvey = "Q1100_1",
  residential_history_q03_parenteligibilitysurvey = "Q1100_2",
  residential_history_q04_parenteligibilitysurvey = "Q1100_3",
  residential_history_q05_parenteligibilitysurvey = "Q1100_4",
  residential_history_q06_parenteligibilitysurvey = "Q1101",
  residential_history_q07_parenteligibilitysurvey = "Q127",
  residential_history_q08_parenteligibilitysurvey = "Q1102",
  residential_history_q09_parenteligibilitysurvey = "Q1103_1",
  residential_history_q10_parenteligibilitysurvey = "Q1103_2",
  residential_history_q11_parenteligibilitysurvey = "Q1103_3",
  residential_history_q12_parenteligibilitysurvey = "Q1103_4",
  residential_history_q13_parenteligibilitysurvey = "Q1105",
  residential_history_q14_parenteligibilitysurvey = "Q1109_1",
  residential_history_q15_parenteligibilitysurvey = "Q1109_2",
  residential_history_q16_parenteligibilitysurvey = "Q1109_3",
  residential_history_q17_parenteligibilitysurvey = "Q1109_4",
  residential_history_q18_parenteligibilitysurvey = "Q1111",
  residential_history_q19_parenteligibilitysurvey = "Q1113",
  residential_history_q20_parenteligibilitysurvey = "Q1114",
  cannabis_cbd_p_q01_parenteligibilitysurvey = "Q224",
  cannabis_cbd_p_q02_parenteligibilitysurvey = "Q226",
  cannabis_cbd_p_q03_parenteligibilitysurvey = "Q227",
  cannabis_cbd_p_q04_parenteligibilitysurvey = "Q228",
  contact_future_studies_parenteligibilitysurvey = "Q1117",
  child_number_parenteligibilitysurvey = "Q172_1",
  child_email_address_parenteligibilitysurvey = "Q172_2")

rename_mapping_Teen_Eligibility_Survey <- list(
  sid = "SubjectID",
  notes_one_teeneligibilitysurvey = "Notes_one",
  start_date_teeneligibilitysurvey = "StartDate",
  end_date_teeneligibilitysurvey = "EndDate",
  response_type_teeneligibilitysurvey = "Status",
  ip_address_teeneligibilitysurvey = "IPAddress",
  progress_teeneligibilitysurvey = "Progress",
  duration_seconds_teeneligibilitysurvey = "Duration..in.seconds.",
  finished_survey_teeneligibilitysurvey = "Finished",
  recorded_date_teeneligibilitysurvey = "RecordedDate",
  response_id_teeneligibilitysurvey = "ResponseId",
  recipient_last_name_teeneligibilitysurvey = "RecipientLastName",
  recipient_first_name_teeneligibilitysurvey = "RecipientFirstName",
  recipient_email_teeneligibilitysurvey = "RecipientEmail",
  external_data_reference_teeneligibilitysurvey = "ExternalReference",
  location_latitude_teeneligibilitysurvey = "LocationLatitude",
  location_longitude_teeneligibilitysurvey = "LocationLongitude",
  distribution_channel_teeneligibilitysurvey = "DistributionChannel",
  user_language_teeneligibilitysurvey = "UserLanguage",
  recaptcha_score_teeneligibilitysurvey = "Q_RecaptchaScore",
  consent_to_complete_teeneligibilitysurvey = "Q6",
  first_name_teeneligibilitysurvey = "Q641_1",
  last_name_teeneligibilitysurvey = "Q641_2",
  gender_teeneligibilitysurvey = "Q642",
  birth_control_teeneligibilitysurvey = "Q650",
  birth_date_month_teeneligibilitysurvey = "Q139_1",
  birth_date_day_teeneligibilitysurvey = "Q139_2",
  birth_date_year_teeneligibilitysurvey = "Q139_3",
  age_teeneligibilitysurvey = "Q644",
  age_text_teeneligibilitysurvey = "Q644_5_TEXT",
  scared_c_q01_teeneligibilitysurvey = "Q16",
  scared_c_q02_teeneligibilitysurvey = "Q17",
  scared_c_q03_teeneligibilitysurvey = "Q18",
  scared_c_q04_teeneligibilitysurvey = "Q19",
  scared_c_q05_teeneligibilitysurvey = "Q20",
  scared_c_q06_teeneligibilitysurvey = "Q21",
  scared_c_q07_teeneligibilitysurvey = "Q22",
  scared_c_q08_teeneligibilitysurvey = "Q139",
  scared_c_q09_teeneligibilitysurvey = "Q23",
  scared_c_q10_teeneligibilitysurvey = "Q24",
  scared_c_q11_teeneligibilitysurvey = "Q25",
  scared_c_q12_teeneligibilitysurvey = "Q26",
  scared_c_q13_teeneligibilitysurvey = "Q27",
  scared_c_q14_teeneligibilitysurvey = "Q28",
  scared_c_q15_teeneligibilitysurvey = "Q29",
  scared_c_q16_teeneligibilitysurvey = "Q30",
  scared_c_q17_teeneligibilitysurvey = "Q31",
  scared_c_q18_teeneligibilitysurvey = "Q32",
  scared_c_q19_teeneligibilitysurvey = "Q33",
  scared_c_q20_teeneligibilitysurvey = "Q34",
  scared_c_q21_teeneligibilitysurvey = "Q35",
  scared_c_q22_teeneligibilitysurvey = "Q36",
  scared_c_q23_teeneligibilitysurvey = "Q37",
  scared_c_q24_teeneligibilitysurvey = "Q38",
  scared_c_q25_teeneligibilitysurvey = "Q39",
  scared_c_q26_teeneligibilitysurvey = "Q40",
  scared_c_q27_teeneligibilitysurvey = "Q41",
  scared_c_q28_teeneligibilitysurvey = "Q42",
  scared_c_q29_teeneligibilitysurvey = "Q43",
  scared_c_q30_teeneligibilitysurvey = "Q44",
  scared_c_q31_teeneligibilitysurvey = "Q45",
  scared_c_q32_teeneligibilitysurvey = "Q46",
  scared_c_q33_teeneligibilitysurvey = "Q47",
  scared_c_q34_teeneligibilitysurvey = "Q48",
  scared_c_q35_teeneligibilitysurvey = "Q49",
  scared_c_q36_teeneligibilitysurvey = "Q50",
  scared_c_q37_teeneligibilitysurvey = "Q51",
  scared_c_q38_teeneligibilitysurvey = "Q52",
  scared_c_q39_teeneligibilitysurvey = "Q53",
  scared_c_q40_teeneligibilitysurvey = "Q54",
  scared_c_q41_teeneligibilitysurvey = "Q55",
  scared_c_q42_teeneligibilitysurvey = "Q56",
  tihsh_c_q01_teeneligibilitysurvey = "Q430",
  tihsh_c_q02_teeneligibilitysurvey = "Q432",
  tihsh_c_q03_teeneligibilitysurvey = "Q433",
  tihsh_c_q04_teeneligibilitysurvey = "Q434",
  tihsh_c_q05_teeneligibilitysurvey = "Q435",
  tihsh_c_q06_teeneligibilitysurvey = "Q436",
  tihsh_c_q07_teeneligibilitysurvey = "Q437",
  tihsh_c_q08_teeneligibilitysurvey = "Q438",
  tihsh_c_q09_teeneligibilitysurvey = "Q440",
  tihsh_c_q10_teeneligibilitysurvey = "Q441",
  tihsh_c_q11_teeneligibilitysurvey = "Q442",
  tihsh_c_q12_teeneligibilitysurvey = "Q443",
  tihsh_c_q13_teeneligibilitysurvey = "Q444",
  tihsh_c_q14_teeneligibilitysurvey = "Q445",
  tihsh_c_q15_teeneligibilitysurvey = "Q446",
  tihsh_c_q16_teeneligibilitysurvey = "Q447",
  tihsh_c_q17_teeneligibilitysurvey = "Q448",
  tihsh_c_q18_teeneligibilitysurvey = "Q449",
  tihsh_c_q19_teeneligibilitysurvey = "Q450",
  tihsh_c_q20_teeneligibilitysurvey = "Q451",
  substance_use_c_q01_teeneligibilitysurvey = "Q452",
  substance_use_c_q02_teeneligibilitysurvey = "Q455",
  substance_use_c_q03_teeneligibilitysurvey = "Q456",
  substance_use_c_q04_teeneligibilitysurvey = "Q471",
  substance_use_c_q05_teeneligibilitysurvey = "Q472",
  substance_use_c_q06_teeneligibilitysurvey = "Q131",
  substance_use_c_q07_teeneligibilitysurvey = "Q453",
  substance_use_c_q08_teeneligibilitysurvey = "Q454",
  substance_use_c_q09_teeneligibilitysurvey = "Q457",
  substance_use_c_q10_teeneligibilitysurvey = "Q473",
  substance_use_c_q11_teeneligibilitysurvey = "Q476",
  substance_use_c_q12_teeneligibilitysurvey = "Q460",
  substance_use_c_q13_teeneligibilitysurvey = "Q461",
  substance_use_c_q14_teeneligibilitysurvey = "Q462",
  substance_use_c_q15_teeneligibilitysurvey = "Q464",
  substance_use_c_q16_teeneligibilitysurvey = "Q465",
  substance_use_c_q17_teeneligibilitysurvey = "Q129",
  substance_use_c_q18_teeneligibilitysurvey = "Q135",
  substance_use_c_q19_teeneligibilitysurvey = "Q133",
  substance_use_c_q20_teeneligibilitysurvey = "Q475",
  substance_use_c_q21_teeneligibilitysurvey = "Q130")

rename_mapping_Visit_0_Data <- list(start_date_v0 = "StartDate",
                                    end_date_v0 = "EndDate",
                                    response_type_v0 = "Status",
                                    ip_address_v0 = "IPAddress",
                                    progress_v0 = "Progress",
                                    duration_seconds_v0 = "Duration..in.seconds.", #note had to manually rename this one
                                    finished_survey_v0 = "Finished",
                                    recorded_date_v0 = "RecordedDate",
                                    response_id_v0 = "ResponseId",
                                    recipient_last_name_v0 = "RecipientLastName",
                                    sid_v0 = "RecipientFirstName",
                                    recipient_email_v0 = "RecipientEmail",
                                    external_data_reference_v0 = "ExternalReference",
                                    location_latitude_v0 = "LocationLatitude",
                                    location_longitude_v0 = "LocationLongitude",
                                    distribution_channel_v0 = "DistributionChannel",
                                    user_language_v0 = "UserLanguage",
                                    sid = "Q284",
                                    date_month_v0 = "Q291_1",
                                    date_day_v0 = "Q291_2",
                                    date_year_v0 = "Q291_3",
                                    ra_initials_v0 = "Q91",
                                    age = "Q288",
                                    sex = "Q290",
                                    inclusion_age_v0 = "Q1322.1_1", #manually rename
                                    inclusion_r_hand_v0 = "Q1322.1_2", #manually rename
                                    inclusion_eng_c_v0 = "Q1322.1_3", #manually rename
                                    inclusion_consent_v0 = "Q1322.1_4", #manually rename
                                    inclusion_eng_present_p_v0 = "Q1322.1_5", #manually rename
                                    exclusion_sensory_impair_v0 = "Q1323.1_1", #manually rename
                                    f_exclusion_oc_use_v0 = "Q1324.1_1", #manually rename
                                    setup_ts_01_v0 = "Q296_1",
                                    setup_ts_02_v0 = "Q296_2",
                                    setup_ts_03_v0 = "Q296_3",
                                    setup_ts_04_v0 = "Q296_4",
                                    setup_ts_05_v0 = "Q296_5",
                                    setup_ts_06_v0 = "Q296_6",
                                    setup_ts_07_v0 = "Q296_7",
                                    setup_ts_08_v0 = "Q296_8",
                                    setup_ts_09_v0 = "Q296_9",
                                    five_min_late_v0 = "Q289", #manually rename
                                    fifteen_min_late_v0 = "Q93", #manually rename
                                    arrival_time_v0 = "Q92",
                                    no_show_01_v0 = "Q116_1",
                                    no_show_02_v0 = "Q116_2",
                                    no_show_03_v0 = "Q116_3",
                                    no_show_04_v0 = "Q116_4",
                                    reschedule_01_v0 = "Q223",
                                    reschedule_02_v0 = "Q223_1_TEXT",
                                    reschedule_03_v0 = "Q223_6_TEXT",
                                    reschedule_04_v0 = "Q223_4_TEXT",
                                    reschedule_05_v0 = "Q1380_1",
                                    reschedule_06_v0 = "Q1380_2",
                                    reschedule_07_v0 = "Q1380_3",
                                    reschedule_08_v0 = "Q1380_4",
                                    reschedule_09_v0 = "Q348_1",
                                    reschedule_10_v0 = "Q348_2",
                                    reschedule_11_v0 = "Q348_3",
                                    reschedule_12_v0 = "Q348_4",
                                    reschedule_13_v0 = "Q349_1",
                                    reschedule_14_v0 = "Q349_2",
                                    caregiver_v0 = "Q134",
                                    overview_v0 = "Q134_4_TEXT",
                                    overview_q01_v0 = "Q1386_1",
                                    overview_q02_v0 = "Q1386_2",
                                    overview_q03_v0 = "Q1386_3",
                                    overview_q04_v0 = "Q1386_4",
                                    overview_q05_v0 = "Q1386_5",
                                    overview_q06_v0 = "Q1386_6",
                                    overview_q07_v0 = "Q1386_7",
                                    overview_q08_v0 = "Q1386_8",
                                    consent_cs_v0 = "Q334",
                                    consent_q01_v0 = "Q217",
                                    consent_q02_v0 = "Q217_2_TEXT",
                                    consent_q03_v0 = "Q1390",
                                    consent_q04_v0 = "Q1391",
                                    consent_q05_v0 = "Q1392",
                                    consent_q06_v0 = "Q1393",
                                    consent_q07_v0 = "Q1393_1_TEXT",
                                    consent_q08_v0 = "Q1394",
                                    consent_q09_v0 = "Q1395",
                                    consent_q10_v0 = "Q1395_2_TEXT",
                                    consent_q11_v0 = "Q1396",
                                    consent_q12_v0 = "Q1396_2_TEXT",
                                    consent_q13_v0 = "Q354",
                                    consent_q14_v0 = "Q1397_Id",
                                    consent_q15_v0 = "Q1397_Name",
                                    consent_q16_v0 = "Q1397_Size",
                                    consent_q17_v0 = "Q1397_Type",
                                    consent_q18_v0 = "Q1398",
                                    baby_teeth_q01_v0 = "Q168",
                                    baby_teeth_q02_v0 = "Q168_2_TEXT",
                                    baby_teeth_q03_v0 = "Q1388",
                                    baby_teeth_q04_v0 = "Q1388_1_TEXT",
                                    baby_teeth_q05_v0 = "Q1388_2_TEXT",
                                    med_info_01_v0 = "Q136_1",
                                    med_info_02_v0 = "Q136_2",
                                    med_info_03_v0 = "Q136_3",
                                    med_info_04_v0 = "Q136_4",
                                    med_info_05_v0 = "Q138_1",
                                    med_info_06_v0 = "Q138_2",
                                    med_info_07_v0 = "Q138_3",
                                    med_info_08_v0 = "Q138_4",
                                    birth_control_v0 = "Q137",
                                    time_last_meal_v0 = "Q346",
                                    opt_out_q01_v0 = "Q219",
                                    opt_out_q02_v0 = "Q219_1_TEXT",
                                    opt_out_q03_v0 = "Q219_2_TEXT",
                                    opt_out_q04_v0 = "Q219_3_TEXT",
                                    opt_out_q05_v0 = "Q1400_1",
                                    opt_out_q06_v0 = "Q1400_2",
                                    opt_out_q07_v0 = "Q1400_3",
                                    opt_out_q08_v0 = "Q1400_4",
                                    opt_out_q09_v0 = "Q160_1",
                                    opt_out_q10_v0 = "Q160_2",
                                    opt_out_q11_v0 = "Q160_3",
                                    caregiver_checklist_q01_v0 = "Q132_1",
                                    caregiver_checklist_q02_v0 = "Q132_2",
                                    caregiver_checklist_q03_v0 = "Q132_3",
                                    sleep_q01_c_v0 = "Q170",
                                    sleep_q02_c_v0 = "Q171",
                                    sleep_q03_c_v0 = "Q172",
                                    sleep_q04_c_v0 = "Q173",
                                    sleep_q05_c_v0 = "Q173_1_TEXT",
                                    sleep_q06_c_v0 = "Q174",
                                    sleep_q07_c_v0 = "Q175",
                                    dominant_hand_c_v0 = "Q222",
                                    dominant_hand_text_c_v0 = "Q222_3_TEXT",
                                    oral_contra_c_v0 = "Q346.1",
                                    iud_c_v0 = "Q176",
                                    iud_type_c_v0 = "Q188",
                                    mri_call_v0 = "Q189",
                                    color_blind_test_v0 = "Q225",
                                    kbit_q01_v0 = "Q358",
                                    kbit_q02_v0 = "KBIT.Scoring", #manually rename
                                    kbit_q03_v0 = "Q318_1",
                                    kbit_q04_v0 = "Q318_2",
                                    kbit_q05_v0 = "Q162",
                                    kbit_q06_v0 = "Q165_1",
                                    kbit_q07_v0 = "Q165_2",
                                    kbit_q08_v0 = "Q164_1",
                                    kbit_q09_v0 = "Q164_2",
                                    kbit_q10_v0 = "Q164_3",
                                    saliva_collection_q01_v0 = "Saliva_Visit0_YN",
                                    saliva_collection_q02_v0 = "Q5_First.Click", #manually rename
                                    saliva_collection_q03_v0 = "Q5_Last.Click", #manually rename
                                    saliva_collection_q04_v0 = "Q5_Page.Submit", #manually rename
                                    saliva_collection_q05_v0 = "Q5_Click.Count", #manually rename
                                    saliva_collection_q06_v0 = "Q6_1",
                                    saliva_collection_q07_v0 = "Q6_2",
                                    saliva_collection_q08_v0 = "Q6_3",
                                    saliva_collection_q09_v0 = "Q6_4",
                                    saliva_collection_q10_v0 = "Q6_5",
                                    saliva_collection_q11_v0 = "Q6_6",
                                    saliva_collection_q12_v0 = "Q6_7",
                                    saliva_collection_q13_v0 = "Q6_8",
                                    saliva_collection_q14_v0 = "Q7",
                                    teen_survey_q01_v0 = "Q356",
                                    teen_survey_q02_v0 = "Q357",
                                    airmonitor_device_v0 = "airmonitor_device",
                                    airmonitor_tablet_v0 = "Q350",
                                    fitbit_device_v0 = "fitbit_device",
                                    height_v0 = "Q351",
                                    weight_v0 = "weight",
                                    airmonitor_instruction_q01_v0 = "Q332_1",
                                    airmonitor_instruction_q02_v0 = "Q332_2",
                                    airmonitor_instruction_q03_v0 = "Q332_3",
                                    airmonitor_instruction_q04_v0 = "Q332_4",
                                    airmonitor_instruction_q05_v0 = "Q332_5",
                                    airmonitor_instruction_q06_v0 = "Q332_6",
                                    airmonitor_instruction_q07_v0 = "Q333_1",
                                    airmonitor_instruction_q08_v0 = "Q333_2",
                                    airmonitor_instruction_q09_v0 = "Q333_3",
                                    airmonitor_instruction_q10_v0 = "Q333_4",
                                    airmonitor_instruction_q11_v0 = "Q333_5",
                                    airmonitor_booklet_q01_v0 = "Q337_1",
                                    airmonitor_booklet_q02_v0 = "Q337_2",
                                    airmonitor_booklet_q03_v0 = "Q337_3",
                                    end_of_visit_q01_v0 = "Q133_1",
                                    end_of_visit_q02_v0 = "Q133_2",
                                    end_of_visit_q03_v0 = "Q133_3",
                                    end_of_visit_q04_v0 = "Q133_4",
                                    end_of_visit_q05_v0 = "Q133_5",
                                    end_of_visit_q06_v0 = "Q133_6",
                                    end_of_visit_q07_v0 = "Q133_7",
                                    end_of_visit_q08_v0 = "Q106",
                                    kbit_q11_v0 = "Q161_1",
                                    kbit_q12_v0 = "Q161_2",
                                    kbit_q13_v0 = "Q319",
                                    kbit_q14_v0 = "Q320_1",
                                    kbit_q15_v0 = "Q320_2",
                                    kbit_q16_v0 = "Q321_1",
                                    kbit_q17_v0 = "Q321_2",
                                    kbit_q18_v0 = "Q321_3")

rename_mapping_Visit_1_Data <- list(start_date_v1 = "StartDate",
                                    end_date_v1 = "EndDate",
                                    response_type_v1 = "Status",
                                    ip_address_v1 = "IPAddress",
                                    progress_v1 = "Progress",
                                    duration_seconds_v1 = "Duration..in.seconds.", #note had to manually rename this one
                                    finished_survey_v1 = "Finished",
                                    recorded_date_v1 = "RecordedDate",
                                    response_id_v1 = "ResponseId",
                                    recipient_last_name_v1 = "RecipientLastName",
                                    sid_visit_1_v1 = "RecipientFirstName",
                                    recipient_email_v1 = "RecipientEmail",
                                    external_data_reference_v1 = "ExternalReference",
                                    location_latitude_v1 = "LocationLatitude",
                                    location_longitude_v1 = "LocationLongitude",
                                    distribution_channel_v1 = "DistributionChannel",
                                    user_language_v1 = "UserLanguage",
                                    sid = "sid",
                                    date_month_v1 = "Q291_1",
                                    date_day_v1 = "Q291_2",
                                    date_year_v1 = "Q291_3",
                                    ra_initials_v1 = "Q91",
                                    age = "Q288",
                                    sex = "Q290",
                                    mri_visit_v1 = "Q232",
                                    visit_0_completed_v1 = "abcd_ap",
                                    inclusion_age_v1 = "Q1322.1_1", #manually rename
                                    inclusion_r_hand_v1 = "Q1322.1_2", #manually rename
                                    inclusion_eng_c_v1 = "Q1322.1_3", #manually rename
                                    inclusion_consent_v1 = "Q1322.1_4", #manually rename
                                    inclusion_eng_present_p_v1 = "Q1322.1_5", #manually rename
                                    exclusion_sensory_impair_v1 = "Q1323.1_1", #manually rename
                                    exclusion_breathalyzer_v1 = "Q1323.1_2", #manually rename
                                    exclusion_drug_test_v1 = "Q1323.1_3", #manually rename
                                    exclusion_mri_contra_v1 = "Q274.1_1", #manually rename
                                    f_exclusion_oc_use_v1 = "Q1324.1_1", #manually rename
                                    f_exclusion_up_sex_v1 = "Q1324.1_2", #manually rename
                                    f_exclusion_preg_test_v1 = "Q1324.1_3", #manually rename
                                    setup_ts_01_v1 = "Q296_1",
                                    setup_ts_02_v1 = "Q296_2",
                                    setup_ts_03_v1 = "Q296_3",
                                    setup_ts_04_v1 = "Q296_4",
                                    setup_ts_05_v1 = "Q296_5",
                                    setup_ts_06_v1 = "Q296_6",
                                    setup_ts_07_v1 = "Q296_7",
                                    setup_ts_08_v1 = "Q296_8",
                                    setup_ts_09_v1 = "Q296_9",
                                    setup_ts_10_v1 = "Q296_10",
                                    setup_ts_11_v1 = "Q296_11",
                                    setup_ts_12_v1 = "Q296_12",
                                    setup_ts_13_v1 = "Q296_13",
                                    setup_ts_14_v1 = "Q296_14",
                                    setup_ts_15_v1 = "Q296_15",
                                    setup_ts_16_v1 = "Q296_16",
                                    setup_ts_17_v1 = "Q296_17",
                                    setup_ts_18_v1 = "Q296_18",
                                    setup_ts_19_v1 = "Q296_19",
                                    setup_ts_20_v1 = "Q296_20",
                                    setup_ts_21_v1 = "Q296_21",
                                    setup_ts_22_v1 = "Q296_22",
                                    five_min_late_v1 = "Q289", #manually rename
                                    fifteen_min_late_v1 = "Q93", #manually rename
                                    arrival_time_v1 = "Q92",
                                    no_show_01_v1 = "Q116_1",
                                    no_show_02_v1 = "Q116_2",
                                    no_show_03_v1 = "Q116_3",
                                    no_show_04_v1 = "Q116_4",
                                    no_show_05_v1 = "Q116_5",
                                    no_show_reason_v1 = "Q223",
                                    reschedule_01_v1 = "Q223_1_TEXT",
                                    reschedule_02_v1 = "Q223_6_TEXT",
                                    reschedule_03_v1 = "Q223_2_TEXT",
                                    reschedule_04_v1 = "Q223_3_TEXT",
                                    reschedule_05_v1 = "Q223_7_TEXT",
                                    reschedule_06_v1 = "Q223_5_TEXT",
                                    reschedule_07_v1 = "Q223_4_TEXT",
                                    reschedule_in_lab_v1 = "Q282",
                                    reschedule_08_v1 = "Q1380_1",
                                    reschedule_09_v1 = "Q1380_2",
                                    reschedule_10_v1 = "Q1380_3",
                                    reschedule_11_v1 = "Q1380_4",
                                    reschedule_12_v1 = "Q1380_5",
                                    caregiver_v1 = "Q134",
                                    overview_v1 = "Q134_4_TEXT",
                                    overview_q01_v1 = "Q1386_1",
                                    overview_q02_v1 = "Q1386_2",
                                    overview_q03_v1 = "Q1386_3",
                                    overview_q04_v1 = "Q1386_4",
                                    overview_q05_v1 = "Q1386_5",
                                    overview_q06_v1 = "Q1386_6",
                                    overview_q07_v1 = "Q1386_7",
                                    overview_q08_v1 = "Q1386_8",
                                    consent_cs_v1 = "Q305",
                                    consent_q01_v1 = "Q217",
                                    consent_q02_v1 = "Q217_2_TEXT",
                                    consent_q03_v1 = "Q336",
                                    consent_q04_v1 = "Q336_2_TEXT",
                                    consent_q05_v1 = "Q1390",
                                    consent_q06_v1 = "Q1391",
                                    consent_q07_v1 = "Q1392",
                                    consent_q08_v1 = "Q1393",
                                    consent_q09_v1 = "Q1393_1_TEXT",
                                    consent_q10_v1 = "Q1394",
                                    consent_q11_v1 = "Q1395",
                                    consent_q12_v1 = "Q1395_2_TEXT",
                                    consent_q13_v1 = "Q1396",
                                    consent_q14_v1 = "Q1396_2_TEXT",
                                    consent_q15_v1 = "Q339",
                                    consent_q16_v1 = "Q1397_Id",
                                    consent_q17_v1 = "Q1397_Name",
                                    consent_q18_v1 = "Q1397_Size",
                                    consent_q19_v1 = "Q1397_Type",
                                    consent_q20_v1 = "Q1398",
                                    baby_teeth_q01_v1 = "Q168",
                                    baby_teeth_q02_v1 = "Q168_2_TEXT",
                                    baby_teeth_q03_v1 = "Q1388",
                                    baby_teeth_q04_v1 = "Q1388_1_TEXT",
                                    baby_teeth_q05_v1 = "Q1388_2_TEXT",
                                    med_today_q01_v1 = "Q136_1",
                                    med_today_q02_v1 = "Q136_2",
                                    med_today_q03_v1 = "Q136_3",
                                    med_today_q04_v1 = "Q136_4",
                                    med_yesterday_q01_v1 = "Q138_1",
                                    med_yesterday_q02_v1 = "Q138_2",
                                    med_yesterday_q03_v1 = "Q138_3",
                                    med_yesterday_q04_v1 = "Q138_4",
                                    time_last_meal_v1 = "Q225",
                                    birth_control_v1 = "Q137",
                                    visible_contra_v1 = "Q284.1",
                                    air_mon_q01_v1 = "Q333",
                                    air_mon_q02_v1 = "Q334",
                                    air_mon_q03_v1 = "Q331",
                                    opt_out_q01_v1 = "Q219",
                                    opt_out_q02_v1 = "Q219_1_TEXT",
                                    opt_out_q03_v1 = "Q219_2_TEXT",
                                    opt_out_q04_v1 = "Q219_3_TEXT",
                                    opt_out_q05_v1 = "Q1400_1",
                                    opt_out_q06_v1 = "Q1400_2",
                                    opt_out_q07_v1 = "Q1400_3",
                                    opt_out_q08_v1 = "Q1400_4",
                                    screen_fail_q01_v1 = "Q160_1",
                                    screen_fail_q02_v1 = "Q160_2",
                                    screen_fail_q03_v1 = "Q160_3",
                                    screen_fail_q04_v1 = "Q160_4",
                                    initial_screening_q01_v1 = "Q132_1",
                                    initial_screening_q02_v1 = "Q132_2",
                                    initial_screening_q03_v1 = "Q132_3",
                                    initial_screening_q04_v1 = "Q132_4",
                                    initial_screening_q05_v1 = "Q132_5",
                                    visible_marijuana_indication_v1 = "Q228",
                                    cig_tobacco_use_c_v1 = "Q120",
                                    cig_tobacco_use_count_c_v1 = "Q120_1_TEXT",
                                    e_vaporizer_use_c_v1 = "Q121",
                                    e_vaporizer_use_count_c_v1 = "Q121_1_TEXT",
                                    e_vaporizer_type_c_v1 = "Q166",
                                    cannabis_use_c_v1 = "Q117",
                                    cannabis_use_count_c_v1 = "Q288.1",
                                    cannabis_use_year_history_c_v1 = "Q289.1",
                                    cannabis_use_month_history_c_v1 = "Q290.1",
                                    cannabis_ingestion_type_c_v1 = "Q167",
                                    cannabis_ingestion_type_text_c_v1 = "Q167_4_TEXT",
                                    cannabis_use_day_history_c_v1 = "Q229",
                                    menarche_c_v1 = "Q82",
                                    last_period_c_v1 = "Q86",
                                    oral_contra_c_v1 = "Q346",
                                    iud_c_v1 = "Q176",
                                    iud_type_c_v1 = "Q188",
                                    mri_call_v1 = "Q189",
                                    sexual_int_last_period_c_v1 = "Q94",
                                    sexual_int_protection_c_v1 = "Q98",
                                    sexual_int_protection_text_c_v1 = "Q98_14_TEXT",
                                    dominant_hand_c_v1 = "Q222",
                                    dominant_hand_text_c_v1 = "Q222_3_TEXT",
                                    sleep_q01_c_v1 = "Q170",
                                    sleep_q02_c_v1 = "Q171",
                                    sleep_q03_c_v1 = "Q172",
                                    sleep_q04_c_v1 = "Q173",
                                    sleep_q04_text_c_v1 = "Q173_1_TEXT",
                                    sleep_q05_c_v1 = "Q174",
                                    sleep_q06_c_v1 = "Q175",
                                    color_blind_test_v1 = "Q225.1",
                                    breathalyzer_q01_v1 = "Q1217",
                                    breathalyzer_q02_v1 = "Q1219",
                                    breathalyzer_q03_v1 = "Q1220",
                                    drug_screen_q01_v1 = "Q158_1",
                                    drug_screen_q02_v1 = "Q158_2",
                                    drug_screen_q03_v1 = "Q160",
                                    drug_screen_q04_v1 = "Q162",
                                    drug_screen_q05_c_v1 = "Q341",
                                    drug_screen_q06_v1 = "Q164",
                                    preg_test_q01_v1 = "Q166_4",
                                    preg_test_q02_v1 = "Q166_5",
                                    preg_test_q03_v1 = "Q168.1",
                                    preg_test_q04_v1 = "Q281_1",
                                    preg_test_q05_v1 = "Q170.1",
                                    preg_test_q06_v1 = "Q176.1",
                                    mri_screener_q01_v1 = "Q1200",
                                    mri_screener_q02_v1 = "Q1201",
                                    mri_screener_q03_v1 = "Q1201_5_TEXT",
                                    mri_screener_q04_v1 = "Q155",
                                    height_inches_v1 = "Q1224_2",
                                    weight_pounds_v1 = "Q330_1",
                                    phleb_q05_c_v1 = "Q172.1",
                                    phleb_q06_c_v1 = "Q173.1",
                                    phleb_q07_v1 = "Q135_First.Click", #manually rename
                                    phleb_q08_v1 = "Q135_Last.Click", #manually rename
                                    phleb_q09_v1 = "Q135_Page.Submit", #manually rename
                                    phleb_q10_v1 = "Q135_Click.Count", #manually rename
                                    phleb_q11_v1 = "Q166.1",
                                    phleb_q12_v1 = "Q167.1",
                                    phleb_q13_v1 = "Q1225",
                                    phleb_q14_v1 = "Q209",
                                    phleb_q15_v1 = "Q209_2_TEXT",
                                    phleb_q16_v1 = "Q209_3_TEXT",
                                    faces_phleb_c_v1 = "Q340",
                                    phleb_q17_v1 = "Q168.2",
                                    phleb_q18_v1 = "Q168_1_TEXT",
                                    phleb_q19_v1 = "Q168_3_TEXT",
                                    phleb_q20_v1 = "Q169_1",
                                    phleb_q21_v1 = "Q1226",
                                    phleb_q22_v1 = "Q198_1",
                                    phleb_q23_v1 = "Q198_2",
                                    phleb_q24_v1 = "Q198_3",
                                    phleb_q25_v1 = "Q198_4",
                                    phleb_q26_v1 = "Q198_5",
                                    phleb_q27_v1 = "Q198_6",
                                    phleb_q28_v1 = "Q198_7",
                                    blood_processing_q01_v1 = "Q1233_1",
                                    blood_processing_q02_v1 = "Q1233_2",
                                    blood_processing_q03_v1 = "Q1233_3",
                                    blood_processing_q04_v1 = "Q1233_4",
                                    blood_processing_q05_v1 = "Q1233_5",
                                    blood_processing_q06_v1 = "Q1233_6",
                                    blood_processing_q07_v1 = "Q1233_7",
                                    blood_processing_q08_v1 = "Q207",
                                    kbit_q01_v1 = "Q328",
                                    kbit_q02_v1 = "KBIT.Scoring", #manually rename
                                    kbit_q03_v1 = "Q318_1",
                                    kbit_q04_v1 = "Q318_2",
                                    kbit_q05_v1 = "Q162.1",
                                    kbit_q06_v1 = "Q165_1",
                                    kbit_q07_v1 = "Q165_2",
                                    kbit_q08_v1 = "Q164_1",
                                    kbit_q09_v1 = "Q164_2",
                                    kbit_q10_v1 = "Q164_3",
                                    parent_qualtrics_completion_v1 = "Q137_1",
                                    mock_scan_q01_v1 = "Q175_1",
                                    mock_scan_q02_v1 = "Q175_2",
                                    mock_scan_q03_v1 = "Q175_3",
                                    mock_scan_q04_v1 = "Q175_4",
                                    mock_scan_q05_v1 = "Q175_5",
                                    mock_scan_q06_v1 = "Q175_6",
                                    mock_scan_q07_v1 = "Q175_7",
                                    mock_scan_q08_v1 = "Q175_8",
                                    mock_scan_q09_v1 = "Q175_9",
                                    mock_scan_q10_v1 = "Q175_10",
                                    mock_scan_q11_v1 = "Q175_11",
                                    facebias_version_mri_v1 = "Q310",
                                    faces_mockscan_c_v1 = "Q338",
                                    mock_scan_q13_v1 = "Q276_1",
                                    mock_scan_q14_v1 = "Q276_2",
                                    mock_scan_q15_v1 = "Q276_3",
                                    mock_scan_q16_v1 = "Q1248",
                                    mock_scan_q17_v1 = "Q1249",
                                    mock_scan_q18_v1 = "Q344",
                                    scan_setup_q01_v1 = "Q174_1",
                                    scan_setup_q02_v1 = "Q174_2",
                                    scan_setup_q03_v1 = "Q174_3",
                                    scan_setup_q04_v1 = "Q174_4",
                                    scan_setup_q05_v1 = "Q174_5",
                                    scan_setup_q06_v1 = "Q174_6",
                                    scan_setup_q07_v1 = "Q174_7",
                                    scan_setup_q08_v1 = "Q174_8",
                                    scan_setup_q09_v1 = "Q174_9",
                                    scan_setup_q10_v1 = "Q174_10",
                                    scan_setup_q11_v1 = "Q1253",
                                    scan_setup_q12_v1 = "Q1254",
                                    scan_setup_q13_v1 = "Q178",
                                    scan_setup_q14_v1 = "Q178_1_TEXT",
                                    scan_setup_q15_v1 = "Q178_2_TEXT",
                                    scan_setup_q16_v1 = "Q178_3_TEXT",
                                    scan_setup_q17_v1 = "Q178_4_TEXT",
                                    mri_scan_q01_v1 = "Q179_1",
                                    mri_scan_q02_v1 = "Q179_2",
                                    mri_scan_q03_v1 = "Q179_3",
                                    mri_scan_q04_v1 = "Q179_4",
                                    mri_scan_q05_v1 = "Q179_5",
                                    mri_scan_q06_v1 = "Q179_6",
                                    mri_scan_q07_v1 = "Q179_7",
                                    mri_scan_q08_v1 = "Q179_8",
                                    mri_scan_q09_v1 = "Q179_9",
                                    t1_scan_notes_v1 = "Q186",
                                    rs1_scan_q01_v1 = "Q185_1",
                                    rs1_scan_q02_v1 = "Q185_2",
                                    rs1_scan_notes_v1 = "Q187",
                                    mri_scan_q10_v1 = "Q180",
                                    mri_scan_q11_v1 = "Q298_1",
                                    mri_scan_q12_v1 = "Q298_2",
                                    mri_scan_q13_v1 = "Q298_3",
                                    mri_scan_q14_v1 = "Q298_4",
                                    mri_fear_conditioning_version_v1 = "Q180.1",
                                    mri_conditioning_context_v1 = "Q181",
                                    mri_cs0_identity_v1 = "Q182",
                                    mri_cs1_identity_v1 = "Q183",
                                    mri_cs2_identity_v1 = "Q184",
                                    mri_scan_q15_v1 = "Q183_1",
                                    mri_scan_q16_v1 = "Q183_2",
                                    mri_scan_q17_v1 = "Q183_3",
                                    mri_scan_q18_v1 = "Q183_4",
                                    mri_scan_q19_v1 = "Q183_5",
                                    mri_fear_conditioning_notes_v1 = "Q184.1",
                                    mri_scan_q20_v1 = "Q185_1.1",
                                    earbuds_notes_v1 = "Q297",
                                    rs2_scan_notes_v1 = "Q193",
                                    mri_scan_q21_v1 = "Q192",
                                    mri_scan_q22_v1 = "Q191_1",
                                    mri_scan_q23_v1 = "Q191_2",
                                    mri_scan_q24_v1 = "Q191_3",
                                    mri_scan_q25_v1 = "Q191_4",
                                    mri_scan_q26_v1 = "Q191_5",
                                    mri_extinction_notes_v1 = "Q194",
                                    rs3_scan_q01_v1 = "Q190_1",
                                    rs3_scan_q02_v1 = "Q190_2",
                                    rs3_scan_notes_v1 = "Q195",
                                    mri_scan_q27_v1 = "Q196",
                                    mri_scan_q28_v1 = "Q1258",
                                    mri_scan_q29_v1 = "Q178.1",
                                    mri_scan_q30_v1 = "Q178_1_TEXT.1",
                                    mri_scan_q31_v1 = "Q178_2_TEXT.1",
                                    mri_scan_q32_v1 = "Q178_3_TEXT.1",
                                    mri_scan_q33_v1 = "Q1259",
                                    post_mri_q01_v1 = "Q186_1",
                                    post_mri_q02_v1 = "Q186_2",
                                    post_mri_q03_v1 = "Q186_3",
                                    faces_postmri_c_v1 = "Q265",
                                    post_scan_q01_c_v1 = "Q188.1",
                                    post_scan_q02_c_v1 = "Q189_1",
                                    post_scan_q03_c_v1 = "Q189_2",
                                    post_scan_q04_c_v1 = "Q191_1.1",
                                    post_scan_q05_c_v1 = "Q191_4.1",
                                    post_scan_q06_c_v1 = "Q191_2.1",
                                    post_scan_q07_c_v1 = "Q192_1",
                                    post_scan_q08_c_v1 = "Q192_2",
                                    post_scan_q09_c_v1 = "Q267",
                                    post_scan_q10_c_v1 = "Q267_1_TEXT",
                                    post_scan_q11_c_v1 = "Q193.1",
                                    post_mri_q04_v1 = "Q187_1",
                                    post_mri_q05_v1 = "Q187_2",
                                    post_mri_q06_v1 = "Q187_3",
                                    post_mri_q07_v1 = "Q187_4",
                                    post_mri_q08_v1 = "Q187_5",
                                    post_mri_q09_v1 = "Q187_6",
                                    post_mri_q10_v1 = "Q187_7",
                                    post_mri_q11_v1 = "Q1292",
                                    post_mri_q12_v1 = "Q1293",
                                    faces_vr_c_v1 = "Q273",
                                    vr_setup_q01_v1 = "Q260_1",
                                    vr_setup_q02_v1 = "Q260_2",
                                    vr_setup_q03_v1 = "Q260_3",
                                    vr_setup_q04_v1 = "Q260_4",
                                    vr_setup_q05_v1 = "Q260_5",
                                    vr_setup_q06_v1 = "Q260_6",
                                    vr_setup_q07_v1 = "Q260_7",
                                    vr_setup_q08_v1 = "Q260_8",
                                    vr_setup_q09_v1 = "Q260_9",
                                    vr_setup_q10_v1 = "Q260_10",
                                    vr_setup_q11_v1 = "Q260_11",
                                    vr_setup_q12_v1 = "Q260_12",
                                    vr_setup_q13_v1 = "Q260_13",
                                    vr_setup_q14_v1 = "Q260_14",
                                    vr_setup_q15_v1 = "Q260_15",
                                    vr_setup_q16_v1 = "Q260_16",
                                    vr_setup_q17_v1 = "Q260_17",
                                    vr_setup_q18_v1 = "Q260_18",
                                    vr_setup_q19_v1 = "Q260_19",
                                    vr_setup_q20_v1 = "Q260_20",
                                    vr_setup_q21_v1 = "Q260_21",
                                    vr_setup_q22_v1 = "Q260_22",
                                    vr_setup_q23_v1 = "Q260_23",
                                    vr_acquisition_version_v1 = "Q1517",
                                    vr_extinction_version_v1 = "Q294",
                                    vr_recall_version_v1 = "Q295",
                                    vr_renewal_version_v1 = "Q296",
                                    vr_conditioning_context_v1 = "Q1518",
                                    vr_cs0_identity_v1 = "Q1519",
                                    vr_cs1_identity_v1 = "Q1520",
                                    vr_cs2_identity_v1 = "Q1521",
                                    vr_acq_extinct_setup_q01_v1 = "Q323_1",
                                    vr_acq_extinct_setup_q02_v1 = "Q323_2",
                                    vr_acq_extinct_setup_q03_v1 = "Q323_3",
                                    vr_acq_extinct_setup_q04_v1 = "Q323_4",
                                    vr_acq_extinct_setup_q05_v1 = "Q323_5",
                                    vr_acq_extinct_setup_q06_v1 = "Q323_6",
                                    vr_acq_extinct_setup_q07_v1 = "Q323_7",
                                    vr_acq_extinct_setup_q08_v1 = "Q323_8",
                                    vr_acq_extinct_setup_q09_v1 = "Q323_9",
                                    vr_acq_extinct_setup_q10_v1 = "Q323_10",
                                    vr_acquisition_q01_v1 = "Q1522_1",
                                    vr_acquisition_q02_v1 = "Q1522_2",
                                    vr_acquisition_q03_v1 = "Q1522_3",
                                    vr_acquisition_q04_v1 = "Q1522_4",
                                    vr_acquisition_q05_v1 = "Q1522_5",
                                    vr_fear_conditioning_notes_v1 = "Q1523",
                                    discontinue_q01_v1 = "Q307",
                                    discontinue_q02_v1 = "Q306_1",
                                    discontinue_q03_v1 = "Q306_2",
                                    discontinue_q04_v1 = "Q306_3",
                                    discontinue_q05_v1 = "Q306_4",
                                    discontinue_q06_v1 = "Q306_5",
                                    discontinue_q07_v1 = "Q306_6",
                                    discontinue_q08_v1 = "Q306_7",
                                    vr_extinction_q01_v1 = "Q1527_1",
                                    vr_extinction_q02_v1 = "Q1527_2",
                                    vr_extinction_q03_v1 = "Q1527_3",
                                    vr_extinction_q04_v1 = "Q1527_4",
                                    vr_extinction_q05_v1 = "Q1527_5",
                                    vr_extinction_q06_v1 = "Q1527_6",
                                    vr_extinction_q07_v1 = "Q1527_7",
                                    vr_extinction_notes_v1 = "Q1528",
                                    faces_postvr_c_v1 = "Q197",
                                    post_vr_q01_c_v1 = "Q268",
                                    post_vr_q02_c_v1 = "Q268_1_TEXT",
                                    post_vr_q03_c_v1 = "Q269",
                                    facebias_q01_v1 = "Q312_1",
                                    facebias_q02_v1 = "Q312_2",
                                    facebias_q03_v1 = "Q312_3",
                                    facebias_q04_v1 = "Q312_4",
                                    facebias_q05_v1 = "Q312_5",
                                    facebias_q06_v1 = "Q312_6",
                                    facebias_q07_v1 = "Q312_7",
                                    facebias_q08_v1 = "Q314",
                                    facebias_version_vr_v1 = "Q313",
                                    end_visit_q01_v1 = "Q133_1",
                                    end_visit_q02_v1 = "Q133_2",
                                    end_visit_q03_v1 = "Q133_3",
                                    end_visit_q04_v1 = "Q133_4",
                                    end_visit_q05_v1 = "Q133_5",
                                    end_visit_q06_v1 = "Q133_6",
                                    end_visit_q07_v1 = "Q133_7",
                                    end_visit_q08_v1 = "Q133_8",
                                    end_visit_q09_v1 = "Q133_9",
                                    final_notes_v1 = "Q106",
                                    kbit_post_visit_q01_v1 = "Q161_1",
                                    kbit_post_visit_q02_v1 = "Q161_2",
                                    kbit_post_visit_q03_v1 = "Q319",
                                    kbit_post_visit_q04_v1 = "Q320_1",
                                    kbit_post_visit_q05_v1 = "Q320_2",
                                    kbit_post_visit_q06_v1 = "Q321_1",
                                    kbit_post_visit_q07_v1 = "Q321_2",
                                    kbit_post_visit_q08_v1 = "Q321_3")

rename_mapping_Visit_2_Data <- list(start_date_v2 = "StartDate",
                                    end_date_v2 = "EndDate",
                                    response_type_v2 = "Status",
                                    ip_address_v2 = "IPAddress",
                                    progress_v2 = "Progress",
                                    duration_seconds_v2 = "Duration..in.seconds.", #note had to manually rename this one
                                    finished_survey_v2 = "Finished",
                                    recorded_date_v2 = "RecordedDate",
                                    response_id_v2 = "ResponseId",
                                    recipient_last_name_v2 = "RecipientLastName",
                                    sid_v2 = "RecipientFirstName",
                                    recipient_email_v2 = "RecipientEmail",
                                    external_data_reference_v2 = "ExternalReference",
                                    location_latitude_v2 = "LocationLatitude",
                                    location_longitude_v2 = "LocationLongitude",
                                    distribution_channel_v2 = "DistributionChannel",
                                    user_language_v2 = "UserLanguage",
                                    sid = "sid",
                                    date_month_v2 = "Q90_1",
                                    date_day_v2 = "Q90_2",
                                    date_year_v2 = "Q90_3",
                                    ra_initials_v2 = "Q91",
                                    age_v2 = "Q288",
                                    sex_v2 = "Q290",
                                    mri_visit_v2 = "Q463",
                                    visit_0_completed_v2 = "Q621",
                                    inclusion_age_v2 = "Q1322.1_1", #manually rename for R
                                    inclusion_r_hand_v2 = "Q1322.1_2", #manually rename for R
                                    inclusion_eng_c_v2 = "Q1322.1_3", #manually rename for R
                                    inclusion_consent_v2 = "Q1322.1_4", #manually rename for R
                                    inclusion_eng_present_p_v2 = "Q1322.1_5", #manually rename for R
                                    inclusion_iq_v2 = "Q1322.1_6", #manually rename for R
                                    exclusion_sensory_impair_v2 = "Q1323.1_1", #manually rename for R
                                    exclusion_cannabis_use_v2 = "Q1323.1_2", #manually rename for R
                                    exclusion_breathalyzer_v2 = "Q1323.1_3", #manually rename for R
                                    exclusion_drug_test_v2 = "Q1323.1_4", #manually rename for R
                                    exclusion_mri_contra_v2 = "Q1323.1_5", #manually rename for R
                                    f_exclusion_oc_use_v2 = "Q1324.1_1", #manually rename for R
                                    f_exclusion_up_sex_v2 = "Q1324.1_2", #manually rename for R
                                    f_exclusion_preg_test_v2 = "Q1324.1_3", #manually rename for R
                                    setup_ts_01_v2 = "Q495_1",
                                    setup_ts_02_v2 = "Q495_2",
                                    setup_ts_03_v2 = "Q495_3",
                                    setup_ts_04_v2 = "Q495_4",
                                    setup_ts_05_v2 = "Q495_5",
                                    setup_ts_06_v2 = "Q495_6",
                                    setup_ts_07_v2 = "Q495_7",
                                    setup_ts_08_v2 = "Q495_8",
                                    setup_ts_09_v2 = "Q495_9",
                                    setup_ts_10_v2 = "Q495_10",
                                    setup_ts_11_v2 = "Q495_11",
                                    setup_ts_12_v2 = "Q495_12",
                                    setup_ts_13_v2 = "Q495_13",
                                    setup_ts_14_v2 = "Q495_14",
                                    setup_ts_15_v2 = "Q495_15",
                                    setup_ts_16_v2 = "Q495_16",
                                    five_min_late_v2 = "Q289", #rename because of R 
                                    fifteen_min_late_v2 = "Q93", #rename because of R
                                    arrival_time_v2 = "Q92",
                                    no_resched_01_v2 = "Q168",
                                    no_resched_02_v2 = "Q168_2_TEXT",
                                    no_resched_03_v2 = "Q168_3_TEXT",
                                    no_resched_04_v2 = "Q116_1",
                                    no_resched_05_v2 = "Q116_2",
                                    no_resched_06_v2 = "Q116_3",
                                    no_resched_07_v2 = "Q116_4",
                                    overview_01_v2 = "Q1386_1",
                                    overview_02_v2 = "Q1386_2",
                                    overview_03_v2 = "Q1386_3",
                                    mri_contra_check_v2 = "Q438",
                                    baby_teeth_q03_v2 = "Q1388",
                                    baby_teeth_q04_v2 = "Q1388_1_TEXT",
                                    baby_teeth_q05_v2 = "Q1388_2_TEXT",
                                    med_today_q01_v2 = "Q136_1",
                                    med_today_q02_v2 = "Q136_2",
                                    med_today_q03_v2 = "Q136_3",
                                    med_today_q04_v2 = "Q136_4",
                                    ap_material_return = "Q619",
                                    ap_material_return_plan = "Q620",
                                    discontinue_v2 = "Q172",
                                    discontinue_mri_contra_v2 = "Q172_1_TEXT",
                                    discontinue_si_v2 = "Q172_5_TEXT",
                                    discontinue_other_v2 = "Q172_4_TEXT",
                                    discontinue_info_q01 = "Q160_1",
                                    discontinue_info_q02 = "Q160_2",
                                    discontinue_info_q03 = "Q160_3",
                                    discontinue_info_q04 = "Q160_4",
                                    discontinue_info_q05 = "Q160_5",
                                    discontinue_info_q06 = "Q160_6",
                                    air_mon_q01_v2 = "Q2",
                                    air_mon_q02_v2 = "Q3",
                                    air_mon_q03_v2 = "Q5",
                                    air_mon_q04_v2 = "Q631",
                                    new_mri_contra_v2 = "Q466",
                                    screen_fail_q01_v2 = "Q468_1",
                                    screen_fail_q02_v2 = "Q468_2",
                                    screen_fail_q03_v2 = "Q468_3",
                                    screen_fail_q04_v2 = "Q468_4",
                                    sleep_q01_c_v2 = "Q176",
                                    sleep_q02_c_v2 = "Q178",
                                    sleep_q03_c_v2 = "Q180",
                                    sleep_q04_c_v2 = "Q182",
                                    sleep_q04_text_c_v2 = "Q182_1_TEXT",
                                    sleep_q05_c_v2 = "Q184",
                                    sleep_q06_c_v2 = "Q186",
                                    faces_start_v2 = "Q102",
                                    initial_screening_q01_v2 = "Q171_1",
                                    initial_screening_q02_v2 = "Q171_2",
                                    initial_screening_q03_v2 = "Q171_3",
                                    initial_screening_q04_v2 = "Q171_4",
                                    breathalyzer_q01_v2 = "Q1217",
                                    breathalyzer_q02_v2 = "Q1219",
                                    breathalyzer_q03_v2 = "Q1220",
                                    drug_screen_q01_v2 = "Q158_1",
                                    drug_screen_q02_v2 = "Q158_2",
                                    drug_screen_q03_v2 = "Q160",
                                    drug_screen_q04_v2 = "Q162",
                                    drug_screen_q05_c_v2 = "Q626",
                                    drug_screen_q06_v2 = "Q164",
                                    preg_test_q06_v2 = "Q176.1",
                                    saliva_need_v2 = "Q612",
                                    saliva_start_time_v2 = "Q463_First.Click", #manually rename for R
                                    saliva_stop_time_v2 = "Q463_Last.Click", #manually rename for R
                                    saliva_submit_time_v2 = "Q463_Page.Submit", #manually rename for R
                                    saliva_click_count_v2 = "Q463_Click.Count", #manually rename for R
                                    saliva_q01_v2 = "Q464_1",
                                    saliva_q02_v2 = "Q464_2",
                                    saliva_q03_v2 = "Q464_3",
                                    saliva_q04_v2 = "Q464_4",
                                    saliva_q05_v2 = "Q464_5",
                                    saliva_q06_v2 = "Q464_6",
                                    saliva_q07_v2 = "Q464_7",
                                    saliva_q08_v2 = "Q464_8",
                                    saliva_notes_v2 = "Q465",
                                    c_interview_need_v2 = "Q553",
                                    injury_c = "Q1232",
                                    injury_desc_c = "Q182.1",
                                    injury_type_c = "Q181",
                                    injury_other_desc_c = "Q181_7_TEXT",
                                    injury_role_c = "Q183",
                                    injury_age_c = "Q184.1",
                                    illness_c = "Q186.1",
                                    illness_desc_c = "Q187",
                                    illness_type_c = "Q189",
                                    illness_other_desc_c = "Q189_10_TEXT",
                                    illness_role_c = "Q190",
                                    illness_age_c = "Q191",
                                    comm_violence_c = "Q266",
                                    comm_violence_desc_c = "Q267",
                                    comm_violence_type_c = "Q268",
                                    comm_violence_other_desc_c = "Q268_10_TEXT",
                                    comm_violence_role_c = "Q269",
                                    comm_violence_age_c = "Q270",
                                    dom_violence_c = "Q271",
                                    dom_violence_desc_c = "Q272",
                                    dom_violence_type_c = "Q273",
                                    dom_violence_role_c = "Q274",
                                    dom_violence_age_c = "Q275",
                                    school_violence_c = "Q281",
                                    school_violence_desc_c = "Q282",
                                    school_violence_type_c = "Q283",
                                    school_violence_other_desc_c = "Q283_16_TEXT",
                                    school_violence_role_c = "Q284",
                                    school_violence_age_c = "Q285",
                                    phys_assault_c = "Q286",
                                    phys_assault_desc_c = "Q287",
                                    phys_assault_type_c = "Q288.1",
                                    phys_assault_other_desc_c = "Q288_16_TEXT",
                                    phys_assault_role_c = "Q289.1",
                                    phys_assault_age_c = "Q290.1",
                                    disaster_c = "Q291",
                                    disaster_desc_c = "Q292",
                                    disaster_type_c = "Q293",
                                    disaster_other_desc_c = "Q293_16_TEXT",
                                    disaster_role_c = "Q294",
                                    disaster_age_c = "Q295",
                                    sex_abuse_c = "Q296",
                                    sex_abuse_desc_c = "Q297",
                                    sex_abuse_type_c = "Q298",
                                    sex_abuse_perp_desc_c = "Q298_2_TEXT",
                                    sex_abuse_role_c = "Q299",
                                    sex_abuse_age_c = "Q300",
                                    phys_abuse_c = "Q301",
                                    phys_abuse_desc_c = "Q302",
                                    phys_abuse_type_c = "Q303",
                                    phys_abuse_perp_desc_c = "Q303_17_TEXT",
                                    phys_abuse_role_c = "Q304",
                                    phys_abuse_age_c = "Q305",
                                    neglect_c = "Q306",
                                    neglect_desc_c = "Q307",
                                    neglect_type_c = "Q308",
                                    neglect_other_desc_c = "Q308_12_TEXT",
                                    neglect_perp_desc_c = "Q308_17_TEXT",
                                    neglect_role_c = "Q309",
                                    neglect_age_c = "Q310",
                                    psych_c = "Q311",
                                    psych_desc_c = "Q312",
                                    psych_type_c = "Q313",
                                    psych_other_desc_c = "Q313_12_TEXT",
                                    psych_perp_desc_c = "Q313_17_TEXT",
                                    psych_role_c = "Q314",
                                    psych_age_c = "Q315",
                                    care_interfere_c = "Q316",
                                    care_interfere_desc_c = "Q317",
                                    care_interfere_type_c = "Q318",
                                    care_interfere_other_desc_c = "Q318_19_TEXT",
                                    care_interfere_role_c = "Q319",
                                    care_interfere_age_c = "Q320",
                                    sex_assault_c = "Q322",
                                    sex_assault_desc_c = "Q323",
                                    sex_assault_type_c = "Q324",
                                    sex_assault_other_desc_c = "Q324_19_TEXT",
                                    sex_assault_role_c = "Q325",
                                    sex_assault_age_c = "Q326",
                                    kidnap_c = "Q327",
                                    kidnap_desc_c = "Q328",
                                    kidnap_perp_c = "Q329",
                                    kidnap_time_desc_c = "Q329_24_TEXT",
                                    kidnap_role_c = "Q330",
                                    kidnap_age_c = "Q331",
                                    terrorism_c = "Q332",
                                    terrorism_desc_c = "Q333",
                                    terrorism_type_c = "Q334",
                                    terrorism_other_desc_c = "Q334_24_TEXT",
                                    terrorism_role_c = "Q335",
                                    terrorism_age_c = "Q336",
                                    bereave_c = "Q337",
                                    bereave_desc_c = "Q338",
                                    bereave_person_c = "Q339",
                                    bereave_primary_c = "Q339_8_TEXT",
                                    bereave_parent_c = "Q339_1_TEXT",
                                    bereave_sibling_c = "Q339_29_TEXT",
                                    bereave_grandparent_c = "Q339_9_TEXT",
                                    bereavee_relative_c = "Q339_12_TEXT",
                                    bereave_friend_c = "Q339_22_TEXT",
                                    bereave_other_person_c = "Q339_23_TEXT",
                                    bereave_cause_c = "Q339_24_TEXT",
                                    bereave_role_c = "Q340",
                                    bereave_age_c = "Q341",
                                    separate_c = "Q342",
                                    separate_desc_c = "Q343",
                                    separate_cause_c = "Q344",
                                    separate_other_desc_c = "Q344_24_TEXT",
                                    separate_role_c = "Q345",
                                    separate_age_c = "Q346",
                                    war_c = "Q347",
                                    war_desc_c = "Q348",
                                    war_type_c = "Q349",
                                    war_other_desc_c = "Q349_24_TEXT",
                                    war_role_c = "Q350",
                                    war_age_c = "Q351",
                                    displace_c = "Q352",
                                    displace_desc_c = "Q353",
                                    displace_type_c = "Q354",
                                    displace_other_cause_desc_c = "Q354_29_TEXT",
                                    displace_other_site_deesc_c = "Q354_24_TEXT",
                                    displace_role_c = "Q355",
                                    displace_age_c = "Q356",
                                    traffic_c = "Q357",
                                    traffic_desc_c = "Q358",
                                    traffic_type_c = "Q359",
                                    traffic_other_desc_c = "Q359_24_TEXT",
                                    traffic_role_c = "Q360",
                                    traffic_age_c = "Q361",
                                    bully_c = "Q362",
                                    bully_desc_c = "Q363",
                                    bully_type_c = "Q364",
                                    bully_other_desc_c = "Q364_24_TEXT",
                                    bully_role_c = "Q365",
                                    bully_age_c = "Q366",
                                    witness_suicide_c = "Q372",
                                    witness_suicide_desc_c = "Q373",
                                    witness_suicide_type_c = "Q374",
                                    witness_suicide_other_desc_c = "Q374_24_TEXT",
                                    witness_suicide_role_c = "Q375",
                                    witness_suicide_age_c = "Q376",
                                    attempt_suicide_c = "Q367",
                                    attempt_suicide_desc_c = "Q368",
                                    attempt_suicide_type_c = "Q369",
                                    attempt_suicide_other_desc_c = "Q369_24_TEXT",
                                    attempt_suicide_role_c = "Q370",
                                    attempt_suicide_age_c = "Q371",
                                    other_event_c = "Q439",
                                    other_event_desc_c = "Q440",
                                    other_event_role_c = "Q441",
                                    other_event_age_c = "Q442",
                                    si_q01 = "Q387",
                                    si_q02 = "Q406",
                                    si_q03 = "Q407",
                                    si_q04 = "Q408",
                                    num_cat_trauma_c = "Q377",
                                    one_trauma_desc_c = "Q377_2_TEXT",
                                    most_upset_trauma_type_c = "Q378",
                                    most_upset_trauma_type_other_c = "Q378_3_TEXT",
                                    most_upset_trauma_desc_c = "Q379",
                                    ptss_1_c = "Q381_1",
                                    ptss_2_c = "Q381_2",
                                    ptss_3_c = "Q381_3",
                                    ptss_4_c = "Q381_4",
                                    ptss_5_c = "Q381_5",
                                    ptss_6_c = "Q381_6",
                                    ptss_7_c = "Q381_7",
                                    ptss_8_c = "Q382_1",
                                    ptss_9_c = "Q382_2",
                                    ptss_10_c = "Q382_3",
                                    ptss_11_c = "Q382_4",
                                    ptss_12_c = "Q382_5",
                                    ptss_13_c = "Q382_6",
                                    ptss_14_c = "Q382_7",
                                    ptss_15_c = "Q383_1",
                                    ptss_16_c = "Q383_2",
                                    ptss_17_c = "Q383_3",
                                    ptss_18_c = "Q383_4",
                                    ptss_19_c = "Q383_5",
                                    ptss_20_c = "Q383_6",
                                    ptss_21_c = "Q383_7",
                                    hurt_self_explain = "Q424",
                                    ptss_22_c = "Q384_1",
                                    ptss_23_c = "Q384_2",
                                    ptss_24_c = "Q384_3",
                                    ptss_25_c = "Q384_4",
                                    ptss_26_c = "Q384_5",
                                    ptss_27_c = "Q384_6",
                                    unsafe_things_explain = "Q629",
                                    ptss_28_c = "Q385_1",
                                    ptss_29_c = "Q385_2",
                                    ptss_30_c = "Q385_3",
                                    ptss_31_c = "Q385_4",
                                    ptss_impair_1_c = "Q386",
                                    ptss_impair_2a_c = "Q388",
                                    ptss_impair_2b_c = "Q389",
                                    ptss_impair_2c_c = "Q390",
                                    ptss_impair_3a_c = "Q391",
                                    ptss_impair_3b_c = "Q392",
                                    ptss_impair_4a_c = "Q393",
                                    ptss_impair_5a_c = "Q394",
                                    interview_pt2_need = "Q554",
                                    tish_1a = "Q192",
                                    tish_1b = "Q193",
                                    tish_1c = "Q194",
                                    tish_2a = "Q196",
                                    tish_2b = "Q197.1",
                                    tish_2c = "Q195",
                                    tish_3a = "Q198",
                                    unsafe_home_explain = "Q630",
                                    tish_3b = "Q199",
                                    tish_3c = "Q201",
                                    tish_4a = "Q202",
                                    tish_4b = "Q203",
                                    tish_4c = "Q204",
                                    tish_5a = "Q205",
                                    tish_5b = "Q241",
                                    tish_5c = "Q242",
                                    tish_6a = "Q243",
                                    tish_6b = "Q244",
                                    tish_6c = "Q245",
                                    tish_7a = "Q246",
                                    tish_7b = "Q247",
                                    tish_7c = "Q248",
                                    tish_8a = "Q249",
                                    tish_8b = "Q250",
                                    tish_8c = "Q251",
                                    tish_9a = "Q252",
                                    tish_9b = "Q253",
                                    tish_9c = "Q254",
                                    tish_10a = "Q255",
                                    tish_10b = "Q256",
                                    tish_10c = "Q257",
                                    cdrisc_1 = "Q259",
                                    cdrisc_2 = "Q260_1",
                                    cdrisc_3 = "Q260_2",
                                    cdrisc_4 = "Q260_3",
                                    cdrisc_5 = "Q260_4",
                                    cdrisc_6 = "Q260_5",
                                    cdrisc_7 = "Q260_6",
                                    cdrisc_8 = "Q260_7",
                                    cdrisc_9 = "Q260_8",
                                    cdrisc_10 = "Q260_9",
                                    int_ae_q01 = "Q265",
                                    int_ae_q02 = "Q265_1_TEXT",
                                    int_ae_q03 = "Q265_3_TEXT",
                                    si_q05 = "Q266.1",
                                    int_c_comments = "Q546",
                                    faces_post_int = "Q623",
                                    si_q06 = "Q545",
                                    si_q07 = "Q548",
                                    si_q08 = "Q547",
                                    si_q09 = "Q414",
                                    si_q10 = "Q550",
                                    si_p_convo_q01 = "Q551",
                                    si_p_convo_q02 = "Q557",
                                    si_p_convo_q03 = "Q556",
                                    si_p_convo_q04 = "Q556_3_TEXT",
                                    child_abuse_q01_v2 = "Q419",
                                    child_abuse_q02_v2 = "Q420",
                                    child_abuse_q03_v2 = "Q421",
                                    c_survey_need = "Q625",
                                    c_survey_q01 = "Q387_1",
                                    c_survey_q02 = "Q387_2",
                                    p_interview_need = "Q544",
                                    injury_p = "Q1667",
                                    injury_desc_p = "Q1668",
                                    injury_type_p = "Q1669",
                                    injury_other_desc_p = "Q1669_7_TEXT",
                                    injury_role_p = "Q1670",
                                    injury_age_p = "Q1671",
                                    illness_p = "Q1672",
                                    illness_desc_p = "Q1673",
                                    illness_type_p = "Q1674",
                                    illness_other_desc_p = "Q1674_10_TEXT",
                                    illness_role_p = "Q1675",
                                    illness_age_p = "Q1676",
                                    comm_violence_p = "Q1677",
                                    comm_violence_desc_p = "Q1678",
                                    comm_violence_type_p = "Q1679",
                                    comm_violence_other_desc_p = "Q1679_10_TEXT",
                                    comm_violence_role_p = "Q1680",
                                    comm_violence_age_p = "Q1681",
                                    dom_violence_p = "Q1682",
                                    dom_violence_desc_p = "Q1683",
                                    dom_violence_type_p = "Q1684",
                                    dom_violence_role_p = "Q1685",
                                    dom_violence_age_p = "Q1686",
                                    school_violence_p = "Q1687",
                                    school_violence_desc_p = "Q1688",
                                    school_violence_type_p = "Q1689",
                                    school_violence_other_desc_p = "Q1689_16_TEXT",
                                    school_violence_role_p = "Q1690",
                                    school_violence_age_p = "Q1691",
                                    phys_assault_p = "Q1692",
                                    phys_assault_desc_p = "Q1693",
                                    phys_assault_type_p = "Q1694",
                                    phys_assault_other_desc_p = "Q1694_16_TEXT",
                                    phys_assault_role_p = "Q1695",
                                    phys_assault_age_p = "Q1696",
                                    disaster_p = "Q1697",
                                    disaster_desc_p = "Q1698",
                                    disaster_type_p = "Q1699",
                                    disaster_other_desc_p = "Q1699_16_TEXT",
                                    disaster_role_p = "Q1700",
                                    disaster_age_p = "Q1701",
                                    sex_abuse_p = "Q1702",
                                    sex_abuse_desc_p = "Q1703",
                                    sex_abuse_type_p = "Q1704",
                                    sex_abuse_perp_desc_p = "Q1704_2_TEXT",
                                    sex_abuse_role_p = "Q1705",
                                    sex_abuse_age_p = "Q1706",
                                    phys_abuse_p = "Q1707",
                                    phys_abuse_desc_p = "Q1708",
                                    phys_abuse_type_p = "Q1709",
                                    phys_abuse_perp_desc_p = "Q1709_17_TEXT",
                                    phys_abuse_role_p = "Q1710",
                                    phys_abuse_age_p = "Q1711",
                                    neglect_p = "Q1712",
                                    neglect_desc_p = "Q1713",
                                    neglect_type_p = "Q1714",
                                    neglect_other_desc_p = "Q1714_12_TEXT",
                                    neglect_perp_desc_p = "Q1714_17_TEXT",
                                    neglect_role_p = "Q1715",
                                    neglect_age_p = "Q1716",
                                    psych_p = "Q1717",
                                    psych_desc_p = "Q1718",
                                    psych_type_p = "Q1719",
                                    psych_other_desc_p = "Q1719_12_TEXT",
                                    psych_perp_desc_p = "Q1719_17_TEXT",
                                    psych_role_p = "Q1720",
                                    psych_age_p = "Q1721",
                                    care_interfere_p = "Q1722",
                                    care_interfere_desc_p = "Q1723",
                                    care_interfere_type_p = "Q1724",
                                    care_interfere_other_desc_p = "Q1724_19_TEXT",
                                    care_interfere_role_p = "Q1725",
                                    care_interfere_age_p = "Q1726",
                                    sex_assault_p = "Q1727",
                                    sex_assault_desc_p = "Q1728",
                                    sex_assault_type_p = "Q1729",
                                    sex_assault_other_desc_p = "Q1729_19_TEXT",
                                    sex_assault_role_p = "Q1730",
                                    sex_assault_age_p = "Q1731",
                                    kidnap_p = "Q1732",
                                    kidnap_desc_p = "Q1733",
                                    kidnap_perp_p = "Q1734",
                                    kidnap_time_desc_p = "Q1734_24_TEXT",
                                    kidnap_role_p = "Q1735",
                                    kidnap_age_p = "Q1736",
                                    terrorism_p = "Q1737",
                                    terrorism_desc_p = "Q1738",
                                    terrorism_type_p = "Q1739",
                                    terrorism_other_desc_p = "Q1739_24_TEXT",
                                    terrorism_role_p = "Q1740",
                                    terrorism_age_p = "Q1741",
                                    bereave_p = "Q1742",
                                    bereave_desc_p = "Q1743",
                                    bereave_person_p = "Q1744",
                                    bereave_primary_p = "Q1744_8_TEXT",
                                    bereave_p_p = "Q1744_1_TEXT",
                                    bereave_sibling_p = "Q1744_29_TEXT",
                                    bereave_grandp_p = "Q1744_9_TEXT",
                                    bereavee_relative_p = "Q1744_12_TEXT",
                                    bereave_friend_p = "Q1744_22_TEXT",
                                    bereave_other_person_p = "Q1744_23_TEXT",
                                    bereave_other_cause_p = "Q1744_24_TEXT",
                                    bereave_role_p = "Q1745",
                                    bereave_age_p = "Q1746",
                                    separate_p = "Q1747",
                                    separate_desc_p = "Q1748",
                                    separate_cause_p = "Q1749",
                                    separate_other_desc_p = "Q1749_24_TEXT",
                                    separate_role_p = "Q1750",
                                    separate_age_p = "Q1751",
                                    war_p = "Q1752",
                                    war_desc_p = "Q1753",
                                    war_type_p = "Q1754",
                                    war_other_desc_p = "Q1754_24_TEXT",
                                    war_role_p = "Q1755",
                                    war_age_p = "Q1756",
                                    displace_p = "Q1757",
                                    displace_desc_p = "Q1758",
                                    displace_type_p = "Q1759",
                                    displace_other_cause_desc_p = "Q1759_29_TEXT",
                                    displace_other_site_deesc_p = "Q1759_24_TEXT",
                                    displace_role_p = "Q1760",
                                    displace_age_p = "Q1761",
                                    traffic_p = "Q1762",
                                    traffic_desc_p = "Q1763",
                                    traffic_type_p = "Q1764",
                                    traffic_other_desc_p = "Q1764_24_TEXT",
                                    traffic_role_p = "Q1765",
                                    traffic_age_p = "Q1766",
                                    bully_p = "Q1767",
                                    bully_desc_p = "Q1768",
                                    bully_type_p = "Q1769",
                                    bully_other_desc_p = "Q1769_24_TEXT",
                                    bully_role_p = "Q1770",
                                    bully_age_p = "Q1771",
                                    attempt_suicide_p = "Q1772",
                                    attempt_suicide_desc_p = "Q1773",
                                    attempt_suicide_type_p = "Q1774",
                                    attempt_suicide_other_desc_p = "Q1774_24_TEXT",
                                    attempt_suicide_role_p = "Q1775",
                                    attempt_suicide_age_p = "Q1776",
                                    witness_suicide_p = "Q1777",
                                    witness_suicide_desc_p = "Q1778",
                                    witness_suicide_type_p = "Q1779",
                                    witness_suicide_other_desc_p = "Q1779_24_TEXT",
                                    witness_suicide_role_p = "Q1780",
                                    witness_suicide_age_p = "Q1781",
                                    other_event_p = "Q444",
                                    other_event_desc_p = "Q445",
                                    other_event_role_p = "Q447",
                                    other_event_age_p = "Q448",
                                    num_cat_trauma_p = "Q1782",
                                    one_trauma_desc_p = "Q1782_2_TEXT",
                                    most_upset_trauma_desc_p = "Q1784",
                                    ptss_1_p = "Q1786_1",
                                    ptss_2_p = "Q1786_2",
                                    ptss_3_p = "Q1786_3",
                                    ptss_4_p = "Q1786_4",
                                    ptss_5_p = "Q1786_5",
                                    ptss_6_p = "Q1786_6",
                                    ptss_7_p = "Q1786_7",
                                    ptss_8_p = "Q1787_1",
                                    ptss_9_p = "Q1787_2",
                                    ptss_10_p = "Q1787_3",
                                    ptss_11_p = "Q1787_4",
                                    ptss_12_p = "Q1787_5",
                                    ptss_13_p = "Q1787_6",
                                    ptss_14_p = "Q1787_7",
                                    ptss_15_p = "Q1788_1",
                                    ptss_16_p = "Q1788_2",
                                    ptss_17_p = "Q1788_3",
                                    ptss_18_p = "Q1788_4",
                                    ptss_19_p = "Q1788_5",
                                    ptss_20_p = "Q1788_6",
                                    ptss_21_p = "Q1788_7",
                                    ptss_22_p = "Q1789_1",
                                    ptss_23_p = "Q1789_2",
                                    ptss_24_p = "Q1789_3",
                                    ptss_25_p = "Q1789_4",
                                    ptss_26_p = "Q1789_5",
                                    ptss_27_p = "Q1789_6",
                                    ptss_28_p = "Q1790_1",
                                    ptss_29_p = "Q1790_2",
                                    ptss_30_p = "Q1790_3",
                                    ptss_31_p = "Q1790_4",
                                    ptss_impair_1_p = "Q396",
                                    ptss_impair_2a_p = "Q398",
                                    ptss_impair_2b_p = "Q399",
                                    ptss_impair_2c_p = "Q400",
                                    ptss_impair_3a_p = "Q401",
                                    ptss_impair_3b_p = "Q402",
                                    ptss_impair_4a_p = "Q403",
                                    ptss_impair_5a_p = "Q404",
                                    ptss_impair_5b_p = "Q405",
                                    int_ae_q04 = "Q1791",
                                    int_ae_q05 = "Q1791_1_TEXT",
                                    int_ae_q06 = "Q1791_3_TEXT",
                                    si_q11 = "Q1792",
                                    new_mri_contra_form_v2 = "Q384",
                                    new_mri_contra_form_desc_v2 = "Q384_2_TEXT",
                                    discontinue_q01_v2 = "Q386.1",
                                    mock_scan_q01_v2 = "Q175_1",
                                    mock_scan_q02_v2 = "Q175_2",
                                    mock_scan_q03_v2 = "Q175_3",
                                    mock_scan_q04_v2 = "Q175_4",
                                    mock_scan_q05_v2 = "Q175_5",
                                    mock_scan_q06_v2 = "Q175_6",
                                    mock_scan_q07_v2 = "Q175_7",
                                    mock_scan_q08_v2 = "Q175_8",
                                    faces_mock_scan_c_v2 = "Q196.1",
                                    mock_scan_q09_v2 = "Q453_1",
                                    mock_scan_q10_v2 = "Q453_2",
                                    mock_scan_q11_v2 = "Q453_3",
                                    mock_scan_q12_v2 = "Q1248",
                                    mock_scan_q13_v2 = "Q540",
                                    mock_scan_q14_v2 = "Q1249",
                                    faces_mri_c_v2 = "Q473",
                                    vr_setup_q01_v2 = "Q470_1",
                                    vr_setup_q02_v2 = "Q470_2",
                                    vr_setup_q03_v2 = "Q470_3",
                                    vr_setup_q04_v2 = "Q470_4",
                                    vr_setup_q05_v2 = "Q470_5",
                                    vr_setup_q06_v2 = "Q470_6",
                                    vr_setup_q07_v2 = "Q470_7",
                                    vr_setup_q08_v2 = "Q470_8",
                                    vr_setup_q09_v2 = "Q470_9",
                                    vr_setup_q10_v2 = "Q470_10",
                                    vr_setup_q11_v2 = "Q470_11",
                                    vr_setup_q12_v2 = "Q470_12",
                                    vr_setup_q13_v2 = "Q470_13",
                                    vr_setup_q14_v2 = "Q470_14",
                                    vr_setup_q15_v2 = "Q470_15",
                                    vr_setup_q16_v2 = "Q470_16",
                                    vr_setup_q17_v2 = "Q470_17",
                                    vr_setup_q18_v2 = "Q470_18",
                                    vr_setup_q19_v2 = "Q470_19",
                                    vr_setup_q20_v2 = "Q470_20",
                                    vr_setup_q21_v2 = "Q470_21",
                                    vr_setup_q22_v2 = "Q470_22",
                                    vr_renew_recall_setup_q01_v2 = "Q475_1",
                                    vr_renew_recall_setup_q02_v2 = "Q475_2",
                                    vr_renew_recall_setup_q03_v2 = "Q475_3",
                                    vr_renew_recall_setup_q04_v2 = "Q475_4",
                                    vr_renew_recall_setup_q05_v2 = "Q475_5",
                                    vr_renew_recall_setup_q06_v2 = "Q475_6",
                                    vr_renew_recall_setup_q07_v2 = "Q475_7",
                                    vr_renew_recall_setup_q08_v2 = "Q475_8",
                                    vr_renew_recall_setup_q09_v2 = "Q475_9",
                                    vr_renew_recall_setup_q10_v2 = "Q475_10",
                                    vr_recall_q01_v2 = "Q476_1",
                                    vr_recall_q02_v2 = "Q476_2",
                                    vr_recall_q03_v2 = "Q476_3",
                                    vr_recall_q04_v2 = "Q476_4",
                                    vr_recall_q05_v2 = "Q476_5",
                                    vr_recall_notes_v2 = "Q486",
                                    vr_renewal_q01_v2 = "Q490_1",
                                    vr_renewal_q02_v2 = "Q490_2",
                                    vr_renewal_q03_v2 = "Q490_3",
                                    vr_renewal_q04_v2 = "Q490_4",
                                    vr_renewal_q05_v2 = "Q490_5",
                                    vr_renewal_q06_v2 = "Q490_6",
                                    vr_renewal_notes_v2 = "Q489",
                                    faces_postvr_c_v2 = "Q491",
                                    post_vr_q01_c_v2 = "Q493",
                                    post_vr_q02_c_v2 = "Q493_1_TEXT",
                                    post_vr_q03_c_v2 = "Q494",
                                    ant_q01_vr_v2 = "Q510_1",
                                    ant_q02_vr_v2 = "Q510_2",
                                    ant_q03_vr_v2 = "Q510_3",
                                    ant_q04_vr_v2 = "Q510_4",
                                    ant_q05_vr_v2 = "Q510_5",
                                    ant_q06_vr_v2 = "Q510_6",
                                    ant_version_vr_v2 = "Q507",
                                    vr_ant_notes_v2 = "Q511",
                                    c_survey_complete_v2 = "Q137",
                                    c_survey_notes_v2 = "Q241.1",
                                    si_p_convo_q05 = "Q501",
                                    end_visit_q01_v2 = "Q133_1",
                                    end_visit_q02_v2 = "Q133_2",
                                    end_visit_q03_v2 = "Q133_3",
                                    end_visit_q04_v2 = "Q133_4",
                                    end_visit_q05_v2 = "Q133_5",
                                    end_visit_q06_v2 = "Q133_6",
                                    end_visit_q07_v2 = "Q133_7",
                                    end_visit_q08_v2 = "Q133_8",
                                    final_notes_v2 = "Q106",
                                    scan_setup_q01_v2 = "Q174_1",
                                    scan_setup_q02_v2 = "Q174_2",
                                    scan_setup_q03_v2 = "Q174_3",
                                    scan_setup_q04_v2 = "Q174_4",
                                    scan_setup_q05_v2 = "Q174_5",
                                    scan_setup_q06_v2 = "Q174_6",
                                    scan_setup_q07_v2 = "Q174_7",
                                    scan_setup_q08_v2 = "Q174_8",
                                    scan_setup_q09_v2 = "Q174_9",
                                    scan_setup_q10_v2 = "Q174_10",
                                    scan_setup_q11_v2 = "Q1253",
                                    scan_setup_q12_v2 = "Q1254",
                                    scan_setup_q13_v2 = "Q178.1",
                                    scan_setup_q14_v2 = "Q178_1_TEXT",
                                    scan_setup_q15_v2 = "Q178_2_TEXT",
                                    scan_setup_q16_v2 = "Q178_3_TEXT",
                                    scan_setup_q17_v2 = "Q178_4_TEXT",
                                    mri_scan_q01_v2 = "Q209_1",
                                    mri_scan_q02_v2 = "Q209_2",
                                    mri_scan_q03_v2 = "Q209_3",
                                    mri_scan_q04_v2 = "Q209_4",
                                    mri_scan_q05_v2 = "Q209_5",
                                    mri_scan_q06_v2 = "Q209_6",
                                    mri_scan_q07_v2 = "Q209_7",
                                    mri_scan_q08_v2 = "Q209_8",
                                    mri_scan_q09_v2 = "Q209_9",
                                    t1_scan_notes_v2 = "Q211",
                                    ant_q01_mri_v2 = "Q259_1",
                                    ant_q02_mri_v2 = "Q259_2",
                                    ant_q03_mri_v2 = "Q259_3",
                                    ant_q04_mri_v2 = "Q503_1",
                                    ant_q05_mri_v2 = "Q503_2",
                                    ant_version_mri_v2 = "Q235",
                                    ant_q06_v2 = "Q215",
                                    rs1_q01_v2 = "Q265_1",
                                    rs1_scan_notes_v2 = "Q236",
                                    mri_scan_q10_v2 = "Q217",
                                    mri_scan_q11_v2 = "Q504_1",
                                    mri_scan_q12_v2 = "Q504_2",
                                    mri_scan_q13_v2 = "Q504_3",
                                    mri_scan_q14_v2 = "Q504_4",
                                    mri_scan_q15_v2 = "Q241_1",
                                    mri_scan_q16_v2 = "Q241_2",
                                    mri_scan_q17_v2 = "Q241_3",
                                    mri_scan_q18_v2 = "Q241_4",
                                    mri_scan_q19_v2 = "Q241_5",
                                    mri_recall_notes_v2 = "Q233",
                                    mri_scan_q20_v2 = "Q237_1",
                                    mri_scan_q21_v2 = "Q237_2",
                                    mri_scan_q22_v2 = "Q237_3",
                                    mri_scan_q23_v2 = "Q237_4",
                                    mri_scan_q24_v2 = "Q237_5",
                                    mri_renewal_notes_v2 = "Q257.1",
                                    mri_scan_q25_v2 = "Q502_1",
                                    mri_scan_q26_v2 = "Q502_2",
                                    mri_scan_q27_v2 = "Q253.1",
                                    mri_scan_q28_v2 = "Q255.1",
                                    mri_scan_q29_v2 = "Q255_1_TEXT",
                                    mri_scan_q30_v2 = "Q255_2_TEXT",
                                    mri_scan_q31_v2 = "Q255_3_TEXT",
                                    post_mri_q01_v2 = "Q186_1",
                                    post_mri_q02_v2 = "Q186_2",
                                    post_mri_q03_v2 = "Q186_3",
                                    faces_postmri_c_v2 = "Q197",
                                    post_scan_q01_c_v2 = "Q188",
                                    post_scan_q02_c_v2 = "Q189_1",
                                    post_scan_q03_c_v2 = "Q189_2",
                                    post_scan_q04_c_v2 = "Q191_1",
                                    post_scan_q05_c_v2 = "Q191_4",
                                    post_scan_q06_c_v2 = "Q191_2",
                                    post_scan_q07_c_v2 = "Q192_1",
                                    post_scan_q08_c_v2 = "Q192_2",
                                    post_scan_q09_c_v2 = "Q190.1",
                                    post_scan_q10_c_v2 = "Q190_1_TEXT",
                                    post_scan_q11_c_v2 = "Q193.1",
                                    post_mri_q04_v2 = "Q187_1",
                                    post_mri_q05_v2 = "Q187_2",
                                    post_mri_q06_v2 = "Q187_3",
                                    post_mri_q07_v2 = "Q187_4",
                                    post_mri_q08_v2 = "Q187_5",
                                    post_mri_q09_v2 = "Q187_6",
                                    post_mri_q10_v2 = "Q187_7",
                                    post_mri_q11_v2 = "Q1292")

#Create a new data frame with renamed variables
Teen_Survey_Filtered_data_renamed <- Filtered_Teen_Survey %>% rename(!!!rename_mapping_Teen_Survey)
Parent_Survey_Filtered_data_renamed <- Filtered_Parent_Survey %>% rename(!!!rename_mapping_Parent_Survey)
Parent_Eligibility_Survey_Filtered_data_renamed <- Filtered_Parent_Eligibility_Survey %>% rename(!!!rename_mapping_Parent_Eligibility_Survey)
Teen_Eligibility_Survey_Filtered_data_renamed <- Filtered_Teen_Eligibility %>% rename(!!!rename_mapping_Teen_Eligibility_Survey)
Visit_0_Data_Filtered_data_renamed <- Filtered_Visit_0_Data %>% rename(!!!rename_mapping_Visit_0_Data)
Visit_1_Data_Filtered_data_renamed <- Filtered_Visit_1_Data %>% rename(!!!rename_mapping_Visit_1_Data)
Visit_2_Data_Filtered_data_renamed <- Filtered_Visit_2_Data %>% rename(!!!rename_mapping_Visit_2_Data)


#Recoding variables 
##Teen Survey

###SCARED Recoding
###Create a vector of column names
scared_column <- paste0("scared_c_q", formatC(1:41, width = 2, flag = "0"), "_teensurvey")
###Iterate through the column names
for (col in scared_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Teen_Survey_Filtered_data_renamed[[col]] == "Not True or Hardly Ever True", 0,
    ifelse(
      Teen_Survey_Filtered_data_renamed[[col]] == "Somewhat True or Sometimes True", 1,
      ifelse(
        Teen_Survey_Filtered_data_renamed[[col]] == "Very True or Often True", 2,NA
      )
    )
  )
}
###Change variable to be numeric
for (col in scared_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]]),
    na.strings = "NA"
  )
}


###CAMM Recoding
###Create a vector of column names
camm_column <- paste0("camm_c_q", formatC(1:10, width = 2, flag = "0"), "_teensurvey")
###Iterate through the column names
for (col in camm_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Teen_Survey_Filtered_data_renamed[[col]] == "Always True", 0,
    ifelse(
      Teen_Survey_Filtered_data_renamed[[col]] == "Often True", 1,
      ifelse(
        Teen_Survey_Filtered_data_renamed[[col]] == "Sometimes True", 2, 
        ifelse(
          Teen_Survey_Filtered_data_renamed[[col]] == "Rarely True", 3,
          ifelse(
            Teen_Survey_Filtered_data_renamed[[col]] == "Never True", 4,NA
          )
        )
      )
    )
  )
}
###Change variable to numeric
for (col in camm_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]]),
    na.strings = "NA"
  )
}

###CDI Recoding
Teen_Survey_Filtered_data_renamed$cdi_c_q01_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q01_teensurvey == "I read books all the time.", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q01_teensurvey == "I read books once in a while.", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q01_teensurvey == "I never read books.", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q02_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q02_teensurvey == "I am sad once in a while", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q02_teensurvey == "I am sad many times", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q02_teensurvey == "I am sad all the time", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q03_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q03_teensurvey == "Things will work out for me O.K.", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q03_teensurvey == "I am not sure if things will work out for me", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q03_teensurvey == "Nothing will ever work out for me", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q04_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q04_teensurvey == "I do most things O.K.", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q04_teensurvey == "I do most things wrong", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q04_teensurvey == "I do everything wrong", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q05_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q05_teensurvey == "I like myself", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q05_teensurvey == "I do not like myself", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q05_teensurvey == "I hate myself", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q06_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q06_teensurvey == "I feel like crying once in a while", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q06_teensurvey == "I feel like crying many days", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q06_teensurvey == "I feel like crying every day", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q07_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q07_teensurvey == "Things bother me once in a while", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q07_teensurvey == "Things bother me many times", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q07_teensurvey == "Things bother me all the time", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q08_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q08_teensurvey == "I look O.K.", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q08_teensurvey == "There are some bad things about my looks", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q08_teensurvey == "I look ugly", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q09_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q09_teensurvey == "I do not feel alone", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q09_teensurvey == "I feel alone many times", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q09_teensurvey == "I feel alone all the time", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q10_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q10_teensurvey == "I have plenty of friends", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q10_teensurvey == "I have some friends but I wish I had more", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q10_teensurvey == "I do not have any friends", 2, NA)))
Teen_Survey_Filtered_data_renamed$cdi_c_q11_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q11_teensurvey == "I am sure that somebody loves me", 0, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q11_teensurvey == "I am not sure if anybody loves me", 1, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$cdi_c_q11_teensurvey == "Nobody really loves me", 2, NA)))


###Create a vector of column names
cdi_column <- paste0("cdi_c_q", formatC(1:11, width = 2, flag = "0"), "_teensurvey")

###Change variable to be numeric
for (col in cdi_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]]),
    na.strings = "NA"
  )
}


###PRACY Recoding for youth under 13
###Create a vector of column names
column_pracy_younger <- paste0("pracy_c_q", formatC(1:10, width = 2, flag = "0"), "_younger_teensurvey")
###Iterate through the column names
for (col in column_pracy_younger) {
  Teen_Survey_Filtered_data_renamed[[col]] <- ifelse(Teen_Survey_Filtered_data_renamed[[col]] == "Yes", 1, 
                                                     ifelse(Teen_Survey_Filtered_data_renamed[[col]] == "No", 0,NA))
}
###Change variable to be numeric 
for (col in column_pracy_younger) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]]),
    na.strings = "NA"
  )
}

###PRACY Recoding for youth 13 and older
###Create a vector of column names
column_pracy_older <- paste0("pracy_c_q", formatC(1:10, width = 2, flag = "0"), "_older_teensurvey")
###Iterate through the column names
for (col in column_pracy_older) {
  Teen_Survey_Filtered_data_renamed[[col]] <- ifelse(Teen_Survey_Filtered_data_renamed[[col]] == "Yes", 1, 
                                                     ifelse(Teen_Survey_Filtered_data_renamed[[col]] == "No", 0,NA))
}
###Change variable to be numeric 
for (col in column_pracy_older) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]]),
    na.strings = "NA"
  )
}

###MCTQ Recoding
Teen_Survey_Filtered_data_renamed$mctq_c_q01_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$mctq_c_q01_teensurvey == "Yes", 2, ifelse(Teen_Survey_Filtered_data_renamed$mctq_c_q01_teensurvey == "No", 1,NA))                                                                   
###Change variable to be numeric
Teen_Survey_Filtered_data_renamed$mctq_c_q01_teensurvey <- as.numeric(Teen_Survey_Filtered_data_renamed$mctq_c_q01_teensurvey)

###PCRS Recoding
##Create a vector of column names
pcrs_column <- paste0("pcrs_c_q", formatC(1:15, width = 2, flag = "0"), "_teensurvey")

###Iterate through the column names
for (col in pcrs_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Teen_Survey_Filtered_data_renamed[[col]] == "Definitely NOT", 1,
    ifelse(
      Teen_Survey_Filtered_data_renamed[[col]] == "Not really", 2,
      ifelse(
        Teen_Survey_Filtered_data_renamed[[col]] == "Neutral, not sure", 3, 
        ifelse(
          Teen_Survey_Filtered_data_renamed[[col]] == "Somewhat", 4,
          ifelse(
            Teen_Survey_Filtered_data_renamed[[col]] == "Definitely", 5,NA
          )
        )
      )
    )
  )
}
###Change variable to be numeric
for (col in pcrs_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]]),
    na.strings = "NA"
  )
}


###PEDS-QL Recording
###Create a vector of column names
peds_ql_column <- paste0("peds_ql_c_q", formatC(1:15, width = 2, flag = "0"), "_teensurvey")

###Iterate through the column names
for (col in peds_ql_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Teen_Survey_Filtered_data_renamed[[col]] == "Never", 100,
    ifelse(
      Teen_Survey_Filtered_data_renamed[[col]] == "Almost Never", 75,
      ifelse(
        Teen_Survey_Filtered_data_renamed[[col]] == "Sometimes", 50, 
        ifelse(
          Teen_Survey_Filtered_data_renamed[[col]] == "Often", 25,
          ifelse(
            Teen_Survey_Filtered_data_renamed[[col]] == "Almost Always", 0,NA
          )
        )
      )
    )
  )
}
###Change variable to be numeric
for (col in peds_ql_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]]),
    na.strings = "NA"
  )
}


###Tanner Stages Recoding
Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q01_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q01_teensurvey == "\nDrawing 1: There is no pubic hair.", 1, 
                                                                             ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q01_teensurvey == "\nDrawing 2: There is a little long, lightly colored hair. This hair may be straight or a little curly.", 2, 
                                                                                    ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q01_teensurvey == "\nDrawing 3: The hair is darker in this stage. It is coarser and more curled. It has spread out and thinly covers a larger area.", 3, 
                                                                                           ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q01_teensurvey == "\nDrawing 4: The hair is now as dark, curly, and coarse as that of an adult female. However, the area that the hair covers is not as large as that of an adult female. The hair has not spread out to the thighs.", 4, 
                                                                                                  ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q01_teensurvey == "\nDrawing 5: The hair is now like that of an adult female. It also covers the same area as that of an adult female. The hair usually forms a triangular pattern as it spreads out to the thighs.", 5, NA)))))

Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q02_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q02_teensurvey == "\nThe nipple is raised a little in this stage. The rest of the breast is still not raised.", 1, 
                                                                             ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q02_teensurvey == "\nThis is the breast bud stage. In this stage, the nipple is raised more than in Stage 1. The breast is a small mound. The areola is larger than in Stage 1.", 2, 
                                                                                    ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q02_teensurvey == "\nThe areola and the breast are both larger than in Stage 2. The areola does not stick out away from the breasts.", 3, 
                                                                                           ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q02_teensurvey == "\nThe areola and the nipple make up a mound that sticks above the shape of the breast. (Note: this stage may not happen at all for some girls. Some girls develop from Stage 3 to Stage 5, with no Stage 4).", 4, 
                                                                                                  ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_f_c_q02_teensurvey == "\nThis is the mature adult stage. The breasts are fully developed. Only the nipple sticks out in this stage. The areola has moved back to the general shape of the breast.", 5, NA)))))

Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q01_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q01_teensurvey == "\nDrawing 1: There is no pubic hair at all.", 1, 
                                                                             ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q01_teensurvey == "\nDrawing 2: There is a little soft, long, lightly colored hair. Most of the hair is at the base of the penis. This hair may be straight or a little curly.", 2, 
                                                                                    ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q01_teensurvey == "\nDrawing 3: The hair is darker in this stage. It is coarser and more curled. It has spread out thinly and covers a somewhat larger area.", 3, 
                                                                                           ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q01_teensurvey == "\nDrawing 4: The hair is now as dark, curly, and coarse as that of an adult male. However, the area that the hair covers is not as large as that of an adult male. The hair is not spread out to the thighs.", 4, 
                                                                                                  ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q01_teensurvey == "\nDrawing 5: The hair has spread out to the thighs. The hair is now like that of an adult male. It covers the same area as that of an adult male.", 5, NA)))))

Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q02_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q02_teensurvey == " Drawing 1: The testes, scrotum and penis are about the same size and shape as they were when you were a child.", 1, 
                                                                             ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q02_teensurvey == " Drawing 2: The testes and scrotum have gotten a little larger; the skin of the scrotum has changed; the scrotum, the sack holding the testes, has lowered a little bit.  The penis has gotten only a little larger.", 2, 
                                                                                    ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q02_teensurvey == " Drawing 3: The penis has grown mainly in length. The testes and scrotum have grown and dropped lower than in Stage 2.", 3, 
                                                                                           ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q02_teensurvey == " Drawing 4: The penis has grown even larger. It is wider.  The glans (the head of the penis) is bigger.  The scrotum is darker than before.  It is bigger because the testes have gotten bigger.", 4, 
                                                                                                  ifelse(Teen_Survey_Filtered_data_renamed$tanner_stages_m_c_q02_teensurvey == " Drawing 5: The penis, scrotum, and testes are the size and shape of that of an adult.", 5, NA)))))
tanner_column <- c(
  "tanner_stages_f_c_q01_teensurvey",
  "tanner_stages_f_c_q02_teensurvey",
  "tanner_stages_m_c_q01_teensurvey",
  "tanner_stages_m_c_q02_teensurvey"
)

for (col in tanner_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]])
  )
}


###FAD Recoding
Teen_Survey_Filtered_data_renamed$fad_c_q01_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q01_teensurvey == "1 - Strongly Agree", 4, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q01_teensurvey == "2 - Agree", 3, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q01_teensurvey == "3 - Disagree", 2, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q01_teensurvey == "4 - Strongly Disagree", 1,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q02_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q02_teensurvey == "1 - Strongly Agree", 1, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q02_teensurvey == "2 - Agree", 2, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q02_teensurvey == "3 - Disagree", 3, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q02_teensurvey == "4 - Strongly Disagree", 4,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q03_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q03_teensurvey == "1 - Strongly Agree", 4, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q03_teensurvey == "2 - Agree", 3, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q03_teensurvey == "3 - Disagree", 2, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q03_teensurvey == "4 - Strongly Disagree", 1,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q04_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q04_teensurvey == "1 - Strongly Agree", 1, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q04_teensurvey == "2 - Agree", 2, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q04_teensurvey == "3 - Disagree", 3, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q04_teensurvey == "4 - Strongly Disagree", 4,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q05_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q05_teensurvey == "1 - Strongly Agree", 4, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q05_teensurvey == "2 - Agree", 3, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q05_teensurvey == "3 - Disagree", 2, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q05_teensurvey == "4 - Strongly Disagree", 1,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q06_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q06_teensurvey == "1 - Strongly Agree", 1, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q06_teensurvey == "2 - Agree", 2, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q06_teensurvey == "3 - Disagree", 3, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q06_teensurvey == "4 - Strongly Disagree", 4,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q07_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q07_teensurvey == "1 - Strongly Agree", 4, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q07_teensurvey == "2 - Agree", 3, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q07_teensurvey == "3 - Disagree", 2, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q07_teensurvey == "4 - Strongly Disagree", 1,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q08_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q08_teensurvey == "1 - Strongly Agree", 1, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q08_teensurvey == "2 - Agree", 2, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q08_teensurvey == "3 - Disagree", 3, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q08_teensurvey == "4 - Strongly Disagree", 4,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q09_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q09_teensurvey == "1 - Strongly Agree", 4, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q09_teensurvey == "2 - Agree", 3, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q09_teensurvey == "3 - Disagree", 2, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q09_teensurvey == "4 - Strongly Disagree", 1,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q10_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q10_teensurvey == "1 - Strongly Agree", 1, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q10_teensurvey == "2 - Agree", 2, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q10_teensurvey == "3 - Disagree", 3, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q10_teensurvey == "4 - Strongly Disagree", 4,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q11_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q11_teensurvey == "1 - Strongly Agree", 4, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q11_teensurvey == "2 - Agree", 3, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q11_teensurvey == "3 - Disagree", 2, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q11_teensurvey == "4 - Strongly Disagree", 1,NA))))
Teen_Survey_Filtered_data_renamed$fad_c_q12_teensurvey <- ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q12_teensurvey == "1 - Strongly Agree", 1, 
                                                                 ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q12_teensurvey == "2 - Agree", 2, 
                                                                        ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q12_teensurvey == "3 - Disagree", 3, 
                                                                               ifelse(Teen_Survey_Filtered_data_renamed$fad_c_q12_teensurvey == "4 - Strongly Disagree", 4,NA))))
###Create a vector of column names
fad_column <- paste0("fad_c_q", formatC(1:12, width = 2, flag = "0"), "_teensurvey")
###Change variables to numeric
for (col in fad_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]])
  )
}


###Physical Activity Recoding
##Create a vector of column names
physical_activity_column <- paste0("physical_activity_c_q", formatC(1:3, width = 2, flag = "0"), "_teensurvey")

###Iterate through the column names
for (col in physical_activity_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Teen_Survey_Filtered_data_renamed[[col]] == "0 days", 0,
    ifelse(
      Teen_Survey_Filtered_data_renamed[[col]] == "1 day", 1,
      ifelse(
        Teen_Survey_Filtered_data_renamed[[col]] == "2 days", 2, 
        ifelse(
          Teen_Survey_Filtered_data_renamed[[col]] == "3 days", 3,
          ifelse(
            Teen_Survey_Filtered_data_renamed[[col]] == "4 days", 4,
            ifelse(
              Teen_Survey_Filtered_data_renamed[[col]] == "5 days", 5,
              ifelse(
                Teen_Survey_Filtered_data_renamed[[col]] == "6 days", 6, 
                ifelse(
                  Teen_Survey_Filtered_data_renamed[[col]] == "7 days", 7,NA
                )
              )
            )
          )
        )
      )
    ))
}
###Change variable to be numeric
for (col in physical_activity_column) {
  Teen_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Survey_Filtered_data_renamed[[col]])
  )
}


##Parent Survey
###PCRS-P
##Create a vector of column names
pcrs_column_p <- paste0("pcrs_p_q", formatC(1:15, width = 2, flag = "0"), "_parentsurvey")

###Iterate through the column names
for (col in pcrs_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Parent_Survey_Filtered_data_renamed[[col]] == "Definitely does not apply", 1,
    ifelse(
      Parent_Survey_Filtered_data_renamed[[col]] == "Not really", 2,
      ifelse(
        Parent_Survey_Filtered_data_renamed[[col]] == "Neutral, not sure", 3, 
        ifelse(
          Parent_Survey_Filtered_data_renamed[[col]] == "Applies somewhat", 4,
          ifelse(
            Parent_Survey_Filtered_data_renamed[[col]] == "Definitely applies", 5,NA
          )
        )
      )
    )
  )
}
###Change variable to be numeric
for (col in pcrs_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}

###PEDS-QL Recoding
###Create a vector of column names
peds_ql_column_p <- paste0("peds_ql_p_q", formatC(1:15, width = 2, flag = "0"), "_parentsurvey")

###Iterate through the column names
for (col in peds_ql_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Parent_Survey_Filtered_data_renamed[[col]] == "Never", 100,
    ifelse(
      Parent_Survey_Filtered_data_renamed[[col]] == "Almost Never", 75,
      ifelse(
        Parent_Survey_Filtered_data_renamed[[col]] == "Sometimes", 50, 
        ifelse(
          Parent_Survey_Filtered_data_renamed[[col]] == "Often", 25,
          ifelse(
            Parent_Survey_Filtered_data_renamed[[col]] == "Almost Always", 0,NA
          )
        )
      )
    )
  )
}
###Change variable to be numeric
for (col in pcrs_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}


###BDI-P Recoding
Parent_Survey_Filtered_data_renamed$bdi_p_q01_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q01_parentsurvey == "I do not feel sad.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q01_parentsurvey == "I feel sad.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q01_parentsurvey == "I am sad all of the time and can't snap out of it.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q01_parentsurvey == "I am so sad or unhappy that I can't stand it.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q02_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q02_parentsurvey == "I am not particularly discouraged about the future.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q02_parentsurvey == "I feel discouraged about the future.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q02_parentsurvey == "I feel I have nothing to look forward to.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q02_parentsurvey == "I feel that the future is hopeless and that things cannot improve.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q03_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q03_parentsurvey == "I do not feel like a failure.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q03_parentsurvey == "I feel I have failed more than the average person.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q03_parentsurvey == "As I look back on my life, all I can see is lot of failures.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q03_parentsurvey == "I feel I am a complete failure as a person.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q04_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q04_parentsurvey == "I get as much satisfaction out of things as I used to.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q04_parentsurvey == "I don’t enjoy things the way I used to.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q04_parentsurvey == "I don’t get real satisfaction out of anything anymore.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q04_parentsurvey == "I am dissatisfied or bored with everything.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q05_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q05_parentsurvey == "I don’t feel particularly guilty.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q05_parentsurvey == "I feel guilty a good part of the time.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q05_parentsurvey == "I feel quite guilty most of the time.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q05_parentsurvey == "I feel guilty all of the time.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q06_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q06_parentsurvey == "I don’t feel I am being punished.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q06_parentsurvey == "I feel I may be punished.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q06_parentsurvey == "I expect to be punished.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q06_parentsurvey == "I feel I am being punished.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q07_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q07_parentsurvey == "I don’t feel disappointed in myself.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q07_parentsurvey == "I am disappointed in myself.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q07_parentsurvey == "I am disgusted with myself.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q07_parentsurvey == "I hate myself.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q08_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q08_parentsurvey == "I don’t feel I am worse than anybody else.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q08_parentsurvey == "I am critical of myself for my weaknesses or mistakes.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q08_parentsurvey == "I blame myself all the time for my faults.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q08_parentsurvey == "I blame myself for everything bad that happens.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q09_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q09_parentsurvey == "I don’t cry any more than usual.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q09_parentsurvey == "I cry more now than I used to.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q09_parentsurvey == "I cry all the time now.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q09_parentsurvey == "I used to be able to cry, but now I can’t even cry even though I want to.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q10_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q10_parentsurvey == "I am no more irritated by things than I ever am.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q10_parentsurvey == "I am slightly more irritated now than usual.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q10_parentsurvey == "I am quite annoyed or irritated a good deal of the time.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q10_parentsurvey == "I feel irritated all the time now.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q11_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q11_parentsurvey == "I have not lost interest in other people.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q11_parentsurvey == "I am less interested in other people than I used to be.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q11_parentsurvey == "I have lost most of my interest in other people.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q11_parentsurvey == "I have lost all of my interest in other people.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q12_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q12_parentsurvey == "I make decisions about as well as I ever could.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q12_parentsurvey == "I put off making decisions more than I used to.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q12_parentsurvey == "I have greater difficulty in making decisions than before.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q12_parentsurvey == "I can’t make decisions at all anymore.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q13_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q13_parentsurvey == "I don’t feel that I look any worse than I used to.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q13_parentsurvey == "I am worried that I am looking old or unattractive.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q13_parentsurvey == "I feel that there are permanent changes in my appearance that make me look unattractive.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q13_parentsurvey == "I believe that I look ugly.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q14_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q14_parentsurvey == "I can work about as well as before.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q14_parentsurvey == "It takes an extra effort to get started at doing something.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q14_parentsurvey == "I have to push myself very hard to do anything.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q14_parentsurvey == "I can’t do any work at all.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q15_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q15_parentsurvey == "I can sleep as well as usual.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q15_parentsurvey == "I don’t sleep as well as I used to.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q15_parentsurvey == "I wake up 1-2 hours earlier than usual and find it hard to get back to sleep.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q15_parentsurvey == "I wake up several hours earlier than I used to and cannot get back to sleep.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q16_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q16_parentsurvey == "I don’t get tired more than usual.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q16_parentsurvey == "I get tired more easily than I used to.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q16_parentsurvey == "I get tired from doing almost anything.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q16_parentsurvey == "I am too tired to do anything.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q17_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q17_parentsurvey == "My appetite is no worse than usual.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q17_parentsurvey == "My appetite is not as good as it used to be.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q17_parentsurvey == "My appetite is much worse now.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q17_parentsurvey == "I have no appetite at all anymore.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q18_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q18_parentsurvey == "I haven’t lost much weight, if any, lately.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q18_parentsurvey == "I have lost more than five pounds.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q18_parentsurvey == "I have lost more than ten pounds.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q18_parentsurvey == "I have lost more than fifteen pounds.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q19_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q19_parentsurvey == "I am no more worried about my health than usual.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q19_parentsurvey == "I am worried about physical problems such as aches or pains, or upset stomach, or constipation.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q19_parentsurvey == "I am very worried about physical problems and it’s hard to think of much else.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q19_parentsurvey == "I am so worried about my physical problems that I cannot think about anything else.", 3,NA))))
Parent_Survey_Filtered_data_renamed$bdi_p_q20_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q20_parentsurvey == "I have not noticed any recent change in my interest in sex.", 0, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q20_parentsurvey == "I am less interested in sex than I used to be.", 1, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q20_parentsurvey == "I am much less interested in sex now.", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$bdi_p_q20_parentsurvey == "I have lost interest in sex completely.", 3,NA))))
###Create a vector of column names
bdi_column <- paste0("bdi_p_q", formatC(1:20, width = 2, flag = "0"), "_parentsurvey")
###Change variables to numeric
for (col in bdi_column) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}


###CLERQ Recoding
Parent_Survey_Filtered_data_renamed$clerq_p_q01_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q01_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q01_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q01_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q02_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q02_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q02_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q02_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q03_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q03_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q03_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q03_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q04_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q04_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q04_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q04_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q05_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q05_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q05_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q05_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q06_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q06_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q06_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q06_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q07_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q07_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q07_parentsurvey == "Yes: please list the countries:", 1, NA))
#Skip question 8 since it's the name of the countries
Parent_Survey_Filtered_data_renamed$clerq_p_q09_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q09_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q09_parentsurvey == "Yes: please list the countries:", 1, NA))
#Skip question 10 since it's the name of the countries
Parent_Survey_Filtered_data_renamed$clerq_p_q11_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q11_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q11_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q11_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q12_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q12_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q12_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q12_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q13_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q13_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q13_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q13_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q14_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q14_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q14_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q14_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q15_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q15_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q15_parentsurvey == "Yes", 1, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q15_parentsurvey == "Unsure", 2, NA)))
Parent_Survey_Filtered_data_renamed$clerq_p_q16_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q16_parentsurvey == "No", 0, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$clerq_p_q16_parentsurvey == "Yes", 1, NA))
#Change to numeric
clerq_column_p <- c(
  "clerq_p_q01_parentsurvey",
  "clerq_p_q02_parentsurvey",
  "clerq_p_q03_parentsurvey",
  "clerq_p_q04_parentsurvey",
  "clerq_p_q05_parentsurvey",
  "clerq_p_q06_parentsurvey",
  "clerq_p_q07_parentsurvey",
  "clerq_p_q09_parentsurvey",
  "clerq_p_q11_parentsurvey",
  "clerq_p_q12_parentsurvey",
  "clerq_p_q13_parentsurvey",
  "clerq_p_q14_parentsurvey",
  "clerq_p_q15_parentsurvey",
  "clerq_p_q16_parentsurvey"
)

for (col in clerq_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}


###Family Demographics Rescoring
###Family Assessment Device 
Parent_Survey_Filtered_data_renamed$fad_p_q01_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q01_parentsurvey == "Strongly Agree", 4, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q01_parentsurvey == "Agree", 3, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q01_parentsurvey == "Disagree", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q01_parentsurvey == "Strongly Disagree", 1,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q02_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q02_parentsurvey == "Strongly Agree", 1, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q02_parentsurvey == "Agree", 2, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q02_parentsurvey == "Disagree", 3, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q02_parentsurvey == "Strongly Disagree", 4,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q03_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q03_parentsurvey == "Strongly Agree", 4, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q03_parentsurvey == "Agree", 3, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q03_parentsurvey == "Disagree", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q03_parentsurvey == "Strongly Disagree", 1,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q04_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q04_parentsurvey == "Strongly Agree", 1, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q04_parentsurvey == "Agree", 2, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q04_parentsurvey == "Disagree", 3, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q04_parentsurvey == "Strongly Disagree", 4,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q05_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q05_parentsurvey == "Strongly Agree", 4, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q05_parentsurvey == "Agree", 3, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q05_parentsurvey == "Disagree", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q05_parentsurvey == "Strongly Disagree", 1,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q06_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q06_parentsurvey == "Strongly Agree", 1, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q06_parentsurvey == "Agree", 2, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q06_parentsurvey == "Disagree", 3, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q06_parentsurvey == "Strongly Disagree", 4,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q07_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q07_parentsurvey == "Strongly Agree", 4, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q07_parentsurvey == "Agree", 3, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q07_parentsurvey == "Disagree", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q07_parentsurvey == "Strongly Disagree", 1,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q08_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q08_parentsurvey == "Strongly Agree", 1, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q08_parentsurvey == "Agree", 2, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q08_parentsurvey == "Disagree", 3, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q08_parentsurvey == "Strongly Disagree", 4,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q09_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q09_parentsurvey == "Strongly Agree", 4, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q09_parentsurvey == "Agree", 3, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q09_parentsurvey == "Disagree", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q09_parentsurvey == "Strongly Disagree", 1,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q10_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q10_parentsurvey == "Strongly Agree", 1, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q10_parentsurvey == "Agree", 2, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q10_parentsurvey == "Disagree", 3, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q10_parentsurvey == "Strongly Disagree", 4,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q11_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q11_parentsurvey == "Strongly Agree", 4, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q11_parentsurvey == "Agree", 3, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q11_parentsurvey == "Disagree", 2, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q11_parentsurvey == "Strongly Disagree", 1,NA))))
Parent_Survey_Filtered_data_renamed$fad_p_q12_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q12_parentsurvey == "Strongly Agree", 1, 
                                                                     ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q12_parentsurvey == "Agree", 2, 
                                                                            ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q12_parentsurvey == "Disagree", 3, 
                                                                                   ifelse(Parent_Survey_Filtered_data_renamed$fad_p_q12_parentsurvey == "Strongly Disagree", 4,NA))))
###Create a vector of column names
fad_column_p <- paste0("fad_p_q", formatC(1:12, width = 2, flag = "0"), "_parentsurvey")
###Change variables to numeric
for (col in fad_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}

###MCTQ
Parent_Survey_Filtered_data_renamed$mctq_p_q01_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$mctq_p_q01_parentsurvey == "Yes", 2, ifelse(Parent_Survey_Filtered_data_renamed$mctq_p_q01_parentsurvey == "No", 1,NA))                                                                   
###Change variable to be numeric
Parent_Survey_Filtered_data_renamed$mctq_p_q01_parentsurvey <- as.numeric(
  as.character(Parent_Survey_Filtered_data_renamed$mctq_p_q01_parentsurvey)
)


###IRRS Recoding
###Create a vector of column names
irrs_column <- paste0("irrs_p_q", formatC(4:25, width = 2, flag = "0"), "_parentsurvey")
###Iterate through the column names
for (col in irrs_column) {
  Parent_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Parent_Survey_Filtered_data_renamed[[col]] == "This has never happened to me", 0,
    ifelse(
      Parent_Survey_Filtered_data_renamed[[col]] == "This event happened, but did not bother me", 1,
      ifelse(
        Parent_Survey_Filtered_data_renamed[[col]] == "This event happened & I was slightly upset", 2, 
        ifelse(
          Parent_Survey_Filtered_data_renamed[[col]] == "This event happened & I was upset", 3,
          ifelse(
            Parent_Survey_Filtered_data_renamed[[col]] == "This event happened & I was extremely upset", 4,NA
          )
        )
      )
    )
  )
}
###Change variable to numeric
for (col in irrs_column) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}
###STAI
Parent_Survey_Filtered_data_renamed$stai_p_q01_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q01_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q01_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q01_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q01_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q02_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q02_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q02_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q02_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q02_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q03_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q03_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q03_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q03_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q03_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q04_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q04_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q04_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q04_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q04_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q05_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q05_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q05_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q05_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q05_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q06_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q06_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q06_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q06_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q06_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q07_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q07_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q07_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q07_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q07_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q08_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q08_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q08_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q08_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q08_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q09_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q09_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q09_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q09_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q09_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q10_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q10_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q10_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q10_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q10_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q11_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q11_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q11_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q11_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q11_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q12_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q12_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q12_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q12_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q12_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q13_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q13_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q13_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q13_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q13_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q14_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q14_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q14_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q14_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q14_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q15_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q15_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q15_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q15_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q15_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q16_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q16_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q16_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q16_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q16_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q17_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q17_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q17_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q17_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q17_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q18_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q18_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q18_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q18_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q18_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q19_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q19_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q19_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q19_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q19_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q20_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q20_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q20_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q20_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q20_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q21_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q21_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q21_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q21_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q21_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q22_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q22_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q22_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q22_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q22_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q23_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q23_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q23_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q23_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q23_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q24_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q24_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q24_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q24_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q24_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q25_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q25_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q25_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q25_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q25_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q26_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q26_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q26_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q26_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q26_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q27_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q27_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q27_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q27_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q27_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q28_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q28_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q28_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q28_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q28_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q29_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q29_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q29_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q29_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q29_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q30_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q30_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q30_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q30_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q30_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q31_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q31_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q31_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q31_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q31_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q32_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q32_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q32_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q32_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q32_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q33_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q33_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q33_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q33_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q33_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q34_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q34_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q34_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q34_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q34_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q35_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q35_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q35_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q35_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q35_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q36_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q36_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q36_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q36_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q36_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q37_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q37_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q37_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q37_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q37_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q38_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q38_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q38_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q38_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q38_parentsurvey == "Very Much So", 4,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q39_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q39_parentsurvey == "Not At All", 4, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q39_parentsurvey == "Somewhat", 3, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q39_parentsurvey == "Moderately So", 2, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q39_parentsurvey == "Very Much So", 1,NA))))
Parent_Survey_Filtered_data_renamed$stai_p_q40_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q40_parentsurvey == "Not At All", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q40_parentsurvey == "Somewhat", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q40_parentsurvey == "Moderately So", 3, 
                                                                                    ifelse(Parent_Survey_Filtered_data_renamed$stai_p_q40_parentsurvey == "Very Much So", 4,NA))))
###Create a vector of column names
stai_column_p <- paste0("stai_p_q", formatC(1:40, width = 2, flag = "0"), "_parentsurvey")
###Change variables to numeric
for (col in stai_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}



###EEQU - Recoded the responses for the EEQU based off of what Clara provided in a word document
Parent_Survey_Filtered_data_renamed$eequ_p_q09_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q09_parentsurvey == "Rural", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q09_parentsurvey == "Suburban", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q09_parentsurvey == "City", 3,NA)))
Parent_Survey_Filtered_data_renamed$eequ_p_q10_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q10_parentsurvey == "Low", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q10_parentsurvey == "Medium", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q10_parentsurvey == "High", 3,NA)))
Parent_Survey_Filtered_data_renamed$eequ_p_q62_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q62_parentsurvey == "Rural", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q62_parentsurvey == "Suburban", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q62_parentsurvey == "City", 3,NA)))
Parent_Survey_Filtered_data_renamed$eequ_p_q63_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q63_parentsurvey == "Low", 1, 
                                                                      ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q63_parentsurvey == "Medium", 2, 
                                                                             ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q63_parentsurvey == "High", 3,NA)))
Parent_Survey_Filtered_data_renamed$eequ_p_q111_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q111_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q111_parentsurvey == "Yes", 2, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q111_parentsurvey == "Unsure", 3,NA)))
Parent_Survey_Filtered_data_renamed$eequ_p_q161_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q161_parentsurvey == "No - not during pregnancy", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q161_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q163_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q163_parentsurvey == "No - not during pregnancy", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q163_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q165_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q165_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q165_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q166_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q166_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q166_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q167_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q167_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q167_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q168_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q168_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q168_parentsurvey == "Yes", 2, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q168_parentsurvey == "Unknown", 3,NA)))
Parent_Survey_Filtered_data_renamed$eequ_p_q172_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q172_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q172_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q173_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q173_parentsurvey == "Rarely/never", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q173_parentsurvey == "Every 3-6 months", 2, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q173_parentsurvey == "Monthly", 3,NA)))
Parent_Survey_Filtered_data_renamed$eequ_p_q174_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q174_parentsurvey == "Rarely/never", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q174_parentsurvey == "Every 3-6 months", 2, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q174_parentsurvey == "Monthly", 3, 
                                                                                     ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q174_parentsurvey == "Weekly", 4,NA))))
Parent_Survey_Filtered_data_renamed$eequ_p_q175_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q175_parentsurvey == "None of the above", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q175_parentsurvey == "Pillow-top mattress", 2, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q175_parentsurvey == "Memory Foam mattress", 3, 
                                                                                     ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q175_parentsurvey == "Memory foam pillow", 4,NA))))
Parent_Survey_Filtered_data_renamed$eequ_p_q176_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q176_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q176_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q179_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q179_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q179_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q180_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q180_parentsurvey == "No wall-to-wall carpeting", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q180_parentsurvey == "Over 10 years", 2, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q180_parentsurvey == "5-10 years", 3, 
                                                                                     ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q180_parentsurvey == "1-5 years", 4,NA))))
###Unable to recode eequ_p_q181 because of some responses having numbers in them. R will mark any response that isn't a yes or no with an N/A for the responses with numbers
Parent_Survey_Filtered_data_renamed$eequ_p_q206_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q206_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q206_parentsurvey == "Yes", 2,NA))
Parent_Survey_Filtered_data_renamed$eequ_p_q207_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q207_parentsurvey == "No", 1, 
                                                                       ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q207_parentsurvey == "Yes", 2, 
                                                                              ifelse(Parent_Survey_Filtered_data_renamed$eequ_p_q207_parentsurvey == "Unsure", 3,NA)))

###Change variables to be numeric
eequ_column_p <- c(
  "eequ_p_q09_parentsurvey",
  "eequ_p_q10_parentsurvey",
  "eequ_p_q62_parentsurvey",
  "eequ_p_q63_parentsurvey",
  "eequ_p_q111_parentsurvey",
  "eequ_p_q161_parentsurvey",
  "eequ_p_q163_parentsurvey",
  "eequ_p_q165_parentsurvey",
  "eequ_p_q166_parentsurvey",
  "eequ_p_q167_parentsurvey",
  "eequ_p_q168_parentsurvey",
  "eequ_p_q172_parentsurvey",
  "eequ_p_q173_parentsurvey",
  "eequ_p_q174_parentsurvey",
  "eequ_p_q175_parentsurvey",
  "eequ_p_q176_parentsurvey",
  "eequ_p_q179_parentsurvey",
  "eequ_p_q180_parentsurvey",
  "eequ_p_q206_parentsurvey",
  "eequ_p_q207_parentsurvey"
)

for (col in eequ_column_p) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}

###COVID-19 Questionnaire 
Parent_Survey_Filtered_data_renamed$covid19_p_q01_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q01_parentsurvey == "Yes", 2, 
                                                                         ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q01_parentsurvey == "No", 1,NA))                                                                   
Parent_Survey_Filtered_data_renamed$covid19_p_q04_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q04_parentsurvey == "Yes", 2, 
                                                                         ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q04_parentsurvey == "No", 1,NA))                                                                   
Parent_Survey_Filtered_data_renamed$covid19_p_q07_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q07_parentsurvey == "Yes", 2, 
                                                                         ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q07_parentsurvey == "No", 1,NA))                                                                   
Parent_Survey_Filtered_data_renamed$covid19_p_q10_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q10_parentsurvey == "Yes", 2, 
                                                                         ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q10_parentsurvey == "No", 1,NA))                                                                   
Parent_Survey_Filtered_data_renamed$covid19_p_q13_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q13_parentsurvey == "Yes", 2, 
                                                                         ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q13_parentsurvey == "No", 1,NA))                                                                   
Parent_Survey_Filtered_data_renamed$covid19_p_q15_parentsurvey <- ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q15_parentsurvey == "Yes", 2, 
                                                                         ifelse(Parent_Survey_Filtered_data_renamed$covid19_p_q15_parentsurvey == "No", 1,NA))                                                                   
#change to numeric
covid19_column <- c(
  "covid19_p_q01_parentsurvey",
  "covid19_p_q04_parentsurvey",
  "covid19_p_q07_parentsurvey",
  "covid19_p_q10_parentsurvey",
  "covid19_p_q13_parentsurvey",
  "covid19_p_q15_parentsurvey"
)

for (col in covid19_column) {
  Parent_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Parent_Survey_Filtered_data_renamed[[col]])
  )
}

##Teen Eligibility Survey
###Gender Recoding
Teen_Eligibility_Survey_Filtered_data_renamed$gender_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$gender_teeneligibilitysurvey == "Male?", 1, 
                                                                                     ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$gender_teeneligibilitysurvey == "Female?", 2, 
                                                                                            ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$gender_teeneligibilitysurvey == "Other?", 3, 
                                                                                                   ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$gender_teeneligibilitysurvey == "Rather not say", 4,NA))))
###Change variable to be numeric
Teen_Eligibility_Survey_Filtered_data_renamed$gender_teeneligibilitysurvey <- as.numeric(
  as.character(Teen_Eligibility_Survey_Filtered_data_renamed$gender_teeneligibilitysurvey)
)

###Oral Contraceptive Recoding
Teen_Eligibility_Survey_Filtered_data_renamed$birth_control_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$birth_control_teeneligibilitysurvey == "No", 1, 
                                                                                            ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$birth_control_teeneligibilitysurvey == "Yes", 2,NA))
###Change variable to be numeric
Teen_Eligibility_Survey_Filtered_data_renamed$birth_control_teeneligibilitysurvey <- as.numeric(
  as.character(Teen_Eligibility_Survey_Filtered_data_renamed$birth_control_teeneligibilitysurvey)
)


###SCARED Recoding
###Create a vector of column names
scared_column_teeneligibility <- paste0("scared_c_q", formatC(1:42, width = 2, flag = "0"), "_teeneligibilitysurvey")
###Iterate through the column names
for (col in scared_column_teeneligibility) {
  Teen_Eligibility_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Teen_Eligibility_Survey_Filtered_data_renamed[[col]] == "Not True or Hardly Ever True", 0,
    ifelse(
      Teen_Eligibility_Survey_Filtered_data_renamed[[col]] == "Somewhat True or Sometimes True", 1,
      ifelse(
        Teen_Eligibility_Survey_Filtered_data_renamed[[col]] == "Very True or Often True", 2,NA
      )
    )
  )
}
###Change variable to be numeric
for (col in scared_column_teeneligibility) {
  Teen_Eligibility_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Eligibility_Survey_Filtered_data_renamed[[col]])
  )
}
###TIHSH Recoding
###Create a vector of column names
tihsh_column_teeneligibility <- paste0("tihsh_c_q", formatC(1:20, width = 2, flag = "0"), "_teeneligibilitysurvey")
###Iterate through the column names
for (col in tihsh_column_teeneligibility) {
  Teen_Eligibility_Survey_Filtered_data_renamed[[col]] <- ifelse(
    Teen_Eligibility_Survey_Filtered_data_renamed[[col]] == "Never", 1,
    ifelse(
      Teen_Eligibility_Survey_Filtered_data_renamed[[col]] == "Once", 2,
      ifelse(
        Teen_Eligibility_Survey_Filtered_data_renamed[[col]] == "Two to three times", 3, 
        ifelse(
          Teen_Eligibility_Survey_Filtered_data_renamed[[col]] == "Four or more times", 4,NA
        )
      )
    )
  )
}
###Change variable to be numeric
for (col in tihsh_column_teeneligibility) {
  Teen_Eligibility_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Eligibility_Survey_Filtered_data_renamed[[col]])
  )
}
###Substance Use
Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q01_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q01_teeneligibilitysurvey == "Yes", 2, 
                                                                                                  ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q01_teeneligibilitysurvey == "No", 1,NA))                                                                   
Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q02_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q02_teeneligibilitysurvey == "Yes", 2, 
                                                                                                  ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q02_teeneligibilitysurvey == "No", 1,NA)) 
Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q07_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q07_teeneligibilitysurvey == "Yes", 2, 
                                                                                                  ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q07_teeneligibilitysurvey == "No", 1,NA)) 
Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q08_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q08_teeneligibilitysurvey == "Yes", 2, 
                                                                                                  ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q08_teeneligibilitysurvey == "No", 1,NA)) 
Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q12_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q12_teeneligibilitysurvey == "Yes", 2, 
                                                                                                  ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q12_teeneligibilitysurvey == "No", 1,NA)) 
Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q13_teeneligibilitysurvey <- ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q13_teeneligibilitysurvey == "Yes", 2, 
                                                                                                  ifelse(Teen_Eligibility_Survey_Filtered_data_renamed$substance_use_c_q13_teeneligibilitysurvey == "No", 1,NA)) 
###Change variable to be numeric
substanceuse_column <- c(
  "substance_use_c_q01_teeneligibilitysurvey",
  "substance_use_c_q02_teeneligibilitysurvey",
  "substance_use_c_q07_teeneligibilitysurvey",
  "substance_use_c_q08_teeneligibilitysurvey",
  "substance_use_c_q12_teeneligibilitysurvey",
  "substance_use_c_q13_teeneligibilitysurvey"
)

for (col in substanceuse_column) {
  Teen_Eligibility_Survey_Filtered_data_renamed[[col]] <- as.numeric(
    as.character(Teen_Eligibility_Survey_Filtered_data_renamed[[col]])
  )
}

## TIHSH - spell tish in Sam's trauma interview data
# Create a vector of column names
tish_column_c <- c()
for (i in 1:10) {
  tish_column_c <- c(tish_column_c, paste0("tish_", i, c("a", "b", "c"), "_teen"))
}

# Change variables to numeric
for (col in tish_column_c) {
  Teen_Trauma_Interview_Data[[col]] <- as.numeric(
    as.character(Teen_Trauma_Interview_Data[[col]])
  )
}

# Merging the Data
## Convert sid from integer to character in order to merge

Teen_Eligibility_Survey_Filtered_data_renamed$sid <- as.character(Teen_Eligibility_Survey_Filtered_data_renamed$sid)
Parent_Eligibility_Survey_Filtered_data_renamed$sid <- as.character(Parent_Eligibility_Survey_Filtered_data_renamed$sid)
Parent_Trauma_Interview_Data$sid <- as.character(Parent_Trauma_Interview_Data$sid)
CBCL$sid <- as.character(CBCL$sid)
Race_Data$sid <- as.character(Race_Data$sid)

## Merge data from multiple data frames
## Create a data frame list
ABCD_df_list <- list(Teen_Survey_Filtered_data_renamed, Parent_Survey_Filtered_data_renamed,
                     Teen_Eligibility_Survey_Filtered_data_renamed, Parent_Eligibility_Survey_Filtered_data_renamed,
                     Visit_0_Data_Filtered_data_renamed, Visit_1_Data_Filtered_data_renamed, 
                     Visit_2_Data_Filtered_data_renamed, Teen_Trauma_Interview_Data, Parent_Trauma_Interview_Data, CBCL, Race_Data)

# Define a function to merge multiple data frames by a common column (sid for this data)
ABCD_merge_data <- function(ABCD_df_list) {
  Reduce(function(x, y) merge(x, y, by = "sid", all = TRUE), ABCD_df_list)
}

# Use the merge_df function to merge all data frames in the list
ABCD_merged_data <- ABCD_merge_data(ABCD_df_list)

# Remove unwanted data
## Repeating data from row 1 to 768 that needs to be remove - approved by Hilary
ABCD_merged_data <- ABCD_merged_data %>%
  slice(-c(1:768))
## RAs had taken the survey to test the survey. This data also needs to be removed
ABCD_merged_data <- ABCD_merged_data %>%
  slice(-c(129:145))



# Scoring
## CAMM Sum Score
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(camm_sum_teensurvey = rowSums(select(., starts_with("camm") & ends_with("teensurvey"))))

## CDI Sum Score
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(cdi_sum_teensurvey = rowSums(select(., starts_with("cdi") & ends_with("teensurvey"))))

## FAD Sum Score Child
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(fad_sum_c_teensurvey = rowSums(select(., starts_with("fad") & ends_with("teensurvey")))) 

## FAD Sum Score Parent
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(fad_sum_p_parentsurvey = rowSums(select(., starts_with("fad") & ends_with("parentsurvey"))))

## BDI Sum Score Parent
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(bdi_sum_p_parentsurvey = rowSums(select(., starts_with("bdi") & ends_with("parentsurvey"))))

## SCARED Total Sum Score 
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(scared_sum_c_teensurvey = rowSums(select(., starts_with("scared") & ends_with("teensurvey"))))

## SCARED Panic Disorder or Significant Somatic Symptoms Sum Score
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(PD_sum_c_teensurvey = rowSums(select(., c("scared_c_q01_teensurvey", "scared_c_q06_teensurvey", "scared_c_q09_teensurvey",
                                                   "scared_c_q12_teensurvey", "scared_c_q15_teensurvey", "scared_c_q18_teensurvey",
                                                   "scared_c_q19_teensurvey", "scared_c_q22_teensurvey", "scared_c_q24_teensurvey",
                                                   "scared_c_q27_teensurvey", "scared_c_q30_teensurvey", "scared_c_q34_teensurvey",
                                                   "scared_c_q38_teensurvey"))))

## SCARED Generalized Anxiety Disorder
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(GAD_sum_c_teensurvey = rowSums(select(., c("scared_c_q05_teensurvey", "scared_c_q07_teensurvey", "scared_c_q14_teensurvey",
                                                    "scared_c_q21_teensurvey", "scared_c_q23_teensurvey", "scared_c_q28_teensurvey",
                                                    "scared_c_q33_teensurvey", "scared_c_q35_teensurvey", "scared_c_q37_teensurvey"))))
## SCARED Separation Anxiety Disorder
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(SeparationAD_sum_c_teensurvey = rowSums(select(., c("scared_c_q04_teensurvey", "scared_c_q08_teensurvey", "scared_c_q13_teensurvey",
                                                             "scared_c_q16_teensurvey", "scared_c_q20_teensurvey", "scared_c_q25_teensurvey",
                                                             "scared_c_q29_teensurvey", "scared_c_q31_teensurvey"))))
## SCARED Social Anxiety Disorder
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(SocialAD_sum_c_teensurvey = rowSums(select(., c("scared_c_q03_teensurvey", "scared_c_q10_teensurvey", "scared_c_q26_teensurvey",
                                                         "scared_c_q32_teensurvey", "scared_c_q39_teensurvey", "scared_c_q40_teensurvey",
                                                         "scared_c_q41_teensurvey"))))
## SCARED School Avoidance
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(SchoolAdvoidance_sum_c_teensurvey = rowSums(select(., c("scared_c_q02_teensurvey", "scared_c_q11_teensurvey", "scared_c_q17_teensurvey",
                                                                 "scared_c_q36_teensurvey"))))

## PRACY Sum Score Younger
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(pracy_sum_c_teensurvey_younger = rowSums(select(., starts_with("pracy") & ends_with("_younger_teensurvey"))))
## Replace 0s with NAs for participants that did not complete the PRACY

## PRACY Sum Score Older
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(pracy_sum_c_teensurvey_older = rowSums(select(., starts_with("pracy") & ends_with("_older_teensurvey"))))
## Replace 0s with NAs for participants that did not complete the PRACY


## PEDS_QL Teen Survey Total Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_total_mean_c_teensurvey = rowMeans(select(., starts_with("peds_ql") & ends_with("teensurvey"))))


## PEDS_QL Teen Survey Physical Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_physical_mean_c_teensurvey = rowMeans(select(., c("peds_ql_c_q01_teensurvey", "peds_ql_c_q02_teensurvey", 
                                                                   "peds_ql_c_q03_teensurvey", "peds_ql_c_q04_teensurvey", 
                                                                   "peds_ql_c_q05_teensurvey"))))

## PEDS_QL Teen Survey Emotional Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_emotional_mean_c_teensurvey = rowMeans(select(., c("peds_ql_c_q06_teensurvey", "peds_ql_c_q07_teensurvey", 
                                                                    "peds_ql_c_q08_teensurvey", "peds_ql_c_q09_teensurvey"))))

## PEDS_QL Teen Survey Social Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_social_mean_c_teensurvey = rowMeans(select(., c("peds_ql_c_q10_teensurvey", "peds_ql_c_q11_teensurvey", 
                                                                 "peds_ql_c_q12_teensurvey")))) 

## PEDS_QL Teen Survey School Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_school_mean_c_teensurvey = rowMeans(select(., c("peds_ql_c_q13_teensurvey", "peds_ql_c_q14_teensurvey", 
                                                                 "peds_ql_c_q15_teensurvey"))))
## PEDS_QL Teen Survey Psychosocial Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_psychosocial_mean_c_teensurvey = rowMeans(select(., c("peds_ql_c_q06_teensurvey", "peds_ql_c_q07_teensurvey",
                                                                       "peds_ql_c_q08_teensurvey", "peds_ql_c_q09_teensurvey",
                                                                       "peds_ql_c_q10_teensurvey", "peds_ql_c_q11_teensurvey",
                                                                       "peds_ql_c_q12_teensurvey", "peds_ql_c_q13_teensurvey",
                                                                       "peds_ql_c_q14_teensurvey", "peds_ql_c_q15_teensurvey"))))

## PEDS_QL Parent Survey Total Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_total_mean_p_parentsurvey = rowMeans(select(., starts_with("peds_ql") & ends_with("parentsurvey"))))


## PEDS_QL Parent Survey Physical Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_physical_mean_p_parentsurvey = rowMeans(select(., c("peds_ql_p_q01_parentsurvey", "peds_ql_p_q02_parentsurvey", 
                                                                     "peds_ql_p_q03_parentsurvey", "peds_ql_p_q04_parentsurvey", 
                                                                     "peds_ql_p_q05_parentsurvey"))))

## PEDS_QL Parent Survey Emotional Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_emotional_mean_p_parentsurvey = rowMeans(select(., c("peds_ql_p_q06_parentsurvey", "peds_ql_p_q07_parentsurvey", 
                                                                      "peds_ql_p_q08_parentsurvey", "peds_ql_p_q09_parentsurvey"))))

## PEDS_QL Parent Survey Social Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_social_mean_p_parentsurvey = rowMeans(select(., c("peds_ql_p_q10_parentsurvey", "peds_ql_p_q11_parentsurvey", 
                                                                   "peds_ql_p_q12_parentsurvey"))))

## PEDS_QL Parent Survey School Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_school_mean_p_parentsurvey = rowMeans(select(., c("peds_ql_p_q13_parentsurvey", "peds_ql_p_q14_parentsurvey", 
                                                                   "peds_ql_p_q15_parentsurvey"))))
## PEDS_QL Parent Survey Psychosocial Average
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(peds_ql_psychosocial_mean_p_parentsurvey = rowMeans(select(., c("peds_ql_p_q06_parentsurvey", "peds_ql_p_q07_parentsurvey",
                                                                         "peds_ql_p_q08_parentsurvey", "peds_ql_p_q09_parentsurvey",
                                                                         "peds_ql_p_q10_parentsurvey", "peds_ql_p_q11_parentsurvey",
                                                                         "peds_ql_p_q12_parentsurvey", "peds_ql_p_q13_parentsurvey",
                                                                         "peds_ql_p_q14_parentsurvey", "peds_ql_p_q15_parentsurvey"))))

## Parent Child Relation Scale Conflict - Teen Survey
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(pcrs_conflict_sum_c_teensurvey = rowSums(select(., c("pcrs_c_q02_teensurvey", "pcrs_c_q04_teensurvey", "pcrs_c_q08_teensurvey",
                                                              "pcrs_c_q10_teensurvey", "pcrs_c_q11_teensurvey", "pcrs_c_q12_teensurvey",
                                                              "pcrs_c_q13_teensurvey", "pcrs_c_q14_teensurvey"))))

## Parent Child Relation Scale Closeness - Teen Survey
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(pcrs_closeness_sum_c_teensurvey = rowSums(select(., c("pcrs_c_q01_teensurvey", "pcrs_c_q03_teensurvey", "pcrs_c_q05_teensurvey",
                                                               "pcrs_c_q06_teensurvey", "pcrs_c_q07_teensurvey", "pcrs_c_q09_teensurvey",
                                                               "pcrs_c_q15_teensurvey"))))

## Parent Child Relation Scale Conflict - Parent Survey
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(pcrs_conflict_sum_p_parentsurvey = rowSums(select(., c("pcrs_p_q02_parentsurvey", "pcrs_p_q04_parentsurvey", "pcrs_p_q08_parentsurvey",
                                                                "pcrs_p_q10_parentsurvey", "pcrs_p_q11_parentsurvey", "pcrs_p_q12_parentsurvey",
                                                                "pcrs_p_q13_parentsurvey", "pcrs_p_q14_parentsurvey"))))

## Parent Child Relation Scale Closeness - Teen Survey
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(pcrs_closeness_sum_p_parentsurvey = rowSums(select(., c("pcrs_p_q01_parentsurvey", "pcrs_p_q03_parentsurvey", "pcrs_p_q05_parentsurvey",
                                                                 "pcrs_p_q06_parentsurvey", "pcrs_p_q07_parentsurvey", "pcrs_p_q09_parentsurvey",
                                                                 "pcrs_p_q15_parentsurvey")))) 

## State Trait Anxiety Inventory -State- Parent Survey
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(stai_state_sum_p_parentsurvey = rowSums(select(., c("stai_p_q01_parentsurvey", "stai_p_q02_parentsurvey", "stai_p_q03_parentsurvey",
                                                             "stai_p_q04_parentsurvey", "stai_p_q05_parentsurvey", "stai_p_q06_parentsurvey",
                                                             "stai_p_q07_parentsurvey", "stai_p_q08_parentsurvey", "stai_p_q09_parentsurvey",
                                                             "stai_p_q10_parentsurvey", "stai_p_q11_parentsurvey", "stai_p_q12_parentsurvey",
                                                             "stai_p_q13_parentsurvey", "stai_p_q14_parentsurvey", "stai_p_q15_parentsurvey",
                                                             "stai_p_q16_parentsurvey", "stai_p_q17_parentsurvey", "stai_p_q18_parentsurvey",
                                                             "stai_p_q19_parentsurvey", "stai_p_q20_parentsurvey"))))

## State Trait Anxiety Inventory -Trait- Parent Survey
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(stai_trait_sum_p_parentsurvey = rowSums(select(., c("stai_p_q21_parentsurvey", "stai_p_q22_parentsurvey", "stai_p_q23_parentsurvey",
                                                             "stai_p_q24_parentsurvey", "stai_p_q25_parentsurvey", "stai_p_q26_parentsurvey",
                                                             "stai_p_q27_parentsurvey", "stai_p_q28_parentsurvey", "stai_p_q29_parentsurvey",
                                                             "stai_p_q30_parentsurvey", "stai_p_q31_parentsurvey", "stai_p_q32_parentsurvey",
                                                             "stai_p_q33_parentsurvey", "stai_p_q34_parentsurvey", "stai_p_q35_parentsurvey",
                                                             "stai_p_q36_parentsurvey", "stai_p_q37_parentsurvey", "stai_p_q38_parentsurvey",
                                                             "stai_p_q39_parentsurvey", "stai_p_q40_parentsurvey"))))

## Tanner Stages Female
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(tanner_stages_f_mean_teensurvey = rowMeans(select(., c("tanner_stages_f_c_q01_teensurvey", "tanner_stages_f_c_q02_teensurvey"))))

## Tanner Stages Male
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(tanner_stages_m_mean_teensurvey = rowMeans(select(., c("tanner_stages_m_c_q01_teensurvey", "tanner_stages_m_c_q02_teensurvey"))))

### Number of different types of violence exposure ever experienced 
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(num_type_VE_lifetime = rowSums(select(., c("tish_1a_teen", "tish_2a_teen", "tish_4a_teen",
                                                    "tish_5a_teen", "tish_6a_teen", "tish_7a_teen",
                                                    "tish_8a_teen", "tish_9a_teen", "tish_10a_teen"))))

### Number of different types of violence exposure experienced in past year
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(num_type_VE_pastyear = rowSums(select(., c("tish_1b_teen", "tish_2b_teen", "tish_4b_teen",
                                                    "tish_5b_teen", "tish_6b_teen", "tish_7b_teen",
                                                    "tish_8b_teen", "tish_9b_teen", "tish_10b_teen"))))
#Clara's edited version below
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(num_type_VE_pastyear = rowSums(select(., c("tish_1b_teen", "tish_2b_teen", "tish_4b_teen",
                                                    "tish_5b_teen", "tish_6b_teen", "tish_7b_teen",
                                                    "tish_8b_teen", "tish_9b_teen", "tish_10b_teen")),
                                        na.rm = TRUE))

### Number of times any VE was experienced 
ABCD_merged_data <- ABCD_merged_data %>%
    mutate(frequency_of_VE = rowSums(select(., c("tish_1c_teen", "tish_2c_teen", "tish_4c_teen",
                                                 "tish_5c_teen", "tish_6c_teen", "tish_7c_teen",
                                                 "tish_8c_teen", "tish_9c_teen", "tish_10c_teen"))))
##Clara's edited version below 
### Number of times any VE was experienced 
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(frequency_of_VE = rowSums(select(., c("tish_1c_teen", "tish_2c_teen", "tish_4c_teen",
                                               "tish_5c_teen", "tish_6c_teen", "tish_7c_teen",
                                               "tish_8c_teen", "tish_9c_teen", "tish_10c_teen")),
                                        na.rm = TRUE))

### Refer to tish_3a_teen for feeling safe at home
### Refer to tish_3b_teen for feeling safe at home within the past year
### Refer to tish_3c_teen for number of times child has felt safe at home

## TIHSH Teen Eligibility
### Total violence exposure
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(num_type_VE_teeneligibility = rowSums(select(., c("tihsh_c_q01_teeneligibilitysurvey", "tihsh_c_q02_teeneligibilitysurvey", 
                                                           "tihsh_c_q04_teeneligibilitysurvey", "tihsh_c_q05_teeneligibilitysurvey", 
                                                           "tihsh_c_q06_teeneligibilitysurvey", "tihsh_c_q07_teeneligibilitysurvey", 
                                                           "tihsh_c_q08_teeneligibilitysurvey", "tihsh_c_q09_teeneligibilitysurvey", 
                                                           "tihsh_c_q11_teeneligibilitysurvey", "tihsh_c_q13_teeneligibilitysurvey",
                                                           "tihsh_c_q14_teeneligibilitysurvey", "tihsh_c_q15_teeneligibilitysurvey",
                                                           "tihsh_c_q16_teeneligibilitysurvey", "tihsh_c_q17_teeneligibilitysurvey",
                                                           "tihsh_c_q18_teeneligibilitysurvey", "tihsh_c_q19_teeneligibilitysurvey"))))

### Total safety
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(num_type_safety_teeneligibility = rowSums(select(., c("tihsh_c_q03_teeneligibilitysurvey", "tihsh_c_q10_teeneligibilitysurvey", 
                                                               "tihsh_c_q12_teeneligibilitysurvey", "tihsh_c_q20_teeneligibilitysurvey"))))
## SCARED Teen Eligibility
## SCARED Total Sum Score 
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(scared_sum_c_teeneligibility = rowSums(select(., starts_with("scared") & ends_with("teeneligibilitysurvey") & !ends_with("scared_c_q08_teeneligibilitysurvey"))))

## SCARED Panic Disorder or Significant Somatic Symptoms Sum Score
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(PD_sum_c_teeneligibility = rowSums(select(., c("scared_c_q01_teeneligibilitysurvey", "scared_c_q06_teeneligibilitysurvey", "scared_c_q10_teeneligibilitysurvey",
                                                        "scared_c_q13_teeneligibilitysurvey", "scared_c_q16_teeneligibilitysurvey", "scared_c_q19_teeneligibilitysurvey",
                                                        "scared_c_q20_teeneligibilitysurvey", "scared_c_q23_teeneligibilitysurvey", "scared_c_q25_teeneligibilitysurvey",
                                                        "scared_c_q28_teeneligibilitysurvey", "scared_c_q31_teeneligibilitysurvey", "scared_c_q35_teeneligibilitysurvey",
                                                        "scared_c_q39_teeneligibilitysurvey"))))

## SCARED Generalized Anxiety Disorder
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(GAD_sum_c_teeneligibility = rowSums(select(., c("scared_c_q05_teeneligibilitysurvey", "scared_c_q07_teeneligibilitysurvey", "scared_c_q15_teeneligibilitysurvey",
                                                         "scared_c_q22_teeneligibilitysurvey", "scared_c_q24_teeneligibilitysurvey", "scared_c_q29_teeneligibilitysurvey",
                                                         "scared_c_q34_teeneligibilitysurvey", "scared_c_q36_teeneligibilitysurvey", "scared_c_q38_teeneligibilitysurvey"))))
## SCARED Separation Anxiety Disorder
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(SeparationAD_sum_c_teeneligibility = rowSums(select(., c("scared_c_q04_teeneligibilitysurvey", "scared_c_q09_teeneligibilitysurvey", "scared_c_q14_teeneligibilitysurvey",
                                                                  "scared_c_q17_teeneligibilitysurvey", "scared_c_q21_teeneligibilitysurvey", "scared_c_q26_teeneligibilitysurvey",
                                                                  "scared_c_q30_teeneligibilitysurvey", "scared_c_q32_teeneligibilitysurvey"))))
## SCARED Social Anxiety Disorder
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(SocialAD_sum_c_teeneligibility = rowSums(select(., c("scared_c_q03_teeneligibilitysurvey", "scared_c_q11_teeneligibilitysurvey", "scared_c_q27_teeneligibilitysurvey",
                                                              "scared_c_q33_teeneligibilitysurvey", "scared_c_q40_teeneligibilitysurvey", "scared_c_q41_teeneligibilitysurvey",
                                                              "scared_c_q42_teeneligibilitysurvey"))))
## SCARED School Avoidance
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(SchoolAdvoidance_sum_c_teeneligibility = rowSums(select(., c("scared_c_q02_teeneligibilitysurvey", "scared_c_q12_teeneligibilitysurvey", "scared_c_q18_teeneligibilitysurvey",
                                                                      "scared_c_q37_teeneligibilitysurvey"))))


## IRRS 
### IRRS Cultural
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(irrs_culturalracism_parentsurvey = rowSums(select(., c("irrs_p_q04_parentsurvey", "irrs_p_q06_parentsurvey",
                                                                "irrs_p_q08_parentsurvey", "irrs_p_q09_parentsurvey",
                                                                "irrs_p_q15_parentsurvey", "irrs_p_q18_parentsurvey",
                                                                "irrs_p_q19_parentsurvey", "irrs_p_q20_parentsurvey",
                                                                "irrs_p_q22_parentsurvey", "irrs_p_q23_parentsurvey"))))
### IRRS Institutional
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(irrs_institutionalracism_parentsurvey = rowSums(select(., c("irrs_p_q07_parentsurvey", "irrs_p_q12_parentsurvey",
                                                                     "irrs_p_q13_parentsurvey", "irrs_p_q16_parentsurvey",
                                                                     "irrs_p_q21_parentsurvey", "irrs_p_q25_parentsurvey"))))
### IRRS Individual
ABCD_merged_data <- ABCD_merged_data %>%
  mutate(irrs_individualracism_parentsurvey = rowSums(select(., c("irrs_p_q05_parentsurvey", "irrs_p_q10_parentsurvey",
                                                            "irrs_p_q11_parentsurvey", "irrs_p_q14_parentsurvey",
                                                            "irrs_p_q17_parentsurvey", "irrs_p_q24_parentsurvey"))))

### Convert subscales to z-scores and then average z-score for a global racism score
ABCD_merged_data$irrs_culturalracism_parentsurvey_zscore <- scale(ABCD_merged_data$irrs_culturalracism_parentsurvey)

ABCD_merged_data$irrs_institutionalracism_parentsurvey_zscore <- scale(ABCD_merged_data$irrs_institutionalracism_parentsurvey)

ABCD_merged_data$irrs_individualracism_parentsurvey_zscore <- scale(ABCD_merged_data$irrs_individualracism_parentsurvey)

# Do a mean of the subscales for a global racism score
ABCD_merged_data$irrs_global_racism_score <- rowMeans(
  select(ABCD_merged_data, 
         irrs_culturalracism_parentsurvey_zscore,
         irrs_institutionalracism_parentsurvey_zscore,
         irrs_individualracism_parentsurvey_zscore)
)

# Export data set as a csv file
  install.packages("foreign")
  library(foreign)
  write.csv(ABCD_merged_data, "//Users/amanpreetbhogal/Documents/Research2024/Final_ABCD_Data/ABCD_final_dataset.csv", row.names = FALSE)

