package edu.gatech.ccbs;

import java.util.*;

public class Pattern {
	public String name;
	public MatchTerm match;
	public ActionsTerm actions;
	public ConvertTerm convert;
	
	public Pattern() {
		name = "";
	}
	
	public enum VariableType {
		AircraftID,
		WaypointID,
		RampID,
		TaxiwayID,
		RunwayID,
		Clearance,
		Path
	}
	
	static public class Variable {
		public String name;
		public VariableType type;
		public Object value;
		
		public void printVariable() {
			System.out.print("variable: ");
			System.out.print(name);
			System.out.print(" of ");
			System.out.print(type);
			System.out.print(" = ");
			System.out.println(value);
		}
	}
	
	static public class Term {
		public void printTerm() {}
	}
	
	static public class MatchTerm extends Term {
		public MatchTerm() {
			variables = new ArrayList();
		}
		
		public void printTerm() {
			Iterator itr = variables.iterator();
			System.out.println("Match term -> ");
			
			while(itr.hasNext()) {
				Variable var = (Variable)itr.next();
				var.printVariable();
			}
		}
		
		public ArrayList variables;
	}
	
	static public class ActionsTerm extends Term {
		public ActionsTerm() {
			actions = new ArrayList();
		}
		
		public void printTerm() {
			Iterator itr = actions.iterator();
			
			System.out.println("Actions term -> ");
			
			while(itr.hasNext()) {
				String action = (String)itr.next();
				System.out.print("Do ");
				System.out.println(action);
			}
		}
		
		public ArrayList actions;
	}
	
	static public class ConvertTerm extends Term {
		public ConvertTerm() {
			operands = new ArrayList();
		}
		
		public void printTerm() {
			Iterator itr = operands.iterator();
			
			System.out.print("Command term ");
			System.out.print(commandName);
			System.out.println(" ->");
			
			while(itr.hasNext()) {
				String action = (String)itr.next();
				System.out.print("Output ");
				System.out.println(action);
			}
		}
		
		public String commandName;
		public ArrayList operands;
	}
}
