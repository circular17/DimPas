////////////////////// UNITS DERIVED FROM SPECIAL UNITS ////////////////////////

{ Units of speed }
{$IFDEF INTF}
type
  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondId = specialize TRatioUnitId<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioQuantity<TRadian, TSecond>;
{$ENDIF}

// combining units
operator /(const {%H-}rad: TRadianId; const {%H-}s: TSecondId): TRadianPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator/(const AAngle: TRadians; const ADuration: TSeconds): TRadiansPerSecond;
{$IFDEF IMPL}begin result.Value:= AAngle.Value / ADuration.Value; end;{$ENDIF}

{ Units of acceleration }
{$IFDEF INTF}
type
  TRadianPerSecondSquaredId = specialize TRatioUnitId<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioQuantity<TRadianPerSecond, TSecond>;
{$ENDIF}

// combining units
operator /(const {%H-}rad_s: TRadianPerSecondId; const {%H-}s: TSecondId): TRadianPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}rad: TRadianId; const {%H-}s2: TSquareSecondId): TRadianPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator/(const ASpeed: TRadiansPerSecond; const ATime: TSeconds): TRadiansPerSecondSquared;
{$IFDEF IMPL}begin result.Value := ASpeed.Value / ATime.Value; end;{$ENDIF}
operator/(const AAngle: TRadians; const ASquareTime: TSquareSeconds): TRadiansPerSecondSquared;
{$IFDEF IMPL}begin result.Value := AAngle.Value / ASquareTime.Value; end;{$ENDIF}

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
  TPascalsSecond = specialize TQuantityProduct<TPascal, TSecond>;
{$ENDIF}

// combining units
operator /(const {%H-}N: TNewtonId; const {%H-}m: TMeterId): TNewtonPerMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N: TNewtonId; const {%H-}mm: TMillimeterId): TNewtonPerMillimeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator /(const {%H-}N: TNewtonId; const {%H-}m3: TCubicMeterId): TNewtonPerCubicMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator *(const {%H-}Pa: TPascalId; const {%H-}s: TSecondId): TPascalSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}s: TSecondId; const {%H-}Pa: TPascalId): TPascalSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}Pas: TPascalSecondId; const {%H-}Pa: TPascalId): TSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

// combining quantities
operator /(const AForce: TNewtons; const ALength: TMeters): TNewtonsPerMeter;
{$IFDEF IMPL}begin result.Value := AForce.Value / ALength.Value; end;{$ENDIF}
operator /(const AForce: TNewtons; const ALength: TMillimeters): TNewtonsPerMillimeter;
{$IFDEF IMPL}begin result.Value := AForce.Value / ALength.Value; end;{$ENDIF}

operator /(const AForce: TNewtons; const AVolume: TCubicMeters): TNewtonsPerCubicMeter;
{$IFDEF IMPL}begin result.Value := AForce.Value / AVolume.Value; end;{$ENDIF}

operator *(const APressure: TPascals; const ATime: TSeconds): TPascalsSecond;
{$IFDEF IMPL}begin result.Value := APressure.Value * ATime.Value; end;{$ENDIF}
operator *(const ATime: TSeconds; const APressure: TPascals): TPascalsSecond;
{$IFDEF IMPL}begin result.Value := ATime.Value * APressure.Value; end;{$ENDIF}
operator /(const ADynViscosity: TPascalsSecond; const APressure: TPascals): TSeconds;
{$IFDEF IMPL}begin result.Value := ADynViscosity.Value / APressure.Value; end;{$ENDIF}

// alternate definition N/m = Pa * m
operator *(const {%H-}Pa: TPascalId; const {%H-}m: TMeterId): TNewtonPerMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m: TMeterId; const {%H-}Pa: TPascalId): TNewtonPerMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N_m: TNewtonPerMeterId; const {%H-}Pa: TPascalId): TMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N_m: TNewtonPerMeterId; const {%H-}m: TMeterId): TPascalId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator *(const APressure: TPascals; const ALength: TMeters): TNewtonsPerMeter;
{$IFDEF IMPL}begin result.Value := APressure.Value * ALength.Value; end;{$ENDIF}
operator *(const ALength: TMeters; const APressure: TPascals): TNewtonsPerMeter;
{$IFDEF IMPL}begin result.Value := ALength.Value * APressure.Value; end;{$ENDIF}
operator /(const ASurfaceTension: TNewtonsPerMeter; const APressure: TPascals): TMeters;
{$IFDEF IMPL}begin result.Value := ASurfaceTension.Value / APressure.Value; end;{$ENDIF}
operator /(const ASurfaceTension: TNewtonsPerMeter; const ALength: TMeters): TPascals;
{$IFDEF IMPL}begin result.Value := ASurfaceTension.Value / ALength.Value; end;{$ENDIF}

