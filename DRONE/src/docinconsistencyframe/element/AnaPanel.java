package docinconsistencyframe.element;


import java.io.File;
import java.io.OutputStream;
import java.io.PrintStream;

import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.DirectoryDialog;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.ProgressBar;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;

import docinconsistencyframe.views.AlterBugsView;
import GlobalVariables.CallGraphGlobalSettings;
import udf.ApiOmiDetec.CallGraph.fromJDT.BuildAllFromWorkbench;
import udf.ApiOmiDetec.CallGraph.fromJDT.BuildFromProject;
import udf.ApiOmiDetec.Globals.GlobalSettings;
import udf.ApiOmiDetec.Layers.ProjectLevel;
import udf.ApiOmiDetec.check.InconsistencyAnalysisViaCallGraph;
import udf.ApiOmiDetec.check.SummarizeAllCheckInfos;

public class AnaPanel extends Composite{

	public AnaPanel(Composite parent, int style) {
		super(parent, style);
		// TODO Auto-generated constructor stub
		//OldFrame(parent);
		NewFrame(parent);
	}
	private ProjectStorages myProjs; 
	private Combo projNameCombo;
	private ProgressBar[] bars = new ProgressBar[3];
	private void refreshProjs(){
		this.myProjs.RefreshProjs();
	}
	public Combo getCombo(){
		return this.projNameCombo;
	}
	public static int sum = 0;
	
	private void NewFrame(Composite parent){
		GridLayout layout = new GridLayout();
		layout.numColumns = 6;
		layout.marginTop = 10;
		layout.verticalSpacing = 8;
		layout.marginLeft = 10;
		this.setLayout(layout);
		
		Label[]  title = new Label[5];
		
		Button[] bts = new Button[3];
		
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
		btData.horizontalSpan = 1;
		
		GridData textData = new GridData();
		textData.horizontalAlignment = GridData.FILL;
		textData.horizontalSpan = 1;
		textData.verticalSpan = 4;
		textData.heightHint = 130;
		textData.widthHint = 400;
		
		title[0] = new Label(this, SWT.NONE);
		title[0].setText("Project:");
		title[0].setLayoutData(ldata);
		/*	by 锟斤拷睿猴拷 锟芥换锟斤拷combo
		 * Text projName = new Text(this, SWT.BORDER);
		projName.setEnabled(false);
		!!caution!!
		projName.setText("jdk_part");
		!!caution!!
		
//		GlobalSettings.ProjectName = projName.getText();
		
		
		projName.setLayoutData(nameData);*/
		GridData nameData = new GridData();
		nameData.widthHint = 150;
		Combo projName = new Combo(this, SWT.READ_ONLY);
		this.projNameCombo = projName;
		projName.setLayoutData(nameData);
		this.myProjs = new ProjectStorages();
		projName.setItems(this.myProjs.getProjNames());
		projName.select(0);
		
//		projName.addSelectionListener(new ProjectSelectionListener(this.myProjs, projName));
		
		projName.addSelectionListener(new SelectionAdapter(){
            @Override
            public void widgetSelected(SelectionEvent e) {
            	settingProjectName();
            }
        });
		
//		PlatformUI.getWorkbench().getActiveWorkbenchWindow().getSelectionService().addSelectionListener(new ProjectSelectionListener(this.myProjs, projName));
		
		Button Refresh = new Button(this, SWT.FLAT);
		Refresh.setText("Refresh");
		Refresh.addMouseListener(new RefreshListener(this.myProjs, projName));
		
		//	占位锟斤拷Label
		Label[] fi = new Label[10];
		for (int i = 1; i< 2; i++) fi[i] = new Label(this, SWT.NONE);
		
		Label laConsole = new Label(this,SWT.NONE);
		laConsole.setText("Console:");
		
		title[1] = new Label(this, SWT.NONE);
		title[1].setText("Save directory:");
		title[1].setLayoutData(ldata);
		Text rootDir = new Text(this, SWT.BORDER);
		rootDir.setLayoutData(barData);
		/*!!caution!!*/
//		rootDir.setText("F:\\DocErrorDetect\\Experiments\\");
		/*!!caution!!*/
		Button browse = new Button(this, SWT.PUSH);
		browse.setText("browse");
		
		browse.addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			Shell shell = new Shell();
    			DirectoryDialog dialog = new DirectoryDialog(shell);
    			String selectPath = dialog.open();
    			rootDir.setText("");
    			rootDir.setText(selectPath);
    			settingGlobalValues(selectPath);
    			
    			AlterBugsView Alterviewpart=(AlterBugsView) PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().findView("docinconsistencyframe.views.AlterBugsView");
    			Alterviewpart.getBrowse().setEnabled(false);
    			Alterviewpart.getRootDir().setText(GlobalSettings.InconsistencyInfoPathRoot + "checkLog.csv");
    			Alterviewpart.getRootDir().setEnabled(false);
    		}
    	});
		
