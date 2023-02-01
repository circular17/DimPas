{$IFNDEF INCLUDING}{$DEFINE INCLUDING}
unit Dim;

{$H+}{$modeSwitch advancedRecords}{$modeSwitch advancedRecords}
{$WARN NO_RETVAL OFF}{$MACRO ON}

interface

uses SysUtils;

type
  TUnit = class
    class function Factor: double; virtual;
    class function Symbol: string; virtual; abstract;
    class function Name: string; virtual; abstract;
  end;

{$UNDEF INCLUDING}{$ENDIF}
{$IF defined(UNIT_OV_INTF) or defined(FACTORED_UNIT_INTF)}
  class(TUnit)
    {$IFDEF FACTORED_UNIT_INTF}
      class function Factor: double; override;
    {$ENDIF}
    class function Symbol: string; override;
    class function Name: string; override;
  end;
{$ENDIF}{$UNDEF UNIT_OV_INTF}{$UNDEF FACTORED_UNIT_INTF}
{$IF defined(UNIT_OV_IMPL) or defined(FACTORED_UNIT_IMPL)}
  {$IFDEF FACTORED_UNIT_IMPL}
    class function T_FACTORED_UNIT.Factor: double; begin result := V_FACTOR; end;
  {$ENDIF}
  class function T_FACTORED_UNIT.Symbol: string; begin result := V_SYMBOL + U.Symbol; end;
  class function T_FACTORED_UNIT.Name: string; begin result := V_NAME + U.Name; end;
{$ENDIF}{$UNDEF UNIT_OV_IMPL}{$UNDEF FACTORED_UNIT_IMPL}
{$IFNDEF INCLUDING}{$DEFINE INCLUDING}

  generic TUnitSquared<BaseU> = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  generic TUnitCubed<BaseU> = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  generic TRatioUnit<NumeratorU, DenomU: TUnit> = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  generic TReciprocalUnit<DenomU: TUnit> = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  generic TUnitProduct<U1, U2: TUnit> = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
 
  { TFactoredRatioUnit }

  generic TFactoredRatioUnit<NumeratorU, DenomU: TUnit> = class(specialize TRatioUnit<NumeratorU, DenomU>)
    class function Factor: double; override;
  end;

  generic TMegaUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TKiloUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic THectoUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TDecaUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TDeciUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TCentiUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TMilliUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TMicroUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}

  { Dimensionned quantities }

  generic TCubedDimensionedQuantity<BaseU: TUnit> = record
    type TSelf = specialize TCubedDimensionedQuantity<BaseU>;
    type U = specialize TUnitCubed<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$i dim.pas}
  end;

  generic TSquaredDimensionedQuantity<BaseU: TUnit> = record
    type TSelf = specialize TSquaredDimensionedQuantity<BaseU>;
    type U = specialize TUnitSquared<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$i dim.pas}
  end;

  generic TDimensionedQuantity<U: TUnit> = record
    type TSelf = specialize TDimensionedQuantity<U>;
    type TSquaredQuantity = specialize TSquaredDimensionedQuantity<U>;
    type TCubedQuantity = specialize TCubedDimensionedQuantity<U>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE SQUARABLE_QTY_INTF}{$i dim.pas}
  end;

  generic TBasicDimensionedQuantity<U: TUnit> = record
    type TSelf = specialize TBasicDimensionedQuantity<U>;
    {$DEFINE BASIC_DIM_QTY_INTF}{$i dim.pas}
  end;

  generic TReciprocalDimensionedQuantity<DenomU: TUnit> = record
    type U = specialize TReciprocalUnit<DenomU>;
    type TSelf = specialize TReciprocalDimensionedQuantity<DenomU>;
    type TDenomQuantity = specialize TDimensionedQuantity<DenomU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE RECIP_QTY_INTF}{$i dim.pas}
  end;

  generic TRatioDimensionedQuantity<NumeratorU, DenomU: TUnit> = record
    type U = specialize TRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TRatioDimensionedQuantity<NumeratorU, DenomU>;
    type TNumeratorQuantity = specialize TDimensionedQuantity<NumeratorU>;
    type TDenomQuantity = specialize TDimensionedQuantity<DenomU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TDimensionedQuantityProduct<U1, U2: TUnit> = record
    type U = specialize TUnitProduct<U1, U2>;
    type TSelf = specialize TDimensionedQuantityProduct<U1, U2>;
    type TQuantity1 = specialize TDimensionedQuantity<U1>;
    type TQuantity2 = specialize TDimensionedQuantity<U2>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  generic TFactoredDimensionedQuantity<BaseU: TUnit; U: TUnit> = record
    type TSelf = specialize TFactoredDimensionedQuantity<BaseU, U>;
    type TBaseDimensionedQuantity = specialize TDimensionedQuantity<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU: TUnit;
                                            NumeratorU, DenomU: TUnit> = record
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type U = specialize TFactoredRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredRatioDimensionedQuantity
                 <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type TBaseDimensionedQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type TNumeratorQuantity = specialize TFactoredDimensionedQuantity<BaseNumeratorU, NumeratorU>;
    type TDenomQuantity = specialize TFactoredDimensionedQuantity<BaseDenomU, DenomU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  { Unit identifiers }

  { TUnitCubedIdentifier }

  generic TUnitCubedIdentifier<BaseU: TUnit> = record
    type U = specialize TUnitCubed<BaseU>;
    type TSelf = specialize TUnitCubedIdentifier<BaseU>;
    type TQuantity = specialize TCubedDimensionedQuantity<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TUnitSquaredIdentifier<BaseU: TUnit> = record
    type U = specialize TUnitSquared<BaseU>;
    type TSelf = specialize TUnitSquaredIdentifier<BaseU>;
    type TQuantity = specialize TSquaredDimensionedQuantity<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TBasicUnitIdentifier<U: TUnit> = record
    type TSelf = specialize TBasicUnitIdentifier<U>;
    type TQuantity = specialize TBasicDimensionedQuantity<U>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TUnitIdentifier<U: TUnit> = record
    type TSelf = specialize TUnitIdentifier<U>;
    type TQuantity = specialize TDimensionedQuantity<U>;
    type TSquaredIdentifier = specialize TUnitSquaredIdentifier<U>;
    type TCubedIdentifier = specialize TUnitCubedIdentifier<U>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE SQUARABLE_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredUnitIdentifier<BaseU: TUnit; U: TUnit> = record
    type TSelf = specialize TFactoredUnitIdentifier<BaseU, U>;
    type TQuantity = specialize TFactoredDimensionedQuantity<BaseU, U>;
    type TBaseQuantity = specialize TDimensionedQuantity<BaseU>;
    type TBaseUnitIdentifier = specialize TUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$i dim.pas}
  end;

  { TReciprocalUnitIdentifier }

  generic TReciprocalUnitIdentifier<DenomU: TUnit> = record
    type U = specialize TReciprocalUnit<DenomU>;
    type TSelf = specialize TReciprocalUnitIdentifier<DenomU>;
    type TQuantity = specialize TReciprocalDimensionedQuantity<DenomU>;
    type TDenomIdentifier = specialize TUnitIdentifier<DenomU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE RECIP_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TRatioUnitIdentifier<NumeratorU, DenomU: TUnit> = record
    type U = specialize TRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TRatioUnitIdentifier<NumeratorU, DenomU>;
    type TQuantity = specialize TRatioDimensionedQuantity<NumeratorU, DenomU>;
    type TNumeratorIdentifier = specialize TUnitIdentifier<NumeratorU>;
    type TDenomIdentifier = specialize TUnitIdentifier<DenomU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TUnitProductIdentifier<U1, U2: TUnit> = record
    type U = specialize TUnitProduct<U1, U2>;
    type TSelf = specialize TUnitProductIdentifier<U1, U2>;
    type TQuantity = specialize TDimensionedQuantityProduct<U1, U2>;
    type TIdentifier1 = specialize TUnitIdentifier<U1>;
    type TIdentifier2 = specialize TUnitIdentifier<U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredRatioUnitIdentifier<BaseNumeratorU, BaseDenomU: TUnit;
                                       NumeratorU, DenomU: TUnit> = record
    type U = specialize TFactoredRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredRatioUnitIdentifier
                 <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type TQuantity = specialize TFactoredRatioDimensionedQuantity
                     <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type TNumeratorIdentifier = specialize TFactoredUnitIdentifier<BaseNumeratorU, NumeratorU>;
    type TDenomIdentifier = specialize TFactoredUnitIdentifier<BaseDenomU, DenomU>;
    type TBaseQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseUnitIdentifier = specialize TUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

