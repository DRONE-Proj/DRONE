package udf.ApiOmiDetec.CallGraph.fromJDT.testPackage;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class testDataTime {
	
	public static void main(String[] args){
		Date startTime = new Date();
		String sTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(startTime);
		System.out.println(sTime);
		int sum = 0;
		long st = System.currentTimeMillis();
		System.out.println(st);
		for (int i = 0;i < 999999; i++){
				System.out.print(i);
		}
		Date endTime = new Date();
		String eTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(endTime);
		System.out.println(eTime);
		
		System.out.println(endTime.toInstant());
		long et = System.currentTimeMillis();
		System.out.println(et);
		System.out.println(et-st);
		
	}

}
