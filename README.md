# DRONE

# ***Description***
***DRONE***(Detector and Repair of doucmentation defects) is integrated into a framework, which can automatically detect and repair 
defects affecting API documents by leveraging techniques from program analysis, natural language processing and constraint solving.

Our approach include several parts as follows:
* Leverage static analysis techniques for program comprehension
* Leverage domain specific, pattern based natural language processing (NLP) techniques for document comprehension
* The above two steps' analysis results are presented in the form of first-order logic (FOL) formulae 
* The generated FOL formulae are then fed into the SMT solver Z3 to detect the defects in case of inconsistency
* In the end, a pattern based patch will be recommended to users, suggesting how to repair the defects

Our approach mainly handles four types of document defects, which include ***null not allowed***, ***null allowed***, ***range limitation*** and ***type restriction***.

We summarize more than 60 heuristics on the typical descriptions of API usage constraints in documents, which could be reused across different doucumentation projects.

***DRONE*** generates some templates by analyzing both extracted code constraints and document patterns for each of the four constraints types.


# ***Configuration***

* step 1. Import the project ***DRONE*** into Eclipse IDE;
* step 2. The two files ***libz3.dll*** and ***libz3java.dll*** needed to be put on the specified path:
***C:/Windows/System32/*** ;
* step 3. You must be sure that ***vcredist_x64.exe*** has been installed( Our tool use the SMT solver ***Z3***, so step 2 and 3 need to be executed.);


# ***Usage***

* step 1. Project should run as ***Eclipse Application***;
* step 2. The tool contains two views: ***DRONE-Detect Vew*** and ***DRONE-Repair View*** (Windows->Show view->Other->sample category-> ***DRONE-Detect Vew*** and ***DRONE-Repair View***);
* step 3. You need to put the projects needed to be detected under the folder ***runtime-EclipseApplication*** which has the same root dictionary with the workspace of Eclipse.
* step 4.	After clicking the corresponding buttons in the ***DRONE-Detect Vew*** step by step , you can finally find a folder which stores the final results and the ***DRONE-Repair View*** will be presented to you. Under the folder ***./CellDocViaInvokations/*** , you can find a file ***checklog.csv***.
* step 5 Handle the file ***checklog.csv*** as the input and click start button and then you can see the recommendation result.
