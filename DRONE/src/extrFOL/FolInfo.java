package extrFOL;

import java.util.List;

public class FolInfo {
	private String exception;
	private String FOLs_doc;
	private String NLPs_doc;
	private String ckeck;
	private String projectName;
	private String methodName;
	private String returnType;
	private List<String> paramType;
	private String AllInfo;
	
	
	public String getAllInfo() {
		return AllInfo;
	}
	public void setAllInfo(String allInfo) {
		AllInfo = allInfo;
	}
	public List<String> getParamType() {
		return paramType;
	}
	public void setParamType(List<String> paramType) {
		this.paramType = paramType;
	}
	public String getReturnType() {
		return returnType;
	}
	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getDocPath() {
		return docPath;
	}
	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}
	private String docPath;
	
	public String getCkeck() {
		return ckeck;
	}
	public void setCkeck(String ckeck) {
		this.ckeck = ckeck;
	}
	public String getNLPs_doc() {
		return NLPs_doc;
	}
	public void setNLPs_doc(String nLPs_doc) {
		NLPs_doc = nLPs_doc;
	}
	public String getException() {
		return exception;
	}
	public void setException(String exception) {
		this.exception = exception;
	}
	public String getFOLs_doc() {
		return FOLs_doc;
	}
	public void setFOLs_doc(String fOLs_doc) {
		FOLs_doc = fOLs_doc;
	}
}
