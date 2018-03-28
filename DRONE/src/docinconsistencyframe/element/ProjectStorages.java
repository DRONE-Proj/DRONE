package docinconsistencyframe.element;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.JavaCore;
import org.eclipse.jdt.internal.core.JavaProject;

public class ProjectStorages {
	
	private List<IJavaProject> workspaceProjs = new ArrayList<IJavaProject>();
	
	public ProjectStorages(){
		RefreshProjs();
	}
	
	public void RefreshProjs(){
		this.workspaceProjs.clear();
		IProject[] projs = ResourcesPlugin.getWorkspace().getRoot().getProjects();
		for (IProject proj : projs){
			try {
				if (proj.isNatureEnabled("org.eclipse.jdt.core.javanature")){
					this.workspaceProjs.add(JavaCore.create(proj));
				}
			} catch (CoreException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public String[] getProjNames(){
		List<String> names = new ArrayList<String>();
		for (IJavaProject proj : this.workspaceProjs){
			names.add(proj.getElementName().toString());
		}
		String[] res = new String[names.size()];
		for (int i = 0; i< names.size(); i++) res[i] = names.get(i);
		return res;
	}
	
	public int getIndexOfProject(JavaProject proj){
		boolean find = false;
		int index = 0;
		for (index = 0; index < this.workspaceProjs.size(); index ++){
			if (this.workspaceProjs.get(index).equals(proj)){
				find = true;
				break;
			}
		}
		if (find){
			return index;
		}else{
			return -1;
		}
	}
	
	public String getSelectedProjectLocation(int i){
		return this.workspaceProjs.get(i).getProject().getLocation().toString();
//				getLocation().toString();
	}
	public IJavaProject getSelectProjectObject(int i){
		return this.workspaceProjs.get(i);
	}
	
}
