////////////////////////////////// BASE UNITS //////////////////////////////////

{ Units of time }
{$IFDEF INTF}
type
  TSecond = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TSecondId = specialize TUnitId<TSecond>;
  TSeconds = specialize TQuantity<TSecond>;

  TMilliseconds = specialize TFactoredQuantity<TSecond, specialize TMilliUnit<TSecond>>;
  TMicroseconds = specialize TFactoredQuantity<TSecond, specialize TMicroUnit<TSecond>>;
  TNanoseconds = specialize TFactoredQuantity<TSecond, specialize TNanoUnit<TSecond>>;

  TMinute = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TMinutes = specialize TFactoredQuantity<TSecond, TMinute>;

  THour = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  THourId = specialize TFactoredUnitId<TSecond, THour>;
  THours = specialize TFactoredQuantity<TSecond, THour>;

  TDay = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TDays = specialize TFactoredQuantity<TSecond, TDay>;

  // this unit is not really to be used directly because
  // time is divided one exponent at a time: m/s2 -> (m/s)/s
  // thus acceleration are "per second squared" instead of "per square second"
  TSquareSecond = specialize TSquareUnit<TSecond>;
  TSquareSecondId = specialize TSquareUnitId<TSecond>;
  TSquareSecondFactorId = specialize TUnitId<TSquareSecond>;
  TSquareSeconds = specialize TSquareQuantity<TSecond>;
  TSquareSecondsFactor = specialize TQuantity<TSquareSecond>;

var
  ns: specialize TFactoredUnitId<TSecond, specialize TNanoUnit<TSecond>>;
  us: specialize TFactoredUnitId<TSecond, specialize TMicroUnit<TSecond>>;
  ms: specialize TFactoredUnitId<TSecond, specialize TMilliUnit<TSecond>>;
  s: TSecondId;
  s2: TSquareSecondId;
  mn: specialize TFactoredUnitId<TSecond, TMinute>;
  h: THourId;
  day: specialize TFactoredUnitId<TSecond, TDay>;
{$ENDIF}{$IFDEF IMPL}
class function TSecond.Symbol: string; begin result := 's'; end;
class function TSecond.Name: string;   begin result := 'second'; end;

class function TMinute.Factor: double; begin result := 60; end;
class function TMinute.Symbol: string; begin result := 'min'; end;
class function TMinute.Name: string;   begin result := 'minute'; end;

class function THour.Factor: double; begin result := 60 * 60; end;
class function THour.Symbol: string; begin result := 'h'; end;
class function THour.Name: string;   begin result := 'hour'; end;

class function TDay.Factor: double; begin result := 60 * 60 * 24; end;
class function TDay.Symbol: string; begin result := 'd'; end;
class function TDay.Name: string;   begin result := 'day'; end;
{$ENDIF}

// dimension equivalence
operator:=(const {%H-}s2: TSquareSecondId): TSquareSecondFactorId; {$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const ASquareTime: TSquareSeconds): TSquareSecondsFactor;
{$IFDEF IMPL}begin result.Value := ASquareTime.Value; end;{$ENDIF}
operator:=(const ASquareTime: TSquareSecondsFactor): TSquareSeconds;
{$IFDEF IMPL}begin result.Value := ASquareTime.Value; end;{$ENDIF}

