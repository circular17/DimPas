//////////////////////////////// SPECIAL UNITS /////////////////////////////////

{$IFDEF INTF}
const
  SpecialUnits: array[0..19] of record Formula, Symbol, Recipee, Name: string end = (
  (Formula: 's-1';     Symbol: 'Hz';  Recipee: 'reciprocal second';                 Name: 'Herz'),
  (Formula: 'rad2';    Symbol: 'sr';  Recipee: 'square radian';                     Name: 'steradian'),
  (Formula: 'kg.m/s2'; Symbol: 'N';   Recipee: 'kilogram-meter per second squared'; Name: 'newton'),
  (Formula: 'N/m2';    Symbol: 'Pa';  Recipee: 'newton per square meter';           Name: 'pascal'),
  (Formula: 'kN/m2';   Symbol: 'kPa'; Recipee: 'kilonewton per square meter';       Name: 'kilopascal'),
  (Formula: 'N/mm2';   Symbol: 'MPa'; Recipee: 'newton per square millimeter';      Name: 'megapascal'),
  (Formula: 'N.m';     Symbol: 'J';   Recipee: 'newton-meter';                      Name: 'joule'),
  (Formula: 'J/s';     Symbol: 'W';   Recipee: 'joule per second';                  Name: 'watt'),
  (Formula: 'A.s';     Symbol: 'C';   Recipee: 'ampere-second';                     Name: 'coulomb'),
  (Formula: 'J/C';     Symbol: 'V';   Recipee: 'joule per coulomb';                 Name: 'volt'),
  (Formula: 'V.s';     Symbol: 'Wb';  Recipee: 'volt-second';                       Name: 'weber'),
  (Formula: 'Wb/m2';   Symbol: 'T';   Recipee: 'weber per square meter';            Name: 'tesla'),
  (Formula: 'V/A';     Symbol: 'Ω';   Recipee: 'volt per ampere';                   Name: 'ohm'),
  (Formula: 'A/V';     Symbol: 'S';   Recipee: 'ampere per volt';                   Name: 'siemens'),
  (Formula: 'Wb/A';    Symbol: 'H';   Recipee: 'weber per ampere';                  Name: 'henry'),
  (Formula: 'C/V';     Symbol: 'F';   Recipee: 'coulomb per volt';                  Name: 'farad'),
  (Formula: 'cd.sr';   Symbol: 'lm';  Recipee: 'candela-steradian';                 Name: 'lumen'),
  (Formula: 'lm/m2';   Symbol: 'lx';  Recipee: 'lumen per square meter';            Name: 'lux'),
  (Formula: 'J/kg';    Symbol: 'Gy';  Recipee: 'joule per kilogram';                Name: 'gray'),
  (Formula: 'mol/s';   Symbol: 'kat'; Recipee: 'mole per second';                   Name: 'katal')
  );

  // Equivalences that are not automatically translated
  // --------------------------------------------------
  // m/m = rad
  // Bq  = s-1 = Hz
  // Sv  = s2/m2
{$ENDIF}

function GetSpecialUnitSymbolFromFormula(AFormula: string): string;
{$IFDEF IMPL}var i: integer;
begin
  for i := low(SpecialUnits) to high(SpecialUnits) do
    if SpecialUnits[i].Formula = AFormula then
      exit(SpecialUnits[i].Symbol);
  result := AFormula;
end;{$ENDIF}

function GetSpecialUnitNameFromRecipee(ARecipee: string): string;
{$IFDEF IMPL}var i: integer;
begin
  for i := low(SpecialUnits) to high(SpecialUnits) do
    if SpecialUnits[i].Recipee = ARecipee then
      exit(SpecialUnits[i].Name);
  result := ARecipee;
end;{$ENDIF}


{ Frequency units : Hz = 1 / s }
{$IFDEF INTF}
type
  THertzId = specialize TReciprocalUnitId<TSecond>;
  THertz = specialize TReciprocalQuantity<TSecond>;

  TKilohertz = specialize TFactoredReciprocalQuantity<TSecond, specialize TMilliUnit<TSecond>>;
  TMegahertz = specialize TFactoredReciprocalQuantity<TSecond, specialize TMicroUnit<TSecond>>;
  TGigahertz = specialize TFactoredReciprocalQuantity<TSecond, specialize TNanoUnit<TSecond>>;
  TTerahertz = specialize TFactoredReciprocalQuantity<TSecond, specialize TPicoUnit<TSecond>>;
