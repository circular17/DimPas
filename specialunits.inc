//////////////////////////////// SPECIAL UNITS /////////////////////////////////

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

// combining units
operator /(const {%H-}AValue: double; const {%H-}s: TSecondId): THertzId; inline;
{$IFDEF IMPL}begin if AValue <> 1 then raise Exception.Create('Factor must be 1') end;{$ENDIF}
operator /(const {%H-}AValue: double; const {%H-}s: THertzId): TSecondId; inline;
{$IFDEF IMPL}begin if AValue <> 1 then raise Exception.Create('Factor must be 1') end;{$ENDIF}

// combining quantities
operator /(const AValue: double; const ADuration: TSeconds): THertz; inline;
{$IFDEF IMPL}begin result.Value := AValue / ADuration.Value; end;{$ENDIF}
operator /(const AValue: double; const AFrequency: THertz): TSeconds; inline;
{$IFDEF IMPL}begin result.Value := AValue / AFrequency.Value; end;{$ENDIF}

// alternate definitions
{$DEFINE LeftId:=TMeterId}{$DEFINE RightId:=THertzId}{$DEFINE ProdId:=TMeterPerSecondId}
{$DEFINE LeftQty:=TMeters}{$DEFINE RightQty:=THertz}{$DEFINE ProdQty:=TMetersPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas} // m/s = m * Hz

{$DEFINE LeftId:=TMillimeterId}{$DEFINE RightId:=THertzId}{$DEFINE ProdId:=TMillimeterPerSecondId}
{$DEFINE LeftQty:=TMillimeters}{$DEFINE RightQty:=THertz}{$DEFINE ProdQty:=TMillimetersPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas} // mm/s = mm * Hz

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
begin
  result := System.Cos(Value);
end;

function TRadiansHelper.Sin: double;
begin
  result := System.Sin(Value);
end;

function TRadiansHelper.Tan: double;
begin
  result := Math.Tan(Value);
end;

function TRadiansHelper.Cotan: double;
begin
  result := Math.Cotan(Value);
end;

function TRadiansHelper.Secant: double;
begin
  result := Math.Secant(Value);
end;

function TRadiansHelper.Cosecant: double;
begin
  result := Math.Cosecant(Value);
end;

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
begin
  result := ToBase.Cos;
end;

function TDegreesHelper.Sin: double;
begin
  result := ToBase.Sin;
end;

function TDegreesHelper.Tan: double;
begin
  result := ToBase.Tan;
end;

function TDegreesHelper.Cotan: double;
begin
  result := ToBase.Cotan;
end;

function TDegreesHelper.Secant: double;
begin
  result := ToBase.Secant;
end;

function TDegreesHelper.Cosecant: double;
begin
  result := ToBase.Cosecant;
end;
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
  N: TNewtonId;
  kN: TKilonewtonId;
{$ENDIF}

// combining units
operator *(const {%H-}g: TGramId; const {%H-}m_s2: TMeterPerSecondSquaredId): TMillinewtonId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m_s2: TMeterPerSecondSquaredId; const {%H-}g: TGramId): TMillinewtonId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}mN: TMillinewtonId; const {%H-}g: TGramMeterId): TMeterPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator *(const {%H-}kg: TKilogramId; const {%H-}m_s2: TMeterPerSecondSquaredId): TNewtonId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m_s2: TMeterPerSecondSquaredId; const {%H-}kg: TKilogramId): TNewtonId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N: TNewtonId; const {%H-}kg: TKilogramId): TMeterPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator *(const AWeight: TKilograms; const AAcceleration: TMetersPerSecondSquared): TNewtons; inline;
{$IFDEF IMPL}begin result.Value := AWeight.Value * AAcceleration.Value; end;{$ENDIF}
operator *(const AAcceleration: TMetersPerSecondSquared; const AWeight: TKilograms): TNewtons; inline;
{$IFDEF IMPL}begin result.Value := AWeight.Value * AAcceleration.Value; end;{$ENDIF}
operator /(const AForce: TNewtons; const AWeight: TKilograms): TMetersPerSecondSquared; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / AWeight.Value; end;{$ENDIF}