{ Units of time }

type
  TSecond = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TSecondIdentifier = specialize TUnitIdentifier<TSecond>;
  TSeconds = specialize TDimensionedQuantity<TSecond>;

  TMillisecondIdentifier = specialize TFactoredUnitIdentifier<TSecond, specialize TMilliUnit<TSecond>>;
  TMilliseconds = specialize TFactoredDimensionedQuantity<TSecond, specialize TMilliUnit<TSecond>>;

  TMinute = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TMinuteIdentifier = specialize TFactoredUnitIdentifier<TSecond, TMinute>;
  TMinutes = specialize TFactoredDimensionedQuantity<TSecond, TMinute>;

  THour = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  THourIdentifier = specialize TFactoredUnitIdentifier<TSecond, THour>;
  THours = specialize TFactoredDimensionedQuantity<TSecond, THour>;

  TDay = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TDayIdentifier = specialize TFactoredUnitIdentifier<TSecond, TDay>;
  TDays = specialize TFactoredDimensionedQuantity<TSecond, TDay>;

  // this unit is not really to be used directly because
  // time is divided one exponent at a time: m/s2 -> (m/s)/s
  // thus acceleration are "per second squared" instead of "per square second"
  TSquareSecond = specialize TUnitSquared<TSecond>;
  TSquareSecondIdentifier = specialize TUnitSquaredIdentifier<TSecond>;
  TSquareSeconds = specialize TSquaredDimensionedQuantity<TSecond>;

var
  ms: TMillisecondIdentifier;
  s: TSecondIdentifier;
  s2: TSquareSecondIdentifier;
  mn: TMinuteIdentifier;
  h: THourIdentifier;
  day: TDayIdentifier;

{ Units of length }

type
  TMeter = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TMeterIdentifier = specialize TUnitIdentifier<TMeter>;
  TMeters = specialize TDimensionedQuantity<TMeter>;

  TSquareMeter = specialize TUnitSquared<TMeter>;
  TSquareMeters = specialize TSquaredDimensionedQuantity<TMeter>;
  TSquareMeterIdentifier = specialize TUnitSquaredIdentifier<TMeter>;

  TCubicMeter = specialize TUnitCubed<TMeter>;
  TCubicMeters = specialize TCubedDimensionedQuantity<TMeter>;
  TCubicMeterIdentifier = specialize TUnitCubedIdentifier<TMeter>;

  TLitre = class(TUnit)
    class function Symbol: string; override;
    class function Name: string; override;
  end;
  TLitreIdentifier = specialize TUnitIdentifier<TLitre>;
  TLitres = specialize TDimensionedQuantity<TLitre>;

  { TLitreHelper }

  TLitreHelper = record helper for TLitreIdentifier
    function From(const AVolume: TCubicMeters): TLitres;
  end;

  TKilometer = specialize TKiloUnit<TMeter>;
  TKilometerIdentifier = specialize TFactoredUnitIdentifier<TMeter, TKilometer>;
  TKilometers = specialize TFactoredDimensionedQuantity<TMeter, TKilometer>;
  TCentimeters = specialize TFactoredDimensionedQuantity<TMeter, specialize TCentiUnit<TMeter>>;
  TMillimeters = specialize TFactoredDimensionedQuantity<TMeter, specialize TMilliUnit<TMeter>>;

var
  mm: specialize TFactoredUnitIdentifier<TMeter, specialize TMilliUnit<TMeter>>;
  cm: specialize TFactoredUnitIdentifier<TMeter, specialize TCentiUnit<TMeter>>;
  m: TMeterIdentifier;
  km: TKilometerIdentifier;

  m2: TSquareMeterIdentifier;
  m3: TCubicMeterIdentifier;
  L: TLitreIdentifier;

// combining units
operator /(const {%H-}m3: TCubicMeterIdentifier; const {%H-}m2: TSquareMeterIdentifier): TMeterIdentifier; inline;

// combining dimensioned quantities
operator /(const AVolume: TCubicMeters; const ASurface: TSquareMeters): TMeters; inline;

// dimension equivalence
operator:=(const AVolume: TLitres): TCubicMeters;

{ Units of mass }

type
  TGram = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TGramIdentifier = specialize TUnitIdentifier<TGram>;
  TGrams = specialize TDimensionedQuantity<TGram>;

  TMilligrams = specialize TFactoredDimensionedQuantity<TGram, specialize TMilliUnit<TGram>>;

  TKilogram = specialize TKiloUnit<TGram>;
  TKilogramIdentifier = specialize TFactoredUnitIdentifier<TGram, TKilogram>;
  TKilograms = specialize TFactoredDimensionedQuantity<TGram, TKilogram>;

  TMegagrams = specialize TFactoredDimensionedQuantity<TGram, specialize TMegaUnit<TGram>>;
  TTon = specialize TMegaUnit<TGram>;
  TTons = specialize TFactoredDimensionedQuantity<TGram, TTon>;

