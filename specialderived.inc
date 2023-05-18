////////////////////// UNITS DERIVED FROM SPECIAL UNITS ////////////////////////

{ Units of speed }
{$IFDEF INTF}
type
  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondId = specialize TRatioUnitId<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioQuantity<TRadian, TSecond>;
{$ENDIF}

{$DEFINE NumId:=TRadianId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TRadianPerSecondId}
{$DEFINE NumQty:=TRadians}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TRadiansPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas} // rad/s = rad / s

// alternative definition
{$DEFINE LeftId:=TRadianPerSecondId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TMeterPerSecondId}
{$DEFINE LeftQty:=TRadiansPerSecond}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TMetersPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas} // rad/s * m = m/s

{ Units of acceleration }
{$IFDEF INTF}
type
  TRadianPerSecondSquaredId = specialize TRatioUnitId<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioQuantity<TRadianPerSecond, TSecond>;
{$ENDIF}

{$DEFINE NumId:=TRadianPerSecondId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TRadianPerSecondSquaredId}
{$DEFINE NumQty:=TRadiansPerSecond}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TRadiansPerSecondSquared}
{$DEFINE DEF_RATIO}{$i dim.pas} // rad/s2 = rad/s / s

// alternate definitions
{$DEFINE LeftId:=TRadianPerSecondSquaredId}{$DEFINE RightId:=TSquareSecondId}{$DEFINE ProdId:=TRadianId}
{$DEFINE LeftQty:=TRadiansPerSecondSquared}{$DEFINE RightQty:=TSquareSeconds}{$DEFINE ProdQty:=TRadians}
{$DEFINE ALT_PROD}{$i dim.pas} // rad = rad/s2 * s2

{ Mechanical derived units }
{$IFDEF INTF}
type
  TNewtonPerMeter = specialize TRatioUnit<TNewton, TMeter>;
  TNewtonPerMeterId = specialize TRatioUnitId<TNewton, TMeter>;
  TNewtonsPerMeter = specialize TRatioQuantity<TNewton, TMeter>;

  TNewtonPerMilliMeter = specialize TFactoredDenominatorUnit<TNewton, TMilliMeter>;
  TNewtonPerMilliMeterId = specialize TFactoredDenominatorUnitId<TNewton, TMeter, TMilliMeter>;
  TNewtonsPerMilliMeter = specialize TFactoredDenominatorQuantity<TNewton, TMeter, TMilliMeter>;

  TNewtonPerCubicMeter = specialize TRatioUnit<TNewton, TCubicMeter>;
  TNewtonPerCubicMeterId = specialize TRatioUnitId<TNewton, TCubicMeter>;
  TNewtonsPerCubicMeter = specialize TRatioQuantity<TNewton, TCubicMeter>;

  TPascalSecond = specialize TUnitProduct<TPascal, TSecond>;
  TPascalSecondId = specialize TUnitProductId<TPascal, TSecond>;
  TPascalSeconds = specialize TQuantityProduct<TPascal, TSecond>;
{$ENDIF}

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TNewtonPerMeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TNewtonsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // N/m = N / m

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TMillimeterId}{$DEFINE RatioId:=TNewtonPerMillimeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TMillimeters}{$DEFINE RatioQty:=TNewtonsPerMillimeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // N/mm = N / mm

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TCubicMeterId}{$DEFINE RatioId:=TNewtonPerCubicMeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TCubicMeters}{$DEFINE RatioQty:=TNewtonsPerCubicMeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // N/m3 = N / m3

{$DEFINE LeftId:=TPascalId}{$DEFINE RightId:=TSecondId}{$DEFINE ProdId:=TPascalSecondId}
{$DEFINE LeftQty:=TPascals}{$DEFINE RightQty:=TSeconds}{$DEFINE ProdQty:=TPascalSeconds}
{$DEFINE DEF_PROD}{$i dim.pas} // Pa*s = Pa * s

// alternate definitions
{$DEFINE LeftId:=TPascalId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TNewtonPerMeterId}
{$DEFINE LeftQty:=TPascals}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TNewtonsPerMeter}
{$DEFINE ALT_PROD}{$i dim.pas} // N/m = Pa * m

