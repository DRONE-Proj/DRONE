package extrFOL;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class toNLP {
	public String exception;
	public String FOLs_doc;
	public String NLPs_doc;
	public String ckeck;
	public String docPath;
	public String projectName;
	public String methodName;
	public String returnType;
	public String AllInfo;
	public List<String> paramType;
	public List<FolInfo> alterBugsInfo = new ArrayList<FolInfo>();
	private List<String> storeCommon=new ArrayList<String>();
	private List<String> storeSpec=new ArrayList<String>();
	public toNLP(List<FolInfo> folInfo){
//		System.out.println(folInfo);
		for(FolInfo folI :folInfo){
			FolInfo folInf = new FolInfo();
			this.exception = folI.getException();
			this.FOLs_doc = folI.getFOLs_doc();
			this.ckeck = folI.getCkeck();
			this.returnType = folI.getReturnType();
			this.AllInfo = folI.getAllInfo();
		//	System.out.println(this.ckeck);
			if(this.ckeck.equals("1")) continue;
			if(this.exception.contains("SOLOIF")||this.exception.contains("FIRSTRETURN")){
				this.NLPs_doc = getNLPs_doc2(this.FOLs_doc).trim();
				if(this.NLPs_doc.equals(""))
					this.NLPs_doc="";
				//	this.NLPs_doc="Constraint Missing";
			}else{
				try{
				this.NLPs_doc = "@throws " + this.exception + "   If " + getNLPs_doc(this.FOLs_doc, this.exception)+".";
				}catch(Exception e){
					System.out.println(this.FOLs_doc);
				}
			}
			if(this.NLPs_doc.contains("Sorry")){
				this.NLPs_doc = "Sorry,No better advice." + this.FOLs_doc;
			}
			folI.setNLPs_doc(this.NLPs_doc);
			this.docPath = processDocPath(folI.getDocPath());
			this.projectName = processProjectName(folI.getDocPath());
			this.methodName = processMethodName(folI.getDocPath());
			this.paramType = processParamType(folI.getDocPath());
			
			folInf.setCkeck(this.ckeck);
			folInf.setDocPath(this.docPath);
			folInf.setNLPs_doc(this.NLPs_doc);
			folInf.setProjectName(this.projectName);
			folInf.setMethodName(this.methodName);
			folInf.setReturnType(this.returnType);
			folInf.setParamType(this.paramType);
			folInf.setAllInfo(this.AllInfo);
			
			alterBugsInfo.add(folInf);
//			System.out.println(this.NLPs_doc);
		}
		writeToRes wr = new writeToRes(folInfo);
	}
	public void filterFolCompletely(List<String> tempList){
		for(String set:tempList){
			String s=set.substring(0,1);
			if(s.equals("V")||s.equals("T")||s.equals("N")){
				if(s.equals("N"))
					storeSpec.add(set);
			}
			else{
				List<String> temp=getFirstFol(set);
				filterFolCompletely(temp);
				}
					
		}
	}
	public List<String> filterElementWithSameName(List<String> list){
		for(int i=0;i<list.size()-1;i++){
			String set=list.get(i);
			String s=set.substring(set.indexOf("("),set.indexOf(";"));
			for(int j=i+1;j<list.size();j++){
				String set2=list.get(j);
				String s2=set2.substring(set2.indexOf("("),set2.indexOf(";"));
				if(s.equals(s2)){
					list.remove(j);
					j--;
				}
			}
		}
		return list;
		
	}
	

	public String  getNLPs_doc2(String fol){
		String NLP="";
		storeSpec.clear();
		String type=fol.substring(0,1);
		if(type.equals("N")||type.equals("T")||type.equals("V")){
			if(type.equals("N")){
				String pName=fol.substring(fol.indexOf("(")+1,fol.indexOf(";"));
				NLP=NLP+"@param "+pName+"    "+pName+ " could be null.";
			}
			return NLP;
		} 
		List<String> list=getFirstFol(fol);
		filterFolCompletely(list);
	    List<String> list2= filterElementWithSameName(storeSpec);
		if(list2.size()>0){
			for(String s:list2){
				try{
				String pName=s.substring(s.indexOf("(")+1,s.indexOf(";"));
				if(s.equals(list2.get(list2.size()-1))){
				    NLP=NLP+"@param "+pName+"    "+pName+ " could be null.";
				}
				else
					NLP=NLP+"@param "+pName+"    "+pName+ " could be null\n";
			}catch(Exception e){
				System.out.println(fol);
			}
			}
			return NLP.trim().toString();
		}
		
		else 
			return "";
	}
	public String getNLPs_doc(String fol, String exception){
		String first = fol.trim().substring(0,1);
		String AnswerDoc = new String();
		
		if(first.equals("A")){
			AnswerDoc = OrAndProcess(fol, exception,"and");
		}
		else if(first.equals("O")){
			AnswerDoc = OrAndProcess(fol, exception,"or");
		}
		else if(first.equals("V")){
			AnswerDoc = VcProcess(fol);
		}
		else if(first.equals("N")){
			AnswerDoc = NullProcess(fol, exception);
		}
		else if(first.equals("T")){
			AnswerDoc = TypeProcess(fol);
		}
		else if(first.equals("I")){
			AnswerDoc = InSetProcess(fol);
		}
		else{
			AnswerDoc = "Sorry,No better advice.";
		}
		return AnswerDoc;
	}
	public List<String> getFirstFol(String fol){
		String str = fol.substring(fol.indexOf("(") + 1,fol.length() - 1);
//		System.out.println(s);
		List<String> firstfol = new ArrayList<String>(); 
		int location = 0;
		while(str.length()> 0){
			location = getlocation(str);
			String first = str.substring(0, location+1);
			firstfol.add(first);
			if(!first.equals(str)){
				str = str.substring(location+2, str.length());
			}else{
				break;
			}
		}
		return firstfol;
	}

	public String judgeCombination(List<String> folInfo){
		if(folInfo.size()<2)
			return String.valueOf(-1);
		else{
			for(int i=0;i<folInfo.size();i++){
				String fol=folInfo.get(i);
				String[] str=fol.substring(fol.indexOf("(")+1, fol.length()-1).split(";");
				for(int j=i+1;j<folInfo.size();j++){
					String fol2=folInfo.get(j);
					String[] str2=fol2.substring(fol2.indexOf("(")+1, fol2.length()-1).split(";");
					if(fol.charAt(0)==fol2.charAt(0)){
						if(fol.charAt(0)=='V'&&str[0]==str2[0])
							return String.valueOf(i)+j;	
					}
				}
			}
		}
		return String.valueOf(-1);
	}
	public String judgeNull(String str,String str2,String type){//用于判断两个空值约束的fol是否可以进行合并
		String [] list=str.substring(str.indexOf("(")+1,str.length()-1).split(";");
		String [] list2=str2.substring(str2.indexOf("(")+1,str2.length()-1).split(";");
		if(list[1].equals(list2[1])){
			if(list[0].contains(" "+type+" "))
				list[0]=list[0].replace(" "+type+" ",", ");
			return list[0]+" "+type+" "+list2[0];		
		}
		return "-1";
	}
	public String judgeType(String fol,String fol2,String type){
		String [] list=fol.substring(fol.indexOf("(")+1,fol.length()-1).split(";");
		String [] list2=fol2.substring(fol2.indexOf("(")+1,fol2.length()-1).split(";");
		if(list[1].equals(list2[1])&&list[2].equals(list2[2])){
			if(list[0].contains(" "+type+" "))
				list[0]=list[0].replace(" "+type+" ",", ");
			return list[0]+" "+type+" "+list2[0];		
		}
		return "-1";
	}
	public String judgeRange(String fol,String fol2,String type){
		String [] list=fol.substring(fol.indexOf("(")+1,fol.length()-1).split(";");
		String [] list2=fol2.substring(fol2.indexOf("(")+1,fol2.length()-1).split(";");
		if(list[1].equals(list2[1])){
			if(list[2].equals(list2[2]))
				if(list[3].equals(list2[3])||((list[3].equals("=")||list[3].equals("=="))&&(list2[3].equals("=")||list2[3].equals("==")))){
					if(list[0].contains(" "+type+" "))
						list[0]=list[0].replace(" "+type+" ",", ");
					return list[0]+" "+type+" "+list2[0];
				
						
				}	
		}
		return "-1";
	}
	public String judgeRange2(String fol,String fol2){
		String [] list=splitSimpleFol(fol);
		String [] list2=splitSimpleFol(fol2);
		if(fol2.substring(0,1).equals("N"))
			return "-1";
		if(list[0].equals(list2[0])&&fol2.substring(0,1).equals("T"))
			return "3";
		if(list[0].equals(list2[0])){
			if(list[2].equals(list2[2]))
				if(list[3].equals("=")||list[3].equals("=="))
					if(list[3].equals("=")||list[3].equals("==")){
						return "2";
					}
		return "1";
		}
		return "-1";
	}
	public List<String> sort(List<String> folInfo){//排序，把为同一种限制约束的放在一起
		int flag=-1;//用于标记是否存在限制约束相同的元素，存在则count++
		int count=0;//用于记录每种限制约束相同的个数，并将其标记到对应的fol中去
		int index=0;//下标
		List<String> tempList=new ArrayList<String>();
		for(int i=0;i<folInfo.size();i++){
			String fol=folInfo.get(i);
			for(int j=i+1;j<folInfo.size();j++){
				String fol2=folInfo.get(j);
				if(fol.charAt(0)==fol2.charAt(0)){
					tempList.add(fol2);
					folInfo.remove(j);
					j--;
					count++;
					flag=1;
				}
			}
			if(flag==1){
				count++;
				tempList.add(fol);
				tempList.set(index, count+"___"+tempList.get(index));
				folInfo.remove(i);
				i--;
				index=count;		
			}	
			flag=-1;
			count=0;
		}
		if(tempList.size()==0)
			return folInfo;
		else{
			if(folInfo.size()==0)
				return tempList;
			else{
				for(String s:folInfo)
					tempList.add(s);
				return tempList;
			}
		}
	}

	public String Select(char judge,String fol,String fol2,String type){
		switch(judge){
		case 'N':
			return judgeNull(fol,fol2,type);
		case 'V':
			return judgeRange(fol,fol2,type);
		case 'T':
			return judgeType(fol,fol2,type);
		default:
			return "-2";
			
		}
	}


	public List<String> simplifyFol(List<String> folInfo, String type){
		for(int i=0;i<folInfo.size();i++){
			String current=folInfo.get(i);
			String type2=current.substring(0,1);		
			if(type2.equals(type)){
				List<String> list=getFirstFol(current);
				folInfo.remove(i);
				i--;
				simplifyFol(list,type);			
			}
			else if(type2.equals("T")||type2.equals("V")||type2.equals("N"))
				storeCommon.add(current);
			else
				storeSpec.add(current);
		}
		return folInfo;
	}
  public String OrAndProcess(String fol, String exception,String compl){
	List<String> firstfol = getFirstFol(fol); 
	List<String> tempList=new ArrayList<String>();
	List<String> tempList2=new ArrayList<String>();
	for(String fol1:firstfol){//拆分FOL
		if(fol1.charAt(0)=='A'||fol1.charAt(0)=='O'){
			tempList.add(fol1);//只包含以A和O开头的字符串
		}
		else
			tempList2.add(fol1);//只包含以V,T和N开头的字符串
	}
	String type=compl.substring(0,1).toUpperCase();//判断首字母是A还是O
	storeCommon.clear();
	storeSpec.clear();
	simplifyFol(tempList,type);//简化tempList,使其更易转化为NLP
	for(String s:storeCommon)
		tempList2.add(s);	
	tempList2=sort(tempList2);//重排,使得开头字母相同的字符串毗邻
	tempList2=ConditonCommonComb(tempList2,compl);//判定一阶逻辑表达式中约束限制属于同一种的情况下是否执行和并操作（若合并，则表示相对应的一阶逻辑表达式中，除参数名可能不相同，其余均相同）
	tempList2=ArgCommonComb(tempList2);//判断判定一阶逻辑表达式中约束限制属于同一种的情况下是否执行和并操作（若合并则表示对应的参数对象相同）
	for(int i=0;i<tempList2.size();i++){
		String lis=tempList2.get(i);
		if(lis.contains("___"))
			tempList2.set(i, lis.substring(4));
		}
	for(String fol1:storeSpec)//把以O或者A开头的子字符串添加到list中
		tempList2.add(fol1);
	return logicJudge(tempList2,compl);//连接符号或连接词的逻辑判断

}
  public List<String> ConditonCommonComb(List<String> tempList,String compl){
		int total=0;
		String temp=null;
		for(int i=0;i<tempList.size()-1;i++){//判定一阶逻辑表达式中约束限制属于同一种的情况下是否执行和并操作（若合并，则表示相对应的一阶逻辑表达式中，除参数名可能不相同，其余均相同）
			int count=0;
			if(i>=total)
			 temp=tempList.get(total);
			if(temp.contains("___")||i<total-1){
				count=Integer.parseInt(temp.substring(0,1));
				if(i>=total)
					total=total+count;
				for(int j=i+1;j<total;j++){
						String backStr=null;
						backStr=Select(temp.charAt(4),tempList.get(i),tempList.get(j),compl);
						if(backStr!="-1"&&backStr!="-2"){
							tempList.remove(j);
							String var=tempList.get(i);
							String elem[]=splitSimpleFol(var);
							if(var.contains("[")||var.contains("]")||var.contains("&")){
								var=var.replace(elem[0],backStr);
							}
							else
								var=var.replaceFirst(elem[0],backStr);
							tempList.set(i, var);
							j--;
							count--;
							total--;
						}
				}			
				String rep=tempList.get(total-count);
				rep=rep.replaceFirst(rep.substring(0,1), String.valueOf(count));	
				tempList.set(total-count,rep );
				temp=tempList.get(total-count);
			}
		}
		return tempList;
  }
  public List<String> ArgCommonComb(List<String> tempList){
		//判断判定一阶逻辑表达式中约束限制属于同一种的情况下是否执行和并操作（若合并则表示对应的参数对象相同）
		int total=0;
		String fol3=null;
		for(int i=0;i<tempList.size();i++){	
			if(i>=total)
			  fol3=tempList.get(total);
			if(fol3.contains("___")){
				int count=Integer.parseInt(String.valueOf(fol3.charAt(0)));
				if(i>=total)
					total=total+count;
				if(count>=2){
					for(int j=i+1;j<total;j++){
						//try{
						String backStr=judgeRange2(tempList.get(i),tempList.get(j));
						
						if(backStr.equals("1")||backStr.equals("2")||backStr.equals("3")){
							String fol4=tempList.get(j);
							String element[]=splitSimpleFol(fol4);
							if(backStr.equals("1"))
								if(element[0].contains("[")||element[0].contains("]")||element[0].contains("&"))
									fol4=fol4.replace(element[0].trim(),"111");
								else
									fol4=fol4.replaceFirst(element[0].trim(),"111");
							else 
								if(backStr.equals("2")){
									if(element[0].contains("[")||element[0].contains("]")||element[0].contains("&"))
										fol4=fol4.replace(element[0].trim(),"222");
									else
										fol4=fol4.replaceFirst(element[0].trim(),"222");
								}
								else{
									if(element[0].contains("[")||element[0].contains("]")||element[0].contains("&"))
										fol4=fol4.replace(element[0].trim(),"333");
									else
										fol4=fol4.replaceFirst(element[0].trim(),"333");
								}
							tempList.set(j, fol4);
							if(j>i+1)//调换位置，如果与tempList.get(i)或者包含"111"、"222"、"333"的字符串不相邻，则调换到相邻的位置
								for(int k=i+1;k<j;k++){
									String change=tempList.get(k);
									if(fol4.contains("222")&&change.contains("111")){
											for(int m=j-1;m>=k;m--){
												String temp=tempList.get(m);
												tempList.set(m+1, temp);	
											}
											tempList.set(k, fol4);
											break;
									}else
									if(!change.contains("111")&&!change.contains("222")&&!change.contains("333")){
										tempList.set(k, fol4);
										tempList.set(j, change);
										break;
									}
									
								}
					//	}
					//	}catch(Exception e){
					//		System.out.println(fol);
						
						}
					}
				}			
			}
		}
		return tempList;
  }
 public String logicJudge(List<String> tempList,String compl){
	 StringBuilder itemcell = new StringBuilder();
	 boolean flag=true;
	 for(int i=0;i<tempList.size();i++){
			String current=tempList.get(i);
			if(flag){
				itemcell.append(getNLPs_doc(current, exception));
				flag=false;
			}
			else {
				if(current.contains("333"))
				    itemcell.append(" or ");
				else {
					if(i==tempList.size()-1){
						if(!current.contains("222"))
							itemcell.append(" "+compl+" ");
						else
							itemcell.append(" or ");
					}
					else{
						boolean WheTheLast=judgeIfTheLastElement(tempList,i);
						String next=tempList.get(i+1);
						if(WheTheLast==true){	
							if(!current.contains("222")&&!current.contains("111"))
								itemcell.append(" "+compl+" ");
							else
								itemcell.append(", ");
						}	
						else
							if(current.contains("222")&&!next.contains("222"))
								itemcell.append(" or ");
							else
								if(current.contains("111")&&!next.contains("111"))
									itemcell.append(" "+compl+" ");
								else 		
									itemcell.append(", ");		
					}	
				}
				itemcell.append(getNLPs_doc(current, exception));
			}
			}
		return itemcell.toString();
 }
  public boolean judgeIfTheLastElement(List<String> list,int start){
	  for(int i=start+1;i<list.size();i++){
		  if(!list.get(i).contains("111")&&!list.get(i).contains("222"))
			  return false;
	  }
	  return true;
  }
//    public String OrAndProcess(String fol, String exception,String compl){
//    	List<String> firstfol = getFirstFol(fol); 
//		StringBuilder itemcell = new StringBuilder();
//		boolean flag = true;
//		List<String> tempList=new ArrayList<String>();
//		List<String> tempList2=new ArrayList<String>();
//		for(String fol1:firstfol){
//			if(fol1.charAt(0)=='A'||fol1.charAt(0)=='O'){
//				tempList.add(fol1);
//			}
//			else
//				tempList2.add(fol1);
//		}
//		tempList2=sort(tempList2);
//		for(int i=0;i<tempList2.size()-1;i++){
//			String temp=tempList2.get(i);
//			if(temp.contains("_")){
//				int count=Integer.parseInt(temp.substring(0,1));
//				String combine=null;
//				for(int j=i+1;j<count+i;j++){
//					if(temp.charAt(2)=='N'){//空值约束条件出现两个或两个以上
//						String backStr=null;
//						if(count>=3)//判断加逗号还是or或者and
//							backStr=judgeNull(temp,tempList2.get(j),",");
//						else
//							backStr=judgeNull(temp,tempList2.get(j),compl);
//						if(backStr!="-1"){
//							combine=combine+backStr;
//							tempList2.remove(j);
//							String elem=temp;
//							temp=temp.replace(elem.substring(elem.indexOf("(")+1,elem.indexOf(";")),backStr);
//							tempList2.set(i, temp);
//							j--;
//							count--;
//						}
//					}
//				}
//				tempList2.set(i, temp.substring(2));
//			}
//		}
//		for(String fol1:tempList)
//			tempList2.add(fol1);
//		
//		for(String fol1: tempList2){
//			if(flag){
//				itemcell.append(getNLPs_doc(fol1, exception));
//				flag =false;
//			}
//			else{
//				if(fol1.equals(tempList2.get(tempList2.size()-1)))
//					itemcell.append(compl);
//				else
//					itemcell.append(",");
//				itemcell.append(getNLPs_doc(fol1, exception));
//			}
//		}
//		return itemcell.toString();
//	}
  public String [] splitSimpleFol(String fol){
	  String folPart=fol.substring(fol.indexOf("(")+1,fol.length()-1);
	  return folPart.split(";");
  }
  public String judgeAndOrOr(String fol){
	  String []list=splitSimpleFol(fol);
	  if(list[0].contains(" and "))
		  return " are ";
	  return " is ";
	  
  }
    public String VcProcess(String fol){
    	StringBuilder itemcell = new StringBuilder();
		String element[] = splitSimpleFol(fol);
		
		String andOrOr=judgeAndOrOr(fol);
		if(!element[0].equals("111")&&!element[0].equals("222"))
	     	itemcell.append(element[0] +andOrOr);
		else if(element[0].equals("222")){
			itemcell.append(element[1]);
			return itemcell.toString();
		}
		if(element[2].equals("NEG")){
			if(element[3].equals(">")){
				itemcell.append("no greater than ");
			}else if(element[3].equals("<")){
				itemcell.append("no less than ");
			}else if(element[3].equals(">=")){
				itemcell.append("less than ");
			}else if(element[3].equals("<=")){
				itemcell.append("greater than ");
			}else if(element[3].equals("=")||element[3].equals("==")){
				if(element[1].equals("TRUE")||element[1].equals("FALSE")||element[1].equals("true")||element[1].equals("false"))
				    itemcell.append("not ");
				else
					itemcell.append("not equal to ");
			}
			else 
				if(element[1].equals("TRUE")||element[1].equals("FALSE")||element[1].equals("true")||element[1].equals("false"))
				    itemcell.append(" ");
				else
				    itemcell.append("equal to ");
		}
		if(!element[2].equals("NEG")){
			if(element[3].equals(">")){
				itemcell.append("greater than ");
			}else if(element[3].equals("<")){
				itemcell.append("less than ");
			}else if(element[3].equals(">=")){
				itemcell.append("no less than ");
			}else if(element[3].equals("=")||element[3].equals("==")){
				if(element[1].equals("TRUE")||element[1].equals("FALSE")||element[1].equals("true")||element[1].equals("false"))
				    itemcell.append(" ");
				else
					itemcell.append("equal to ");
			}else if(element[3].equals("<=")){
				itemcell.append("no greater than ");
			}
			else 
				if(element[1].equals("TRUE")||element[1].equals("FALSE")||element[1].equals("true")||element[1].equals("false"))
				    itemcell.append("not ");
				else
					itemcell.append("not equal to ");
		}
		itemcell.append(element[1]);
		return itemcell.toString();
	}
    
    public String NullProcess(String fol, String exception){
    	StringBuilder itemcell = new StringBuilder();
		String element[] = splitSimpleFol(fol);
//		System.out.println(this.FOLs_doc);
		String andOrOr=judgeAndOrOr(fol);
		itemcell.append(element[0] + andOrOr);
		if(exception.contains("NO")){
			if(element[1].equals("NEG")){
				itemcell.append("not ");
			}
		}else{
			try{
			if(!element[1].equals("NEG"))
				itemcell.append("not ");
			}catch(Exception e){
				System.out.println(fol);
			}
		}
		itemcell.append("null");
		
    	return itemcell.toString();
    }
    
    public String TypeProcess(String fol){
    	StringBuilder itemcell = new StringBuilder();
   
		String element[] = splitSimpleFol(fol);
		if(element[0].equals("333"))
			return element[1];
		String andOrOr=judgeAndOrOr(fol);
		
		if(element[2].equals("NEG")){
			itemcell.append(element[0] + andOrOr+"not the type of " + element[1]);
		}else{
			itemcell.append(element[0] + andOrOr);
			itemcell.append("the type of " + element[1]);
		}
    	return itemcell.toString();
    }
    public String InSetProcess(String fol){
    	StringBuilder itemcell = new StringBuilder();
    	List<String> values = new ArrayList<String>();
    	String param = new String();
    	String neg = new String();
    	String SetValue = new String();
    	boolean flag = true;
    	
    	String s = fol.substring(fol.indexOf("(") + 1, fol.length() - 1);
		String element[] = s.split(";");
		if(element != null){
			try{
			param = element[0];
			neg = element[1];
			}catch(Exception e){
				System.out.println(fol);
			}
			
		}
		s = s.substring(s.indexOf(";") + 1, s.length() - 1);
		SetValue = s.substring(s.indexOf(";") + 1, s.length() - 1);
		String ValueElement= new String();
		ValueElement = SetValue.substring(SetValue.indexOf("(") + 1, SetValue.length() - 1);
		String ValueElements[] = ValueElement.split(";");
		
		for(int i = 0; i < ValueElements.length ; i++){
			values.add(ValueElements[i]);
		}
		if(neg.equals("NEG")){
			itemcell.append( param + "is not one of ");
		}else{
			itemcell.append( param + "is one of ");
		}
    	for(String value: values){
    		if(flag){
    			itemcell.append(value);
    			flag = false;
    		}else{
    			itemcell.append("," + value);
    		}
    	}
    	
    	return itemcell.toString();
    }
    
    public String processDocPath(String docPath){
    	
    	String preDocPath = docPath.substring(docPath.indexOf("CellDoc\\") + 8, docPath.indexOf(".java") + 5);
    	String docpath = preDocPath.substring(preDocPath.indexOf("\\") + 1, preDocPath.length());
    	String docpath1 = "/" + docpath.replace("\\", "/");
    	return docpath1;
    }
    public String processProjectName(String docPath){
    	
    	String preDocPath = docPath.substring(docPath.indexOf("CellDoc\\") + 8, docPath.indexOf(".java") + 5);
    	String projectName = preDocPath.substring(0, preDocPath.indexOf("\\"));
    	return projectName;
    }
    public String processMethodName(String docPath){
    	
    	String preMethodPath = docPath.substring(docPath.indexOf(".java") + 6, docPath.indexOf("(") + 1);
//    	System.out.println(preMethodPath);
    	return preMethodPath;
    }
    
    public List<String> processParamType(String docPath){
    	String preParamType = docPath.substring(docPath.indexOf("(") + 1, docPath.indexOf(")"));
    	List<String> paramType = new ArrayList();
    	if(preParamType.contains("-")){
    		String type[] = preParamType.split("-");
    		for(int i = 0; i < type.length; i++){
    			paramType.add(type[i]);
    		}
    	}else{
    		paramType.add(preParamType);
    	}
    	
//    	System.out.println(paramType);
    	return paramType;
    }
    
    public int getlocation(String s){
    	Stack<Character> stack = new Stack<Character>();
		Stack  locat2= new Stack();
		int locat = 0;
		int locat1 = 0;
		boolean flag = true;
		for (int i = 0; i < s.length(); i++){
			if((stack.isEmpty()) && s.charAt(i) == '('){
                locat1 = i;
                locat2.push(i);
                break;
                }
		}
		for (int i = locat1; i < s.length(); i++) {
			if(stack.isEmpty()){
				stack.push(s.charAt(i)); 
			}
			if(stack.peek() == '(' && s.charAt(i) == ')')
            {
				if(locat1 == (int) locat2.peek()){
                	locat = i;
                }
                stack.pop(); 
                locat2.pop();
            }
			else if(s.charAt(i) == '(' || s.charAt(i) == ')'){
				if(i != locat1){
					stack.push(s.charAt(i));
					locat2.push(i);
				}
			}
		}
    	return locat;
    }
    public List<FolInfo> getAlterBugsInfo() {
		return alterBugsInfo;
	}
	public void setAlterBugsInfo(List<FolInfo> alterBugsInfo) {
		this.alterBugsInfo = alterBugsInfo;
	}

}
