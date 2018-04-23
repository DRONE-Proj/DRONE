package extrFOL;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import GlobalVariables.CallGraphGlobalSettings;

public class extractFOL {
	private List<FolInfo> folInfo = new ArrayList();
	public List<FolInfo> alterBugsInfo;
	public List<FolInfo> alterBugsInfoNotFilted;
	public List<String>  AllInfo=new ArrayList<String>();
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		extractFOL ex = new extractFOL();
//		alterBugsInfo = ex.alterBugsInfo;
	}
//	public List<FolInfo> folToNlp(){
//		extractFOL ex = new extractFOL();
//		return ex.
//	}
	public extractFOL(){
		try {
			
            String encoding="GBK";
            File file=new File(CallGraphGlobalSettings.ResultSavePath);
         //  File file=new File("C:\\Users\\Administrator\\Desktop\\joda\\CellDocViaInvokations\\checkLog.csv");
            
            if(file.isFile() && file.exists()){ //判断文件是否存在
                InputStreamReader read = new InputStreamReader(
                new FileInputStream(file),encoding);//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
               while ((lineTxt = bufferedReader.readLine()) != null) {
					
					String txt[] = lineTxt.split(",");
					if(txt[1].equals("API"))continue;
					AllInfo.add(lineTxt.toString());
					FolInfo folInf = new FolInfo();
					if (txt[9] != null) {
						folInf.setDocPath(txt[1]);
				//		folInf.setTriggerMethod(txt[1]);
						folInf.setReturnType(txt[3].replace(";", ","));
						folInf.setCkeck(txt[5]);
						try{
						folInf.setException(txt[13].substring(txt[13].indexOf("[")+1,txt[13].indexOf("]")));	
						}catch(Exception e){
							System.out.print(lineTxt.toString());
						}
						try{
						if (txt[12].charAt(0) == '"'){
							txt[12]=txt[12].substring(1,txt[12].length()-1);
							txt[12]=txt[12].replace("\"\"", "\"");
						}
				
							folInf.setFOLs_doc(txt[12]);
						folInf.setAllInfo(txt[13] + "  " + txt[12] );
						}catch(Exception e){
							System.out.println(txt[12]);
						}
					}
                    if(folInf != null){
                    	folInfo.add(folInf);
                    }
                }
                read.close();
                }else{
                	System.out.println("找不到指定的文件");
                	}
            } catch (Exception e) {
            	System.out.println("读取文件内容出错");
            	e.printStackTrace();
            	}
		toNLP tn = new toNLP(folInfo);
		alterBugsInfoNotFilted = tn.alterBugsInfo;
		alterBugsInfo=filterBugsInfo(alterBugsInfoNotFilted);
		try {
			createXLSFile();
		} catch (RowsExceededException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public List<FolInfo> filterBugsInfo(List<FolInfo> bugsInfoNotFilted){
		List<FolInfo> info=new ArrayList<FolInfo>();
		info.addAll(bugsInfoNotFilted);
		for(int i=0;i<info.size();i++){
			FolInfo temp=info.get(i);
			if(temp.getNLPs_doc().isEmpty()||temp.getNLPs_doc()==null){
				info.remove(i);
				i--;
			}
		}
		return info;
	}
	
	public void createXLSFile() throws RowsExceededException, WriteException{
	//	String path="E:\\mine.xls";
		String path=CallGraphGlobalSettings.ResultSavePath.replace(".csv", ".xls");
		File file= new File(path);
		
		String [] header=new String[]{"API","Trigger Location","Parsed Directive","Constraint in Source Code","FOL from Directive","FOL from Source Code","Constraint Type","Our Approach","Manual Classification","NLP"};
		
		WritableWorkbook wwb;
	
			try {
				wwb = Workbook.createWorkbook(file);
				WritableSheet ws=wwb.createSheet("Sheet1", 0);
				for(int i=0;i<header.length;i++){
					Label head=new Label(i,0,header[i]);
					ws.addCell(head);
				}
				int rowNum=AllInfo.size();
				int colNum=10;
				int index=0;
				try{
					int i;
				for(i=0;i<rowNum;i++){
					
					String content=AllInfo.get(i);
				
					String str="";
					String []elements=content.split(",");
					String []elementsChanged=new String[10] ;
				//	System.out.println(i);
					int k=0;
					for(int num=0;num<elements.length;num++){
						if(num==1||num==2||(num>=9&&num!=13))
							elementsChanged[k++]=elements[num];
					}
					if(elements[5].equals("1"))
						elementsChanged[k++]="Consistent";
					else
						elementsChanged[k++]="Inconsistent";
					String check=elementsChanged[k-1];
		//			System.out.println(check);
					if(!check.equals("Consistent")){
						FolInfo s=alterBugsInfoNotFilted.get(index);
				
						index++;
						str=s.getNLPs_doc();
//						if(str.contains("\n")){
//							String []arg=str.split("\n");
//							for(int j=0;j<arg.length;j++)
//								str+=arg[j]+"     ";
						}
						Label la=new Label(colNum-1,i+1,str);
						ws.addCell(la);
//					}
						int j;
					for(j=0;j<colNum-1;j++){
						Label label=new Label(j,i+1,elementsChanged[j]);
						ws.addCell(label);
					}	
					
				}
				wwb.write();
				wwb.close();
				}catch(Exception e){
					
					e.printStackTrace();
				}
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
	
		}


}