var
  mg: specialize TFactoredUnitIdentifier<TGram, specialize TMilliUnit<TGram>>;
  g: TGramIdentifier;
  kg: TKilogramIdentifier;
  ton: specialize TFactoredUnitIdentifier<TGram, specialize TMegaUnit<TGram>>;

{ Units of amount of substance }

type
  TMole = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TMoleIdentifier = specialize TUnitIdentifier<TMole>;
  TMoles = specialize TDimensionedQuantity<TMole>;

var
  mol: TMole;

{ Units of electric current }

type
  TAmpere = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TAmpereIdentifier = specialize TUnitIdentifier<TAmpere>;
  TAmperes = specialize TDimensionedQuantity<TAmpere>;

var
  A: TAmpereIdentifier;
  A2: specialize TUnitSquaredIdentifier<TAmpere>;

{ Units of temperature }

type
  TKelvin = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TKelvinIdentifier = specialize TUnitIdentifier<TKelvin>;
  TKelvins = specialize TDimensionedQuantity<TKelvin>;

  TDegreeCelsius = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TDegreeCelsiusIdentifier = specialize TBasicUnitIdentifier<TDegreeCelsius>;
  TDegreesCelsius = specialize TBasicDimensionedQuantity<TDegreeCelsius>;
  TDegreeCelsiusIdentifierHelper = record helper for TDegreeCelsiusIdentifier
    class function From(const ATemperature: TKelvins): TDegreesCelsius; inline; static; overload;
  end;

  TDegreeFahrenheit = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TDegreeFahrenheitIdentifier = specialize TBasicUnitIdentifier<TDegreeFahrenheit>;
  TDegreesFahrenheit = specialize TBasicDimensionedQuantity<TDegreeFahrenheit>;
  TDegreeFahrenheitIdentifierHelper = record helper for TDegreeFahrenheitIdentifier
    class function From(const ATemperature: TKelvins): TDegreesFahrenheit; inline; static; overload;
  end;

var
  K: TKelvinIdentifier;
  degC: TDegreeCelsiusIdentifier;
  degF: TDegreeFahrenheitIdentifier;

operator :=(const ATemperature: TDegreesCelsius): TKelvins;
operator :=(const ATemperature: TDegreesFahrenheit): TDegreesCelsius;
operator :=(const ATemperature: TDegreesFahrenheit): TKelvins;
operator -(const ATemperature1, ATemperature2: TDegreesCelsius): TKelvins;
operator +(const ATemperature: TDegreesCelsius; const ADifference: TKelvins): TDegreesCelsius;
operator +(const ADifference: TKelvins; const ATemperature: TDegreesCelsius): TDegreesCelsius;

{ Units of luminous energy }

type
  TCandela = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TCandelaIdentifier = specialize TUnitIdentifier<TCandela>;
  TCandelas = specialize TDimensionedQuantity<TCandela>;

var
  cd: TCandelaIdentifier;

{ Units of speed }

type
  TMeterPerSecond = specialize TRatioUnit<TMeter, TSecond>;
  TMeterPerSecondIdentifier = specialize TRatioUnitIdentifier<TMeter, TSecond>;
  TMetersPerSecond = specialize TRatioDimensionedQuantity<TMeter, TSecond>;

  TKilometerPerHour = specialize TFactoredRatioUnit<TKilometer, THour>;
  TKilometerPerHourIdentifier = specialize TFactoredRatioUnitIdentifier
                                           <TMeter, TSecond, TKilometer, THour>;
  TKilometersPerHour = specialize TFactoredRatioDimensionedQuantity
                                  <TMeter, TSecond, TKilometer, THour>;

// combining units
operator /(const {%H-}m: TMeterIdentifier; const {%H-}s: TSecondIdentifier): TMeterPerSecondIdentifier; inline;
operator /(const {%H-}km: TKilometerIdentifier; const {%H-}h: THourIdentifier): TKilometerPerHourIdentifier; inline;

