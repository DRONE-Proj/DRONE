package udf.ApiOmiDetec.CallGraph.fromJDT;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.eclipse.jdt.core.ICompilationUnit;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.IPackageFragment;
import org.eclipse.jdt.core.IPackageFragmentRoot;
import org.eclipse.jdt.core.IType;
import org.eclipse.jdt.core.JavaModelException;
import org.eclipse.jdt.internal.core.search.JavaSearchScope;

import GlobalVariables.GlobalTools;
import GlobalVariables.PrintoutResult;

public class BuildFromProject {
	
	private IJavaProject sourceProj;
	private JavaSearchScope searchScope;
	private List<IType> classes;
	
	private String savePath;
	
	public BuildFromProject(IJavaProject proj, String saveroot){
		this.sourceProj = proj;
		this.savePath = saveroot + proj.getElementName() + "/";
		
		GlobalVariables.CallGraphGlobalSettings.ProjName = proj.getElementName();
		
		this.classes = new ArrayList();
		try {
			this.searchScope = new JavaSearchScope();
			this.searchScope.add(this.sourceProj);
			ExtractAllClasses();
			for (IType type : this.classes){
				PrintoutResult.PrintOutResult("\ttype:\t" + type.getElementName());
				new BuildFromOneClass(type, this.searchScope, this.savePath);
			}
		} catch (JavaModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		GlobalTools.EmptyFileFoldCleaner(new File(this.savePath));
		GlobalTools.NoInvokMethodCleaner(new File(this.savePath));
		GlobalTools.EmptyFileFoldCleaner(new File(this.savePath));
		
	}
	
	private void ExtractAllClasses() throws JavaModelException{
		IPackageFragment[] packages = this.sourceProj.getPackageFragments();
		for (IPackageFragment pack : packages){
			//System.out.println(pack.getElementName());
			if (!(pack.getKind() == IPackageFragmentRoot.K_SOURCE)){ continue; }
			ICompilationUnit[] units = pack.getCompilationUnits();
			for (ICompilationUnit unit : units){
				//System.out.println(unit.getElementName().replaceAll("/.", "/"));
				IType[] types = unit.getAllTypes();
				this.classes.addAll(Arrays.asList(types));
			}
		}
	}

}
