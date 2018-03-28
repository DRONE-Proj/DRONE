package udf.ApiOmiDetec.CallGraph.fromJDT.getSignature;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import udf.ApiOmiDetec.CallGraph.fromJDT.Tools;

public class CalleMethodInfo {
	
	private String methodName;
	private String methodBody;
	private String srcMetBody;
	
	private List<ParamInfo> params;
	
	private int NumberOfParams;
	
	private List<String> InQuot;
	
	public CalleMethodInfo(String src, String name, int paramNum){
				//	paramNum ������֤����Ϊsrc�п����кܶ�name����������Щname��һ����������Ҫ�����calle����ʱ��������������Ƿ�ƥ��
		this.methodName = name;
		this.srcMetBody = src;
		this.NumberOfParams = paramNum;
		String noAnnSrc = Tools.SplitAnnotations(src);
		this.methodBody = noAnnSrc.replaceAll("\\s", "");
		this.InQuot = Tools.InQuotations(this.methodBody);
		
		this.params = new ArrayList();
		ExtractParams();
	}
	
	private void ExtractParams(){
		String srcStr = this.methodBody;
		int index = srcStr.indexOf(this.methodName);
		int left, right;	//	��������
		int ld, rd;		//	��������
		int lf, rf;		//	���һ�����
		while (index >= 0){
			int b = IsInQuotation(index);
			if ( b >= 0 ){
				//	���������������""֮�У���������һ��
				srcStr = srcStr.substring(b+1);
				this.InQuot = Tools.InQuotations(srcStr);
				index = srcStr.indexOf(this.methodName);
				continue;
			}
			left = right = ld = rd = lf = rf = 0;
			int start = index + this.methodName.length();
			char prec = srcStr.charAt(start);
			if (prec != '('){
				srcStr = srcStr.substring(start);
				this.InQuot = Tools.InQuotations(srcStr);
				index = srcStr.indexOf(this.methodName);
				continue;
			}
			left ++; start ++;
			StringBuilder tempParam = new StringBuilder();
			ParamInfo tempInfo = new ParamInfo();
			
			while(left > 0){
				prec = srcStr.charAt(start);
				switch (prec){
					case '(' : left ++; tempParam.append(prec); break;
					case ')' : {
						left --; 
						if (left > 0){	tempParam.append(prec);	}
						else{
							//	�ս��ڴ�
							tempInfo.paramNames.add(tempParam.toString());
							tempParam = new StringBuilder();
						}
						break;
					}
					case '{': lf ++; tempParam.append(prec); break;
					case '}': lf --; tempParam.append(prec); break;
					case '\'':
					case '\"':{
						char flagc = prec;
						ld ++;
						do{
							tempParam.append(prec);
							start ++;
							if (prec == '\\'){
								prec = srcStr.charAt(start);
								tempParam.append(prec);
								start ++;
							}
							prec = srcStr.charAt(start);
						}while(!
								(prec == flagc));// && srcStr.charAt(start-1) != '\\'));
						tempParam.append(prec);
						break;
						}
					case ',' :{
						if (left != 1 || lf > 0 ){	//	��ʱӦ���Ƕ��ص���
							tempParam.append(prec);
						}else{
							tempInfo.paramNames.add(tempParam.toString());
							tempParam = new StringBuilder();
						}
						break;
					}
					default:{
						tempParam.append(prec);
					}
				}
				start ++;
			}
			if (tempInfo.paramNames.size() == this.NumberOfParams){
				this.params.add(tempInfo);
			}
			srcStr = srcStr.substring(start);
			this.InQuot = Tools.InQuotations(srcStr);
			
			index = srcStr.indexOf(this.methodName);
		}
	}
	
	private int IsInQuotation(int index){
		int flag = -1;		//	����-1���������У�����������У����غ����ŵ�λ��
		int a, b;
		for (String str : this.InQuot){
			String[] range = str.split(",");
			a = Integer.valueOf(range[0]);
			b = Integer.valueOf(range[1]);
			if (index >= a && index <= b){
				flag = b;
				break;
			}
		}
		
		return flag;
	}
	
	public List<ParamInfo> getParamsInfo()
	{	return this.params;		}
	
	public String present(){
		String res = "";
		for (ParamInfo p : this.params){
			res += p.present() + "\n";
		}
		if (this.params.size() > 0)
			res = res.substring(0, res.length()-1);
		else
			res = "no params\n";
		return res;
	}
	
	public boolean ContainParamName(String paramname){
		boolean flag = false;
		for (ParamInfo infoList : this.params){
			for (String p : infoList.paramNames){
				if (p.equals(paramname)){
					flag = true;
					break;
				}
			}
			if (flag)	break;
		}
		return flag;
	}
	
	public int getPassedParamIndex(String paramName){
		int index = -1;
		for (ParamInfo infoList : this.params){
			for (String p : infoList.paramNames){
				if (p.equals(paramName)){
					index = infoList.paramNames.indexOf(p);
					break;
				}
			}
			if (index >= 0)	break;
		}
		
		return index;
	} 
	
	public static void main (String[] args){
		//new CalleMethodInfo("a", "b");
		/*
		String str = " asdfalk sd s  \t sldkf  \n skdjix 	";
		System.out.println(str);
		System.out.println("=====================================");
		System.out.println(str.trim());
		System.out.println("=====================================");
		System.out.println(str.replaceAll("\\s", ""));
		*/
		
		String str = "";
		File file = new File("F:/DocErrorDetect/CallGraphs/JDT_way/testError.res");
				//ATryTest/����log/metcontent.res");
		try {
			BufferedReader reader = new BufferedReader(new FileReader(file));
			String l1 = reader.readLine();
			String l2 = "";
			while(l1 != null && !l1.equals(l2)){
				l2 = l1;
				str += l1 + "\n";
				l1 = reader.readLine();
			}
			str = str.substring(0, str.length()-1);
			
			//System.out.println(str.replaceAll("\\s", ""));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String t = "Color";
		CalleMethodInfo call = new CalleMethodInfo(str, t, 3);
		System.out.println(call.present());
		
	}

}
