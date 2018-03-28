package udf.ApiOmiDetec.CallGraph.fromJDT.getSignature;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IMember;
import org.eclipse.jdt.core.IMethod;

public class MethodInformation {
	//	用于获取方法的规则化签名
	private IMember targetObj;
	private IMethod targetMethod;
	
	private String methodName;
	private String classPath;
	
	private String[] paraOriginTypes;
	private String[] paraGoalTypes;
	private boolean transformed;
	
	private String oriSignature;
	
	public MethodInformation(IMember t){
		this.targetObj = t;
		this.transformed = false;
		if (t instanceof IMethod){
			this.targetMethod = (IMethod)t;
		}else{
			this.targetMethod = null;
		}
		
		try{
			extractMethodInfo();
			//this.methodName = this.targetMethod.getElementName();
			extractParameterTypes();
			convertParameterTypes();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	private void extractMethodInfo(){
		if (this.targetMethod == null) return ;
		this.methodName = this.targetMethod.getElementName();
		
		IJavaElement classParent = this.targetMethod.getParent();
		String classParentName = classParent.getElementName();
		IJavaElement packParent = classParent.getParent().getParent();
		String packParentName = packParent.getElementName();
		
		this.classPath = packParentName + "." + classParentName;
	}
	private void extractParameterTypes(){
		this.paraOriginTypes = this.targetMethod.getParameterTypes();
	}
	
	private void convertParameterTypes(){
		List<String> goalRes = new ArrayList();
		for (String ori : this.paraOriginTypes){
			goalRes.add((new transformJDTSignature(ori)).goalType);
		}
		this.paraGoalTypes = new String[goalRes.size()];//(String[]) goalRes.toArray();
		for (int i = 0; i< goalRes.size(); i++){
			this.paraGoalTypes[i] = goalRes.get(i);
		}
		
		this.transformed = true;
	}
	
	public String getGoalSignature(){
		String res = this.methodName + "(";
		for(String param : this.paraGoalTypes){
			res += param + ",";
		}
		if(this.paraGoalTypes.length > 0)
			res = res.substring(0, res.length()-1);
		res += ")";
		
		return res;
	}
	
	public String writeMethodFileInfo(){
		StringBuilder res = new StringBuilder(getGoalSignature());
		
		res.append("\n");
		res.append(this.classPath);
		
		res.append("\n" + this.paraGoalTypes.length + "\n");
		for (String param : this.paraGoalTypes){
			res.append(param + "\n");
		}
		
		return res.toString();
	}
	
	public String getAllParamTypesForParamFile(){
		StringBuilder res = new StringBuilder();
		
		res.append(this.paraOriginTypes.length + "\n");
		for (String param : this.paraOriginTypes){
			res.append(param + "\n");
		}
		res.append(this.paraGoalTypes.length + "\n");
		for (String param : this.paraGoalTypes){
			res.append(param + "\n");
		}
		
		return res.toString();
	}
	
	public String getClassPath()
	{	return this.classPath;	}
	public String[] getGoalTypeParams(){
		if (!this.transformed){
			return null;
		}else{
			return this.paraGoalTypes;
		}
	}
}
