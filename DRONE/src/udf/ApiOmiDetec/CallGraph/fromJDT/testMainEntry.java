package udf.ApiOmiDetec.CallGraph.fromJDT;

import java.io.File;

import GlobalVariables.GlobalTools;

public class testMainEntry {
	
	public static void main(String[] args){
		
		String savePath = "F:\\DocErrorDetect\\CallGraphs\\JDT_way\\ATryTest\\jdk_part\\";
		
		GlobalTools.EmptyFileFoldCleaner(new File(savePath));
		GlobalTools.NoInvokMethodCleaner(new File(savePath));
		GlobalTools.EmptyFileFoldCleaner(new File(savePath));
	}

}