var
  Hz: THertzId;
  kHz: specialize TFactoredReciprocalUnitId<TSecond, specialize TMilliUnit<TSecond>>;
  MHz: specialize TFactoredReciprocalUnitId<TSecond, specialize TMicroUnit<TSecond>>;
  GHz: specialize TFactoredReciprocalUnitId<TSecond, specialize TNanoUnit<TSecond>>;
  THz: specialize TFactoredReciprocalUnitId<TSecond, specialize TPicoUnit<TSecond>>;
{$ENDIF}

{$DEFINE DenomId:=TSecondId}{$DEFINE RecipId:=THertzId}
{$DEFINE DenomQty:=TSeconds}{$DEFINE RecipQty:=THertz}
{$DEFINE DEF_RECIP}{$i dim.pas} // Hz = 1 / s

{ angle units }
{$IFDEF INTF}
type
  TRadian = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TRadianId = specialize TUnitId<TRadian>;
  TRadians = specialize TQuantity<TRadian>;
  TSteradian = specialize TSquareUnit<TRadian>;
  TSteradianId = specialize TSquareUnitId<TRadian>;
  TSteradianFactorId = specialize TUnitId<TSteradian>;
  TSteradians = specialize TSquareQuantity<TRadian>;
  TSteradiansFactor = specialize TQuantity<TSteradian>;

  TRadianHelper = record helper for TRadianId
    function ArcCos(AValue: double): TRadians;
    function ArcSin(AValue: double): TRadians;
    function ArcTan(AValue: double): TRadians;
    function ArcTan2(y, x: double): TRadians;
  end;

  TRadiansHelper = record helper for TRadians
    function Cos: double;
    function Sin: double;
    function Tan: double;
    function Cotan: double;
    function Secant: double;
    function Cosecant: double;
  end;

  TDegree = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TDegreeId = specialize TFactoredUnitId<TRadian, TDegree>;
  TDegrees = specialize TFactoredQuantity<TRadian, TDegree>;
  TSquareDegreeId = specialize TFactoredSquareUnitId<TRadian, TDegree>;
  TSquareDegrees = specialize TFactoredSquareQuantity<TRadian, TDegree>;

  TDegreeHelper = record helper for TDegreeId
    function ArcCos(AValue: double): TDegrees;
    function ArcSin(AValue: double): TDegrees;
    function ArcTan(AValue: double): TDegrees;
    function ArcTan2(y, x: double): TDegrees;
  end;

  TDegreesHelper = record helper for TDegrees
    function Cos: double;
    function Sin: double;
    function Tan: double;
    function Cotan: double;
    function Secant: double;
    function Cosecant: double;
  end;
var
  rad: TRadianId;
  sr: TSteradianId;
  deg: TDegreeId;
  deg2: TSquareDegrees;
{$ENDIF}{$IFDEF IMPL}
class function TRadian.Symbol: string; begin result := 'rad'; end;
class function TRadian.Name: string;   begin result := 'radian'; end;

{ TRadianHelper }

function TRadianHelper.ArcCos(AValue: double): TRadians;
begin
  result.Value := Math.ArcCos(AValue);
end;

function TRadianHelper.ArcSin(AValue: double): TRadians;
begin
  result.Value := Math.ArcSin(AValue);
end;

function TRadianHelper.ArcTan(AValue: double): TRadians;
begin
  result.Value := System.ArcTan(AValue);
end;

function TRadianHelper.ArcTan2(y, x: double): TRadians;
begin
  result.Value := Math.ArcTan2(y, x);
end;

{ TRadiansHelper }

function TRadiansHelper.Cos: double;
begin result := System.Cos(Value); end;

function TRadiansHelper.Sin: double;
begin result := System.Sin(Value); end;

function TRadiansHelper.Tan: double;
begin result := Math.Tan(Value); end;

function TRadiansHelper.Cotan: double;
begin result := Math.Cotan(Value); end;

function TRadiansHelper.Secant: double;
begin result := Math.Secant(Value); end;

function TRadiansHelper.Cosecant: double;
begin result := Math.Cosecant(Value); end;

