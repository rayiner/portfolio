package edu.gatech.ccbs;

import java.util.*;

public class PathModel extends Model {
	public ArrayList intersections;
	public ArrayList realEndpoints;
	
	public PathModel() {
		intersections = new ArrayList();
		realEndpoints = new ArrayList();
	}

	public String stringify() {
		StringBuffer buf = new StringBuffer();
		Iterator itr = intersections.iterator();
		while(itr.hasNext()) {
			Intersection is = (Intersection)itr.next();
			buf.append(is.stringify());
			buf.append("\n");
		}
		
		return buf.toString();
	}
}