//		Text consloe = new Text(this,SWT.BORDER|SWT.MULTI|SWT.WRAP|SWT.V_SCROLL|SWT.READ_ONLY);
		Text consloe = new Text(this,SWT.BORDER|SWT.MULTI|SWT.WRAP|SWT.V_SCROLL);
		consloe.setLayoutData(textData);
//		StyledText consloe = new StyledText(this,SWT.BORDER|SWT.MULTI|SWT.WRAP|SWT.V_SCROLL);
//		consloe.setLayoutData(textData);
		
		title[2] = new Label(this, SWT.NONE);
		title[2].setText("Invocation analysis:");
		title[2].setLayoutData(ldata);
		bars[0] = new ProgressBar(this, SWT.NONE);
		bars[0].setLayoutData(barData);
		
		
		
		
		
		
//		bars[0].setSelection(100);
		bts[0] = new Button(this, SWT.PUSH);
		bts[0].setText("analyze");
		bts[0].setLayoutData(btData);
		
		bts[0].addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			String rootpath = CallGraphGlobalSettings.RootSavePath;
    			//锟斤拷锟斤拷锟斤拷台锟斤拷示锟斤拷页锟斤拷锟斤拷
    			MyPrintStream mps = new MyPrintStream(System.out, consloe);
    			System.setOut(mps);
    			System.setErr(mps);
//    			
    			//统锟斤拷.class锟侥硷拷锟斤拷锟斤拷锟斤拷
//    			sum = 0;
//    			traverseFolder(GlobalSettings.CellInfoSourceCodesPath);
    			
    			//锟斤拷锟矫癸拷系锟斤拷锟斤拷
    			BuildAllFromWorkbench(rootpath);
//    			new BuildFromProject(new ProjectStorages().getSelectProjectObject(projName.getSelectionIndex()),rootpath);
    			
    			//锟斤拷锟斤拷锟斤拷示锟皆伙拷锟斤拷
    			MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","The analysis is done!");
    			}
    	});
		
		title[3] = new Label(this, SWT.NONE);
		title[3].setText("Code parsing and doc analysis:");
		title[3].setLayoutData(ldata);
		bars[1] = new ProgressBar(this, SWT.NONE);
		bars[1].setLayoutData(barData);
//		bars[1].setSelection(32);
		bts[1] = new Button(this, SWT.PUSH);
		bts[1].setText("analyze");
		bts[1].setLayoutData(btData);
		
		bts[1].addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			
    			//锟斤拷锟斤拷锟斤拷台锟斤拷示锟斤拷页锟斤拷锟斤拷
//    			MyPrintStream mps = new MyPrintStream(System.out, consloe);
//    			System.setOut(mps);
//    			System.setErr(mps);
    			try{
    				String[] args= {};
    				ProjectLevel.main(args);
    			}catch (Exception e) {
    				e.printStackTrace();
    			}
    			
    			//锟斤拷锟斤拷锟斤拷示锟皆伙拷锟斤拷
    			MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","The analysis is done!");
    			
    			}
    	});
		
		title[4] = new Label(this, SWT.NONE);
		title[4].setText("Document inconsistency detect:");
		title[4].setLayoutData(ldata);
		bars[2] = new ProgressBar(this, SWT.NONE);
		bars[2].setLayoutData(barData);