operator*(const AWeight: TGrams; const AAcceleration: TMetersPerSecondSquared ): TMillinewtons; inline;
{$IFDEF IMPL}begin result.Value := AWeight.Value * AAcceleration.Value; end;{$ENDIF}
operator*(const AAcceleration: TMetersPerSecondSquared; const AWeight: TGrams): TMillinewtons;inline;
{$IFDEF IMPL}begin result.Value := AWeight.Value * AAcceleration.Value; end;{$ENDIF}
operator /(const AForce: TMillinewtons; const AWeight: TGrams): TMetersPerSecondSquared; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / AWeight.Value; end;{$ENDIF}

// alternate definitions
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

// combining units
operator /(const {%H-}N: TNewtonId; const {%H-}m2: TSquareMeterId): TPascalId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N: TNewtonId; const {%H-}mm2: TSquareMillimeterId): TMegapascalId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}kN: TKilonewtonId; const {%H-}m2: TSquareMeterId): TKilopascalId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const AForce: TNewtons; const AArea: TSquareMeters): TPascals; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / AArea.Value; end;{$ENDIF}
operator /(const AForce: TNewtons; const AArea: TSquareMillimeters): TMegapascals; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / AArea.Value; end;{$ENDIF}
operator/(const AForce: TKilonewtons; const AArea: TSquareMeters): TKilopascals; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / AArea.Value; end;{$ENDIF}
operator/(const AForce: TKilonewtons; const AArea: TSquareMillimeters): TMegapascals; inline;
{$IFDEF IMPL}begin result := AForce.ToBase / AArea; end;{$ENDIF}

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

// combining units
operator *(const {%H-}N: TNewtonId; const {%H-}m: TMeterId): TJouleId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m: TMeterId; const {%H-}N: TNewtonId): TJouleId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}J: TJouleId; const {%H-}N: TNewtonId): TMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}J: TJouleId; const {%H-}s: TSecondId): TWattId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator *(const AForce: TNewtons; const ALength: TMeters): TJoules; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value * ALength.Value; end;{$ENDIF}
operator *(const ALength: TMeters; const AForce: TNewtons): TJoules; inline;
{$IFDEF IMPL}begin result.Value := ALength.Value * AForce.Value; end;{$ENDIF}
operator /(const AWork: TJoules; const AForce: TNewtons): TMeters; inline;
{$IFDEF IMPL}begin result.Value := AWork.Value / AForce.Value; end;{$ENDIF}

operator /(const AWork: TJoules; const ATime: TSeconds): TWatts; inline;
{$IFDEF IMPL}begin result.Value := AWork.Value / ATime.Value; end;{$ENDIF}

// alternate definitions
{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TSquareMeterPerSquareSecondId}{$DEFINE ProdId:=TJouleId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TSquareMetersPerSquareSecond}{$DEFINE ProdQty:=TJoules}
{$DEFINE ALT_PROD}{$i dim.pas} // J = kg * m2/s2

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

// dimension equivalence
operator:=(const {%H-}C2: TSquareCoulombId): TSquareCoulombFactorId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const ASquareCharge: TSquareCoulombs): TSquareCoulombsFactor; inline;
{$IFDEF IMPL}begin result.Value := ASquareCharge.Value; end;{$ENDIF}
operator:=(const ASquareCharge: TSquareCoulombsFactor): TSquareCoulombs; inline;
{$IFDEF IMPL}begin result.Value := ASquareCharge.Value; end;{$ENDIF}

