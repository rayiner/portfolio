package edu.gatech.ccbs;

import java.util.*;

public class ShapeModel extends Model {
	public ArrayList outlinePoints;
	
	public ShapeModel() {
		outlinePoints = new ArrayList();
	}
	
	public void printModel() {
		super.printModel();
		
		for(int i = 0; i < outlinePoints.size(); ++i)
			System.out.println(outlinePoints.get(i));
	}
}