class function TDegree.Factor: double; begin result := Pi/180; end;
class function TDegree.Symbol: string; begin result := 'º'; end;
class function TDegree.Name: string;   begin result := 'degree'; end;

{ TDegreeHelper }

function TDegreeHelper.ArcCos(AValue: double): TDegrees;
begin
  result.Assign(rad.ArcCos(AValue));
end;

function TDegreeHelper.ArcSin(AValue: double): TDegrees;
begin
  result.Assign(rad.ArcSin(AValue));
end;

function TDegreeHelper.ArcTan(AValue: double): TDegrees;
begin
  result.Assign(rad.ArcTan(AValue));
end;

function TDegreeHelper.ArcTan2(y, x: double): TDegrees;
begin
  result.Assign(rad.ArcTan2(y, x));
end;

{ TDegreesHelper }

function TDegreesHelper.Cos: double;
begin result := ToBase.Cos; end;

function TDegreesHelper.Sin: double;
begin result := ToBase.Sin; end;

function TDegreesHelper.Tan: double;
begin result := ToBase.Tan; end;

function TDegreesHelper.Cotan: double;
begin result := ToBase.Cotan; end;

function TDegreesHelper.Secant: double;
begin result := ToBase.Secant; end;

function TDegreesHelper.Cosecant: double;
begin result := ToBase.Cosecant; end;
{$ENDIF}

// dimension equivalence
operator:=(const {%H-}sr: TSteradianId): TSteradianFactorId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const ASolidAngle: TSteradians): TSteradiansFactor; inline;
{$IFDEF IMPL}begin result.Value := ASolidAngle.Value; end;{$ENDIF}
operator:=(const ASolidAngle: TSteradiansFactor): TSteradians; inline;
{$IFDEF IMPL}begin result.Value := ASolidAngle.Value; end;{$ENDIF}

{ units of mass }
{$IFDEF INTF}
type
  // the kg is also a base unit for special units in SI
  TBaseKilogram = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TBaseKilograms = specialize TQuantity<TBaseKilogram>;
{$ENDIF}{$IFDEF IMPL}
class function TBaseKilogram.Symbol: string; begin result := 'kg'; end;
class function TBaseKilogram.Name: string;   begin result := 'kilogram'; end;
{$ENDIF}

// dimension equivalence
operator:=(const AWeight: TKilograms): TBaseKilograms;
{$IFDEF IMPL}begin result.Value := AWeight.Value; end;{$ENDIF}
operator:=(const AWeight: TGrams): TBaseKilograms;
{$IFDEF IMPL}begin result.Value := AWeight.Value * 0.001; end;{$ENDIF}
operator:=(const AWeight: TBaseKilograms): TKilograms;
{$IFDEF IMPL}begin result.Value := AWeight.Value; end;{$ENDIF}
operator:=(const AWeight: TBaseKilograms): TGrams;
{$IFDEF IMPL}begin result.Value := AWeight.Value * 1000; end;{$ENDIF}

{ units of force : N = kg*m/s2 }
{$IFDEF INTF}
type
  TNewton = specialize TUnitProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtonId = specialize TUnitProductId<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtons = specialize TQuantityProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TMillinewton = specialize TMilliUnit<TNewton>;
  TMillinewtonId = specialize TFactoredUnitId<TNewton, TMillinewton>;
  TMillinewtons = specialize TFactoredQuantity<TNewton, TMillinewton>;
  TKilonewton = specialize TKiloUnit<TNewton>;
  TKilonewtonId = specialize TFactoredUnitId<TNewton, TKilonewton>;
  TKilonewtons = specialize TFactoredQuantity<TNewton, TKilonewton>;
var
  milliN: TMillinewtonId;
  N: TNewtonId;
  kN: TKilonewtonId;
{$ENDIF}

{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TMeterPerSecondSquaredId}{$DEFINE ProdId:=TNewtonId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TMetersPerSecondSquared}{$DEFINE ProdQty:=TNewtons}
{$DEFINE DEF_PROD}{$i dim.pas} // N = kg * m/s2

// alternate definitions
{$DEFINE LeftId:=TGramId}{$DEFINE RightId:=TMeterPerSecondSquaredId}{$DEFINE ProdId:=TMillinewtonId}
{$DEFINE LeftQty:=TGrams}{$DEFINE RightQty:=TMetersPerSecondSquared}{$DEFINE ProdQty:=TMillinewtons}
{$DEFINE ALT_PROD}{$i dim.pas} // mN = g * m/s2