// combining units
operator *(const {%H-}A: TAmpereId; const {%H-}s: TSecondId): TCoulombId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}s: TSecondId; const {%H-}A: TAmpereId): TCoulombId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}C: TCoulombId; const {%H-}A: TAmpereId): TSecondId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}J: TJouleId; const {%H-}C: TCoulombId): TVoltId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator*(const ACurrent: TAmperes; const ADuration: TSeconds): TCoulombs; inline;
{$IFDEF IMPL}begin result.Value := ACurrent.Value * ADuration.Value; end;{$ENDIF}
operator *(const ADuration: TSeconds; const ACurrent: TAmperes): TCoulombs; inline;
{$IFDEF IMPL}begin result.Value := ADuration.Value * ACurrent.Value; end;{$ENDIF}
operator /(const ACharge: TCoulombs; const ACurrent: TAmperes): TSeconds; inline;
{$IFDEF IMPL}begin result.Value := ACharge.Value / ACurrent.Value; end;{$ENDIF}

operator /(const AWork: TJoules; const ACharge: TCoulombs): TVolts; inline;
{$IFDEF IMPL}begin result.Value := AWork.Value / ACharge.Value; end;{$ENDIF}

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

// combining units
operator *(const {%H-}V: TVoltId; const {%H-}s: TSecondId): TWeberId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}s: TSecondId; const {%H-}V: TVoltId): TWeberId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}Wb: TWeberId; const {%H-}V: TVoltId): TSecondId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}Wb: TWeberId; const {%H-}m2: TSquareMeterId): TTeslaId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator *(const AVoltage: TVolts; const ATime: TSeconds): TWebers; inline;
{$IFDEF IMPL}begin result.Value := AVoltage.Value * ATime.Value; end;{$ENDIF}
operator *(const ATime: TSeconds; const AVoltage: TVolts): TWebers; inline;
{$IFDEF IMPL}begin result.Value := ATime.Value * AVoltage.Value; end;{$ENDIF}
operator /(const AMagneticFlux: TWebers; const AVoltage: TVolts): TSeconds; inline;
{$IFDEF IMPL}begin result.Value := AMagneticFlux.Value / AVoltage.Value; end;{$ENDIF}

operator /(const AMagneticFlux: TWebers; const AArea: TSquareMeters): TTeslas; inline;
{$IFDEF IMPL}begin result.Value := AMagneticFlux.Value / AArea.Value; end;{$ENDIF}

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

// combining units
operator /(const {%H-}V: TVoltId; const {%H-}A: TAmpereId): TOhmId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}A: TAmpereId; const {%H-}V: TVoltId): TSiemensId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}Wb: TWeberId; const {%H-}A: TAmpereId): THenryId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const AVoltage: TVolts; const ACurrent: TAmperes): TOhms; inline;
{$IFDEF IMPL}begin result.Value := AVoltage.Value / ACurrent.Value; end;{$ENDIF}

operator /(const ACurrent: TAmperes; const AVoltage: TVolts): TSiemens; inline;
{$IFDEF IMPL}begin result.Value := ACurrent.Value / AVoltage.Value; end;{$ENDIF}

operator /(const AMagneticFlux: TWebers; const ACurrent: TAmperes): THenrys; inline;
{$IFDEF IMPL}begin result.Value := AMagneticFlux.Value / ACurrent.Value; end;{$ENDIF}

// alternate definition of S = 1 / Ω
operator /(const {%H-}AValue: double; const {%H-}ohm: TOhmId): TSiemensId; inline;
{$IFDEF IMPL}begin if AValue <> 1 then raise Exception.Create('Factor must be 1') end;{$ENDIF}
operator /(const {%H-}AValue: double; const {%H-}S: TSiemensId): TOhmId; inline;
{$IFDEF IMPL}begin if AValue <> 1 then raise Exception.Create('Factor must be 1') end;{$ENDIF}

operator /(const AValue: double; const AResistance: TOhms): TSiemens; inline;
{$IFDEF IMPL}begin result.Value := AValue / AResistance.Value; end;{$ENDIF}
operator /(const AValue: double; const AElectricalConductance: TSiemens): TOhms; inline;
{$IFDEF IMPL}begin result.Value := AValue / AElectricalConductance.Value; end;{$ENDIF}

