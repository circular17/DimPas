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

{ main definition [ m/s ] = [ m ] / [ s ] }
{$DEFINE NumId:=TMeterId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TMeterPerSecondId}
{$DEFINE NumQty:=TMeters}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TMetersPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ mm/s ] = [ mm ] / [ s ] }
{$DEFINE NumId:=TMillimeterId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TMillimeterPerSecondId}
{$DEFINE NumQty:=TMillimeters}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TMillimetersPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ km/h ] = [ km ] / [ h ] }
{$DEFINE NumId:=TKilometerId}{$DEFINE DenomId:=THourId}{$DEFINE RatioId:=TKilometerPerHourId}
{$DEFINE NumQty:=TKilometers}{$DEFINE DenomQty:=THours}{$DEFINE RatioQty:=TKilometersPerHour}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ Units of square speed }
{$IFDEF INTF}
type
  TSquareMeterPerSquareSecond = specialize TSquareUnit<TMeterPerSecond>;
  TSquareMeterPerSquareSecondId = specialize TSquareUnitId<TMeterPerSecond>;
  TSquareMeterPerSquareSecondFactorId = specialize TUnitId<TSquareMeterPerSquareSecond>;
  TSquareMetersPerSquareSecond = specialize TSquareQuantity<TMeterPerSecond>;
  TSquareMetersPerSquareSecondFactor = specialize TQuantity<TSquareMeterPerSquareSecond>;
{$ENDIF}

{ alternative definition [ m2/s2 ] = [ m2 ] / [ s2 ] }
{$DEFINE NumId:=TSquareMeterId}{$DEFINE DenomId:=TSquareSecondId}{$DEFINE RatioId:=TSquareMeterPerSquareSecondId}
{$DEFINE NumQty:=TSquareMeters}{$DEFINE DenomQty:=TSquareSeconds}{$DEFINE RatioQty:=TSquareMetersPerSquareSecond}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ equivalences }
operator:=(const {%H-}AQuantityId: TSquareMeterPerSquareSecondId): TSquareMeterPerSquareSecondFactorId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const AQuantity: TSquareMetersPerSquareSecond): TSquareMetersPerSquareSecondFactor; inline;
{$IFDEF IMPL}begin result.Value := AQuantity.Value; end;{$ENDIF}
operator:=(const AQuantity: TSquareMetersPerSquareSecondFactor): TSquareMetersPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := AQuantity.Value; end;{$ENDIF}

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
{$ENDIF}

{ main definition [ m/s2 ] = [ m/s ] / [ s ] }
{$DEFINE NumId:=TMeterPerSecondId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TMeterPerSecondSquaredId}
{$DEFINE NumQty:=TMetersPerSecond}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TMetersPerSecondSquared}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternate definition [ m/s2 ] = [ m ] / [ s2 ] }
{$DEFINE NumId:=TMeterId}{$DEFINE DenomId:=TSquareSecondId}{$DEFINE RatioId:=TMeterPerSecondSquaredId}
{$DEFINE NumQty:=TMeters}{$DEFINE DenomQty:=TSquareSeconds}{$DEFINE RatioQty:=TMetersPerSecondSquared}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ m/s2 ] = [ m2/s2 ] / [ m ] }
{$DEFINE NumId:=TSquareMeterPerSquareSecondId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TMeterPerSecondSquaredId}
{$DEFINE NumQty:=TSquareMetersPerSquareSecond}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TMetersPerSecondSquared}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ main definition [ km/h/s ] = [ km/h ] / [ s ] }
{$DEFINE NumId:=TKilometerPerHourId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TKilometerPerHourPerSecondId}
{$DEFINE NumQty:=TKilometersPerHour}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TKilometersPerHourPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas}

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
