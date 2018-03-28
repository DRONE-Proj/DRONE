package udf.ApiOmiDetec.CallGraph.fromJDT;

import java.util.Arrays;
import java.util.List;

import org.eclipse.jdt.core.IField;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.jdt.core.IType;
import org.eclipse.jdt.core.JavaModelException;
import org.eclipse.jdt.internal.core.search.JavaSearchScope;

import GlobalVariables.PrintoutResult;

public class BuildFromOneClass {
	
	private IType sourceClass;
	private JavaSearchScope searchScope;
	private List<IMethod> methods;
	
	private String savePath;
	
	public BuildFromOneClass(IType type, JavaSearchScope scope, String saveroot) throws JavaModelException{
		this.sourceClass = type;
		this.searchScope = scope;
		//PrintoutResult.PrintInScreen("In class " + this.sourceClass.getElementName());
		PrintoutResult.PrintInScreen("In class: " + this.sourceClass.getFullyQualifiedName());
		// ¡ü this is absolute path ¡ü
		this.savePath = saveroot + this.sourceClass.getFullyQualifiedName().replaceAll("\\.", "\\\\");
		this.savePath += ".java\\";
		//PrintoutResult.PrintInScreen(this.sourceClass.getFullyQualifiedName().replaceAll("\\.", "/"));
		try {
			IMethod[] mets = this.sourceClass.getMethods();
			if (mets != null){
				this.methods = Arrays.asList(mets);
				for (IMethod met : this.methods){
					PrintoutResult.PrintOutResult("\t\tmethod:\t" + met.getElementName());
					new MethodInvokeRelation(met, this.searchScope, this.savePath);
				}
			}
		} catch (JavaModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
