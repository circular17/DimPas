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

// combining units
operator /(const {%H-}m: TMeterId; const {%H-}s: TSecondId): TMeterPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}mm: TMillimeterId; const {%H-}s: TSecondId): TMillimeterPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}km: TKilometerId; const {%H-}h: THourId): TKilometerPerHourId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond; inline;
{$IFDEF IMPL}begin result.Value:= ALength.Value / ADuration.Value; end;{$ENDIF}
operator /(const ALength: TMillimeters; const ADuration: TSeconds): TMillimetersPerSecond; inline;
{$IFDEF IMPL}begin result.Value:= ALength.Value / ADuration.Value; end;{$ENDIF}
operator /(const ALength: TKilometers; const ADuration: THours): TKilometersPerHour; inline;
{$IFDEF IMPL}begin result.Value:= ALength.Value / ADuration.Value; end;{$ENDIF}

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

// combining units
operator /(const {%H-}m_s: TMeterPerSecondId; const {%H-}s: TSecondId): TMeterPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}m: TMeterId; const {%H-}s2: TSquareSecondId): TMeterPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}km_h: TKilometerPerHourId; const {%H-}s: TSecondId): TKilometerPerHourPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}m2: TSquareMeterId; const {%H-}s2: TSquareSecondId): TSquareMeterPerSquareSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m_s: TMeterPerSecondId; const {%H-}m_s_: TMeterPerSecondId): TSquareMeterPerSquareSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}m2_s2: TSquareMeterPerSquareSecondId; const {%H-}m_s: TMeterPerSecondId): TMeterPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const ASpeed: TMetersPerSecond; const ATime: TSeconds): TMetersPerSecondSquared; inline;
{$IFDEF IMPL}begin result.Value := ASpeed.Value / ATime.Value; end;{$ENDIF}
operator /(const ALength: TMeters; const ASquareTime: TSquareSeconds): TMetersPerSecondSquared; inline;
{$IFDEF IMPL}begin result.Value := ALength.Value / ASquareTime.Value; end;{$ENDIF}
operator /(const ASpeed: TKilometersPerHour; const ATime: TSeconds): TKilometersPerHourPerSecond; inline;
{$IFDEF IMPL}begin result.Value := ASpeed.Value / ATime.Value; end;{$ENDIF}

operator /(const AArea: TSquareMeters; const ASquareTime: TSquareSeconds): TSquareMetersPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := AArea.Value / ASquareTime.Value; end;{$ENDIF}
operator *(const ASpeed1: TMetersPerSecond; const ASpeed2: TMetersPerSecond): TSquareMetersPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := ASpeed1.Value * ASpeed2.Value; end;{$ENDIF}
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

// combining units
operator /(const {%H-}g: TGramId; const {%H-}m3: TCubicMeterId): TGramPerCubicMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}g: TGramId; const {%H-}mm3: TCubicMillimeterId): TGramPerCubicMillimeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}kg: TKilogramId; const {%H-}m3: TCubicMeterId): TKilogramPerCubicMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}kg: TKilogramId; const {%H-}mm3: TCubicMillimeterId): TKilogramPerCubicMillimeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const AMass: TGrams; const AVolume: TCubicMeters): TGramsPerCubicMeter; inline;
{$IFDEF IMPL}begin result.Value := AMass.Value / AVolume.Value; end;{$ENDIF}
operator /(const AMass: TGrams; const AVolume: TCubicMillimeters): TGramsPerCubicMillimeter; inline;
{$IFDEF IMPL}begin result.Value := AMass.Value / AVolume.Value; end;{$ENDIF}

operator /(const AMass: TKilograms; const AVolume: TCubicMeters): TKilogramsPerCubicMeter; inline;
{$IFDEF IMPL}begin result.Value := AMass.Value / AVolume.Value; end;{$ENDIF}
operator /(const AMass: TKilograms; const AVolume: TCubicMillimeters): TKilogramsPerCubicMillimeter; inline;
{$IFDEF IMPL}begin result.Value := AMass.Value / AVolume.Value; end;{$ENDIF}

{ units of gravitaional work }
{$IFDEF INTF}
type
  TGramMeterId = specialize TUnitProductId<TGram, TMeter>;
  TGramMeters = specialize TQuantityProduct<TGram, TMeter>;
  TKilogramMeterId = specialize TLeftFactoredUnitProductId<TGram, TMeter, TKilogram>;
  TKilogramMeters = specialize TLeftFactoredQuantityProduct<TGram, TMeter, TKilogram>;
{$ENDIF}

// combining units
operator *(const {%H-}g: TGramId; const {%H-}m: TMeterId): TGramMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m: TMeterId; const {%H-}g: TGramId): TGramMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}kg: TGramMeterId; const {%H-}m: TGramId): TMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}kg: TKilogramId; const {%H-}m: TMeterId): TKilogramMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m: TMeterId; const {%H-}kg: TKilogramId): TKilogramMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}kg: TKilogramMeterId; const {%H-}m: TKilogramId): TMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator *(const AWeight: TGrams; const ALength: TMeters): TGramMeters; inline;
{$IFDEF IMPL}begin result.Value := AWeight.Value * ALength.Value; end;{$ENDIF}
operator *(const AWeight: TKilograms; const ALength: TMeters): TKilogramMeters; inline;
{$IFDEF IMPL}begin result.Value := AWeight.Value * ALength.Value; end;{$ENDIF}

{ units of mass flux }
{$IFDEF INTF}
type
  TGramPerSecond = specialize TRatioUnit<TGram, TSecond>;
  TGramPerSecondId = specialize TRatioUnitId<TGram, TSecond>;
  TGramsPerSecond = specialize TRatioQuantity<TGram, TSecond>;

  TKilogramPerSecondId = specialize TFactoredNumeratorUnitId<TGram, TSecond, TKilogram>;
  TKilogramsPerSecond = specialize TFactoredNumeratorQuantity<TGram, TSecond, TKilogram>;
{$ENDIF}

// combining units
operator /(const {%H-}g: TKilogramId; const {%H-}s: TSecondId): TGramPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}g: TKilogramId; const {%H-}s: TSecondId): TKilogramPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const AMass: TGrams; const ATime: TSeconds): TGramsPerSecond; inline;
{$IFDEF IMPL}begin result.Value := AMass.Value / ATime.Value; end;{$ENDIF}
operator /(const AMass: TKilograms; const ATime: TSeconds): TKilogramsPerSecond; inline;
{$IFDEF IMPL}begin result.Value := AMass.Value / ATime.Value; end;{$ENDIF}