{ Units of length }
{$IFDEF INTF}
type
  TMeter = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TMeterId = specialize TUnitId<TMeter>;
  TMeters = specialize TQuantity<TMeter>;

  TSquareMeter = specialize TSquareUnit<TMeter>;
  TSquareMeterId = specialize TSquareUnitId<TMeter>;
  TSquareMeterFactorId = specialize TUnitId<TSquareMeter>;
  TSquareMeters = specialize TSquareQuantity<TMeter>;
  TSquareMetersFactor = specialize TQuantity<TSquareMeter>;

  TCubicMeter = specialize TCubicUnit<TMeter>;
  TCubicMeterId = specialize TCubicUnitId<TMeter>;
  TCubicMeterFactorId = specialize TUnitId<TCubicMeter>;
  TCubicMeters = specialize TCubicQuantity<TMeter>;
  TCubicMetersFactor = specialize TQuantity<TCubicMeter>;

  TQuarticMeter = specialize TQuarticUnit<TMeter>;
  TQuarticMeterId = specialize TQuarticUnitId<TMeter>;
  TQuarticMeterFactorId = specialize TUnitId<TQuarticMeter>;
  TQuarticMeters = specialize TQuarticQuantity<TMeter>;
  TQuarticMetersFactor = specialize TQuantity<TQuarticMeter>;

  TKilometer = specialize TKiloUnit<TMeter>;
  TKilometerId = specialize TFactoredUnitId<TMeter, TKilometer>;
  TKilometers = specialize TFactoredQuantity<TMeter, TKilometer>;
  TSquareKilometers = specialize TFactoredSquareQuantity<TMeter, TKilometer>;
  TCubicKilometers = specialize TFactoredCubicQuantity<TMeter, TKilometer>;
  TQuarticKilometers = specialize TFactoredQuarticQuantity<TMeter, TKilometer>;

  TDecimeter = specialize TDeciUnit<TMeter>;
  TDecimeters = specialize TFactoredQuantity<TMeter, TDecimeter>;
  TSquareDecimeters = specialize TFactoredSquareQuantity<TMeter, TDecimeter>;
  TCubicDecimeters = specialize TFactoredCubicQuantity<TMeter, TDecimeter>;
  TQuarticDecimeters = specialize TFactoredQuarticQuantity<TMeter, TDecimeter>;

  TCentimeter = specialize TCentiUnit<TMeter>;
  TCentimeters = specialize TFactoredQuantity<TMeter, TCentimeter>;
  TSquareCentimeters = specialize TFactoredSquareQuantity<TMeter, TCentimeter>;
  TCubicCentimeters = specialize TFactoredCubicQuantity<TMeter, TCentimeter>;
  TQuarticCentimeters = specialize TFactoredQuarticQuantity<TMeter, TCentimeter>;

  TMillimeter = specialize TMilliUnit<TMeter>;
  TMillimeterId = specialize TFactoredUnitId<TMeter, TMillimeter>;
  TMillimeters = specialize TFactoredQuantity<TMeter, TMillimeter>;

  TSquareMillimeter = specialize TFactoredSquareUnit<TMillimeter>;
  TSquareMillimeterId = specialize TFactoredSquareUnitId<TMeter, TMillimeter>;
  TSquareMillimeterFactorId = specialize TFactoredUnitId<TSquareMeter, TSquareMillimeter>;
  TSquareMillimeters = specialize TFactoredSquareQuantity<TMeter, TMillimeter>;
  TSquareMillimetersFactor = specialize TFactoredQuantity<TSquareMeter, TSquareMillimeter>;

  TCubicMillimeter = specialize TFactoredCubicUnit<TMillimeter>;
  TCubicMillimeterId = specialize TFactoredCubicUnitId<TMeter, TMillimeter>;
  TCubicMillimeterFactorId = specialize TFactoredUnitId<TCubicMeter, TCubicMillimeter>;
  TCubicMillimeters = specialize TFactoredCubicQuantity<TMeter, TMillimeter>;
  TCubicMillimetersFactor = specialize TFactoredQuantity<TCubicMeter, TCubicMillimeter>;

  TQuarticMillimeters = specialize TFactoredQuarticQuantity<TMeter, TMillimeter>;

  TMicrometer = specialize TMicroUnit<TMeter>;
  TMicrometerId = specialize TFactoredUnitId<TMeter, TMicrometer>;
  TMicrometers = specialize TFactoredQuantity<TMeter, TMicrometer>;

  TNanometer = specialize TNanoUnit<TMeter>;
  TNanometerId = specialize TFactoredUnitId<TMeter, TNanometer>;
  TNanometers = specialize TFactoredQuantity<TMeter, TNanometer>;

  TPicometer = specialize TPicoUnit<TMeter>;
  TPicometerId = specialize TFactoredUnitId<TMeter, TPicometer>;
  TPicometers = specialize TFactoredQuantity<TMeter, TPicometer>;

  TLitre = class(TUnit)
    class function Symbol: string; override;
    class function Name: string; override;
  end;
  TLitreId = specialize TUnitId<TLitre>;
  TLitres = specialize TQuantity<TLitre>;

  { TLitreHelper }

  TLitreHelper = record helper for TLitreId
    function From(const AVolume: TCubicMeters): TLitres;
    function From(const AVolume: TCubicDecimeters): TLitres;
  end;