{$DEFINE LeftId:=TTonId}{$DEFINE RightId:=TMeterPerSecondSquaredId}{$DEFINE ProdId:=TKilonewtonId}
{$DEFINE LeftQty:=TTons}{$DEFINE RightQty:=TMetersPerSecondSquared}{$DEFINE ProdQty:=TKilonewtons}
{$DEFINE ALT_PROD}{$i dim.pas} // kN = t * m/s2

{$DEFINE LeftId:=TKilogramPerSecondId}{$DEFINE RightId:=TMeterPerSecondId}{$DEFINE ProdId:=TNewtonId}
{$DEFINE LeftQty:=TKilogramsPerSecond}{$DEFINE RightQty:=TMetersPerSecond}{$DEFINE ProdQty:=TNewtons}
{$DEFINE ALT_PROD}{$i dim.pas} // N = kg/s * m/s

{ units of pressure }
{$IFDEF INTF}
type
  TPascal = specialize TRatioUnit<TNewton, TSquareMeter>;
  TPascalId = specialize TRatioUnitId<TNewton, TSquareMeter>;
  TPascals = specialize TRatioQuantity<TNewton, TSquareMeter>;

  TKilopascal = specialize TFactoredNumeratorUnit<TKilonewton, TSquareMeter>;
  TKilopascalId = specialize TFactoredNumeratorUnitId<TNewton, TSquareMeter, TKilonewton>;
  TKilopascals = specialize TFactoredNumeratorQuantity<TNewton, TSquareMeter, TKilonewton>;

  TMegapascal = specialize TFactoredDenominatorUnit<TNewton, TSquareMillimeter>;
  TMegapascalId = specialize TFactoredDenominatorUnitId<TNewton, TSquareMeter, TSquareMillimeter>;
  TMegapascals = specialize TFactoredDenominatorQuantity<TNewton, TSquareMeter, TSquareMillimeter>;
var
  Pa: TPascalId;
  kPa: TKilopascalId;
  MPa: TMegapascalId;
{$ENDIF}

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TPascalId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TPascals}
{$DEFINE DEF_RATIO}{$i dim.pas} // Pa = N / m2

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TSquareMillimeterId}{$DEFINE RatioId:=TMegapascalId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TSquareMillimeters}{$DEFINE RatioQty:=TMegapascals}
{$DEFINE DEF_RATIO}{$i dim.pas} // MPa = N / mm2

{$DEFINE NumId:=TKilonewtonId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TKilopascalId}
{$DEFINE NumQty:=TKilonewtons}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TKilopascals}
{$DEFINE DEF_RATIO}{$i dim.pas} // kPa = kN / m2

// alternative definition
{$DEFINE LeftId:=TKilogramPerCubicMeterId}{$DEFINE RightId:=TSquareMeterPerSquareSecondId}{$DEFINE ProdId:=TPascalId}
{$DEFINE LeftQty:=TKilogramsPerCubicMeter}{$DEFINE RightQty:=TSquareMetersPerSquareSecond}{$DEFINE ProdQty:=TPascals}
{$DEFINE ALT_PROD}{$i dim.pas} // [ Pa ] = [ kg/m3 ] * [ m2/s2 ]

{ units of energy and power }
{$IFDEF INTF}
type
  TJoule = specialize TUnitProduct<TNewton, TMeter>;
  TJouleId = specialize TUnitProductId<TNewton, TMeter>;
  TJoules = specialize TQuantityProduct<TNewton, TMeter>;

  TWatt = specialize TRatioUnit<TJoule, TSecond>;
  TWattId = specialize TRatioUnitId<TJoule, TSecond>;
  TWatts = specialize TRatioQuantity<TJoule, TSecond>;
var
  J: TJouleId;
  W: TWattId;
{$ENDIF}

{ main definition [ J ] = [ N ] * [ m ] }
{$DEFINE LeftId:=TNewtonId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TJouleId}
{$DEFINE LeftQty:=TNewtons}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TJoules}
{$DEFINE DEF_PROD}{$i dim.pas}

{ alternative definition [ J ] = [ kg ] * [ m2/s2 ] }
{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TSquareMeterPerSquareSecondId}{$DEFINE ProdId:=TJouleId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TSquareMetersPerSquareSecond}{$DEFINE ProdQty:=TJoules}
{$DEFINE ALT_PROD}{$DEFINE NO_DIV_LEFT}{$i dim.pas}

