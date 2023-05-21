// ELECTRIC FIELD //////////////////////////////////////////////////////////////

{ Units of electric field strength }
{$IFDEF INTF}
type
  TVoltPerMeter = specialize TRatioUnit<TVolt, TMeter>;
  TVoltPerMeterId = specialize TRatioUnitId<TVolt, TMeter>;
  TVoltsPerMeter = specialize TRatioQuantity<TVolt, TMeter>;
{$ENDIF}

{ main definition [ V/m ] = [ V ] / [ m ] }
{$DEFINE NumId:=TVoltId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TVoltPerMeterId}
{$DEFINE NumQty:=TVolts}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TVoltsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ V/m ] = [ N ] / [ C ] }
{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TCoulombId}{$DEFINE RatioId:=TVoltPerMeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TCoulombs}{$DEFINE RatioQty:=TVoltsPerMeter}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ V/m ] = [ T ] * [ m/s ] }
{$DEFINE LeftId:=TTeslaId}{$DEFINE RightId:=TMeterPerSecondId}{$DEFINE ProdId:=TVoltPerMeterId}
{$DEFINE LeftQty:=TTeslas}{$DEFINE RightQty:=TMetersPerSecond}{$DEFINE ProdQty:=TVoltsPerMeter}
{$DEFINE ALT_PROD}{$i dim.pas}

{$IFDEF INTF}
type
  TCoulombPerMeter = specialize TRatioUnit<TCoulomb, TMeter>;
  TCoulombPerMeterId = specialize TRatioUnitId<TCoulomb, TMeter>;
  TCoulombsPerMeter = specialize TRatioQuantity<TCoulomb, TMeter>;
{$ENDIF}

{ main definition [ C/m ] = [ C ] / [ m ] }
{$DEFINE NumId:=TCoulombId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TCoulombPerMeterId}
{$DEFINE NumQty:=TCoulombs}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TCoulombsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TSquareCoulombPerMeter = specialize TRatioUnit<TSquareCoulomb, TMeter>;
  TSquareCoulombPerMeterId = specialize TRatioUnitId<TSquareCoulomb, TMeter>;
  TSquareCoulombsPerMeter = specialize TRatioQuantity<TSquareCoulomb, TMeter>;
{$ENDIF}

{ main definition [ C2/m ] = [ C2 ] / [ m ] }
{$DEFINE NumId:=TSquareCoulombId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TSquareCoulombPerMeterId}
{$DEFINE NumQty:=TSquareCoulombs}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TSquareCoulombsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ C2/m ] = [ C/m ] * [ C ] }
{$DEFINE LeftId:=TCoulombPerMeterId}{$DEFINE RightId:=TCoulombId}{$DEFINE ProdId:=TSquareCoulombPerMeterId}
{$DEFINE LeftQty:=TCoulombsPerMeter}{$DEFINE RightQty:=TCoulombs}{$DEFINE ProdQty:=TSquareCoulombsPerMeter}
{$DEFINE ALT_PROD}{$i dim.pas}

{$IFDEF INTF}
type
  TCoulombPerSquareMeter = specialize TRatioUnit<TCoulomb, TSquareMeter>;
  TCoulombPerSquareMeterId = specialize TRatioUnitId<TCoulomb, TSquareMeter>;
  TCoulombsPerSquareMeter = specialize TRatioQuantity<TCoulomb, TSquareMeter>;
{$ENDIF}

