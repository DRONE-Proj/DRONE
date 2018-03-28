package udf.ApiOmiDetec.CallGraph.fromJDT;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IMember;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.jdt.core.JavaModelException;
import org.eclipse.jdt.internal.core.search.JavaSearchScope;
import org.eclipse.jdt.internal.corext.callhierarchy.CallHierarchy;
import org.eclipse.jdt.internal.corext.callhierarchy.MethodWrapper;

import udf.ApiOmiDetec.CallGraph.fromJDT.getSignature.CalleMethodInfo;
import udf.ApiOmiDetec.CallGraph.fromJDT.getSignature.MethodInformation;
import udf.ApiOmiDetec.CallGraph.fromJDT.getSignature.ParamInfo;
import GlobalVariables.CallGraphGlobalSettings;
import GlobalVariables.PrintoutResult;

public class MethodInvokeRelation {
	//	����ĳ��Ŀ�귽����������callees�Լ�callers
	private String savePath;
	
	private IMethod targetMethod;
	private String targetMethodName;
	private CallHierarchy callHierarchy;
	private JavaSearchScope searchScope;
	
	private MethodWrapper[] callers;
	private MethodWrapper[] callees;
	
	private String[] paramNames;
	private String methodBody;
	
	public MethodInvokeRelation(IMethod method, JavaSearchScope scope, String saveroot) throws JavaModelException{
		this.targetMethod = method;
		this.savePath = saveroot + "/" + this.getMethodSignature() + "/";
		this.paramNames = this.targetMethod.getParameterNames();
		
		if (CallGraphGlobalSettings.SplitNoParameters	//	�޳��޲�������Ŀ���
				&&(this.paramNames == null || this.paramNames.length <= 0)){
			//	�����û�в��������
			return ;
		}
		
		try{
			File paramFile = new File(this.savePath + method.getElementName() + "_params.res");
			if(!paramFile.exists())	{
				paramFile.getParentFile().mkdirs();
				paramFile.createNewFile();
			}
			FileWriter fwriter = new FileWriter(paramFile);
			fwriter.append(new MethodInformation(this.targetMethod).getAllParamTypesForParamFile());
			fwriter.close();
		}catch(IOException e){
			e.printStackTrace();
		}
		
		PrintoutResult.PrintInScreen("\tin method: " + method.getElementName());
		
		this.targetMethodName = this.targetMethod.getElementName();
		this.methodBody = this.targetMethod.getSource();
		//PrintoutResult.PrintInScreen(this.methodBody);
		
		String toStr = "\t\tto String:\n" + this.targetMethod.toString();
		PrintoutResult.PrintOutResult(toStr);
		String src = "\t\tget source:\n" + this.targetMethod.getSource();
		PrintoutResult.PrintOutResult(src);
		String paramInfo = "\t\tparam names:\n";
		if (this.paramNames.length > 0){
			for (String p : this.paramNames){
				paramInfo += "\t\t\t" + p + "\n";
			}
		}else{
			paramInfo += "\t\t\tno params\n";
		}
		PrintoutResult.PrintOutResult(paramInfo);
		
		this.callHierarchy = CallHierarchy.getDefault();
		this.callHierarchy.setSearchScope(scope);
		
		getCallersWrappers();
		getCalleeWrappers();

		testEfficiency();
	}
	
