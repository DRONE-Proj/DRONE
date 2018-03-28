package GlobalVariables;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class PrintoutResult {
	
	public static File logFile;
	private static BufferedWriter cnsl;
	
	public static int PreFileNumber = 0;
	public static int TotalFileNumber = 0;
	public static void InitTotalFileNumber(String root){
		TotalFileNumber += CountFiles(new File(root), ".java");
	}
	public static int CountFiles(File file, String constraint){
		if (!file.isDirectory()){
			String filename = file.getName();
			if (! filename.endsWith(constraint))	return 0;
			PrintoutResult.PrintInScreen("Counting file number..." + file.getAbsolutePath());
			return 1;
		}
		File[] files = file.listFiles();
		int num = 0;
		for (File f : files){
			num += CountFiles(f, constraint);
		}
		
		return num;
	}
	
	public static void InitLogConsole() {
		try{
			logFile = new File(CallGraphGlobalSettings.LogConsolePath);
			cnsl = new BufferedWriter(new FileWriter(logFile));
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	public static void CloseLogConsole() throws IOException{
		if (cnsl != null)
			cnsl.close();
	} 
	public static void PrintOutResult(String str){
		//System.out.println(str);
		/*
		try {
			
			cnsl.append(str + "\n");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
	}
	
	public static void PrintInScreen(String str){
		System.out.println(PreFileNumber + "-" + TotalFileNumber + "\t" + str);
//		try {
//			
//			cnsl.append(str + "\n");
//			
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	}

}
