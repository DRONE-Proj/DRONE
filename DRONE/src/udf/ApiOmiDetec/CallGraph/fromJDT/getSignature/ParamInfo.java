package udf.ApiOmiDetec.CallGraph.fromJDT.getSignature;

import java.util.ArrayList;
import java.util.List;

public class ParamInfo {
	
	public List<String> paramNames;
	
	public ParamInfo(){
		this.paramNames = new ArrayList();
	}
	
	public String present(){
		String res = "";
		for (String s : paramNames){
			res += s + 
					", ";
					//" \n";
		}
		res = res.substring(0, res.length()-2);
		return res;
	}
}