{ main definition [ C/m2 ] = [ C ] / [ m2 ] }
{$DEFINE NumId:=TCoulombId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TCoulombPerSquareMeterId}
{$DEFINE NumQty:=TCoulombs}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TCoulombsPerSquareMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ C/m2 ] = [ C/m ] / [ m ] }
{$DEFINE NumId:=TCoulombPerMeterId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TCoulombPerSquareMeterId}
{$DEFINE NumQty:=TCoulombsPerMeter}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TCoulombsPerSquareMeter}
{$DEFINE ALT_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TSquareMeterPerSquareCoulomb = specialize TRatioUnit<TSquareMeter, TSquareCoulomb>;
  TSquareMeterPerSquareCoulombId = specialize TRatioUnitId<TSquareMeter, TSquareCoulomb>;
  TSquareMetersPerSquareCoulomb = specialize TRatioQuantity<TSquareMeter, TSquareCoulomb>;
{$ENDIF}

{ main definition [ m2/C2 ] = [ m2 ] / [ C2 ] }
{$DEFINE NumId:=TSquareMeterId}{$DEFINE DenomId:=TSquareCoulombId}{$DEFINE RatioId:=TSquareMeterPerSquareCoulombId}
{$DEFINE NumQty:=TSquareMeters}{$DEFINE DenomQty:=TSquareCoulombs}{$DEFINE RatioQty:=TSquareMetersPerSquareCoulomb}
{$DEFINE DEF_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TNewtonPerSquareCoulomb = specialize TRatioUnit<TNewton, TSquareCoulomb>;
  TNewtonPerSquareCoulombId = specialize TRatioUnitId<TNewton, TSquareCoulomb>;
  TNewtonsPerSquareCoulomb = specialize TRatioQuantity<TNewton, TSquareCoulomb>;
{$ENDIF}

{ main definition [ N/C2 ] = [ N ] / [ C2 ] }
{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TSquareCoulombId}{$DEFINE RatioId:=TNewtonPerSquareCoulombId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TSquareCoulombs}{$DEFINE RatioQty:=TNewtonsPerSquareCoulomb}
{$DEFINE DEF_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TNewtonSquareMeter = specialize TUnitProduct<TNewton, TSquareMeter>;
  TNewtonSquareMeterId = specialize TUnitProductId<TNewton, TSquareMeter>;
  TNewtonSquareMeters = specialize TQuantityProduct<TNewton, TSquareMeter>;
{$ENDIF}

{ main definition [ N*m2 ] = [ N ] * [ m2 ] }
{$DEFINE LeftId:=TNewtonId}{$DEFINE RightId:=TSquareMeterId}{$DEFINE ProdId:=TNewtonSquareMeterId}
{$DEFINE LeftQty:=TNewtons}{$DEFINE RightQty:=TSquareMeters}{$DEFINE ProdQty:=TNewtonSquareMeters}
{$DEFINE DEF_PROD}{$i dim.pas}

{ Units of Coulomb constant }
{$IFDEF INTF}
type
  TNewtonSquareMeterPerSquareCoulomb = specialize TUnitProduct<TNewton, TSquareMeterPerSquareCoulomb>;
  TNewtonSquareMeterPerSquareCoulombId = specialize TUnitProductId<TNewton, TSquareMeterPerSquareCoulomb>;
  TNewtonSquareMetersPerSquareCoulomb = specialize TQuantityProduct<TNewton, TSquareMeterPerSquareCoulomb>;
{$ENDIF}

{ main definition [ N*m2/C2 ] = [ N ] * [ m2/C2 ] }
{$DEFINE LeftId:=TNewtonId}{$DEFINE RightId:=TSquareMeterPerSquareCoulombId}{$DEFINE ProdId:=TNewtonSquareMeterPerSquareCoulombId}
{$DEFINE LeftQty:=TNewtons}{$DEFINE RightQty:=TSquareMetersPerSquareCoulomb}{$DEFINE ProdQty:=TNewtonSquareMetersPerSquareCoulomb}
{$DEFINE DEF_PROD}{$i dim.pas}

{ alternative definition [ N*m2/C2 ] = [ N*m2 ] / [ C2 ] }
{$DEFINE NumId:=TNewtonSquareMeterId}{$DEFINE DenomId:=TSquareCoulombId}{$DEFINE RatioId:=TNewtonSquareMeterPerSquareCoulombId}
{$DEFINE NumQty:=TNewtonSquareMeters}{$DEFINE DenomQty:=TSquareCoulombs}{$DEFINE RatioQty:=TNewtonSquareMetersPerSquareCoulomb}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ N*m2/C2 ] = [ N/C2 ] * [ m2 ] }
{$DEFINE LeftId:=TNewtonPerSquareCoulombId}{$DEFINE RightId:=TSquareMeterId}{$DEFINE ProdId:=TNewtonSquareMeterPerSquareCoulombId}
{$DEFINE LeftQty:=TNewtonsPerSquareCoulomb}{$DEFINE RightQty:=TSquareMeters}{$DEFINE ProdQty:=TNewtonSquareMetersPerSquareCoulomb}
{$DEFINE ALT_PROD}{$i dim.pas}

{ alternative definition [ N*m2/C2 ] = [ V/m ] / [ C/m2 ] }
{$DEFINE NumId:=TVoltPerMeterId}{$DEFINE DenomId:=TCoulombPerSquareMeterId}{$DEFINE RatioId:=TNewtonSquareMeterPerSquareCoulombId}
{$DEFINE NumQty:=TVoltsPerMeter}{$DEFINE DenomQty:=TCoulombsPerSquareMeter}{$DEFINE RatioQty:=TNewtonSquareMetersPerSquareCoulomb}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ N*m2/C2 ] = [ J ] / [ C2/m ] }
{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TSquareCoulombPerMeterId}{$DEFINE RatioId:=TNewtonSquareMeterPerSquareCoulombId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TSquareCoulombsPerMeter}{$DEFINE RatioQty:=TNewtonSquareMetersPerSquareCoulomb}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ Units of electric field flux }
{$IFDEF INTF}
type
  TVoltMeter = specialize TUnitProduct<TVolt, TMeter>;
  TVoltMeterId = specialize TUnitProductId<TVolt, TMeter>;
  TVoltMeters = specialize TQuantityProduct<TVolt, TMeter>;
{$ENDIF}

