package edu.gatech.ccbs;

import java.awt.geom.*;

public class AircraftModel extends Model {
	public Point2D.Double location;
	public double         rotation;
	
	public void printModel() {
		System.out.println("Aircraft ->");
		super.printModel();
		System.out.println(location);
	}
}
