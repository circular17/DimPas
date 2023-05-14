////////////////////// UNITS DERIVED FROM SPECIAL UNITS ////////////////////////

{ Units of speed }
{$IFDEF INTF}
type
  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondId = specialize TRatioUnitId<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioQuantity<TRadian, TSecond>;
{$ENDIF}

operator /(const {%H-}rad: TRadianId; const {%H-}s: TSecondId): TRadianPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator/(const AAngle: TRadians; const ADuration: TSeconds): TRadiansPerSecond; inline;
{$IFDEF IMPL}begin result.Value:= AAngle.Value / ADuration.Value; end;{$ENDIF}

{ Units of acceleration }
{$IFDEF INTF}
type
  TRadianPerSecondSquaredId = specialize TRatioUnitId<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioQuantity<TRadianPerSecond, TSecond>;
{$ENDIF}

operator /(const {%H-}rad_s: TRadianPerSecondId; const {%H-}s: TSecondId): TRadianPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator/(const ASpeed: TRadiansPerSecond; const ATime: TSeconds): TRadiansPerSecondSquared; inline;
{$IFDEF IMPL}begin result.Value := ASpeed.Value / ATime.Value; end;{$ENDIF}

operator /(const {%H-}rad: TRadianId; const {%H-}s2: TSquareSecondId): TRadianPerSecondSquaredId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator/(const AAngle: TRadians; const ASquareTime: TSquareSeconds): TRadiansPerSecondSquared; inline;
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
  TPascalSeconds = specialize TQuantityProduct<TPascal, TSecond>;
{$ENDIF}

operator /(const {%H-}N: TNewtonId; const {%H-}m: TMeterId): TNewtonPerMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const AForce: TNewtons; const ALength: TMeters): TNewtonsPerMeter; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / ALength.Value; end;{$ENDIF}

operator /(const {%H-}N: TNewtonId; const {%H-}mm: TMillimeterId): TNewtonPerMillimeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const AForce: TNewtons; const ALength: TMillimeters): TNewtonsPerMillimeter; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / ALength.Value; end;{$ENDIF}

operator /(const {%H-}N: TNewtonId; const {%H-}m3: TCubicMeterId): TNewtonPerCubicMeterId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const AForce: TNewtons; const AVolume: TCubicMeters): TNewtonsPerCubicMeter; inline;
{$IFDEF IMPL}begin result.Value := AForce.Value / AVolume.Value; end;{$ENDIF}

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

{$DEFINE LeftId:=TKilogramPerCubicMeterId}{$DEFINE RightId:=TMeterPerSecondSquaredId}{$DEFINE ProdId:=TNewtonPerCubicMeterId}
{$DEFINE LeftQty:=TKilogramsPerCubicMeter}{$DEFINE RightQty:=TMetersPerSecondSquared}{$DEFINE ProdQty:=TNewtonsPerCubicMeter}
{$DEFINE ALT_PROD}{$i dim.pas} // N/m3 = kg/m3 * m/s2

{$DEFINE LeftId:=TPascalSecondId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TKilogramPerSecondId}
{$DEFINE LeftQty:=TPascalSeconds}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TKilogramsPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas} // kg/s = Pa*s * m
