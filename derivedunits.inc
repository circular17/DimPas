/////////////////////// UNITS DERIVED FROM BASE UNITS ////////////////////////

{ Units of speed }
{$IFDEF INTF}
type
  TMeterPerSecond = specialize TRatioUnit<TMeter, TSecond>;
  TMeterPerSecondId = specialize TRatioUnitId<TMeter, TSecond>;
  TMetersPerSecond = specialize TRatioQuantity<TMeter, TSecond>;

  TMillimeterPerSecond = specialize TFactoredNumeratorUnit<TMilliMeter, TSecond>;
  TMillimeterPerSecondId = specialize TFactoredNumeratorUnitId<TMeter, TSecond, TMilliMeter>;
  TMillimetersPerSecond = specialize TFactoredNumeratorQuantity<TMeter, TSecond, TMilliMeter>;

  TKilometerPerHour = specialize TFactoredRatioUnit<TKilometer, THour>;
  TKilometerPerHourId = specialize TFactoredRatioUnitId<TMeter, TSecond, TKilometer, THour>;
  TKilometersPerHour = specialize TFactoredRatioQuantity<TMeter, TSecond, TKilometer, THour>;
{$ENDIF}

{$DEFINE NumId:=TMeterId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TMeterPerSecondId}
{$DEFINE NumQty:=TMeters}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TMetersPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas} // m/s = m / s

{$DEFINE NumId:=TMillimeterId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TMillimeterPerSecondId}
{$DEFINE NumQty:=TMillimeters}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TMillimetersPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas} // mm/s = mm / s

{$DEFINE NumId:=TKilometerId}{$DEFINE DenomId:=THourId}{$DEFINE RatioId:=TKilometerPerHourId}
{$DEFINE NumQty:=TKilometers}{$DEFINE DenomQty:=THours}{$DEFINE RatioQty:=TKilometersPerHour}
{$DEFINE DEF_RATIO}{$i dim.pas} // km/h = km / h

{ Units of acceleration }
{$IFDEF INTF}
type
  TMeterPerSecondSquared = specialize TRatioUnit<TMeterPerSecond, TSecond>;
  TMeterPerSecondSquaredId = specialize TRatioUnitId<TMeterPerSecond, TSecond>;
  TMetersPerSecondSquared = specialize TRatioQuantity<TMeterPerSecond, TSecond>;

  TKilometerPerHourPerSecondId = specialize TFactoredNumeratorUnitId
                                            <TMeterPerSecond, TSecond, TKilometerPerHour>;
  TKilometersPerHourPerSecond = specialize TFactoredNumeratorQuantity
                                           <TMeterPerSecond, TSecond, TKilometerPerHour>;

  TSquareMeterPerSquareSecond = specialize TRatioUnit<TSquareMeter, TSquareSecond>;
  TSquareMeterPerSquareSecondId = specialize TRatioUnitId<TSquareMeter, TSquareSecond>;
  TSquareMetersPerSquareSecond = specialize TRatioQuantity<TSquareMeter, TSquareSecond>;
{$ENDIF}

{$DEFINE NumId:=TMeterPerSecondId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TMeterPerSecondSquaredId}
{$DEFINE NumQty:=TMetersPerSecond}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TMetersPerSecondSquared}
{$DEFINE DEF_RATIO}{$i dim.pas} // m/s2 = (m/s) / s

{$DEFINE NumId:=TKilometerPerHourId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TKilometerPerHourPerSecondId}
{$DEFINE NumQty:=TKilometersPerHour}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TKilometersPerHourPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas} // km/h/s = (km/h) / s

// alternate definitions
{$DEFINE LeftId:=TMeterPerSecondSquaredId}{$DEFINE RightId:=TSquareSecondId}{$DEFINE ProdId:=TMeterId}
{$DEFINE LeftQty:=TMetersPerSecondSquared}{$DEFINE RightQty:=TSquareSeconds}{$DEFINE ProdQty:=TMeters}
{$DEFINE ALT_PROD}{$i dim.pas} // m = m/s2 * s2

// m2/s2 = m/s * m/s
operator *(const {%H-}m_s: TMeterPerSecondId; const {%H-}m_s_: TMeterPerSecondId): TSquareMeterPerSquareSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const ASpeed1: TMetersPerSecond; const ASpeed2: TMetersPerSecond): TSquareMetersPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := ASpeed1.Value * ASpeed2.Value; end;{$ENDIF}
operator /(const {%H-}m2_s2: TSquareMeterPerSquareSecondId; const {%H-}m_s: TMeterPerSecondId): TMeterPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const ASquareSpeed: TSquareMetersPerSquareSecond; const ASpeed: TMetersPerSecond): TMetersPerSecond; inline;
{$IFDEF IMPL}begin result.Value := ASquareSpeed.Value / ASpeed.Value; end;{$ENDIF}

