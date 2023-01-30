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
  writeln;

  // testing equivalence of derived units
  gravity := 9.81*(m/s2) + 0*(m/s/s);
  writeln('Gravity is: ', gravity.ToVerboseString);
  writeln('s2 = s*s? ', s2 = s*(s*s/s));
  writeln('m/s2*s = m/s? ', (m/s2)*s = m/s);
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
end.