//		Combo combo = new Combo(this, SWT.DROP_DOWN);
//		combo.setItems(new String[]{"String matching", "NLP analysis", "Random tag"});
//		
//		combo.addSelectionListener(new SelectionAdapter(){
//            @Override
//            public void widgetSelected(SelectionEvent e) {
//                if(combo.getSelectionIndex() == 0){
//                	GlobalSettings.UseNLPCompare = 2;
//                }else if(combo.getSelectionIndex() == 1){
//                	GlobalSettings.UseNLPCompare = 1;
//                }else{
//                	GlobalSettings.UseNLPCompare = 3;
//                }
//            }
//        });
		
		bts[2] = new Button(this, SWT.PUSH);
		bts[2].setText("analyze");
		bts[2].setLayoutData(btData);
		
		bts[2].addSelectionListener(new SelectionAdapter(){
    		@Override
			public void widgetSelected(SelectionEvent event){
    			//锟斤拷锟斤拷锟斤拷台锟斤拷示锟斤拷页锟斤拷锟斤拷
//    			MyPrintStream mps = new MyPrintStream(System.out, consloe);
//    			System.setOut(mps);
    			try{
    				String[] args= {};
    				InconsistencyAnalysisViaCallGraph.main(args);
    				SummarizeAllCheckInfos.main(args);
    			}catch (Exception e) {
    				e.printStackTrace();
    			}
    			
    			//锟斤拷锟斤拷锟斤拷示锟皆伙拷锟斤拷
    			MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","The analysis is done!");
    			try {
					PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().showView("docinconsistencyframe.views.AlterBugsView");
				} catch (PartInitException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    			}
    	});
		
//		for (int i = 2; i< 5; i++) fi[i] = new Label(this, SWT.NONE);
//		Button oneKey = new Button(this, SWT.PUSH);
//		GridData oneData = new GridData();
//		oneData.horizontalAlignment = GridData.FILL;
//		oneData.horizontalSpan = 1;
//		oneData.widthHint = 80;
//		oneKey.setText("one-click analysis");
//		oneKey.setLayoutData(oneData);
//		
//		oneKey.addSelectionListener(new SelectionAdapter(){
//    		@Override
//			public void widgetSelected(SelectionEvent event){
//    			//锟斤拷锟斤拷锟斤拷台锟斤拷示锟斤拷页锟斤拷锟斤拷
//    			MyPrintStream mps = new MyPrintStream(System.out, consloe);
//    			System.setOut(mps);
//    			try{
//    				String[] args= {};
//    				ProjectLevel.main(args);
//    				InconsistencyAnalysisViaCallGraph.main(args);
//    				SummarizeAllCheckInfos.main(args);
//    				
//    			}catch (Exception e) {
//    				e.printStackTrace();
//    			}
//    			
//    			//锟斤拷锟斤拷锟斤拷示锟皆伙拷锟斤拷
//    			MessageDialog.openInformation(Display.getCurrent().getActiveShell(),"Prompt","The analysis is done!");
//    			
//    			}
//    	});
		
		
		
		
//		oneKey.addMouseListener(new MouseListener(){
//
//			@Override
//			public void mouseDoubleClick(MouseEvent arg0) {
//				// TODO Auto-generated method stub
//				
//			}
//
//			@Override
//			public void mouseDown(MouseEvent arg0) {
//				// TODO Auto-generated method stub
//				oneKey.setEnabled(false);
//				//MessageDialog.openInformation(parent.getShell(), "Processing", "Analysis is running...");
//				MyDialog d = new MyDialog(parent.getShell());
//				d.open();
//
//				oneKey.setEnabled(true);
//			}
//
//			@Override
//			public void mouseUp(MouseEvent arg0) {
//				// TODO Auto-generated method stub
//				
//			}
//			
//		});;
	}
	

	private void settingProjectName(){
		GlobalSettings.ProjectName = this.projNameCombo.getText();
		GlobalSettings.CellInfoSourceCodesPath = this.myProjs.getSelectedProjectLocation(this.projNameCombo.getSelectionIndex());
	}
	
	
	//锟斤拷值
	private void settingGlobalValues(String selectPath){
		GlobalSettings.UseNLPCompare = 1;
		GlobalSettings.ProjectName = this.projNameCombo.getText();
		GlobalSettings.CellInfoSourceCodesPath = this.myProjs.getSelectedProjectLocation(this.projNameCombo.getSelectionIndex());
//		System.out.println(GlobalSettings.CellInfoSourceCodesPath);
//		System.out.println(this.myProjs.getSelectProjectObject(this.projNameCombo.getSelectionIndex()));
		CallGraphGlobalSettings.RootSavePath = selectPath + "\\" + GlobalSettings.ProjectName + "\\CallGraph" + "\\";
		GlobalSettings.CellInfoSavePathRoot = selectPath + "\\" + GlobalSettings.ProjectName + "\\CellDoc" + "\\" + GlobalSettings.ProjectName + "\\";
		GlobalSettings.CallGraphBaseRoot = selectPath + "\\" + GlobalSettings.ProjectName + "\\CallGraph" + "\\" + GlobalSettings.ProjectName + "\\";
		GlobalSettings.InconsistencyInfoPathRoot = selectPath + "\\" + GlobalSettings.ProjectName + "\\CellDocViaInvokations" + "\\";
//		traverseFolder(GlobalSettings.CellInfoSourceCodesPath);
	}
	//锟斤拷锟矫癸拷系锟斤拷锟斤拷
	private void BuildAllFromWorkbench(String rootpath){
		new BuildFromProject(this.myProjs.getSelectProjectObject(this.projNameCombo.getSelectionIndex()),rootpath);
		
	}
	
	
	
	//扫锟斤拷.class锟侥硷拷锟斤拷锟斤拷锟斤拷
	public int traverseFolder(String path) {
		
        File file = new File(path);
        System.out.println("路锟斤拷为" + path);
        if (file.exists()) {
            File[] files = file.listFiles();
            if (files.length == 0) {
                System.out.println("锟侥硷拷锟斤拷锟角空碉拷!");
            } else {
                for (File file2 : files) {
                    if (file2.isDirectory()) {
                        traverseFolder(file2.getAbsolutePath());
                    } else {
                    	if(file2.getPath().endsWith(".class")){
                    		sum = sum + 1;
                    		
                    	}else{
                    		
                    	}
                    }
                }
            }
        } else {
            System.out.println("锟侥硷拷锟斤拷锟斤拷锟斤拷!");
        }
        System.out.println(".class锟侥硷拷锟斤拷锟斤拷锟斤拷锟斤拷:" + sum);
        return sum;
    }
	
	//锟斤拷锟斤拷一锟斤拷PrintStream锟斤拷锟斤拷,锟斤拷锟斤拷印锟斤拷锟斤拷锟斤拷锟斤拷锟截讹拷锟斤拷Text锟斤拷锟斤拷锟斤拷锟绞�
	class MyPrintStream extends PrintStream {

		private Text text;

		public MyPrintStream(OutputStream out, Text text) {
			super(out);
			this.text = text;
		}
	
		// 锟斤拷写锟斤拷锟斤拷write锟斤拷锟斤拷,锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷写锟接★拷锟斤拷锟斤拷锟斤拷娑家拷锟斤拷玫姆锟斤拷锟�
		public void write(byte[] buf, int off, int len) {
			final String message = new String(buf, off, len);
			String s=message;

			// SWT锟角斤拷锟斤拷锟竭程凤拷锟斤拷锟斤拷锟斤拷姆锟绞�
			Display.getDefault().syncExec(new Thread() {
				public void run() {
					// 锟斤拷锟斤拷息锟斤拷拥锟斤拷锟斤拷锟斤拷
					if ( !text.isDisposed()) {
						text.append(message);
					
						
					}
				}
			});
		}

	}
	
	class MyDialog extends MessageDialog{

		public MyDialog(Shell parentShell) {
			super(parentShell, "Processing", null, "Analysis is running...",
					MessageDialog.INFORMATION, null, 0);
			// TODO Auto-generated constructor stub
		}
		
		@Override
		protected void createButtonsForButtonBar(Composite parent){
			Button okBt = createButton(parent, SWT.Dispose, "锟斤拷锟�", false);
			okBt.setEnabled(false);
		}
	}
	
}
