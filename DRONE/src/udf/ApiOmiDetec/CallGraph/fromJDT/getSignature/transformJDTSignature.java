package udf.ApiOmiDetec.CallGraph.fromJDT.getSignature;

import java.util.HashMap;
import java.util.Map;

public class transformJDTSignature {
	//	规则化每个参数变量的signature
	private String originType;
	public String goalType;
	
	public static Map<String, String> SimpleTypeDic = new HashMap<String, String>(){
		{
			put("B","byte");
			put("C","char");
			put("D","double");
			put("F","float");
			put("I","int");
			put("J","long");
			put("S","short");
			put("V","void");
			put("Z","boolean");
		
		}
	};
	
	public transformJDTSignature(String origin){
		this.originType = origin;
		//System.out.println(origin);
		int index = this.originType.indexOf(";");
		if (index > 0) this.originType = this.originType.substring(0, index);
		this.goalType = this.transforming(originType);
	}
	
	public static String transforming(String origin){
		char[] oriString = origin.toCharArray();
		
		int i;
		int num_bracket = 0, last_dot = 0, start_name = -1, left_sharp = -1, right_sharp = -1;
		int left_sharp_num = 0;
		boolean specialByte = true;
		for (i = 0 ;i< oriString.length; i++){
			switch(oriString[i]){
			case '[':num_bracket ++ ; break;
			case '!':break;
			case 46 :last_dot = i;break;
			case '<':{
				if (left_sharp_num <= 0){
					left_sharp = i;
					left_sharp_num ++;
				}
				break;
				}
			case '>':right_sharp = i;break;
			case 'T':
			case 'Q':
			case 'L':{	if(i == num_bracket){	break;	}}
			default: {
				if (start_name < 0)	start_name = i;
				break;
				}
			}
		}
		
		int start = start_name;//(start_name > last_dot)?start_name:last_dot+1;		
		int end = (left_sharp > 0)?left_sharp:i;
		StringBuilder resStr = new StringBuilder();
		resStr = resStr.append((char[])oriString, start, end-start);
		/*
		String res = getLastName(oriString, i);
		for (int j = 0; j< num_bracket;j ++){
			res += "[]";
		}
		*/
		String temp = resStr.toString();
		if (SimpleTypeDic.get(temp) != null){
			temp = SimpleTypeDic.get(temp);
		}
		for (int j = 0; j< num_bracket;j ++){
			temp += "[]";
		}
		if(temp.equals("java.lang.String")){
			temp = "String";
		}
		return temp;
		
	}
	
	private String getTempletElement(char[] chararray, int start, int end){
		//List<String>
		return null;
	}
	
	private String getLastName(char[] bytes, int offset){
		int lastDot = offset;
		int i;
		for (i = 0; i<bytes.length; i++){
			if (bytes[i] == 46){
				lastDot = i+1;
			}
		}
		return new String(bytes, lastDot, bytes.length-lastDot);
	}
	
	public static void main(String[] args){
		/*
		byte[] bytes = "heheda.com<TV;>".getBytes();
		int i=0;
		for (byte b:bytes){
			System.out.println(b + "\t" + (char)b);
			if (b == 46){
				break;
			}
			i++;
		}
		
		System.out.println(new String(bytes, i, bytes.length-i));
		*/
		String s = "QList<QIObservableList<QE;>;>;";//"[[Ljava.scring.heheda<TV;>";
		System.out.println(transforming(s));
	}

}