{ main definition [ V*m ] = [ V ] * [ m ] }
{$DEFINE LeftId:=TVoltId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TVoltMeterId}
{$DEFINE LeftQty:=TVolts}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TVoltMeters}
{$DEFINE DEF_PROD}{$i dim.pas}

{ alternative definition [ V*m ] = [ V/m ] * [ m2 ] }
{$DEFINE LeftId:=TVoltPerMeterId}{$DEFINE RightId:=TSquareMeterId}{$DEFINE ProdId:=TVoltMeterId}
{$DEFINE LeftQty:=TVoltsPerMeter}{$DEFINE RightQty:=TSquareMeters}{$DEFINE ProdQty:=TVoltMeters}
{$DEFINE ALT_PROD}{$i dim.pas}

{ Units of vacuum permittivity }
{$IFDEF INTF}
type
  TFaradPerMeter = specialize TRatioUnit<TFarad, TMeter>;
  TFaradPerMeterId = specialize TRatioUnitId<TFarad, TMeter>;
  TFaradsPerMeter = specialize TRatioQuantity<TFarad, TMeter>;
{$ENDIF}

{ main definition [ F/m ] = [ F ] / [ m ] }
{$DEFINE NumId:=TFaradId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TFaradPerMeterId}
{$DEFINE NumQty:=TFarads}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TFaradsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ F/m ] = [ C ] / [ V*m ] }
{$DEFINE NumId:=TCoulombId}{$DEFINE DenomId:=TVoltMeterId}{$DEFINE RatioId:=TFaradPerMeterId}
{$DEFINE NumQty:=TCoulombs}{$DEFINE DenomQty:=TVoltMeters}{$DEFINE RatioQty:=TFaradsPerMeter}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ F/m ] = [ C/m2 ] / [ V/m ] }
{$DEFINE NumId:=TCoulombPerSquareMeterId}{$DEFINE DenomId:=TVoltPerMeterId}{$DEFINE RatioId:=TFaradPerMeterId}
{$DEFINE NumQty:=TCoulombsPerSquareMeter}{$DEFINE DenomQty:=TVoltsPerMeter}{$DEFINE RatioQty:=TFaradsPerMeter}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ F/m ] = [ 1 ] / [ N*m2/C2 ] }
{$DEFINE DenomId:=TNewtonSquareMeterPerSquareCoulombId}{$DEFINE RecipId:=TFaradPerMeterId}
{$DEFINE DenomQty:=TNewtonSquareMetersPerSquareCoulomb}{$DEFINE RecipQty:=TFaradsPerMeter}
{$DEFINE ALT_RECIP}{$i dim.pas}

