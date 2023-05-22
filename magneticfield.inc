// MAGNETIC FIELD //////////////////////////////////////////////////////////////

{$IFDEF INTF}
type
  TAmperePerMeter = specialize TRatioUnit<TAmpere, TMeter>;
  TAmperePerMeterId = specialize TRatioUnitId<TAmpere, TMeter>;
  TAmperesPerMeter = specialize TRatioQuantity<TAmpere, TMeter>;
{$ENDIF}

{ main definition [ A/m ] = [ A ] / [ m ] }
{$DEFINE NumId:=TAmpereId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TAmperePerMeterId}
{$DEFINE NumQty:=TAmperes}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TAmperesPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TMeterPerAmpere = specialize TRatioUnit<TMeter, TAmpere>;
  TMeterPerAmpereId = specialize TRatioUnitId<TMeter, TAmpere>;
  TMetersPerAmpere = specialize TRatioQuantity<TMeter, TAmpere>;
{$ENDIF}

{ main definition [ m/A ] = [ m ] / [ A ] }
{$DEFINE NumId:=TMeterId}{$DEFINE DenomId:=TAmpereId}{$DEFINE RatioId:=TMeterPerAmpereId}
{$DEFINE NumQty:=TMeters}{$DEFINE DenomQty:=TAmperes}{$DEFINE RatioQty:=TMetersPerAmpere}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ units of line integral of the magnetic field }
{$IFDEF INTF}
type
  TTeslaMeter = specialize TUnitProduct<TTesla, TMeter>;
  TTeslaMeterId = specialize TUnitProductId<TTesla, TMeter>;
  TTeslaMeters = specialize TQuantityProduct<TTesla, TMeter>;
{$ENDIF}

{ main definition [ T*m ] = [ T ] * [ m ] }
{$DEFINE LeftId:=TTeslaId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TTeslaMeterId}
{$DEFINE LeftQty:=TTeslas}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TTeslaMeters}
{$DEFINE DEF_PROD}{$i dim.pas}

{ main definition [ T*m ] = [ N/A ] = [ N ] / [ A ] }
{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TAmpereId}{$DEFINE RatioId:=TTeslaMeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TAmperes}{$DEFINE RatioQty:=TTeslaMeters}
{$DEFINE ALT_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TTeslaPerAmpere = specialize TRatioUnit<TTesla, TAmpere>;
  TTeslaPerAmpereId = specialize TRatioUnitId<TTesla, TAmpere>;
  TTeslasPerAmpere = specialize TRatioQuantity<TTesla, TAmpere>;
{$ENDIF}

{ main definition [ T/A ] = [ T ] / [ A ] }
{$DEFINE NumId:=TTeslaId}{$DEFINE DenomId:=TAmpereId}{$DEFINE RatioId:=TTeslaPerAmpereId}
{$DEFINE NumQty:=TTeslas}{$DEFINE DenomQty:=TAmperes}{$DEFINE RatioQty:=TTeslasPerAmpere}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ units of magnetic permeability }
{$IFDEF INTF}
type
  THenryPerMeter = specialize TRatioUnit<THenry, TMeter>;
  THenryPerMeterId = specialize TRatioUnitId<THenry, TMeter>;
  THenrysPerMeter = specialize TRatioQuantity<THenry, TMeter>;
{$ENDIF}

{ main definition [ H/m ] = [ H ] / [ m ] }
{$DEFINE NumId:=THenryId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=THenryPerMeterId}
{$DEFINE NumQty:=THenrys}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=THenrysPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ H/m ] = [ T*m/A ] = [ T*m ] / [ A ] }
{$DEFINE NumId:=TTeslaMeterId}{$DEFINE DenomId:=TAmpereId}{$DEFINE RatioId:=THenryPerMeterId}
{$DEFINE NumQty:=TTeslaMeters}{$DEFINE DenomQty:=TAmperes}{$DEFINE RatioQty:=THenrysPerMeter}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ H/ m ] = [ T*m/A ] = [ T/A ] * [ m ] }
{$DEFINE LeftId:=TTeslaPerAmpereId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=THenryPerMeterId}
{$DEFINE LeftQty:=TTeslasPerAmpere}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=THenrysPerMeter}
{$DEFINE ALT_PROD}{$i dim.pas}

{ alternative definition [ H/ m ] = [ T*m/A ] = [ T ] * [ m/A ] }
{$DEFINE LeftId:=TTeslaId}{$DEFINE RightId:=TMeterPerAmpereId}{$DEFINE ProdId:=THenryPerMeterId}
{$DEFINE LeftQty:=TTeslas}{$DEFINE RightQty:=TMetersPerAmpere}{$DEFINE ProdQty:=THenrysPerMeter}
{$DEFINE ALT_PROD}{$i dim.pas}

{ alternative definition [ H/m ] = [ T*m/A ] = [ T ] / [ A/m ] }
{$DEFINE NumId:=TTeslaId}{$DEFINE DenomId:=TAmperePerMeterId}{$DEFINE RatioId:=THenryPerMeterId}
{$DEFINE NumQty:=TTeslas}{$DEFINE DenomQty:=TAmperesPerMeter}{$DEFINE RatioQty:=THenrysPerMeter}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ H/m ] = [ N/A2 ] = [ N ] / [ A2 ] }
{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TSquareAmpereId}{$DEFINE RatioId:=THenryPerMeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TSquareAmperes}{$DEFINE RatioQty:=THenrysPerMeter}
{$DEFINE ALT_RATIO}{$i dim.pas}