{ alternative definition [ J ] = [ Pa ] * [ m3 ] }
{$DEFINE LeftId:=TPascalId}{$DEFINE RightId:=TCubicMeterId}{$DEFINE ProdId:=TJouleId}
{$DEFINE LeftQty:=TPascals}{$DEFINE RightQty:=TCubicMeters}{$DEFINE ProdQty:=TJoules}
{$DEFINE ALT_PROD}{$i dim.pas}

{ main definition [ W ] = [ J ] / [ s ] }
{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TWattId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TWatts}
{$DEFINE DEF_RATIO}{$i dim.pas}

(*
{ alternative definition [ W ] = [ J ] * [ rad/s ] }
{$DEFINE LeftId:=TJouleId}{$DEFINE RightId:=TRadianPerSecondId}{$DEFINE ProdId:=TWattId}
{$DEFINE LeftQty:=TJoules}{$DEFINE RightQty:=TRadiansPerSecond}{$DEFINE ProdQty:=TWatts}
{$DEFINE ALT_PROD}{$i dim.pas}
*)

{ units of charge and electric pontential }
{$IFDEF INTF}
type
  TCoulomb = specialize TUnitProduct<TAmpere, TSecond>;
  TCoulombId = specialize TUnitProductId<TAmpere, TSecond>;
  TCoulombs = specialize TQuantityProduct<TAmpere, TSecond>;

  TSquareCoulomb = specialize TSquareUnit<TCoulomb>;
  TSquareCoulombId = specialize TSquareUnitId<TCoulomb>;
  TSquareCoulombFactorId = specialize TUnitId<TSquareCoulomb>;
  TSquareCoulombs = specialize TSquareQuantity<TCoulomb>;
  TSquareCoulombsFactor = specialize TQuantity<TSquareCoulomb>;

  TVolt = specialize TRatioUnit<TJoule, TCoulomb>;
  TVoltId = specialize TRatioUnitId<TJoule, TCoulomb>;
  TVolts = specialize TRatioQuantity<TJoule, TCoulomb>;

  TSquareVolt = specialize TSquareUnit<TVolt>;
  TSquareVoltId = specialize TSquareUnitId<TVolt>;
  TSquareVolts = specialize TSquareQuantity<TVolt>;
var
  C: TCoulombId;
  C2: TSquareCoulombId;

  V: TVoltId;
  V2: TSquareVoltId;
{$ENDIF}

{$DEFINE LeftId:=TAmpereId}{$DEFINE RightId:=TSecondId}{$DEFINE ProdId:=TCoulombId}
{$DEFINE LeftQty:=TAmperes}{$DEFINE RightQty:=TSeconds}{$DEFINE ProdQty:=TCoulombs}
{$DEFINE DEF_PROD}{$i dim.pas} // C = A * s

{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TCoulombId}{$DEFINE RatioId:=TVoltId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TCoulombs}{$DEFINE RatioQty:=TVolts}
{$DEFINE DEF_RATIO}{$i dim.pas} // V = J / C

// dimension equivalence
operator:=(const {%H-}C2: TSquareCoulombId): TSquareCoulombFactorId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const ASquareCharge: TSquareCoulombs): TSquareCoulombsFactor; inline;
{$IFDEF IMPL}begin result.Value := ASquareCharge.Value; end;{$ENDIF}
operator:=(const ASquareCharge: TSquareCoulombsFactor): TSquareCoulombs; inline;
{$IFDEF IMPL}begin result.Value := ASquareCharge.Value; end;{$ENDIF}

// alternate definitions
{$DEFINE LeftId:=TVoltId}{$DEFINE RightId:=TAmpereId}{$DEFINE ProdId:=TWattId}
{$DEFINE LeftQty:=TVolts}{$DEFINE RightQty:=TAmperes}{$DEFINE ProdQty:=TWatts}
{$DEFINE ALT_PROD}{$i dim.pas} // W = V * A

