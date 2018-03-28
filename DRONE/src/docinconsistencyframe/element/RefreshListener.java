package docinconsistencyframe.element;

import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.widgets.Combo;

public class RefreshListener implements MouseListener{

	private ProjectStorages myProjs;
	private Combo myCombo;
	
	public RefreshListener(ProjectStorages proj, Combo combo) {
		// TODO Auto-generated constructor stub
		this.myProjs = proj;
		this.myCombo = combo;
	}
	
	@Override
	public void mouseDoubleClick(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseDown(MouseEvent arg0) {
		// TODO Auto-generated method stub
		this.myCombo.setEnabled(true);
		this.myProjs.RefreshProjs();
		this.myCombo.setItems(this.myProjs.getProjNames());
		this.myCombo.select(0);
	}

	@Override
	public void mouseUp(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

}
