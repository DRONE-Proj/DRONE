package docinconsistencyframe.element;

import org.eclipse.core.runtime.Platform;
import org.eclipse.jdt.internal.core.JavaProject;
import org.eclipse.jdt.internal.ui.packageview.PackageExplorerPart;
import org.eclipse.jface.action.IAction;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.viewers.TreeSelection;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.IObjectActionDelegate;
import org.eclipse.ui.IViewPart;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchPart;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;

import docinconsistencyframe.views.AlterBugsView;
import docinconsistencyframe.views.DocInconsistencyView;
import udf.ApiOmiDetec.Globals.GlobalSettings;

import org.eclipse.osgi.framework.*;
public class ContextMenuAction implements IObjectActionDelegate {

	private Shell shell;

	/**
	 * Constructor for Action1.
	 */
	public ContextMenuAction(){
		super();
	}

	/**
	 * @see IObjectActionDelegate#setActivePart(IAction, IWorkbenchPart)
	 */
	public void setActivePart(IAction action, IWorkbenchPart targetPart) {
		shell = targetPart.getSite().getShell();
		
	}

	/**
	 * @see IActionDelegate#run(IAction)
	 */

	public void run(IAction action) {
		 IWorkbench workbench = PlatformUI.getWorkbench();
		        IWorkbenchWindow
		 window = workbench.getActiveWorkbenchWindow();
		        IWorkbenchPage
		 page = window.getActivePage();
//		         IViewPart part=page.findView("docinconsistencyframe.views.DocInconsistencyView");
//		         if(part!=null){
//		        //打开视图
//		        try {
//		        	
//					page.showView("docinconsistencyframe.views.DocInconsistencyView");
//				} catch (PartInitException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//		         }
//		        //确认打开的视图处于激活状态
////		        IWorkbenchPart activePart = page.getActivePart();
////		      sertEquals("cn.sf.amateras.sample.views.SampleView", activePart.getSite().getId());
//		  


		DocInconsistencyView viewpart;
			JavaProject selectedProj = getCurrentSelection();
			if (selectedProj == null) return;
			IViewPart part1=PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().findView("docinconsistencyframe.views.DocInconsistencyView");
			if(part1!=null){
				viewpart = (DocInconsistencyView) PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().findView("docinconsistencyframe.views.DocInconsistencyView");
			
	
	
		//viewpart.showBusy(true);
		
	//

				int index = (new ProjectStorages()).getIndexOfProject(selectedProj);
				if (index >= 0){
					viewpart.setCombo(index);
					viewpart.getCombo().setEnabled(false);
					
				}
				try {
					PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().showView("docinconsistencyframe.views.DocInconsistencyView");
				} catch (PartInitException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
//				 IWorkbenchPart
//				 activePart = page.getActivePart();
//				        assertTrue(activePart instanceof IViewPart);
//				        assertEquals("cn.sf.amateras.sample.views.SampleView",   activePart.getSite().getId());
//				    }
			}	
	}
//			
	

	/**
	 * @see IActionDelegate#selectionChanged(IAction, ISelection)
	 */
	public void selectionChanged(IAction action, ISelection selection) {

	}
	public JavaProject getCurrentSelection(){
		IStructuredSelection structured =
				(IStructuredSelection)PlatformUI.getWorkbench().getActiveWorkbenchWindow()
					.getSelectionService().getSelection("org.eclipse.jdt.ui.PackageExplorer");
		if (structured == null) return null;
		Object selected = structured.getFirstElement();
		if (selected instanceof JavaProject){
			return (JavaProject)selected;
		}else{
//			System.out.println(selected.getClass());
			return null;
		}
	}

}