var
  km: TKilometerId;
  km2:specialize TFactoredSquareUnitId<TMeter, TKilometer>;
  km3:specialize TFactoredCubicUnitId<TMeter, TKilometer>;
  km4:specialize TFactoredQuarticUnitId<TMeter, TKilometer>;
  m:  TMeterId;
  m2: TSquareMeterId;
  m3: TCubicMeterId;
  m4: TQuarticMeterId;
  cm: specialize TFactoredUnitId<TMeter, TCentimeter>;
  cm2:specialize TFactoredSquareUnitId<TMeter, TCentimeter>;
  cm3:specialize TFactoredCubicUnitId<TMeter, TCentimeter>;
  cm4:specialize TFactoredQuarticUnitId<TMeter, TCentimeter>;
  mm: TMillimeterId;
  mm2:TSquareMillimeterId;
  mm3:TCubicMillimeterId;
  mm4:specialize TFactoredQuarticUnitId<TMeter, TMillimeter>;
  um: TMicrometerId;
  nm: TNanometerId;
  pm: TPicometerId;

  L: TLitreId;
{$ENDIF}{$IFDEF IMPL}
class function TMeter.Symbol: string; begin result := 'm'; end;
class function TMeter.Name: string;   begin result := 'meter'; end;

class function TLitre.Symbol: string; begin result := 'L'; end;
class function TLitre.Name: string;   begin result := 'litre'; end;

function TLitreHelper.From(const AVolume: TCubicMeters): TLitres;
begin
  result.Value := AVolume.Value * 1000;
end;

function TLitreHelper.From(const AVolume: TCubicDecimeters): TLitres;
begin
  result.Value := AVolume.Value;
end;
{$ENDIF}

// combining units
operator /(const {%H-}m3: TCubicMeterId; const {%H-}m2: TSquareMeterId): TMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}m4: TQuarticMeterId; const {%H-}m3: TCubicMeterId): TMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}m4: TQuarticMeterId; const {%H-}m2: TSquareMeterId): TSquareMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const AVolume: TCubicMeters; const ASurface: TSquareMeters): TMeters; inline;
{$IFDEF IMPL}begin result.Value := AVolume.Value / ASurface.Value; end;{$ENDIF}
operator /(const AMomentOfArea: TQuarticMeters; const AVolume: TCubicMeters): TMeters; inline;
{$IFDEF IMPL}begin result.Value := AMomentOfArea.Value / AVolume.Value; end;{$ENDIF}
operator /(const AMomentOfArea: TQuarticMeters; const AArea: TSquareMeters): TSquareMeters; inline;
{$IFDEF IMPL}begin result.Value := AMomentOfArea.Value / AArea.Value; end;{$ENDIF}

// dimension equivalence
operator:=(const AVolume: TLitres): TCubicMeters;
{$IFDEF IMPL}begin result.Value := AVolume.Value * 0.001; end;{$ENDIF}
operator:=(const AVolume: TLitres): TCubicDecimeters;
{$IFDEF IMPL}begin result.Value := AVolume.Value; end;{$ENDIF}

operator:=(const {%H-}m2: TSquareMeterId): TSquareMeterFactorId; {$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const ASurface: TSquareMeters): TSquareMetersFactor;
{$IFDEF IMPL}begin result.Value := ASurface.Value; end;{$ENDIF}
operator:=(const ASurface: TSquareMetersFactor): TSquareMeters;
{$IFDEF IMPL}begin result.Value := ASurface.Value; end;{$ENDIF}
operator:=(const {%H-}mm2: TSquareMillimeterId): TSquareMillimeterFactorId; {$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const ASurface: TSquareMillimeters): TSquareMillimetersFactor;
{$IFDEF IMPL}begin result.Value := ASurface.Value; end;{$ENDIF}
operator:=(const ASurface: TSquareMillimetersFactor): TSquareMillimeters;
{$IFDEF IMPL}begin result.Value := ASurface.Value; end;{$ENDIF}

