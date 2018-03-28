package extrFOL;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class writeToRes {
	public writeToRes(List<FolInfo> folInf){
		File docFile = new File("C:\\Users\\Administrator\\Desktop\\NLPdoc.res");
		try {
			if(!docFile.exists()){
				docFile.createNewFile();
			}else{
				docFile.delete();
				docFile.createNewFile();
			}
			FileWriter docout = new FileWriter(docFile);
			for(FolInfo folI :folInf){
				if(folI.getCkeck().equals("1")) continue;
				docout.append(folI.getNLPs_doc() + "\n");
			}
			docout.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
