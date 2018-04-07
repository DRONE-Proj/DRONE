# DRONE

# ***Description***
***DRONE***(Detector and Repairer of documentation defects) is integrated into a framework, which can automatically detect and repair 
defects of API documents by leveraging techniques from program analysis, natural language processing and constraint solving.

Our approach includes several parts as follows:
* Leverage static analysis techniques for program comprehension
* Leverage domain specific, pattern based natural language processing (NLP) techniques for document comprehension
* The above two steps' analysis results are presented in the form of first-order logic (FOL) formulae 
* The generated FOL formulae are then fed into the SMT solver Z3 to detect the potential defects in case of inconsistency
* In the end, a template based patch will be recommended to users, suggesting how to repair the defects

Our approach mainly handles four types of document defects, which include ***null not allowed***, ***null allowed***, ***range limitation*** and ***type restriction***.

We summarize more than 60 heuristics on the typical descriptions of API usage constraints in documents, which could be reused across different projects.

***DRONE*** generates some templates by analyzing both extracted code constraints and document patterns for each of the four constraints types.


# ***Configuration***

* step 1. Import the project ***DRONE*** into Eclipse IDE;
* step 2. The two files ***libz3.dll*** and ***libz3java.dll*** need to be put under the specified folder:
***C:/Windows/System32/*** ;
* step 3. Please make sure that ***vcredist_x64.exe*** has been installed (Our tool uses the SMT solver ***Z3***, so step 2 and 3 need to be executed.);

(Current release only supports Windows OS)

# ***Usage***

* step 1. Project should run as ***Eclipse Application***;
* step 2. The tool contains two views: ***DRONE-Detect View*** and ***DRONE-Repair View*** (Windows->Show view->Other->sample category-> ***DRONE-Detect View*** and ***DRONE-Repair View***);
* step 3. You need to put the projects to be detected under the folder ***runtime-EclipseApplication*** which has the same root dictionary with the workspace of Eclipse.
* step 4. After clicking the corresponding buttons in the ***DRONE-Detect View*** step by step , you can finally find a folder which stores the final results and the ***DRONE-Repair View*** will be presented to you. Under the folder ***./CellDocViaInvokations/*** , you can find a file ***checklog.csv***.
* step 5. Select the file ***checklog.csv*** as the input and click start button and then you will see the recommendation result.

# ***Explanation of the file formats of Experiment Results***
* The corresponding experiment results are all under the folder of ***Replication***
* The experiment results from 1 to 2 are all recorded in the files named of ***experiment1.xls***, ***experiment2_part1.xls*** and ***experiment2_part2.xls*** respectively. Note that experiment 2 has two parts.
* With respect to  the file ***experiment1.xls***, column 1 records the corresponding links to the version where the the defects exist, column 5 and 6 record the corresponding FOLs generated from directives and source codes, respectively. Column 7 records the analysis results of our tool "DRONE" and column 8 records the manual classification.
* The layout of the file ***experiment2_part1.xls*** and ***experiment2_part2.xls*** is the same as that of the files ***experiment1.xls***.
* The files under the folder ***experiment3*** record the recommendations of the corresponding detected defects of experiment1 and experiment2.
* The files under the folder ***AssociatedMethodBody*** record the 3915 detected defects(1689+1605+621), which are recorded in the file ***inconsistent***, and the associated method bodies of the 3915 defects, which are recorded in the files named of ***APISource_experiment1***, ***APISource_experiment2*** and ***APISource_experiment3***.
* The files under the folder ***StatisticalOfVerbsAndSubjects*** contain the statistics of the POS process over the 34874 tags: how many with subject? with verbs? what are the most commons verbs?