operator:=(const {%H-}m3: TCubicMeterId): TCubicMeterFactorId; {$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const AVolume: TCubicMeters): TCubicMetersFactor;
{$IFDEF IMPL}begin result.Value := AVolume.Value; end;{$ENDIF}
operator:=(const AVolume: TCubicMetersFactor): TCubicMeters;
{$IFDEF IMPL}begin result.Value := AVolume.Value; end;{$ENDIF}
operator:=(const {%H-}mm3: TCubicMillimeterId): TCubicMillimeterFactorId; {$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const AVolume: TCubicMillimeters): TCubicMillimetersFactor;
{$IFDEF IMPL}begin result.Value := AVolume.Value; end;{$ENDIF}
operator:=(const AVolume: TCubicMillimetersFactor): TCubicMillimeters;
{$IFDEF IMPL}begin result.Value := AVolume.Value; end;{$ENDIF}

operator:=(const {%H-}m4: TQuarticMeterId): TQuarticMeterFactorId; {$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const AHyperVolume: TQuarticMeters): TQuarticMetersFactor;
{$IFDEF IMPL}begin result.Value := AHyperVolume.Value; end;{$ENDIF}
operator:=(const AHyperVolume: TQuarticMetersFactor): TQuarticMeters;
{$IFDEF IMPL}begin result.Value := AHyperVolume.Value; end;{$ENDIF}

{ Units of mass }
{$IFDEF INTF}
type
  TGram = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TGramId = specialize TUnitId<TGram>;
  TGrams = specialize TQuantity<TGram>;

  TMilligram = specialize TMilliUnit<TGram>;
  TMilligrams = specialize TFactoredQuantity<TGram, TMilligram>;

  TKilogram = specialize TKiloUnit<TGram>;
  TKilogramId = specialize TFactoredUnitId<TGram, TKilogram>;
  TKilograms = specialize TFactoredQuantity<TGram, TKilogram>;

  TTon = specialize TMegaUnit<TGram>;
  TTons = specialize TFactoredQuantity<TGram, TTon>;

var
  mg: specialize TFactoredUnitId<TGram, TMilligram>;
  g: TGramId;
  kg: TKilogramId;
  ton: specialize TFactoredUnitId<TGram, TTon>;
{$ENDIF}{$IFDEF IMPL}
class function TGram.Symbol: string; begin result := 'g'; end;
class function TGram.Name: string;   begin result := 'gram'; end;
{$ENDIF}

{ Units of amount of substance }
{$IFDEF INTF}
type
  TMole = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TMoleId = specialize TUnitId<TMole>;
  TMoles = specialize TQuantity<TMole>;

var
  mol: TMoleId;
{$ENDIF}{$IFDEF IMPL}
class function TMole.Symbol: string; begin result := 'mol'; end;
class function TMole.Name: string;   begin result := 'mole'; end;
{$ENDIF}

{ Units of electric current }
{$IFDEF INTF}
type
  TAmpere = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TAmpereId = specialize TUnitId<TAmpere>;
  TAmperes = specialize TQuantity<TAmpere>;

  TSquareAmpere = specialize TSquareUnit<TAmpere>;
  TSquareAmpereId = specialize TSquareUnitId<TAmpere>;
  TSquareAmperes = specialize TSquareQuantity<TAmpere>;

  TMilliampere = specialize TMilliUnit<TAmpere>;
  TMilliampereId = specialize TFactoredUnitId<TAmpere, TMilliampere>;
  TMilliamperes = specialize TFactoredQuantity<TAmpere, TMilliampere>;

  TSquareMilliampere = specialize TFactoredSquareUnit<TMilliampere>;
  TSquareMilliampereId = specialize TFactoredSquareUnitId<TAmpere, TMilliampere>;
  TSquareMilliamperes = specialize TFactoredSquareQuantity<TAmpere, TMilliampere>;