{$DEFINE LeftId:=TMegapascalId}{$DEFINE RightId:=TMillimeterId}{$DEFINE ProdId:=TNewtonPerMillimeterId}
{$DEFINE LeftQty:=TMegapascals}{$DEFINE RightQty:=TMillimeters}{$DEFINE ProdQty:=TNewtonsPerMillimeter}
{$DEFINE ALT_PROD}{$i dim.pas} // N/mm = MPa * mm

{$DEFINE NumId:=TPascalId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TNewtonPerCubicMeterId}
{$DEFINE NumQty:=TPascals}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TNewtonsPerCubicMeter}
{$DEFINE ALT_RATIO}{$i dim.pas} // N/m3 = Pa / m

{$DEFINE LeftId:=TKilogramPerCubicMeterId}{$DEFINE RightId:=TMeterPerSecondSquaredId}{$DEFINE ProdId:=TNewtonPerCubicMeterId}
{$DEFINE LeftQty:=TKilogramsPerCubicMeter}{$DEFINE RightQty:=TMetersPerSecondSquared}{$DEFINE ProdQty:=TNewtonsPerCubicMeter}
{$DEFINE ALT_PROD}{$i dim.pas} // N/m3 = kg/m3 * m/s2

{$DEFINE LeftId:=TPascalSecondId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TKilogramPerSecondId}
{$DEFINE LeftQty:=TPascalSeconds}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TKilogramsPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas} // kg/s = Pa*s * m

{ Heat and Thermodynamics }
{$IFDEF INTF}
type
  TJoulePerKelvin = specialize TRatioUnit<TJoule, TKelvin>;
  TJoulePerKelvinId = specialize TRatioUnitId<TJoule, TKelvin>;
  TJoulesPerKelvin = specialize TRatioQuantity<TJoule, TKelvin>;

  TKilogramKelvin = specialize TUnitProduct<TBaseKilogram, TKelvin>;
  TKilogramKelvinId = specialize TUnitProductId<TBaseKilogram, TKelvin>;
  TKilogramKelvins = specialize TQuantityProduct<TBaseKilogram, TKelvin>;

  TJoulePerKilogramPerKelvin = specialize TRatioUnit<TJoule, TKilogramKelvin>;
  TJoulePerKilogramPerKelvinId = specialize TRatioUnitId<TJoule, TKilogramKelvin>;
  TJoulesPerKilogramPerKelvin = specialize TRatioQuantity<TJoule, TKilogramKelvin>;
{$ENDIF}

{ main definition [ J/K ] = [ J ] / [ K ] }
{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TKelvinId}{$DEFINE RatioId:=TJoulePerKelvinId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TKelvins}{$DEFINE RatioQty:=TJoulesPerKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ kg*K ] = [ kg ] * [ K ] }
{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TKelvinId}{$DEFINE ProdId:=TKilogramKelvinId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TKelvins}{$DEFINE ProdQty:=TKilogramKelvins}
{$DEFINE DEF_PROD}{$i dim.pas}

{ main definition [ J/kg/K ] = [ J ] / [ kg*K ] }
{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TKilogramKelvinId}{$DEFINE RatioId:=TJoulePerKilogramPerKelvinId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TKilogramKelvins}{$DEFINE RatioQty:=TJoulesPerKilogramPerKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ J/kg/K ] = [ J/kg ] / [ K ] = [ m2/s2 ] / [ K ] }
{$DEFINE NumId:=TSquareMeterPerSquareSecondId}{$DEFINE DenomId:=TKelvinId}{$DEFINE RatioId:=TJoulePerKilogramPerKelvinId}
{$DEFINE NumQty:=TSquareMetersPerSquareSecond}{$DEFINE DenomQty:=TKelvins}{$DEFINE RatioQty:=TJoulesPerKilogramPerKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ J/kg/K ] = [ J/K ] / [ kg ] }
{$DEFINE LeftId:=TJoulePerKilogramPerKelvinId}{$DEFINE RightId:=TKilogramId}{$DEFINE ProdId:=TJoulePerKelvinId}
{$DEFINE LeftQty:=TJoulesPerKilogramPerKelvin}{$DEFINE RightQty:=TKilograms}{$DEFINE ProdQty:=TJoulesPerKelvin}
{$DEFINE ALT_PROD}{$i dim.pas}

