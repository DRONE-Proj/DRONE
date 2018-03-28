package docinconsistencyframe.element;

import org.eclipse.jdt.internal.core.JavaProject;
import org.eclipse.jdt.internal.ui.packageview.PackageExplorerPart;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.viewers.TreeSelection;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.ui.ISelectionListener;
import org.eclipse.ui.IWorkbenchPart;
import org.eclipse.ui.PlatformUI;

import udf.ApiOmiDetec.Globals.GlobalSettings;

public class ProjectSelectionListener implements ISelectionListener {

	private ProjectStorages myProjs;
	private Combo myCombo;
	
	public ProjectSelectionListener(ProjectStorages projs, Combo c){
		this.myProjs = projs;
		this.myCombo = c;
		GlobalSettings.ProjectName = c.getText();
		GlobalSettings.CellInfoSourceCodesPath = this.myProjs.getSelectedProjectLocation(c.getSelectionIndex());
	}
	
/*	@Override
	public void widgetDefaultSelected(SelectionEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void widgetSelected(SelectionEvent arg0) {
		// TODO Auto-generated method stub
		JavaProject selectedProj = getCurrentSelection();
		if (selectedProj == null) return;
		int index = this.myProjs.getIndexOfProject(selectedProj);
		if (index >= 0){
			this.myCombo.select(index);
		}
		
	}
*/	
//	public JavaProject getCurrentSelection(){
//		IStructuredSelection structured =
//				(IStructuredSelection)PlatformUI.getWorkbench().getActiveWorkbenchWindow()
//					.getSelectionService().getSelection("org.eclipse.jdt.ui.PackageExplorer");
//		if (structured == null) return null;
//		Object selected = structured.getFirstElement();
//		if (selected instanceof JavaProject){
//			return (JavaProject)selected;
//		}else{
////			System.out.println(selected.getClass());
//			return null;
//		}
//	}
//
//	@Override
	public void selectionChanged(IWorkbenchPart arg0, ISelection arg1) {
//		// TODO Auto-generated method stub
//		if (! (arg0 instanceof PackageExplorerPart)){ return ;}
//		this.myProjs.RefreshProjs();
//		this.myCombo.setItems(this.myProjs.getProjNames());
//		if (((TreeSelection)arg1).getPaths().length <= 0) return ;
//		if (((TreeSelection)arg1).getPaths()[0].getSegmentCount() <= 0) return ;
//		if (! (((TreeSelection)arg1).getPaths()[0].getSegment(0) instanceof JavaProject)){return ;}
////		System.out.println(arg1.toString());
////		System.out.println(((TreeSelection)arg1).getPaths());
//		
//		JavaProject selectedProj = getCurrentSelection();
//		if (selectedProj == null) return;
//		int index = this.myProjs.getIndexOfProject(selectedProj);
//		if (index >= 0){
//			this.myCombo.select(index);
//		}
//		GlobalSettings.ProjectName = this.myCombo.getText();
//		GlobalSettings.CellInfoSourceCodesPath = this.myProjs.getSelectedProjectLocation(this.myCombo.getSelectionIndex());
	}

}