var
  A: TAmpereId;
  mA: TMilliampereId;
  A2: TSquareAmpereId;
  mA2: TSquareMilliampereId;
{$ENDIF}{$IFDEF IMPL}
class function TAmpere.Symbol: string; begin result := 'A'; end;
class function TAmpere.Name: string;   begin result := 'ampere'; end;
{$ENDIF}

{ Units of temperature }
{$IFDEF INTF}
type
  TKelvin = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TKelvinId = specialize TUnitId<TKelvin>;
  TKelvins = specialize TQuantity<TKelvin>;

  TDegreeCelsius = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TDegreeCelsiusId = specialize TBasicUnitId<TDegreeCelsius>;
  TDegreesCelsius = specialize TBasicQuantity<TDegreeCelsius>;
  TDegreeCelsiusIdHelper = record helper for TDegreeCelsiusId
    class function From(const ATemperature: TKelvins): TDegreesCelsius; inline; static; overload;
  end;

  TDegreeFahrenheit = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TDegreeFahrenheitId = specialize TBasicUnitId<TDegreeFahrenheit>;
  TDegreesFahrenheit = specialize TBasicQuantity<TDegreeFahrenheit>;
  TDegreeFahrenheitIdHelper = record helper for TDegreeFahrenheitId
    class function From(const ATemperature: TKelvins): TDegreesFahrenheit; inline; static; overload;
  end;

var
  K: TKelvinId;
  degC: TDegreeCelsiusId;
  degF: TDegreeFahrenheitId;
{$ENDIF}{$IFDEF IMPL}
class function TKelvin.Symbol: string; begin result := 'K'; end;
class function TKelvin.Name: string;   begin result := 'kelvin'; end;

class function TDegreeCelsius.Symbol: string; begin result := 'ºC'; end;
class function TDegreeCelsius.Name: string;   begin result := 'degree Celsius'; end;

class function TDegreeFahrenheit.Symbol: string; begin result := 'ºF'; end;
class function TDegreeFahrenheit.Name: string;   begin result := 'degree Fahrenheit'; end;

class function TDegreeFahrenheitIdHelper.From(const ATemperature: TKelvins): TDegreesFahrenheit;
begin
  result.Value := degC.From(ATemperature).Value*1.8 + 32;
end;

class function TDegreeCelsiusIdHelper.From(const ATemperature: TKelvins): TDegreesCelsius;
begin
  result.Value := ATemperature.Value - 273.15;
end;
{$ENDIF}

operator :=(const ATemperature: TDegreesCelsius): TKelvins;
{$IFDEF IMPL}begin result.Value := ATemperature.Value + 273.15; end;{$ENDIF}
operator :=(const ATemperature: TDegreesFahrenheit): TDegreesCelsius;
{$IFDEF IMPL}begin result.Value := (ATemperature.Value - 32)/1.8; end;{$ENDIF}
operator :=(const ATemperature: TDegreesFahrenheit): TKelvins;
{$IFDEF IMPL}begin result := TDegreesCelsius(ATemperature); end;{$ENDIF}
operator -(const ATemperature1, ATemperature2: TDegreesCelsius): TKelvins;
{$IFDEF IMPL}begin result.Value := ATemperature1.Value - ATemperature2.Value; end;{$ENDIF}
operator +(const ATemperature: TDegreesCelsius; const ADifference: TKelvins): TDegreesCelsius;
{$IFDEF IMPL}begin result.Value := ATemperature.Value + ADifference.Value; end;{$ENDIF}
operator +(const ADifference: TKelvins; const ATemperature: TDegreesCelsius): TDegreesCelsius;
{$IFDEF IMPL}begin result.Value := ATemperature.Value + ADifference.Value; end;{$ENDIF}

{ Units of luminous energy }
{$IFDEF INTF}
type
  TCandela = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TCandelaId = specialize TUnitId<TCandela>;
  TCandelas = specialize TQuantity<TCandela>;

var
  cd: TCandelaId;
{$ENDIF}{$IFDEF IMPL}
class function TCandela.Symbol: string; begin result := 'cd'; end;
class function TCandela.Name: string;   begin result := 'candela'; end;
{$ENDIF}