// alternate definition N/mm = MPa * mm
operator *(const {%H-}MPa: TMegapascalId; const {%H-}mm: TMillimeterId): TNewtonPerMillimeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}mm: TMillimeterId; const {%H-}MPa: TMegapascalId): TNewtonPerMillimeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N_mm: TNewtonPerMillimeterId; const {%H-}Pa: TMegapascalId): TMillimeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N_mm: TNewtonPerMillimeterId; const {%H-}mm: TMillimeterId): TMegapascalId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator *(const APressure: TMegapascals; const ALength: TMillimeters): TNewtonsPerMillimeter;
{$IFDEF IMPL}begin result.Value := APressure.Value * ALength.Value; end;{$ENDIF}
operator *(const ALength: TMillimeters; const APressure: TMegapascals): TNewtonsPerMillimeter;
{$IFDEF IMPL}begin result.Value := ALength.Value * APressure.Value; end;{$ENDIF}
operator /(const ASurfaceTension: TNewtonsPerMillimeter; const APressure: TMegapascals): TMillimeters;
{$IFDEF IMPL}begin result.Value := ASurfaceTension.Value / APressure.Value; end;{$ENDIF}
operator /(const ASurfaceTension: TNewtonsPerMillimeter; const ALength: TMillimeters): TMegapascals;
{$IFDEF IMPL}begin result.Value := ASurfaceTension.Value / ALength.Value; end;{$ENDIF}

// alternative definition N/m3 = kg/m3 * m/s2
operator *(const {%H-}kg_m3: TKilogramPerCubicMeterId; const {%H-}m_s2: TMeterPerSecondSquaredId): TNewtonPerCubicMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m_s2: TMeterPerSecondSquaredId; const {%H-}kg_m3: TKilogramPerCubicMeterId): TNewtonPerCubicMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N_m3: TNewtonPerCubicMeterId; const {%H-}kg_m3: TKilogramPerCubicMeterId): TMeterPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}N_m3: TNewtonPerCubicMeterId; const {%H-}m_s2: TMeterPerSecondSquaredId): TKilogramPerCubicMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}

operator *(const ADensity: TKilogramsPerCubicMeter; const AAcceleration: TMetersPerSecondSquared): TNewtonsPerCubicMeter;
{$IFDEF IMPL}begin result.Value := ADensity.Value * AAcceleration.Value; end;{$ENDIF}
operator *(const AAcceleration: TMetersPerSecondSquared; const ADensity: TKilogramsPerCubicMeter): TNewtonsPerCubicMeter;
{$IFDEF IMPL}begin result.Value := AAcceleration.Value * ADensity.Value; end;{$ENDIF}
operator /(const ASpecificWeight: TNewtonsPerCubicMeter; const ADensity: TKilogramsPerCubicMeter): TMetersPerSecondSquared;
{$IFDEF IMPL}begin result.Value := ASpecificWeight.Value / ADensity.Value; end;{$ENDIF}
operator /(const ASpecificWeight: TNewtonsPerCubicMeter; const AAcceleration: TMetersPerSecondSquared): TKilogramsPerCubicMeter;
{$IFDEF IMPL}begin result.Value := ASpecificWeight.Value / AAcceleration.Value; end;{$ENDIF}

// alternative definition kg/s = Pa*s * m
operator *(const {%H-}Pas: TPascalSecondId; const {%H-}m: TMeterId): TKilogramPerSecondId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}m: TMeterId; const {%H-}Pas: TPascalSecondId): TKilogramPerSecondId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}kg_s: TKilogramPerSecondId; const {%H-}Pas: TPascalSecondId): TMeterId; inline; {$IFDEF IMPL}begin end;{$ENDIF}
operator /(const {%H-}kg_s: TKilogramPerSecondId; const {%H-}m: TMeterId): TPascalSecondId; inline; {$IFDEF IMPL}begin end;{$ENDIF}

operator *(const ADynViscosity: TPascalsSecond; const ALength: TMeters): TKilogramsPerSecond;
{$IFDEF IMPL}begin result.Value := ADynViscosity.Value * ALength.Value; end;{$ENDIF}
operator *(const ALength: TMeters; const ADynViscosity: TPascalsSecond): TKilogramsPerSecond;
{$IFDEF IMPL}begin result.Value := ALength.Value * ADynViscosity.Value; end;{$ENDIF}
operator /(const AMassFlux: TKilogramsPerSecond; const ADynViscosity: TPascalsSecond): TMeters;
{$IFDEF IMPL}begin result.Value := AMassFlux.Value / ADynViscosity.Value; end;{$ENDIF}
operator /(const AMassFlux: TKilogramsPerSecond; const ALength: TMeters): TPascalsSecond;
{$IFDEF IMPL}begin result.Value := AMassFlux.Value / ALength.Value; end;{$ENDIF}
