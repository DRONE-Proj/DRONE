package docinconsistencyframe.views;


import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.DirectoryDialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.ui.part.*;
import org.eclipse.ui.texteditor.IDocumentProvider;
import org.eclipse.ui.texteditor.ITextEditor;

import extrFOL.FolInfo;
import extrFOL.extractFOL;

import org.eclipse.swt.widgets.*;
import org.eclipse.swt.graphics.Image;
import org.eclipse.jface.viewers.*;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.LineNumberReader;
import java.util.HashMap;
import java.util.ArrayList;

import org.eclipse.core.internal.resources.Marker;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IMarker;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IPath;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.runtime.Status;
import org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitEditor;
import org.eclipse.jdt.internal.ui.javaeditor.ICompilationUnitDocumentProvider;
import org.eclipse.jface.action.*;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentPartitioner;
import org.eclipse.jface.text.ITextSelection;
import org.eclipse.ui.*;
import org.eclipse.ui.ide.IDE;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;

import udf.ApiOmiDetec.Globals.GlobalSettings;
import GlobalVariables.CallGraphGlobalSettings;


/**
 * This sample class demonstrates how to plug-in a new
 * workbench view. The view shows data obtained from the
 * model. The sample creates a dummy model on the fly,
 * but a real implementation would connect to the model
 * available either in this or another plug-in (e.g. the workspace).
 * The view is connected to the model using a content provider.
 * <p>
 * The view uses a label provider to define how model
 * objects should be presented in the view. Each
 * view can present the same model objects using
 * different labels and icons, if needed. Alternatively,
 * a single label provider can be shared between views
 * in order to ensure that objects of the same type are
 * presented in the same way everywhere.
 * <p>
 */

public class AlterBugsView extends ViewPart {

	/**
	 * The ID of the view as specified by the extension.
	 */
	public static final String ID = "docinconsistencyframe.views.AlterBugsView";

	private TableViewer viewer;
	private Action action1;
	private Action action2;
	private Action doubleClickAction;
	private boolean buttonflag = false;
	private boolean startflag = false;
	
	private Button browse;
	
	public Button getBrowse() {
		return browse;
	}


	public void setBrowse(Button browse) {
		this.browse = browse;
	}
	
	private Text rootDir;

	public Text getRootDir() {
		return rootDir;
	}


	public void setRootDir(Text rootDir) {
		this.rootDir = rootDir;
	}

	private ArrayList<FolInfo> alterBugsInfo = new ArrayList<FolInfo>();
	private String[] check = new String[3];
	private String[] docPath = new String[3];
	private String[] NLPs_doc = new String[3];
	private String[] projectName = new String[3];
	private String[] methodName = new String[3];
	private String[] returnType = new String[3];
	private String[] AllInfo = new String[3];
	private ArrayList[] paramType = new ArrayList[3];
	private int count = -1;
	private String fixDocPath = "s";
	private String fixProjectName = "s";
	/*
	 * The content provider class is responsible for
	 * providing objects to the view. It can wrap
	 * existing objects in adapters or simply return
	 * objects as-is. These objects may be sensitive
	 * to the current input of the view, or ignore
	 * it and always show the same content 
	 * (like Task List, for example).
	 */
	 
	class ViewContentProvider implements IStructuredContentProvider {
		public void inputChanged(Viewer v, Object oldInput, Object newInput) {
		}
		public void dispose() {
		}
		public Object[] getElements(Object parent) {
			return new String[] { "One", "Two", "Three" };
		}
	}
	class ViewLabelProvider extends LabelProvider implements ITableLabelProvider {
		public String getColumnText(Object obj, int index) {
			return getText(obj);
		}
		public Image getColumnImage(Object obj, int index) {
			return getImage(obj);
		}
		public Image getImage(Object obj) {
			return PlatformUI.getWorkbench().
					getSharedImages().getImage(ISharedImages.IMG_OBJ_ELEMENT);
		}
	}
	class NameSorter extends ViewerSorter {
	}