{ units of magnetic flux and flux density }
{$IFDEF INTF}
type
  TWeber = specialize TUnitProduct<TVolt, TSecond>;
  TWeberId = specialize TUnitProductId<TVolt, TSecond>;
  TWebers = specialize TQuantityProduct<TVolt, TSecond>;

  TTesla = specialize TRatioUnit<TWeber, TSquareMeter>;
  TTeslaId = specialize TRatioUnitId<TWeber, TSquareMeter>;
  TTeslas = specialize TRatioQuantity<TWeber, TSquareMeter>;
var
  Wb: TWeberId;
  T: TTeslaId;
{$ENDIF}

{$DEFINE LeftId:=TVoltId}{$DEFINE RightId:=TSecondId}{$DEFINE ProdId:=TWeberId}
{$DEFINE LeftQty:=TVolts}{$DEFINE RightQty:=TSeconds}{$DEFINE ProdQty:=TWebers}
{$DEFINE DEF_PROD}{$i dim.pas} // Wb = V * s

{$DEFINE NumId:=TWeberId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TTeslaId}
{$DEFINE NumQty:=TWebers}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TTeslas}
{$DEFINE DEF_RATIO}{$i dim.pas} // T = Wb / m2

{ units of electrical resistance, conductance and inductance }
{$IFDEF INTF}
type
  TOhm = specialize TRatioUnit<TVolt, TAmpere>;
  TOhmId = specialize TRatioUnitId<TVolt, TAmpere>;
  TOhms = specialize TRatioQuantity<TVolt, TAmpere>;

  TSiemensId = specialize TRatioUnitId<TAmpere, TVolt>;
  TSiemens = specialize TRatioQuantity<TAmpere, TVolt>;

  THenry = specialize TRatioUnit<TWeber, TAmpere>;
  THenryId = specialize TRatioUnitId<TWeber, TAmpere>;
  THenrys = specialize TRatioQuantity<TWeber, TAmpere>;
var
  ohm: TOhmId;
  siemens, mho: TSiemensId;
  henry: THenryId;
{$ENDIF}

{$DEFINE NumId:=TVoltId}{$DEFINE DenomId:=TAmpereId}{$DEFINE RatioId:=TOhmId}
{$DEFINE NumQty:=TVolts}{$DEFINE DenomQty:=TAmperes}{$DEFINE RatioQty:=TOhms}
{$DEFINE DEF_RATIO}{$i dim.pas} // Ω = V / A

{$DEFINE NumId:=TAmpereId}{$DEFINE DenomId:=TVoltId}{$DEFINE RatioId:=TSiemensId}
{$DEFINE NumQty:=TAmperes}{$DEFINE DenomQty:=TVolts}{$DEFINE RatioQty:=TSiemens}
{$DEFINE DEF_RATIO}{$i dim.pas} // S = A / V

{$DEFINE NumId:=TWeberId}{$DEFINE DenomId:=TAmpereId}{$DEFINE RatioId:=THenryId}
{$DEFINE NumQty:=TWebers}{$DEFINE DenomQty:=TAmperes}{$DEFINE RatioQty:=THenrys}
{$DEFINE DEF_RATIO}{$i dim.pas} // H = Wb / A

{$DEFINE DenomId:=TOhmId}{$DEFINE RecipId:=TSiemensId}
{$DEFINE DenomQty:=TOhms}{$DEFINE RecipQty:=TSiemens}
{$DEFINE ALT_RECIP}{$i dim.pas} // S = 1 / Ω

{$DEFINE LeftId:=TOhmId}{$DEFINE RightId:=TSquareAmpereId}{$DEFINE ProdId:=TWattId}
{$DEFINE LeftQty:=TOhms}{$DEFINE RightQty:=TSquareAmperes}{$DEFINE ProdQty:=TWatts}
{$DEFINE ALT_PROD}{$i dim.pas} // W = Ω * A2

{$DEFINE LeftId:=TWattId}{$DEFINE RightId:=TOhmId}{$DEFINE ProdId:=TSquareVoltId}
{$DEFINE LeftQty:=TWatts}{$DEFINE RightQty:=TOhms}{$DEFINE ProdQty:=TSquareVolts}
{$DEFINE ALT_PROD}{$i dim.pas} // V2 = W * Ω

