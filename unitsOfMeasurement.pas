program unitsOfMeasurement;

uses Dim;

var
  distance: TKilometers;
  time: THours;
  time2: TSeconds;
  speed: TKilometersPerHour;
  acceleration, gravity: TMetersPerSecondSquared;
  side, side2: TMeters;
  surface: TSquareMeters;
  mass: TKilograms;
  scoop: TGrams;
  volume: TCubicMeters;
  temperature: TDegreesCelsius;
  tempDiff: TKelvins;
  bigSurface: TSquareKilometers;
  force: TNewtons;
  area: TSquareMillimeters;
  sigma: TMegapascals;
  stiffness: TNewtonsPerMeter;
  stroke: TMeters;
  density: TKilogramsPerCubicMeter;
  weight: TKilograms;

begin
  // Assign helps to convert to target unit "km" as the value here is in "m"
  distance.Assign((10*km + 100*m) * 2);
  time := h.From(120*mn); // use From to convert explicitely from other unit
  speed := distance/time; // regular assignment because no conversion needed

  time2 := 110*s mod (100*s);  // brackets needed to combine value with unit
  acceleration := speed/time2; // implicit conversion to base units

  writeln('The distance is: ', distance.ToString);
  writeln('The number of hundreds of meters is: ', FormatValue(distance / (100*m)) );
  writeln('The time is: ', time.ToString);
  writeln('Also: ', mn.From(time).ToString); // converts for display
  writeln('The speed is: ', speed.ToString);
  writeln('Also: ', speed.ToBase.ToString); // converts explicitly to base units
  writeln;

  distance := TKilometers.From(50*km + 0*m + 5*mm);
  // ToVerboseString display the full name of the unit
  writeln('Distance to go: ', distance.ToVerboseString);
  time := distance / speed;
  writeln('Time to get there: ', time.ToString);
  writeln('Also: ', time.ToBase.ToString);
  writeln;

  writeln('The time to accelerate is: ', time2.ToString);
  writeln('The acceleration is: ', acceleration.ToString);
  writeln('Also: ', (km/h/s).From(acceleration).ToString);
  speed := (km/h).From(acceleration*time);
  time.Assign(speed/acceleration);
  writeln;

  // testing equivalence of derived units
  gravity := 9.81*(m/s.Squared) + 0*(m/s/s);
  writeln('Gravity is: ', gravity.ToVerboseString);
  writeln('s2 = s*s? ', s2 = s*(s*s/s));
  writeln('m/s2*s = m/s? ', ((m/s2)*s).Symbol = (m/s).Symbol);
  writeln;

  // supposing there is local variable called "cm"
  side := 100*Dim.cm;
  writeln('The name of the base unit of ', cm.Name,
    ' is: ', cm.BaseUnit.Name, ' with a factor of ', FormatValue(cm.Factor));
  surface := side * side;
  writeln('The surface of a ', side.ToString,' by ', side.ToString,
    ' square is: ', surface.ToString);
  side2 := 5*(m/s*s);
  writeln('It is the same surface as a rectangle of ', side2.ToString,
    ' by ', (surface/side2).ToString);
  writeln;

  mass := 3*kg;
  scoop := 100*g;
  // using implicit conversion when dividing
  writeln('From ', mass.ToString,', I can make ',
    FormatValue(mass/scoop), ' scoops of ', scoop.ToString);
  writeln('Comparing computation with or without factor');
  writeln((100/1000 + 200/1000)*1000, ' =? ', (100*mm + 200*mm).Value);
  writeln;

  volume := 2*m3;
  side := 1*m;
  writeln('A rectangular cuboid of of volume ', volume.ToString,
    ' with a height ', side.ToString);
  writeln('has an horizontal face of ', (volume/side).ToString);
  // explicit conversion from m3 to litre
  writeln('It is equivalent to ', L.From(volume).ToString);

  writeln('3 t = ', kg.From(3*ton).ToString);
  writeln('1 lux = ', (1*lx).ToVerboseString);
  writeln('1 / 0.01 s = ', (1 / (0.01*s)).ToString);
  writeln('100 Hz * 10 s = ', FormatValue(100*Hz*(10*s)));
  writeln('180 º = ', rad.From(180*deg).ToString);
  writeln('1 A * 1 s = ', (1*A*(1*s)).ToString);
  writeln('1 C / 1 s = ', (1*C/(1*s)).ToString);

  temperature.Assign(20*degC);
  writeln(temperature.ToString,' is the same as ', K.From(temperature).ToString,
    ' and ', degF.From(temperature).ToString);

  tempDiff := 25*degC - (20*degC);
  writeln('The difference between 20 and 25 degrees Celsius is: ', tempDiff.ToString);
  writeln('From 30 ºC that would be: ', (30*degC + tempDiff).ToString);

  temperature := degC.From(0*K);
  writeln('The absolute zero is: ', temperature.ToString);
  writeln;

  writeln('Accelerating 100 g by 1/s2 is: ', (1*(m/s2)*(100*g)).ToVerboseString);
  writeln;
  writeln('10 cm < 1 m ? ', 10*cm < 1*m);
  writeln('100 cm = 1 m ? ', 100*cm = 1*m);
  writeln('101 cm <> 1 m ? ', 101*cm <> 1*m);
  writeln;

  bigSurface := (1*km).Squared;
  writeln('1 km * 1 km = ', bigSurface.ToString, ' = ',
    (1*km2).ToString, ' = ', bigSurface.ToBase.ToString);

  force.Assign(1200*N);
  area := (10*mm)*(10*mm);
  sigma := force/area;
  writeln;
  writeln('Area is: ',  (force/TPascals(sigma)).ToString);
  writeln('Force is: ', (TPascals(sigma)*TSquareMeters(area)).ToString);
  writeln('Pressure is: ', (force/area).ToString);

  stiffness := 50*(N/m);
  stroke := (100/1000)*m;
  writeln;
  writeln('The stiffness is: ', stiffness.ToString);
  writeln('The stroke is: ', mm.From(stroke).ToString);
  writeln('The force is: ', (stiffness*stroke).ToString);
  side := 10*m;
  force := stiffness * side; // N = N/m * m

  density := 7850*(kg/m3);
  volume := 0.5*m3;
  weight := density*volume;
  writeln;
  writeln('The density is: ', (weight/volume).ToString);
  writeln('The volume is: ', (weight/density).ToString);
  writeln('The weigth is: ', (density*volume).ToString);
  writeln;
  writeln('Press ENTER to Quit.');
  readln;
end.