	/**
	 * The constructor.
	 */
	public AlterBugsView() {
	}

	
	/**
	 * This is a callback that will allow us
	 * to create the viewer and initialize it.
	 */
	public void createPartControl(Composite parent) {
		
		GridLayout layout = new GridLayout();
		Composite topCom = new Composite(parent, SWT.NONE);
		layout.numColumns = 8;
		layout.marginTop = 10;
		layout.verticalSpacing = 8;
		layout.marginLeft = 10;
		topCom.setLayout(layout);
		
		GridData ldata = new GridData();
		ldata.horizontalAlignment = GridData.FILL;
		ldata.horizontalSpan = 2;
		ldata.widthHint = 200;
		
		GridData barData = new GridData();
		barData.horizontalAlignment = GridData.FILL;
		barData.horizontalSpan = 2;
		barData.widthHint = 200;
		
		GridData btData = new GridData();
		btData.horizontalAlignment = GridData.FILL;
		btData.horizontalSpan = 2;
		
		GridData textData = new GridData();
		textData.horizontalAlignment = GridData.FILL;
		textData.horizontalSpan = 4;
		textData.verticalSpan = 5;
		textData.heightHint = 135;
		textData.widthHint = 400;
		
		GridData AlterData = new GridData();
		AlterData.horizontalAlignment = GridData.FILL;
		AlterData.horizontalSpan = 2;
		AlterData.verticalSpan = 5;
		AlterData.heightHint = 150;
		AlterData.widthHint = 400;
		
		GridData startData = new GridData();
		startData.horizontalAlignment = GridData.FILL;
		startData.horizontalSpan = 1;
		startData.widthHint = 50;
		
		Label[]  title = new Label[5];
		Button[] bts = new Button[4];
		
		title[0] = new Label(topCom, SWT.NONE);
		title[0].setText("Directory:");
		title[0].setLayoutData(ldata);
		
		rootDir = new Text(topCom, SWT.BORDER);
		rootDir.setLayoutData(barData);
		
		browse = new Button(topCom, SWT.PUSH);
		browse.setText("browse");
		
		
		Button start = new Button(topCom, SWT.PUSH);
		start.setLayoutData(startData);
		start.setText("Start");
		
		
//		占位符Label
//		Label[] fi = new Label[10];
//		for (int i = 1; i< 2; i++) fi[i] = new Label(topCom, SWT.NONE);
		
//		for (int i = 2; i< 3; i++) fi[i] = new Label(topCom, SWT.NONE);
		
		title[1] = new Label(topCom, SWT.NONE);
		title[1].setText("Repair Information:");
		title[1].setLayoutData(ldata);	
		
		title[2] = new Label(topCom, SWT.NONE);
		title[2].setText("Check Recommendation:");
		title[2].setLayoutData(ldata);
		
		List console = new List(topCom,SWT.BORDER|SWT.MULTI|SWT.WRAP|SWT.V_SCROLL|SWT.SINGLE|SWT.H_SCROLL);
		console.setLayoutData(textData);
		
		browse.addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			Shell shell = new Shell();
    			FileDialog filedlg=new FileDialog(shell);
//    			DirectoryDialog dialog = new DirectoryDialog(shell);
    			String selectPath = filedlg.open();
    			rootDir.setText("");
    			rootDir.setText(selectPath);
    			CallGraphGlobalSettings.ResultSavePath = selectPath;
    			buttonflag = true;
    			if(!CallGraphGlobalSettings.ResultSavePath.contains("checkLog.csv")){
    				MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","Not a valid file!");
    			}
    			}
    	});
		
		start.addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			if(!startflag){
    				startflag = true;
    				if(!buttonflag){
        				File file = new File(GlobalSettings.InconsistencyInfoPathRoot);
        				File[] files = file.listFiles();
        				for (File file2 : files) {
                        	if(file2.getPath().endsWith("checkLog.csv")){
                        		CallGraphGlobalSettings.ResultSavePath = file2.getPath();
                        	}
                        }
        				if(!CallGraphGlobalSettings.ResultSavePath.contains("checkLog.csv")){
            				MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","Not a valid file!");
            			}
        			}
        			getInfomation();
    				int size=AllInfo.length;
        			for(int i=0;i<size;i++)
        			console.add(AllInfo[i]);
        			count=0;
        			openEditor();
    			}else{
    				MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","Not a valid operation!");
    			}
    			
    		}
    	});
		
//		
		Text AlterInfo = new Text(topCom, SWT.BORDER|SWT.MULTI|SWT.WRAP);
		AlterInfo.setLayoutData(AlterData);