{ units of electrical capacitance }
{$IFDEF INTF}
type
  TFarad = specialize TRatioUnit<TCoulomb, TVolt>;
  TFaradId = specialize TRatioUnitId<TCoulomb, TVolt>;
  TFarads = specialize TRatioQuantity<TCoulomb, TVolt>;

  TMillifarads = specialize TFactoredQuantity<TFarad, specialize TMilliUnit<TFarad>>;
  TMicrofarads = specialize TFactoredQuantity<TFarad, specialize TMicroUnit<TFarad>>;
  TNanofarads = specialize TFactoredQuantity<TFarad, specialize TNanoUnit<TFarad>>;
  TPicofarads = specialize TFactoredQuantity<TFarad, specialize TPicoUnit<TFarad>>;
var
  F: TFaradId;
  mF: specialize TFactoredUnitId<TFarad, specialize TMilliUnit<TFarad>>;
  uF: specialize TFactoredUnitId<TFarad, specialize TMicroUnit<TFarad>>;
  nF: specialize TFactoredUnitId<TFarad, specialize TNanoUnit<TFarad>>;
  pF: specialize TFactoredUnitId<TFarad, specialize TPicoUnit<TFarad>>;
{$ENDIF}

{$DEFINE NumId:=TCoulombId}{$DEFINE DenomId:=TVoltId}{$DEFINE RatioId:=TFaradId}
{$DEFINE NumQty:=TCoulombs}{$DEFINE DenomQty:=TVolts}{$DEFINE RatioQty:=TFarads}
{$DEFINE DEF_RATIO}{$i dim.pas} // F = C / V

// alternate definitions
{$DEFINE LeftId:=TJouleId}{$DEFINE RightId:=TFaradId}{$DEFINE ProdId:=TSquareCoulombId}
{$DEFINE LeftQty:=TJoules}{$DEFINE RightQty:=TFarads}{$DEFINE ProdQty:=TSquareCoulombs}
{$DEFINE ALT_PROD}{$i dim.pas} // C2 = J * F

{$DEFINE LeftId:=TFaradId}{$DEFINE RightId:=TOhmId}{$DEFINE ProdId:=TSecondId}
{$DEFINE LeftQty:=TFarads}{$DEFINE RightQty:=TOhms}{$DEFINE ProdQty:=TSeconds}
{$DEFINE ALT_PROD}{$i dim.pas} // s = F * Ω

{ units of luminous flux and illuminance }
{$IFDEF INTF}
type
  TLumen = specialize TUnitProduct<TCandela, TSteradian>;
  TLumenId = specialize TUnitProductId<TCandela, TSteradian>;
  TLumens = specialize TQuantityProduct<TCandela, TSteradian>;

  TLuxId = specialize TRatioUnitId<TLumen, TSquareMeter>;
  TLuxQuantity = specialize TRatioQuantity<TLumen, TSquareMeter>;
var
  lm: TLumenId;
  lx: TLuxId;
{$ENDIF}

{$DEFINE LeftId:=TCandelaId}{$DEFINE RightId:=TSteradianId}{$DEFINE ProdId:=TLumenId}
{$DEFINE LeftQty:=TCandelas}{$DEFINE RightQty:=TSteradians}{$DEFINE ProdQty:=TLumens}
{$DEFINE DEF_PROD}{$i dim.pas} // Wb = V * s

{$DEFINE NumId:=TLumenId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TLuxId}
{$DEFINE NumQty:=TLumens}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TLuxQuantity}
{$DEFINE DEF_RATIO}{$i dim.pas} // lx = lm / m2

{ units of radioactivity : Bq = 1 / s }
{$IFDEF INTF}
type
  TBecquerel = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TBecquerelId = specialize TUnitId<TBecquerel>;
  TBecquerels = specialize TQuantity<TBecquerel>;

  { TBecquerelHelper }

  TBecquerelHelper = record helper for TBecquerelId
    function From(const AFrequency: THertz): TBecquerels;
    function Inverse: TSecond;
  end;

  TKilobecquerel = specialize TKiloUnit<TBecquerel>;
  TKilobecquerelId = specialize TFactoredUnitId<TBecquerel, TKilobecquerel>;
  TKilobecquerels = specialize TFactoredQuantity<TBecquerel, TKilobecquerel>;

  TMegabecquerel = specialize TMegaUnit<TBecquerel>;
  TMegabecquerelId = specialize TFactoredUnitId<TBecquerel, TMegabecquerel>;
  TMegabecquerels = specialize TFactoredQuantity<TBecquerel, TMegabecquerel>;

  TCurie = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TCurieId = specialize TFactoredUnitId<TBecquerel, TCurie>;
  TCuries = specialize TFactoredQuantity<TBecquerel, TCurie>;