// alternate definitions
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

// combining units
operator /(const {%H-}C: TCoulombId; const {%H-}V: TVoltId): TFaradId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const ACharge: TCoulombs; const AVoltage: TVolts): TFarads; inline;
{$IFDEF IMPL}begin result.Value := ACharge.Value / AVoltage.Value; end;{$ENDIF}

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
  TLumenIdentifer = specialize TUnitProductId<TCandela, TSteradian>;
  TLumens = specialize TQuantityProduct<TCandela, TSteradian>;

  TLuxId = specialize TRatioUnitId<TLumen, TSquareMeter>;
  TLuxQuantity = specialize TRatioQuantity<TLumen, TSquareMeter>;
var
  lm: TLumenIdentifer;
  lx: TLuxId;
{$ENDIF}

// combining units
operator *(const {%H-}cd: TCandelaId; const {%H-}sr: TSteradianId): TLumenIdentifer; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}sr: TSteradianId; const {%H-}cd: TCandelaId): TLumenIdentifer; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}lm: TLumenIdentifer; const {%H-}cd: TCandelaId): TSteradianId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}lm: TLumenIdentifer; const {%H-}m2: TSquareMeterId): TLuxId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator *(const ALuminousIntensity: TCandelas; const ASolidAngle: TSteradians): TLumens; inline;
{$IFDEF IMPL}begin result.Value := ALuminousIntensity.Value * ASolidAngle.Value; end;{$ENDIF}
operator *(const ASolidAngle: TSteradians; const ALuminousIntensity: TCandelas): TLumens; inline;
{$IFDEF IMPL}begin result.Value := ASolidAngle.Value * ALuminousIntensity.Value; end;{$ENDIF}
operator /(const ALuminousFlux: TLumens; const ALuminousIntensity: TCandelas): TSteradians; inline;
{$IFDEF IMPL}begin result.Value := ALuminousFlux.Value / ALuminousIntensity.Value; end;{$ENDIF}

operator/(const ALuminousFlux: TLumens; const AArea: TSquareMeters): TLuxQuantity; inline;
{$IFDEF IMPL}begin result.Value := ALuminousFlux.Value / AArea.Value; end;{$ENDIF}

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

// dimension equivalence
operator:=(const ARadioactivity: TBecquerels): THertz; inline;
{$IFDEF IMPL}begin result.Value := ARadioactivity.Value; end;{$ENDIF}

// combining quantities
operator/(const AValue: double; const ARadioactivity: TBecquerels): TSeconds; //inline;
{$IFDEF IMPL}begin result := AValue / ARadioactivity; end;{$ENDIF}
operator*(const ARadioactivity: TBecquerels; const ATime: TSeconds): double; inline;
{$IFDEF IMPL}begin result := ARadioactivity * ATime; end;{$ENDIF}
operator*(const ATime: TSeconds; const ARadioactivity: TBecquerels): double; inline;
{$IFDEF IMPL}begin result := ATime * ARadioactivity; end;{$ENDIF}

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

// combining units
operator /(const {%H-}J: TJouleId; const {%H-}kg: TKilogramId): TGrayId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const AEnergy: TJoules; const AMass: TKilograms): TGrays; inline;
{$IFDEF IMPL}begin result.Value := AEnergy.Value / AMass.Value; end;{$ENDIF}

// dimension equivalence
operator:=(const AEquivalentDose: TSieverts): TSquareMetersPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := AEquivalentDose.Value; end;{$ENDIF}

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

// combining units
operator /(const {%H-}mol: TMoleId; const {%H-}s: TSecondId): TKatalId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator/(const AAmountOfSustance: TMoles; const ATime: TSeconds): TKatals;
{$IFDEF IMPL}begin result.Value := AAmountOfSustance.Value / ATime.Value; end;{$ENDIF}