// combining dimensioned quantities
operator /(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond; inline;
operator /(const ALength: TKilometers; const ADuration: THours): TKilometersPerHour; inline;

{ Units of acceleration }

type
  TMeterPerSecondSquared = specialize TRatioUnit<TMeterPerSecond, TSecond>;
  TMeterPerSecondSquaredIdentifier = specialize TRatioUnitIdentifier<TMeterPerSecond, TSecond>;
  TMetersPerSecondSquared = specialize TRatioDimensionedQuantity<TMeterPerSecond, TSecond>;

  TKilometerPerHourPerSecondIdentifier = specialize TFactoredRatioUnitIdentifier
                                                    <TMeterPerSecond, TSecond, TKilometerPerHour, TSecond>;
  TKilometersPerHourPerSecond = specialize TFactoredRatioDimensionedQuantity
                                           <TMeterPerSecond, TSecond, TKilometerPerHour, TSecond>;

// combining units
operator /(const {%H-}m_s: TMeterPerSecondIdentifier; const {%H-}s: TSecondIdentifier): TMeterPerSecondSquaredIdentifier; inline;
operator /(const {%H-}m: TMeterIdentifier; const {%H-}s2: TSquareSecondIdentifier): TMeterPerSecondSquaredIdentifier; inline;
operator /(const {%H-}km_h: TKilometerPerHourIdentifier; const {%H-}s: TSecondIdentifier): TKilometerPerHourPerSecondIdentifier; inline;

// combining dimensioned quantities
operator /(const ASpeed: TMetersPerSecond; const ATime: TSeconds): TMetersPerSecondSquared; inline;
operator /(const ALength: TMeters; const ASquareTime: TSquareSeconds): TMetersPerSecondSquared; inline;
operator /(const ASpeed: TKilometersPerHour; const ATime: TSeconds): TKilometersPerHourPerSecond; inline;

{ Special units }
type
  THertzIdentifier = specialize TReciprocalUnitIdentifier<TSecond>;
  TFrequency = specialize TReciprocalDimensionedQuantity<TSecond>;

  TRadian = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TRadianIdentifier = specialize TUnitIdentifier<TRadian>;
  TRadians = specialize TDimensionedQuantity<TRadian>;

  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondIdentifier = specialize TRatioUnitIdentifier<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioDimensionedQuantity<TRadian, TSecond>;

  TRadianPerSecondSquaredIdentifier = specialize TRatioUnitIdentifier<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioDimensionedQuantity<TRadianPerSecond, TSecond>;

  TDegree = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TDegreeIdentifier = specialize TFactoredUnitIdentifier<TRadian, TDegree>;
  TDegrees = specialize TFactoredDimensionedQuantity<TRadian, TDegree>;

  TNewton = specialize TUnitProduct<TKilogram, TMeterPerSecondSquared>;
  TNewtonIdentifier = specialize TUnitProductIdentifier<TKilogram, TMeterPerSecondSquared>;
  TNewtons = specialize TDimensionedQuantityProduct<TKilogram, TMeterPerSecondSquared>;

  TCoulombIdentifer = specialize TUnitProductIdentifier<TAmpere, TSecond>;
  TCoulombs = specialize TDimensionedQuantityProduct<TAmpere, TSecond>;

  TLuxIdentifier = specialize TRatioUnitIdentifier<TCandela, TSquareMeter>;
  TLuxQuantity = specialize TRatioDimensionedQuantity<TCandela, TSquareMeter>;

  TSievertIdentifier = specialize TRatioUnitIdentifier<TSquareMeter, TSquareSecond>;
  TSieverts = specialize TRatioDimensionedQuantity<TSquareMeter, TSquareSecond>;

  TKatalIdentifier = specialize TRatioUnitIdentifier<TMole, TSecond>;
  TKatals = specialize TRatioDimensionedQuantity<TMole, TSecond>;

var
  Hz: THertzIdentifier;
  rad: TRadianIdentifier;
  deg: TDegreeIdentifier;
  N: TNewtonIdentifier;
  C: TCoulombIdentifer;
  lx: TLuxIdentifier;
  Sv: TSievertIdentifier;
  kat: TKatalIdentifier;

// combining units
operator /(const {%H-}rad: TRadianIdentifier; const {%H-}s: TSecondIdentifier): TRadianPerSecondIdentifier; inline;
operator /(const {%H-}rad_s: TRadianPerSecondIdentifier; const {%H-}s: TSecondIdentifier): TRadianPerSecondSquaredIdentifier; inline;
operator /(const {%H-}m: TRadianIdentifier; const {%H-}s2: TSquareSecondIdentifier): TRadianPerSecondSquaredIdentifier; inline;
operator /(const {%H-}kg: TKilogramIdentifier; const {%H-}m_s2: TMeterPerSecondSquaredIdentifier): TNewtonIdentifier; inline;

// combining dimensioned quantities
operator /(const AAngle: TRadians; const ADuration: TSeconds): TRadiansPerSecond; inline;
operator /(const ASpeed: TRadiansPerSecond; const ATime: TSeconds): TRadiansPerSecondSquared; inline;
operator /(const AAngle: TRadians; const ASquareTime: TSquareSeconds): TRadiansPerSecondSquared; inline;

operator *(const AWeight: TGrams; const AAcceleration: TMetersPerSecondSquared): TNewtons; inline;
operator *(const AAcceleration: TMetersPerSecondSquared; const AWeight: TGrams): TNewtons; inline;

operator /(const AValue: double; const ADuration: TSeconds): TFrequency; inline;
operator *(const ACurrent: TAmperes; const ADuration: TSeconds): TCoulombs; inline;

{ Formatting }

function GetPluralName(ASingularName: string): string;
function FormatValue(ANumber: double): string;
function FormatUnitName(AName: string; AQuantity: double): string;

implementation

Uses Math;

function GetPluralName(ASingularName: string): string;
var
  spaceIndex: SizeInt;
begin
  spaceIndex := pos(' ', ASingularName);
  if spaceIndex = 0 then spaceIndex := length(ASingularName)+1;
  result := copy(ASingularName, 1, spaceIndex-1) + 's'
            + ASingularName.Substring(spaceIndex-1);
end;

function FormatValue(ANumber: double): string;
var
  i: Int64;
  posE, pos0: SizeInt;
begin
  if abs(ANumber) < 1000000 then
  begin
    i :=  Round(ANumber);
    if SameValue(ANumber, i, abs(ANumber)*1E-15) then
      exit(IntToStr(i))
    else
      exit(FloatToStrF(ANumber, ffGeneral, 15, 4));
  end;
  result := FloatToStrF(ANumber, ffExponent, 15, 1);
  posE := pos('E', result);
  if posE <> 0 then
  begin
    pos0 := posE;
    while result[pos0-1] = '0' do dec(pos0);
    delete(result, pos0, posE-pos0);
  end;
end;

function FormatUnitName(AName: string; AQuantity: double): string;
begin
  if abs(AQuantity) >= 2 then
    result := GetPluralName(AName)
    else result := AName;
end;

{ TUnit }

class function TUnit.Factor: double;
begin
  result := 1;
end;

{ TUnitSquared }

class function TUnitSquared.Symbol: string;
begin
  result := BaseU.Symbol + '2';
end;

class function TUnitSquared.Name: string;
begin
  result := 'square ' + BaseU.Name
end;

{ TUnitCubed }

class function TUnitCubed.Symbol: string;
begin
  result := BaseU.Symbol + '3';
end;

class function TUnitCubed.Name: string;
begin
  result := 'cubic ' + BaseU.Name
end;

{ TRatioUnit }

class function TRatioUnit.Symbol: string;
begin
  if NumeratorU.Symbol.EndsWith('/' + DenomU.Symbol) then
    result := NumeratorU.Symbol + '2'
  else if NumeratorU.Symbol.EndsWith('/' + DenomU.Symbol + '2') then
    result := copy(NumeratorU.Symbol, 1, length(NumeratorU.Symbol)-1) + '3'
  else
    result := NumeratorU.Symbol + '/' + DenomU.Symbol;

  case result of
  'cd/m2': result := 'lx';
  'm2/s2': result := 'Sv';
  'mol/s': result := 'kat';
  end;
end;

class function TRatioUnit.Name: string;
begin
  if NumeratorU.Name.EndsWith(' per ' + DenomU.Name) then
    result := NumeratorU.Name + ' squared'
  else if NumeratorU.Name.EndsWith(' per ' + DenomU.Name + ' squared') then
    result := copy(NumeratorU.Name, 1, length(NumeratorU.Name)-8) + ' cubed'
  else
    result := NumeratorU.Name + ' per ' + DenomU.Name;

  case result of
  'candela per square meter': result := 'lux';
  'square meter per square second': result := 'sievert';
  'mole per second': result := 'katal';
  end;
end;

{ TUnitProduct }

class function TUnitProduct.Symbol: string;
begin
  result := U1.Symbol + '.' + U2.Symbol;

  case result of
  's.A', 'A.s': result := 'C';
  'kg.m/s2': result := 'N';
  end;
end;

class function TUnitProduct.Name: string;
begin
  result := U1.Name + '-' + U2.Name;

  case result of
  'ampere-second', 'second-ampere': result := 'coulomb';
  'kilogram-meter per second squared': result := 'newton';
  end;
end;

{ TReciprocalUnit }

class function TReciprocalUnit.Symbol: string;
var denomSymbol: string;
begin
  denomSymbol := DenomU.Symbol;
  if denomSymbol[length(denomSymbol)] in['2'..'9'] then
    result := denomSymbol.Insert(length(denomSymbol), '-')
  else
    result := denomSymbol + '-1';

  case result of
  's-1': result := 'Hz';
  end;
end;

class function TReciprocalUnit.Name: string;
begin
  result := 'reciprocal ' + DenomU.Name;

  case result of
  'reciprocal second': result := 'hertz';
  end;
end;

{ TFactoredRatioUnit }

class function TFactoredRatioUnit.Factor: double;
begin
  result := NumeratorU.Factor / DenomU.Factor;
end;

{ Factored units }

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TMegaUnit}
{$DEFINE V_FACTOR:=1E6}{$DEFINE V_SYMBOL:='M'}{$DEFINE V_NAME:='mega'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TKiloUnit}
{$DEFINE V_FACTOR:=1000}{$DEFINE V_SYMBOL:='k'}{$DEFINE V_NAME:='kilo'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=THectoUnit}
{$DEFINE V_FACTOR:=100}{$DEFINE V_SYMBOL:='h'}{$DEFINE V_NAME:='hecto'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TDecaUnit}
{$DEFINE V_FACTOR:=10}{$DEFINE V_SYMBOL:='da'}{$DEFINE V_NAME:='deca'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TDeciUnit}
{$DEFINE V_FACTOR:=0.1}{$DEFINE V_SYMBOL:='d'}{$DEFINE V_NAME:='deci'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TCentiUnit}
{$DEFINE V_FACTOR:=0.01}{$DEFINE V_SYMBOL:='c'}{$DEFINE V_NAME:='centi'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TMilliUnit}
{$DEFINE V_FACTOR:=0.001}{$DEFINE V_SYMBOL:='m'}{$DEFINE V_NAME:='milli'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TMicroUnit}
{$DEFINE V_FACTOR:=1E-6}{$DEFINE V_SYMBOL:='µ'}{$DEFINE V_NAME:='micro'}{$i dim.pas}