	private void testEfficiency(){
		String res = "";
		
		try {
			/*
			res += createCallsFiles(1);
			res += createCallsFiles(2);
			*/
			
			res += createCallesFiles(1);
			res += createCallesFiles(2);
		} catch (IOException | JavaModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private String createCallesFiles(int type) throws IOException, JavaModelException{	//	type: 1-caller 2-callee
		String callPath = this.savePath + ((type==1)?"callers/":"callees/");
		File callFold = new File(callPath);
		callFold.mkdirs();
		
		MethodWrapper[] calles = (type==1)?this.callers:this.callees;
		if (calles != null){
			for (MethodWrapper calle : calles){
				if (calle.getMember() instanceof IMethod){
					IMethod callMethod = (IMethod)calle.getMember();
					MethodInformation calleInfo = new MethodInformation(calle.getMember());
					if (calle.getName().equals("ComputedValue") && 
							"getDefault".equals(this.targetMethod.getElementName().toString())){
						System.out.println("bingo!");
						// ���ר��
					}
					File callfile = new File(callPath + 
							calleInfo.getGoalSignature()
							+ ".res");
					callfile.createNewFile();
					//==================д����Ӧ�ķ�����Ϣ�ļ�======================
					FileWriter writerCalleInfo = new FileWriter(callfile);
					writerCalleInfo.append(calleInfo.writeMethodFileInfo());
					PrintoutResult.PrintInScreen("\t\tin Calle:\t" + (callMethod).getElementName());
					
					//	�������ֻ������debug
					if (this.targetMethodName.equals("addName") 
							&& callMethod.getElementName().equals("add")){
						PrintoutResult.PrintInScreen("bingo!");
					}
					
					//String[] p = this.getPassedParams(callMethod);
					String[] p = (type==1)?(this.getPassedParams(callMethod, this.targetMethod))
							:(this.getPassedParams(this.targetMethod, callMethod));
					writerCalleInfo.append(p.length + "\n");
					for (String s : p){
						writerCalleInfo.append(s + "\n");
					}
					writerCalleInfo.close();
					
					//	�����������Ƿ���ͳһ�����ڲ����ֹ�
					/*	��Ϊδ֪bug��ͣʹ�ô˹���
					File checkCalleInSameProj = new File(GlobalVariables.GlobalSettings.RootSavePath
							+ GlobalVariables.GlobalSettings.ProjName + "/"
							+ calleInfo.getClassPath().replaceAll("\\.", "/"));
						*/
					if (	
							//	!checkCalleInSameProj.exists() ||
							//	���ͬһ�����в�����
							(p.length <= 0 && CallGraphGlobalSettings.SplitNoParamDelive)
							//	����   û�д��ݲ�������Ҫ�޳��崫����
							){
						callfile.delete();
					}
				}
			}
		}
		return "";
	}
	
	@Deprecated
	/*
	 * ���������������ڵ���
	 * */
	private String createCallsFiles(int type) throws IOException{	//	type: 1- caller  2- callees
		String start = "\t\t\t\t";
		//	result ����д��log�ļ���
		//	res ����ֵ�� �ӷ��غ������������res�Ѿ��������κ�����
		String res = start + ((type == 1)?"Callers:\n":"Callees:\n");
		String callPath = this.savePath + ((type==1)?"callers/":"callees/");
		File callFold = new File(callPath);
		callFold.mkdirs();
		
		MethodWrapper[] calles = (type==1)?this.callers:this.callees;
		if (calles != null){
			for (MethodWrapper calle : calles){
				/*
				File callfile = new File(callPath + calle.getMember().getElementName() + ".res");
				callfile.createNewFile();
				*/
				
				String result = "";
				
				result += start + "========" + (type==1?"Caller Mem":"Callee Mem") + ":\t"
								+ calle.getName() + "========\n";//"test====heheda ��" + "\n";
				IMember callMem = calle.getMember();
				result += start + "\tcallemem name:\t" + callMem.getElementName() + "\n";
				result += start + "\tcallemem type:\t" + callMem.getClass() + "\n";
				if (callMem instanceof IMethod){
					try {
						MethodInformation calleInfo = new MethodInformation(callMem);
						File callfile = new File(callPath + 
								calleInfo.getGoalSignature()
								+ ".res");
						callfile.createNewFile();
						
						result += start +  "------------is IMethod--------------\n";
						result += start + "\tcallemem sign:\t" + ((IMethod)callMem).getSignature() + "\n";
						
						String[] paras = ((IMethod)callMem).getParameterNames();
						result += start +  "\tcallemem paras names:\n";
						for (String p : paras){
							result += start +  "\t\t" + p + "\n";
						}
						paras = ((IMethod)callMem).getParameterTypes();
						result += start +  "\tcallemem paras types:\n";
						for (String p : paras){
							result += start +  "\t\t" + p + "\n";
						}
						result += start +  "------------------------------------\n";
						
						//==================д����Ӧ�ķ�����Ϣ�ļ�======================
						FileWriter writerCalleInfo = new FileWriter(callfile);
						writerCalleInfo.append(calleInfo.writeMethodFileInfo());
						PrintoutResult.PrintInScreen("\t\tin Calle:\t" + ((IMethod)callMem).getElementName());
						//String[] p = this.getPassedParams(callMethod);
						String[] p = (type==1)?(this.getPassedParams((IMethod)callMem, this.targetMethod))
								:(this.getPassedParams(this.targetMethod, (IMethod)callMem));
						writerCalleInfo.append(p.length + "\n");
						for (String s : p){
							writerCalleInfo.append(s + "\n");
						}
						writerCalleInfo.close();
						
						//	�����������Ƿ���ͳһ�����ڲ����ֹ�
						File checkCalleInSameProj = new File(GlobalVariables.CallGraphGlobalSettings.RootSavePath
								+ GlobalVariables.CallGraphGlobalSettings.ProjName + "/"
								+ calleInfo.getClassPath().replaceAll("\\.", "/"));
						if (!checkCalleInSameProj.exists()){
							callfile.delete();
						}
						
					} catch (JavaModelException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				IJavaElement parentNode = calle.getMember().getParent();
				result += start + "\tcallemem Parent type:\t" + parentNode.getClass() + "\n";
				result += start + "\tcallemem Parent name:\t" + parentNode.getElementName() + "\n";
				result += start + "\tcallemem Parent toString:\t" + parentNode.toString() + "\n";
				IJavaElement packageParent = parentNode.getParent().getParent();
				result += start + "\tpack Parent type:\t" + packageParent.getClass() + "\n";
				result += start + "\tpack Parent name:\t" + packageParent.getElementName() + "\n";
				result += start + "===================================================" + "\n";
				
				PrintoutResult.PrintOutResult(result);
				
				res += start + "\t" + calle.getMember().getElementName() + "\n";
			}
		}
		
		return res;
	}
	
	private void getCallersWrappers(){
		MethodWrapper[] targets = this.callHierarchy.getCallerRoots(new IMember[]{this.targetMethod});
		if (targets.length > 0){
			try{
			this.callers = targets[0].getCalls(new NullProgressMonitor());
			}catch(Exception e){
				System.err.println(targets[0].getName());
			}
		}
	}
	private void getCalleeWrappers(){
		MethodWrapper[] targets = this.callHierarchy.getCalleeRoots(new IMember[]{this.targetMethod});
		if (targets.length > 0){
			try{
			this.callees = targets[0].getCalls(new NullProgressMonitor());
			}catch(Exception e){
				System.err.println(targets[0].getName());
			}
		}
	}
	
	@Deprecated
	/*
	 * �������ֻ�ܿ���callee�������������Ҫһ��������ġ��ܹ�����caller����ķ���
	 * */
	private String[] getPassedParams(IMethod calleMet) throws JavaModelException{
		String calleName = calleMet.getElementName();
		
		if (calleName.equals(this.targetMethodName)){
			return new String[0];
		}
		if("PaletteRecord".equals(this.targetMethod.getParent().getElementName()) 
				&& 
				"toString".equals(this.targetMethod.getElementName())
				&&
				"append".equals(calleMet.getElementName())){
			PrintoutResult.PrintInScreen("bingo!");
			// ���if ����debug��û��ʵ������
		}
		CalleMethodInfo metInfo = new CalleMethodInfo(this.methodBody, calleName, calleMet.getParameterNames().length);
		
		List<String> res = new ArrayList();
		for (String param : this.paramNames){
			if (metInfo.ContainParamName(param)){
				res.add(param);
			}
		}
		
		String[] resStrs = new String[res.size()];
		for (int i = 0 ;i< res.size() ; i++){
			resStrs[i] = res.get(i);
		}
		
		return resStrs;
	}
	
	private String[] getPassedParams(IMethod caller, IMethod callee) throws JavaModelException{
		/* ����caller��callee֮������Ĵ��ݹ�ϵ
		 * ���ص��ַ�����ʽ���£� ��������-caller�еĲ�����-callee�еĲ�����
		 * */
		String calleeName = callee.getElementName();
		if (calleeName.equals(caller.getElementName())){
			return new String[0];
		}
		
		String callerSrc = caller.getSource();
		
		String[] callerParamNames = caller.getParameterNames();
		String[] calleeParamNames = callee.getParameterNames();
		
		if(calleeName.equalsIgnoreCase("ObjectName")){
			System.out.println("stop here");
		}
		CalleMethodInfo metInfo = new CalleMethodInfo(callerSrc, calleeName, 
				calleeParamNames.length);
		
		List<String> res = new ArrayList();
		MethodInformation CalleeMetInfo = new MethodInformation(callee);
		String[] paramTypes = CalleeMetInfo.getGoalTypeParams();
		
		for (String param : callerParamNames){
			//	��һ����������callee����������ǵڼ����� ��ȡ��callee�ķ���ǩ���иò���������
			int index_callee = metInfo.getPassedParamIndex(param);
			if (index_callee < 0)	continue;
			//	�ڶ�����������caller����������ǵڼ�������ȡ�������ͣ��Լ���caller�в���������
			int index_caller = -1;
			for (int i = 0;i< callerParamNames.length; i++){
				if (param.equals(callerParamNames[i])){
					index_caller = i;
					break;
				}
			}
			if (index_caller < 0)	continue;
			String express = paramTypes[index_callee] + "-"	
					+ callerParamNames[index_caller] + "-" 
					+ calleeParamNames[index_callee];
			
			res.add(express);
		}
		
		String[] resStrs = new String[res.size()];
		for (int i = 0 ;i < res.size(); i++){
			resStrs[i] = res.get(i);
		}
		
		return resStrs;
	}
	
	private String getMethodSignature(){
		//String res = this.targetMethod.getElementName();
		String res = new MethodInformation(this.targetMethod).getGoalSignature();
		
		return res;
	}

}
