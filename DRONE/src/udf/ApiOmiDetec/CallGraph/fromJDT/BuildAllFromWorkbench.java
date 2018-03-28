package udf.ApiOmiDetec.CallGraph.fromJDT;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IWorkspace;
import org.eclipse.core.resources.IWorkspaceRoot;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IPath;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.JavaCore;

import GlobalVariables.GlobalTools;
import GlobalVariables.PrintoutResult;

public class BuildAllFromWorkbench {
	
	private IWorkspace workspace; 
    private IWorkspaceRoot workroot;
    private List<IJavaProject> javaProjs;
    
    private String savepath_root;
    
    public BuildAllFromWorkbench(String rootpath){
    	this.workspace = ResourcesPlugin.getWorkspace();
    	this.workroot = workspace.getRoot();
    	this.savepath_root = rootpath;
    	
    	this.javaProjs = new ArrayList();
    	try {
			ExtractJavaProjects();
			for (IJavaProject proj : this.javaProjs){
				PrintoutResult.PrintOutResult("project:\t" + proj.getElementName());
				new BuildFromProject(proj, this.savepath_root);
			}
			
			
		} catch (CoreException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    private void ExtractJavaProjects() throws CoreException{
    	IProject[] projs = this.workroot.getProjects();
    	for (IProject proj : projs){
    		if (proj.isNatureEnabled("org.eclipse.jdt.core.javanature")){
    			this.javaProjs.add(JavaCore.create(proj));
    		}
    	}
    }

}