var
  Bq: TBecquerelId;
  kBq: TKilobecquerelId;
  MBq: TMegabecquerelId;
  Ci: TCurieId;
{$ENDIF}{$IFDEF IMPL}
class function TBecquerel.Symbol: string; begin result := 'Bq'; end;
class function TBecquerel.Name: string;   begin result := 'becquerel'; end;

class function TCurie.Symbol: string; begin result := 'Ci'; end;
class function TCurie.Name: string;   begin result := 'curie'; end;
class function TCurie.Factor: double; begin result := 37e9; end;

{ TBecquerelHelper }

function TBecquerelHelper.From(const AFrequency: THertz): TBecquerels;
begin result.Value := AFrequency.Value; end;

function TBecquerelHelper.Inverse: TSecond;
begin end;
{$ENDIF}

// definition
operator/(const AValue: double; const ARadioactivity: TBecquerels): TSeconds; //inline;
{$IFDEF IMPL}begin result := AValue / ARadioactivity; end;{$ENDIF}
operator*(const ARadioactivity: TBecquerels; const ATime: TSeconds): double; inline;
{$IFDEF IMPL}begin result := ARadioactivity * ATime; end;{$ENDIF}
operator*(const ATime: TSeconds; const ARadioactivity: TBecquerels): double; inline;
{$IFDEF IMPL}begin result := ATime * ARadioactivity; end;{$ENDIF}

// dimension equivalence
operator:=(const ARadioactivity: TBecquerels): THertz; inline;
{$IFDEF IMPL}begin result.Value := ARadioactivity.Value; end;{$ENDIF}

// units of ionizing radiation dose
{$IFDEF INTF}
type
  TGrayId = specialize TRatioUnitId<TJoule, TBaseKilogram>;
  TGrays = specialize TRatioQuantity<TJoule, TBaseKilogram>;

  { TGrayHelper }

  TGrayHelper = record helper for TGrayId
    function From(const ASquareSpeed: TSquareMetersPerSquareSecond): TGrays;
  end;

  TSievert = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TSievertId = specialize TUnitId<TSievert>;
  TSieverts = specialize TQuantity<TSievert>;

  { TSievertHelper }

  TSievertHelper = record helper for TSievertId
    function From(const ASquareSpeed: TSquareMetersPerSquareSecond): TSieverts;
  end;
var
  Gy: TGrayId;
  Sv: TSievertId;
{$ENDIF}{$IFDEF IMPL}
class function TSievert.Symbol: string; begin result := 'Sv'; end;
class function TSievert.Name: string;   begin result := 'sievert'; end;

{ TGrayHelper }

function TGrayHelper.From(const ASquareSpeed: TSquareMetersPerSquareSecond): TGrays;
begin result.Value := ASquareSpeed.Value; end;

{ TSievertHelper }

function TSievertHelper.From(const ASquareSpeed: TSquareMetersPerSquareSecond): TSieverts;
begin result.Value := ASquareSpeed.Value; end;
{$ENDIF}

{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TKilogramId}{$DEFINE RatioId:=TGrayId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TKilograms}{$DEFINE RatioQty:=TGrays}
{$DEFINE DEF_RATIO}{$i dim.pas} // Gy = J / kg

// dimension equivalence
operator:=(const {%H-}Sv: TSievertId): TSquareMeterPerSquareSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const AEquivalentDose: TSieverts): TSquareMetersPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := AEquivalentDose.Value; end;{$ENDIF}

operator:=(const {%H-}Gy: TGrayId): TSquareMeterPerSquareSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const AAbsorbedDose: TGrays): TSquareMetersPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := AAbsorbedDose.Value; end;{$ENDIF}

{ units of catalytic activity }
{$IFDEF INTF}
type
  TKatalId = specialize TRatioUnitId<TMole, TSecond>;
  TKatals = specialize TRatioQuantity<TMole, TSecond>;
var
  kat: TKatalId;
{$ENDIF}

{$DEFINE NumId:=TMoleId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TKatalId}
{$DEFINE NumQty:=TMoles}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TKatals}
{$DEFINE DEF_RATIO}{$i dim.pas} // kat = mol / s
