package udf.ApiOmiDetec.CallGraph.fromJDT;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTParser;
import org.eclipse.jdt.core.dom.ASTVisitor;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.Javadoc;
import org.eclipse.jdt.core.dom.TypeDeclaration;

import GlobalVariables.PrintoutResult;

public class Tools {
	
	public static String SplitAnnotations(String mbody){
		
		int start, end, i;
		char[] src = mbody.toCharArray();
		String res = "";
		start = end = 0;
		for (i = 0; i< src.length; i++){
			char c = src[i];
			switch(c){
				case '/':{
					i ++;
					c = src[i];
					if (c == '/'){
						res += new StringBuilder().append(src, start, end - start + 1).toString();
						//res += "\n";
						while(i < src.length && src[i] != '\n' && i < src.length){
							i++;	
						}
						//i++;
						start = end = i;
						break;
						
					}else if (c == '*'){
						
						res += new StringBuilder().append(src, start, end - start + 1).toString();
						
						while(i < src.length &&
								(!(src[i] == '*' && src[i+1] == '/'))
								&& i < src.length) i++;
						
						i += 1;
						start = end = i+1;
						break;
					
					}else{
						end = i;
						break;
					}
				}
				case '\'':
				case '\"':{
					char flagc = c;
					i++;
					while ( i< src.length && src[i] != flagc){
						if (src[i] == '\\'){
							i += 2;
							continue;
						}
						
						i++;
					}
					
					end = i;
					break;
				}
				default:{
					end = i;
					break;
				}
			}
		}
		
		if (start < src.length)
			res += new StringBuilder().append(src, start, end - start + 1).toString();
		
		return res;
	}
	
	public static List<String> InQuotations(String src){
		int start, end, i;
		start = end = i = 0;
		List<String> res = new ArrayList();
		char[] CharArray = src.toCharArray();
		while(i < CharArray.length){
			char c = CharArray[i];
			switch(c){
				case '\'':
				case '\"':{
					char flag = c;
					start = i;
					/*
					do{
						i++;
						c = CharArray[i];
						if(c == '\\'){i += 2; c = CharArray[i];}
					}while(c != flag);
					*/
					c = CharArray[++i];
					while(c != flag){
						if (c == '\\'){
							i+= 2;
							c = CharArray[i];
						}else{
							i++;
							c = CharArray[i];
						}
					}
					end = i;
					res.add(start + "," + end);
					break;
				}
				default:break;
			}
			i++;
		}
		
		return res;
	}
	
	public static void main(String[] args){
		/*
		char[] test = "0123456789".toCharArray();
		String res = new StringBuilder().append(test, 0, 4-0).toString();
		PrintoutResult.PrintInScreen(res);
		*/
		
		String str = "";
		File file = new File("F:/DocErrorDetect/CallGraphs/JDT_way/testError.res");
				//ATryTest/´íÎólog/metcontent.res");
		try {
			BufferedReader reader = new BufferedReader(new FileReader(file));
			String l1 = reader.readLine();
			String l2 = "";
			while(l1 != null){// && !l1.equals(l2)){
				l2 = l1;
				str += l1 + "\n";
				l1 = reader.readLine();
			}
			str = str.substring(0, str.length()-1);
			System.out.println(str);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(SplitAnnotations(str));
		/*
		List<String> l = InQuotations(SplitAnnotations(str));
		for (String line : l){
			System.out.println(line);
		}
		*/
		//String test = "123/*asdfslkdjfl*/sjfsdk\nabcd";
		//PrintoutResult.PrintInScreen(SplitAnnotations(test));
	}

}