{ Mechanical derived units }
{$IFDEF INTF}
type
  TGramPerCubicMeter = specialize TRatioUnit<TGram, TCubicMeter>;
  TGramPerCubicMeterId = specialize TRatioUnitId
                                            <TGram, TCubicMeter>;
  TGramsPerCubicMeter = specialize TRatioQuantity
                                   <TGram, TCubicMeter>;

  TGramPerCubicMillimeter = specialize TFactoredDenominatorUnit<TGram, TCubicMillimeter>;
  TGramPerCubicMillimeterId = specialize TFactoredDenominatorUnitId
                                         <TGram, TCubicMeter, TCubicMillimeter>;
  TGramsPerCubicMillimeter = specialize TFactoredDenominatorQuantity
                                        <TGram, TCubicMeter, TCubicMillimeter>;

  TKilogramPerCubicMeter = specialize TFactoredNumeratorUnit<TKilogram, TCubicMeter>;
  TKilogramPerCubicMeterId = specialize TFactoredNumeratorUnitId
                                        <TGram, TCubicMeter, TKilogram>;
  TKilogramsPerCubicMeter = specialize TFactoredNumeratorQuantity
                                       <TGram, TCubicMeter, TKilogram>;

  TKilogramPerCubicMillimeter = specialize TFactoredRatioUnit<TKilogram, TCubicMillimeter>;
  TKilogramPerCubicMillimeterId = specialize TFactoredRatioUnitId
                                             <TGram, TCubicMeter, TKilogram, TCubicMillimeter>;
  TKilogramsPerCubicMillimeter = specialize TFactoredRatioQuantity
                                            <TGram, TCubicMeter, TKilogram, TCubicMillimeter>;
{$ENDIF}

{$DEFINE NumId:=TGramId}{$DEFINE DenomId:=TCubicMeterId}{$DEFINE RatioId:=TGramPerCubicMeterId}
{$DEFINE NumQty:=TGrams}{$DEFINE DenomQty:=TCubicMeters}{$DEFINE RatioQty:=TGramsPerCubicMeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // g/m3 = g / m3

{$DEFINE NumId:=TGramId}{$DEFINE DenomId:=TCubicMillimeterId}{$DEFINE RatioId:=TGramPerCubicMillimeterId}
{$DEFINE NumQty:=TGrams}{$DEFINE DenomQty:=TCubicMillimeters}{$DEFINE RatioQty:=TGramsPerCubicMillimeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // g/mm3 = g / mm3

{$DEFINE NumId:=TKilogramId}{$DEFINE DenomId:=TCubicMeterId}{$DEFINE RatioId:=TKilogramPerCubicMeterId}
{$DEFINE NumQty:=TKilograms}{$DEFINE DenomQty:=TCubicMeters}{$DEFINE RatioQty:=TKilogramsPerCubicMeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // kg/m3 = kg / m3

{$DEFINE NumId:=TKilogramId}{$DEFINE DenomId:=TCubicMillimeterId}{$DEFINE RatioId:=TKilogramPerCubicMillimeterId}
{$DEFINE NumQty:=TKilograms}{$DEFINE DenomQty:=TCubicMillimeters}{$DEFINE RatioQty:=TKilogramsPerCubicMillimeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // kg/mm3 = kg / mm3

{ units of gravitaional work }
{$IFDEF INTF}
type
  TGramMeterId = specialize TUnitProductId<TGram, TMeter>;
  TGramMeters = specialize TQuantityProduct<TGram, TMeter>;
  TKilogramMeterId = specialize TLeftFactoredUnitProductId<TGram, TMeter, TKilogram>;
  TKilogramMeters = specialize TLeftFactoredQuantityProduct<TGram, TMeter, TKilogram>;
{$ENDIF}

{$DEFINE LeftId:=TGramId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TGramMeterId}
{$DEFINE LeftQty:=TGrams}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TGramMeters}
{$DEFINE DEF_PROD}{$i dim.pas} // g*m = g * m

{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TKilogramMeterId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TKilogramMeters}
{$DEFINE DEF_PROD}{$i dim.pas} // kg*m = kg * m

{ units of mass flux }
{$IFDEF INTF}
type
  TGramPerSecond = specialize TRatioUnit<TGram, TSecond>;
  TGramPerSecondId = specialize TRatioUnitId<TGram, TSecond>;
  TGramsPerSecond = specialize TRatioQuantity<TGram, TSecond>;

  TKilogramPerSecondId = specialize TFactoredNumeratorUnitId<TGram, TSecond, TKilogram>;
  TKilogramsPerSecond = specialize TFactoredNumeratorQuantity<TGram, TSecond, TKilogram>;
{$ENDIF}

{$DEFINE NumId:=TGramId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TGramPerSecondId}
{$DEFINE NumQty:=TGrams}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TGramsPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas} // g/s = g / s

{$DEFINE NumId:=TKilogramId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TKilogramPerSecondId}
{$DEFINE NumQty:=TKilograms}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TKilogramsPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas} // kg/s = kg / s
