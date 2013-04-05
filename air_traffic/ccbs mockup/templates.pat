(TaxiToTaxiway
  (match
  	(?:aircraft AircraftID)
  	(Taxi_to_Taxiway:clearance Clearance)
	(?:endpoint TaxiwayID)
	(?:via Path))
  (convert
	TAXITAXIWAY
	aircraft
	endpoint
	via))

(TaxiToRamp
  (match
  	(?:aircraft AircraftID)
  	(Taxi_to_Ramp:clearance Clearance)
	(?:endpoint RampID)
	(?:via Path))
  (convert
	TAXIRAMP
	aircraft
	endpoint
	via))

(TaxiToRunway
  (match
  	(?:aircraft AircraftID)
  	(Taxi_to_Runway:clearance Clearance)
	(?:endpoint RunwayID)
	(?:via Path))
  (convert
	TAXIRUNWAY
	aircraft
	endpoint
	via))

(HoldShortOf
  (match
    (?:aircraft AircraftID)
	(Hold_Short_of:clearance Clearance)
	(?:line WaypointID))
  (convert
    HOLDSHORTOF
	aircraft
	line))

(ClearToCross
  (match
    (?:aircraft AircraftID)
	(Clear_to_Cross:clearance Clearance)
	(?:line WaypointID))
  (convert
    CLEARCROSS
	aircraft
	line))

(ClearForTakeOff
  (match
    (?:aircraft AircraftID)
	(Clear_for_Takeoff:clearance Clearance)
	(?:runway RunwayID))
  (convert
    CLEARTAKEOFF
	aircraft
	runway))

(ContactGround
  (match
    (?:aircraft AircraftID)
	(Contact_Ground:clearance Clearance))
  (convert
    CONTACTGROUND
	aircraft))

