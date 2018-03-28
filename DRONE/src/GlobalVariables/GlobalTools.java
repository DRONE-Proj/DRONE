package GlobalVariables;

import java.io.File;

public class GlobalTools {
	
	public static void EmptyFileFoldCleaner(File path){
		if(!path.isDirectory())	return;
		File[] files = path.listFiles();
		for (File file : files){
			EmptyFileFoldCleaner(file);
		}
		int num_filesleft = path.listFiles().length;
		if (num_filesleft <= 0){
			System.out.println("deleting..." + path.getAbsolutePath());
			path.delete();
		}
	}
	
	public static void NoInvokMethodCleaner(File path){
		if (!path.isDirectory())	return ;
		String filename = path.getName();
		boolean flag = false;

		File[] files = path.listFiles();
		
		if (filename.endsWith(")")){
			for (File file : files){
				if (file.getName().startsWith("call")){
					flag = true;
					break;
				}
			}
			if (!flag){
				Deleting(path);
				return ;
			}
		}
		for (File file : files){
			NoInvokMethodCleaner(file);
		}
	}
	
	public static void Deleting(File path){
		if (!path.isDirectory()){
			path.delete();
			return;
		}
		File[] files = path.listFiles();
		for (File file : files){
			System.out.println("deleting..." + path.getAbsolutePath());
			Deleting(file);
		}
		path.delete();
	}
	
	public static void main(String[] args){
		String root = "F:/DocErrorDetect/CallGraphs/JDT_way/ATryTest/poi-whole/";
		//NoInvokMethodCleaner(new File(root));
		EmptyFileFoldCleaner(new File(root));
	}
	
}