{ Unit identifiers }

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitCubedIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitSquaredIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE SQUARABLE_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TBasicUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE RECIP_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TReciprocalUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TRatioUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitProductIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredRatioUnitIdentifier}{$i dim.pas}

{ Dimensioned quantities }

{$DEFINE DIM_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TCubedDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TSquaredDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE SQUARABLE_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TDimensionedQuantity}{$i dim.pas}

{$DEFINE BASIC_DIM_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TBasicDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE RECIP_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TReciprocalDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TRatioDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_DIM_QUANTITY:=TDimensionedQuantityProduct}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredRatioDimensionedQuantity}{$i dim.pas}

{ Base units }

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

class function TMeter.Symbol: string; begin result := 'm'; end;
class function TMeter.Name: string;   begin result := 'meter'; end;

operator/(const m3: TCubicMeterIdentifier; const m2: TSquareMeterIdentifier): TMeterIdentifier;
begin end;

class function TLitre.Symbol: string; begin result := 'L'; end;
class function TLitre.Name: string;   begin result := 'litre'; end;

operator/(const AVolume: TCubicMeters; const ASurface: TSquareMeters): TMeters;
begin
  result.Value := AVolume.Value / ASurface.Value;
end;

operator:=(const AVolume: TLitres): TCubicMeters;
begin
  result.Value := AVolume.Value * 0.001;
end;

function TLitreHelper.From(const AVolume: TCubicMeters): TLitres;
begin
  result.Value := AVolume.Value * 1000;
end;

class function TGram.Symbol: string; begin result := 'g'; end;
class function TGram.Name: string;   begin result := 'gram'; end;

class function TMole.Symbol: string; begin result := 'mol'; end;
class function TMole.Name: string;   begin result := 'mole'; end;

class function TAmpere.Symbol: string; begin result := 'A'; end;
class function TAmpere.Name: string;   begin result := 'ampere'; end;

class function TKelvin.Symbol: string; begin result := 'K'; end;
class function TKelvin.Name: string;   begin result := 'kelvin'; end;

class function TDegreeCelsius.Symbol: string; begin result := 'ºC'; end;
class function TDegreeCelsius.Name: string;   begin result := 'degree Celsius'; end;

class function TDegreeFahrenheit.Symbol: string; begin result := 'ºF'; end;
class function TDegreeFahrenheit.Name: string;   begin result := 'degree Fahrenheit'; end;

operator:=(const ATemperature: TDegreesCelsius): TKelvins;
begin
  result.Value := ATemperature.Value + 273.15;
end;

class function TDegreeCelsiusIdentifierHelper.From(const ATemperature: TKelvins): TDegreesCelsius;
begin
  result.Value := ATemperature.Value - 273.15;
end;

operator:=(const ATemperature: TDegreesFahrenheit): TDegreesCelsius;
begin
  result.Value := (ATemperature.Value - 32)/1.8;
end;

class function TDegreeFahrenheitIdentifierHelper.From(
  const ATemperature: TKelvins): TDegreesFahrenheit;
begin
  result.Value := degC.From(ATemperature).Value*1.8 + 32;
end;

operator:=(const ATemperature: TDegreesFahrenheit): TKelvins;
begin
  result := TDegreesCelsius(ATemperature);
end;

operator-(const ATemperature1, ATemperature2: TDegreesCelsius): TKelvins;
begin
  result.Value := ATemperature1.Value - ATemperature2.Value;
end;

operator+(const ATemperature: TDegreesCelsius; const ADifference: TKelvins): TDegreesCelsius;
begin
 result.Value := ATemperature.Value + ADifference.Value;
end;

operator+(const ADifference: TKelvins; const ATemperature: TDegreesCelsius): TDegreesCelsius;
begin
  result.Value := ATemperature.Value + ADifference.Value;
end;

class function TCandela.Symbol: string; begin result := 'cd'; end;
class function TCandela.Name: string;   begin result := 'candela'; end;

{ Units of speed }

// combining units
operator /(const {%H-}m: TMeterIdentifier; const {%H-}s: TSecondIdentifier): TMeterPerSecondIdentifier;
begin end;

operator /(const {%H-}km: TKilometerIdentifier; const {%H-}h: THourIdentifier): TKilometerPerHourIdentifier;
begin end;