//		for(String info:AllInfo){
//		console.add(info);
//	}
		console.addSelectionListener(new SelectionListener(){
			private int oldindex=-1;
			private String oldcontent=null;
			public void widgetSelected(final SelectionEvent e){	
				if(oldindex!=-1)
					console.setItem(oldindex, oldcontent);
				count=console.getSelectionIndex();
				openEditor();
				AlterInfo.setText(NLPs_doc[count]);
			}
			
			public void widgetDefaultSelected(final SelectionEvent e){
				if(oldindex!=-1)
					console.setItem(oldindex, oldcontent);
				count=console.getSelectionIndex();
				oldindex=count;
				oldcontent=console.getItem(count);
				console.setItem(oldindex, oldcontent);
				AlterInfo.setText(NLPs_doc[count]);
				openEditor();
			}
		});
		
		
		
//		for (int i = 1; i< 2; i++) fi[i] = new Label(topCom, SWT.NONE);
		
//		for (int i = 2; i< 3; i++) fi[i] = new Label(topCom, SWT.NONE);
		
		bts[0] = new Button(topCom, SWT.PUSH);
		bts[0].setText("First");
		bts[0].setLayoutData(btData);
		
		bts[0].addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			count = 0;
    			openEditor();
    			console.setSelection(count);
    			AlterInfo.setText(NLPs_doc[count]);
    		}
    	});
		
		bts[1] = new Button(topCom, SWT.PUSH);
		bts[1].setText("Previous");
		bts[1].setLayoutData(btData);
		
		bts[1].addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			count--;
    			if(count < 0){
    				MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","This is the first one ,don't have more information!");
        			count++;
    			}else{
    				openEditor();
    				console.setSelection(count);
    				AlterInfo.setText(NLPs_doc[count]);
    			}
    			
    			//console.remove(AllInfo[count]);
    			//AlterInfo.setText(NLPs_doc[count]);
    		}
    	});
		
		bts[2] = new Button(topCom, SWT.PUSH);
		bts[2].setText("Next");
		bts[2].setLayoutData(btData);
		
		bts[2].addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			count++;
    			if(count >= alterBugsInfo.size()){
    				MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","This is the last one,don't have more information!");
        			count--;
    			}else{
    				openEditor();
    				console.setSelection(count);
    				AlterInfo.setText(NLPs_doc[count]);
    			}
    			
    		}
    	});
