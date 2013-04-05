package edu.gatech.ccbs;

import java.util.ArrayList;

public class PointSetModel extends Model {
	public ArrayList controlPoints;
	
	public PointSetModel() {
		controlPoints = new ArrayList();
	}
	
	public void printModel() {
		super.printModel();
		
		for(int i = 0; i < controlPoints.size(); ++i)
			System.out.println(controlPoints.get(i));
	}
}