operator/(const rad: TRadianIdentifier; const s: TSecondIdentifier): TRadianPerSecondIdentifier;
begin end;

operator/(const rad_s: TRadianPerSecondIdentifier; const s: TSecondIdentifier): TRadianPerSecondSquaredIdentifier;
begin end;

operator/(const m: TRadianIdentifier; const s2: TSquareSecondIdentifier): TRadianPerSecondSquaredIdentifier;
begin end;

operator/(const kg: TKilogramIdentifier;
  const m_s2: TMeterPerSecondSquaredIdentifier): TNewtonIdentifier;
begin end;

// combining dimensioned quantities
operator/(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond;
begin
  result.Value:= ALength.Value / ADuration.Value;
end;

operator/(const ALength: TKilometers; const ADuration: THours): TKilometersPerHour;
begin
  result.Value:= ALength.Value / ADuration.Value;
end;

operator/(const AAngle: TRadians; const ADuration: TSeconds): TRadiansPerSecond;
begin
 result.Value:= AAngle.Value / ADuration.Value;
end;

operator/(const ASpeed: TRadiansPerSecond; const ATime: TSeconds): TRadiansPerSecondSquared;
begin
  result.Value := ASpeed.Value / ATime.Value;
end;

operator/(const AAngle: TRadians; const ASquareTime: TSquareSeconds): TRadiansPerSecondSquared;
begin
  result.Value := AAngle.Value / ASquareTime.Value;
end;

operator*(const AWeight: TGrams; const AAcceleration: TMetersPerSecondSquared ): TNewtons;
begin
  result.Value := AWeight.Value * 0.001 * AAcceleration.Value;
end;

operator*(const AAcceleration: TMetersPerSecondSquared; const AWeight: TGrams): TNewtons;
begin
  result.Value := AWeight.Value * 0.001 * AAcceleration.Value;
end;

{ Units of acceleration }

// combining units
operator /(const {%H-}m_s: TMeterPerSecondIdentifier; const {%H-}s: TSecondIdentifier): TMeterPerSecondSquaredIdentifier;
begin end;

operator /(const {%H-}m: TMeterIdentifier; const {%H-}s2: TSquareSecondIdentifier): TMeterPerSecondSquaredIdentifier;
begin end;

operator/(const km_h: TKilometerPerHourIdentifier; const s: TSecondIdentifier): TKilometerPerHourPerSecondIdentifier;
begin end;

// combining dimensioned quantities
operator /(const ASpeed: TMetersPerSecond; const ATime: TSeconds): TMetersPerSecondSquared;
begin
  result.Value := ASpeed.Value / ATime.Value;
end;

operator/(const ALength: TMeters; const ASquareTime: TSquareSeconds): TMetersPerSecondSquared;
begin
  result.Value := ALength.Value / ASquareTime.Value;
end;

operator/(const ASpeed: TKilometersPerHour; const ATime: TSeconds): TKilometersPerHourPerSecond;
begin
  result.Value := ASpeed.Value / ATime.Value;
end;

{ Special units }

class function TRadian.Symbol: string; begin result := 'rad'; end;
class function TRadian.Name: string;   begin result := 'radian'; end;

class function TDegree.Factor: double; begin result := Pi/180; end;
class function TDegree.Symbol: string; begin result := 'º'; end;
class function TDegree.Name: string;   begin result := 'degree'; end;

operator/(const AValue: double; const ADuration: TSeconds): TFrequency;
begin
  result.Value := AValue / ADuration.Value;
end;

operator*(const ACurrent: TAmperes; const ADuration: TSeconds): TCoulombs;
begin
  result.Value := ACurrent.Value * ADuration.Value;
end;

end.
{$ENDIF}

{$IF defined(BASIC_DIM_QTY_INTF) or defined(DIM_QTY_INTF)}
public
  Value: double;
  function ToString: string;
  function ToVerboseString: string;
  constructor Assign(const AQuantity: TSelf); overload;
{$ENDIF}{$UNDEF BASIC_DIM_QTY_INTF}
{$IFDEF DIM_QTY_INTF}
  class operator +(const AQuantity1, AQuantity2: TSelf): TSelf;
  class operator -(const AQuantity1, AQuantity2: TSelf): TSelf;
  class operator *(const AFactor: double; const AQuantity: TSelf): TSelf;
  class operator *(const AQuantity: TSelf; const AFactor: double): TSelf;
  class operator /(const AQuantity: TSelf; const AFactor: double): TSelf;
  class operator /(const AQuantity1, AQuantity2: TSelf): double;
  class operator mod(const AQuantity1, AQuantity2: TSelf): TSelf;
  class operator <(const AQuantity1, AQuantity2: TSelf): boolean;
  class operator <=(const AQuantity1, AQuantity2: TSelf): boolean;
  class operator =(const AQuantity1, AQuantity2: TSelf): boolean;
  class operator >(const AQuantity1, AQuantity2: TSelf): boolean;
  class operator >=(const AQuantity1, AQuantity2: TSelf): boolean;
{$ENDIF}{$UNDEF DIM_QTY_INTF}
{$IFDEF SQUARABLE_QTY_INTF}
  class operator *(const AQuantity1, AQuantity2: TSelf): TSquaredQuantity;
  class operator /(const ASquaredQuantity: TSquaredQuantity; const AQuantity: TSelf): TSelf;
  class operator *(const ASquaredQuantity: TSquaredQuantity; const AQuantity: TSelf): TCubedQuantity;
  class operator *(const AQuantity: TSelf; const ASquaredQuantity: TSquaredQuantity): TCubedQuantity;
  class operator /(const ACubedQuantity: TCubedQuantity; const AQuantity: TSelf): TSquaredQuantity;
{$ENDIF}{$UNDEF SQUARABLE_QTY_INTF}
{$IFDEF RATIO_QTY_INTF}
  class operator /(const ANumerator: TNumeratorQuantity; const ASelf: TSelf): TDenomQuantity;
  class operator *(const ASelf: TSelf; const ADenominator: TDenomQuantity): TNumeratorQuantity;
  class operator *(const ADenominator: TDenomQuantity; const ASelf: TSelf): TNumeratorQuantity;
{$ENDIF}{$UNDEF RATIO_QTY_INTF}
{$IFDEF QTY_PROD_INTF}
  //class operator /(const ASelf: TSelf; const AQuantity1: TQuantity1): TQuantity2;
  class operator /(const ASelf: TSelf; const AQuantity2: TQuantity2): TQuantity1;
{$ENDIF}{$UNDEF QTY_PROD_INTF}
{$IFDEF RECIP_QTY_INTF}
  class operator /(const AValue: double; const ASelf: TSelf): TDenomQuantity;
  class operator *(const ASelf: TSelf; const ADenominator: TDenomQuantity): double;
  class operator *(const ADenominator: TDenomQuantity; const ASelf: TSelf): double;
{$ENDIF}{$UNDEF RECIP_QTY_INTF}
{$IFDEF FACTORED_QTY_INTF}
  function ToBase: TBaseDimensionedQuantity;
  constructor Assign(const AQuantity: TBaseDimensionedQuantity); overload;
  class operator :=(const AQuantity: TSelf): TBaseDimensionedQuantity;
  class function From(const AQuantity: TBaseDimensionedQuantity): TSelf; static; inline;
{$ENDIF}{$UNDEF FACTORED_QTY_INTF}

{$IF defined(BASIC_DIM_QTY_IMPL) or defined(DIM_QTY_IMPL)}
  function T_DIM_QUANTITY.ToString: string;
  begin
    result := FormatValue(Value) + ' ' + U.Symbol;
  end;

  function T_DIM_QUANTITY.ToVerboseString: string;
  begin
    result := FormatValue(Value) + ' ' + FormatUnitName(U.Name, Value);
  end;

  constructor T_DIM_QUANTITY.Assign(const AQuantity: TSelf);
  begin
    self := AQuantity;
  end;
{$ENDIF}{$UNDEF BASIC_DIM_QTY_IMPL}
{$IFDEF DIM_QTY_IMPL}
  class operator T_DIM_QUANTITY.+(const AQuantity1, AQuantity2: TSelf): TSelf;
  begin
    result.Value := AQuantity1.Value + AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.-(const AQuantity1, AQuantity2: TSelf): TSelf;
  begin
    result.Value := AQuantity1.Value - AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.*(const AFactor: double; const AQuantity: TSelf): TSelf;
  begin
    result.Value := AFactor * AQuantity.Value;
  end;

  class operator T_DIM_QUANTITY.*(const AQuantity: TSelf; const AFactor: double): TSelf;
  begin
    result.Value := AQuantity.Value * AFactor;
  end;

  class operator T_DIM_QUANTITY./(const AQuantity: TSelf; const AFactor: double): TSelf;
  begin
    result.Value := AQuantity.Value / AFactor;
  end;

  class operator T_DIM_QUANTITY./(const AQuantity1, AQuantity2: TSelf): double;
  begin
    result := AQuantity1.Value / AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.mod(const AQuantity1, AQuantity2: TSelf): TSelf;
  begin
    result.Value := AQuantity1.Value mod AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.<(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value < AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.<=(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value <= AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.=(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value = AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.>(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value > AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY.>=(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value >= AQuantity2.Value;
  end;

{$ENDIF}{$UNDEF DIM_QTY_IMPL}
{$IFDEF SQUARABLE_QTY_IMPL}
  class operator T_DIM_QUANTITY.*(const AQuantity1, AQuantity2: TSelf): TSquaredQuantity;
  begin
    result.Value := AQuantity1.Value * AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY./(const ASquaredQuantity: TSquaredQuantity;
    const AQuantity: TSelf): TSelf;
  begin
    result.Value := ASquaredQuantity.Value / AQuantity.Value;
  end;

  class operator T_DIM_QUANTITY.*(
  const ASquaredQuantity: TSquaredQuantity; const AQuantity: TSelf): TCubedQuantity;
  begin
    result.Value := ASquaredQuantity.Value * AQuantity.Value;
  end;

  class operator T_DIM_QUANTITY.*(const AQuantity: TSelf;
    const ASquaredQuantity: TSquaredQuantity): TCubedQuantity;
  begin
    result.Value := AQuantity.Value * ASquaredQuantity.Value;
  end;

  class operator T_DIM_QUANTITY./(const ACubedQuantity: TCubedQuantity;
    const AQuantity: TSelf): TSquaredQuantity;
  begin
    result.Value := ACubedQuantity.Value / AQuantity.Value;
  end;
{$ENDIF}{$UNDEF SQUARABLE_QTY_IMPL}
{$IFDEF RECIP_QTY_IMPL}
  class operator T_DIM_QUANTITY./(
    const AValue: double; const ASelf: TSelf): TDenomQuantity;
  begin
    result.Value := AValue / ASelf.Value;
  end;

  class operator T_DIM_QUANTITY.*(const ASelf: TSelf;
    const ADenominator: TDenomQuantity): double;
  begin
    result := ASelf.Value * ADenominator.Value;
  end;

  class operator T_DIM_QUANTITY.*(
    const ADenominator: TDenomQuantity; const ASelf: TSelf): double;
  begin
    result := ADenominator.Value * ASelf.Value;
  end;
{$ENDIF}{$UNDEF RECIP_QTY_IMPL}
{$IFDEF RATIO_QTY_IMPL}
  class operator T_DIM_QUANTITY./(
    const ANumerator: TNumeratorQuantity; const ASelf: TSelf): TDenomQuantity;
  begin
    result.Value := ANumerator.Value / ASelf.Value;
  end;

  class operator T_DIM_QUANTITY.*(const ASelf: TSelf;
    const ADenominator: TDenomQuantity): TNumeratorQuantity;
  begin
    result.Value := ASelf.Value * ADenominator.Value;
  end;

  class operator T_DIM_QUANTITY.*(
    const ADenominator: TDenomQuantity; const ASelf: TSelf): TNumeratorQuantity;
  begin
    result.Value := ADenominator.Value * ASelf.Value;
  end;
{$ENDIF}{$UNDEF RATIO_QTY_IMPL}
{$IFDEF QTY_PROD_IMPL}
  {class operator T_DIM_QUANTITY./(
    const ASelf: TSelf; const AQuantity1: TQuantity1): TQuantity2;
  begin
    result.Value := ASelf.Value / AQuantity1.Value;
  end;}

  class operator T_DIM_QUANTITY./(
    const ASelf: TSelf; const AQuantity2: TQuantity2): TQuantity1;
  begin
    result.Value := ASelf.Value / AQuantity2.Value;
  end;
{$ENDIF}{$UNDEF QTY_PROD_IMPL}
{$IFDEF FACTORED_QTY_IMPL}
  function T_DIM_QUANTITY.ToBase: TBaseDimensionedQuantity;
  begin
    result := self;
  end;

  constructor T_DIM_QUANTITY.Assign(const AQuantity: TBaseDimensionedQuantity);
  begin
    self.Value := AQuantity.Value / U.Factor;
  end;

  class function T_DIM_QUANTITY.From(
    const AQuantity: TBaseDimensionedQuantity): TSelf;
  begin
    result.Value := AQuantity.Value / U.Factor;
  end;

  class operator T_DIM_QUANTITY.:=(const AQuantity: TSelf): TBaseDimensionedQuantity;
  begin
    result.Value := AQuantity.Value * U.Factor;
  end;
{$ENDIF}{$UNDEF FACTORED_QTY_IMPL}

{$IFDEF UNIT_ID_INTF}
public
  class operator *(const AValue: double; const {%H-}TheUnit: TSelf): TQuantity;
  class operator /(const {%H-}TheUnit1, {%H-}TheUnit2: TSelf): double;
  class operator =(const {%H-}TheUnit1, {%H-}TheUnit2: TSelf): boolean;
  class function Name: string; inline; static;
  class function Symbol: string; inline; static;
  class function From(const AQuantity: TQuantity): TQuantity; inline; static;
{$ENDIF}{$UNDEF UNIT_ID_INTF}
{$IFDEF SQUARABLE_UNIT_ID_INTF}
  class operator *(const {%H-}TheUnit1, {%H-}TheUnit2: TSelf): TSquaredIdentifier;
  class operator /(const {%H-}TheSquaredUnit: TSquaredIdentifier; const {%H-}TheUnit: TSelf): TSelf;
  class operator *(const {%H-}TheSquaredUnit: TSquaredIdentifier; const {%H-}TheUnit: TSelf): TCubedIdentifier;
  class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheSquaredUnit: TSquaredIdentifier): TCubedIdentifier;
  class operator /(const {%H-}TheCubedUnit: TCubedIdentifier; const {%H-}TheUnit: TSelf): TSquaredIdentifier;
{$ENDIF}{$UNDEF SQUARABLE_UNIT_ID_INTF}
{$IFDEF FACTORED_UNIT_ID_INTF}
  class function From(const AQuantity: TBaseQuantity): TQuantity; inline; static;
  class function BaseUnit: TBaseUnitIdentifier; inline; static;
  class function Factor: double; inline; static;
{$ENDIF}{$UNDEF FACTORED_UNIT_ID_INTF}
{$IFDEF RECIP_UNIT_ID_INTF}
  class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheDenom: TDenomIdentifier): double;
  class function Inverse: TDenomIdentifier; inline; static;
{$ENDIF}{$UNDEF RECIP_UNIT_ID_INTF}
{$IFDEF RATIO_UNIT_ID_INTF}
  class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheDenom: TDenomIdentifier): TNumeratorIdentifier;
{$ENDIF}{$UNDEF RATIO_UNIT_ID_INTF}
{$IFDEF UNIT_PROD_ID_INTF}
  //class operator /(const {%H-}TheUnit: TSelf; const {%H-}Unit1: TIdentifier1): TIdentifier2;
  class operator /(const {%H-}TheUnit: TSelf; const {%H-}Unit2: TIdentifier2): TIdentifier1;
{$ENDIF}{$UNDEF UNIT_PROD_ID_INTF}

{$IFDEF UNIT_ID_IMPL}
  class operator T_UNIT_ID.*(const AValue: double;
    const TheUnit: TSelf): TQuantity;
  begin
    result.Value := AValue;
  end;

  class operator T_UNIT_ID./(const TheUnit1, TheUnit2: TSelf): double;
  begin
    result := 1;
  end;

  class operator T_UNIT_ID.=(const TheUnit1, TheUnit2: TSelf): boolean;
  begin
    result := true;
  end;

  class function T_UNIT_ID.Name: string;
  begin
    case U.Name of
    'Mg': result := 't';
    else
      result := U.Name;
    end;
  end;

  class function T_UNIT_ID.Symbol: string;
  begin
    case U.Name of
    'megagram': result := 'ton';
    else
      result := U.Symbol;
    end;
  end;

  class function T_UNIT_ID.From(const AQuantity: TQuantity): TQuantity;
  begin
    result := AQuantity;
  end;
{$ENDIF}{$UNDEF UNIT_ID_IMPL}
{$IFDEF SQUARABLE_UNIT_ID_IMPL}
  class operator T_UNIT_ID.*(const TheUnit1, TheUnit2: TSelf): TSquaredIdentifier;
  begin end;

  class operator T_UNIT_ID./(const TheSquaredUnit: TSquaredIdentifier;
                             const TheUnit: TSelf): TSelf;
  begin end;

  class operator T_UNIT_ID.*(const TheSquaredUnit: TSquaredIdentifier;
    const TheUnit: TSelf): TCubedIdentifier;
  begin end;

  class operator T_UNIT_ID.*(const TheUnit: TSelf;
    const TheSquaredUnit: TSquaredIdentifier): TCubedIdentifier;
  begin end;

  class operator T_UNIT_ID./(const TheCubedUnit: TCubedIdentifier;
                             const TheUnit: TSelf): TSquaredIdentifier;
  begin end;
{$ENDIF}{$UNDEF SQUARABLE_UNIT_ID_IMPL}
{$IFDEF FACTORED_UNIT_ID_IMPL}
  class function T_UNIT_ID.From(const AQuantity: TBaseQuantity): TQuantity;
  begin
    result.Assign(AQuantity);
  end;
  class function T_UNIT_ID.BaseUnit: TBaseUnitIdentifier;
  begin end;
  class function T_UNIT_ID.Factor: double;
  begin
    result := U.Factor;
  end;
{$ENDIF}{$UNDEF FACTORED_UNIT_ID_IMPL}
{$IFDEF RECIP_UNIT_ID_IMPL}
  class operator T_UNIT_ID.*(const TheUnit: TSelf; const TheDenom: TDenomIdentifier): double;
  begin result := 1; end;

  class function T_UNIT_ID.Inverse: TDenomIdentifier;
  begin end;
{$ENDIF}{$UNDEF RECIP_UNIT_ID_IMPL}
{$IFDEF RATIO_UNIT_ID_IMPL}
  class operator T_UNIT_ID.*(const TheUnit: TSelf; const TheDenom: TDenomIdentifier): TNumeratorIdentifier;
  begin end;
{$ENDIF}{$UNDEF RATIO_UNIT_ID_IMPL}
{$IFDEF UNIT_PROD_ID_IMPL}
  {class operator T_UNIT_ID./(const {%H-}TheUnit: TSelf; const {%H-}Unit1: TIdentifier1): TIdentifier2;
  begin end;}

  class operator T_UNIT_ID./(const {%H-}TheUnit: TSelf; const {%H-}Unit2: TIdentifier2): TIdentifier1;
  begin end;
{$ENDIF}{$UNDEF UNIT_PROD_ID_IMPL}