//		占位符Label
//		Label[] fi = new Label[10];
//		for (int i = 1; i< 2; i++) fi[i] = new Label(topCom, SWT.NONE);
		bts[3] = new Button(topCom, SWT.PUSH);
		bts[3].setText("Last");
		bts[3].setLayoutData(btData);
		
		bts[3].addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			count = alterBugsInfo.size() - 1;
    			openEditor();
    			console.setSelection(count);
    			AlterInfo.setText(NLPs_doc[count]);
    		}
    	});
		
		
		
	}
	
	private void openEditor(){

		IWorkbenchPage page = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage();
		if(!(projectName[count].equals(fixProjectName)&&docPath[count].equals(fixDocPath))){
			//关闭编辑器
			page.closeAllEditors(true);
			
		}
		fixProjectName = projectName[count];
		fixDocPath = docPath[count];
		if(projectName[count] != null){
			
			IPath workPath = ResourcesPlugin.getWorkspace().getRoot().getLocation();
			String filepath = workPath + "/" + projectName[count] + docPath[count];
			IProject project = ResourcesPlugin.getWorkspace().getRoot().getProject(projectName[count]);         
			IFile java_file = project.getFile(new Path(docPath[count]));
//				IDE.openEditor(page, java_file, "org.eclipse.jdt.ui.CompilationUnitEditor");
			LineNumberReader lnr;
			try {
				lnr = new LineNumberReader(new FileReader(new File(filepath)));
				LineNumberReader againLnr = new LineNumberReader(new FileReader(new File(filepath)));
				String line = null;  
				 try {
					 int num = 0;
					 int flagline = 0;
					 
					while ((line = lnr.readLine()) != null) {
						boolean flag = true;
					    	if(line.contains(returnType[count])&&line.contains(methodName[count])){
//					    		flagline = lnr.getLineNumber();
					    		
					    		String res = line;
					    		LineNumberReader lnr1 = lnr;
					    		String line1 = null;
					    		for(int i = 0; i < 5; i++){
					    			if((line1 = lnr1.readLine()) != null){
					    				res = res + line1;
					    			}
					    			
					    		}
					    		for(String s: (ArrayList<String>)paramType[count]){
					    			if(!res.contains(s)){
					    				flag = false;
					    			}  
					    		}
					    		if(flag){
					    			num++;
					    			flagline = lnr.getLineNumber() - 5;
					    		}
//					    		System.out.println(flagline + ": " + line);
//					    		System.out.println("num= " + num);
					    		}
					    	}
					if(flagline == 0){
						while ((line = againLnr.readLine()) != null) {
							boolean flag = true;
						    	if(line.contains(methodName[count])){
//						    		flagline = lnr.getLineNumber();
						    		
						    		String res = line;
						    		LineNumberReader lnr1 = againLnr;
						    		String line1 = null;
						    		for(int i = 0; i < 5; i++){
						    			if((line1 = lnr1.readLine()) != null){
						    				res = res + line1;
						    			}
						    			
						    		}
						    		for(String s: (ArrayList<String>)paramType[count]){
						    			if(!res.contains(s)){
						    				flag = false;
						    			}  
						    		}
						    		if(flag){
						    			num++;
						    			flagline = againLnr.getLineNumber() - 5;
						    		}
//						    		System.out.println("的：" + flagline + ": " + line);
//						    		System.out.println("num1= " + num);
						    		}
						    	}
					}
					HashMap<String, Object> map = new HashMap<String, Object>();
    				map.put(IMarker.LINE_NUMBER, flagline);
    				IMarker marker = null;
    				try {
    				    marker = java_file.createMarker(IMarker.TEXT);
    				    marker.setAttributes(map);
    				    try {
    				        IDE.openEditor(page, marker,true);
    				    } catch ( PartInitException e ) {
    				        //complain
    				    }
    				} catch ( CoreException e1 ) {
    				    //complain
    				} finally {
    				    try {
    				        if (marker != null)
    				            marker.delete();
    				    } catch ( CoreException e ) {
    				        //whatever
    				    }
    				}
					
					
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} catch (FileNotFoundException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			}
		
	
	}
	
	
	private void getInfomation(){
		extractFOL ex = new extractFOL();
	    alterBugsInfo = (ArrayList<FolInfo>) ex.alterBugsInfo;
	    if(alterBugsInfo.size() > check.length){
	    	check = new String[alterBugsInfo.size() + 1];
	    	docPath = new String[alterBugsInfo.size() + 1];
	    	NLPs_doc = new String[alterBugsInfo.size() + 1];
	    	projectName = new String[alterBugsInfo.size() + 1];
	    	methodName = new String[alterBugsInfo.size() + 1];
	    	returnType = new String[alterBugsInfo.size() + 1];
	    	paramType = new ArrayList[alterBugsInfo.size() + 1];
	    	AllInfo = new String[alterBugsInfo.size()];
	    }
	    int i = 0;
		for(FolInfo folI :alterBugsInfo){
			check[i] = folI.getCkeck();
			docPath[i] = folI.getDocPath();
			NLPs_doc[i] = folI.getNLPs_doc();
			projectName[i] = folI.getProjectName();
			methodName[i] = folI.getMethodName();
			returnType[i] = folI.getReturnType();
			paramType[i] = (ArrayList) folI.getParamType();
			AllInfo[i] = folI.getAllInfo();
			i++;
		}
	}
	
	
	private void hookContextMenu() {}

	private void contributeToActionBars() {}

	private void fillLocalPullDown(IMenuManager manager) {}

	private void fillContextMenu(IMenuManager manager) {}
	
	private void fillLocalToolBar(IToolBarManager manager) {}

	private void makeActions() {}

	private void hookDoubleClickAction() {
		viewer.addDoubleClickListener(new IDoubleClickListener() {
			public void doubleClick(DoubleClickEvent event) {
				doubleClickAction.run();
			}
		});
	}
	private void showMessage(String message) {
		MessageDialog.openInformation(
			viewer.getControl().getShell(),
			"AlterBugsView",
			message);
	}

	/**
	 * Passing the focus request to the viewer's control.
	 */
	public void setFocus() {
//		viewer.getControl().setFocus();
	}
}
