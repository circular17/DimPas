{$IFNDEF DIM}{$DEFINE DIM}
unit Dim;

{$H+}{$modeSwitch advancedRecords}
{$WARN NO_RETVAL OFF}{$MACRO ON}

interface uses SysUtils;

type

  { TCustomUnit }

  TCustomUnit = class
    class function Symbol: string; virtual; abstract;
    class function Name: string; virtual; abstract;
  private
    class function GetPowerSymbol(AExponent: integer): string;
    class function GetPowerName(AExponent: integer): string;
  end;

  TUnit = class(TCustomUnit);
  TFactoredUnit = class(TCustomUnit)
    class function Factor: double; virtual; abstract;
  end;
  generic TPowerUnit<BaseU: TUnit> = class(TUnit)
    class function Symbol: string; override;
    class function Name: string; override;
    class function Exponent: integer; virtual; abstract;
  end;

  generic TFactoredPowerUnit<BaseU: TFactoredUnit> = class(TFactoredUnit)
    class function Symbol: string; override;
    class function Name: string; override;
    class function Factor: double; override;
    class function Exponent: integer; virtual; abstract;
  end;

  {$UNDEF DIM}{$ENDIF}
  // derive TUnit and TFactoredUnit classes
  {$IF defined(UNIT_OV_INTF) or defined(FACTORED_UNIT_INTF)}
  {$IFDEF FACTORED_UNIT_INTF}
  class(TFactoredUnit)
    class function Factor: double; override;
  {$ELSE}
  class(TUnit)
  {$ENDIF}
    class function Symbol: string; override;
    class function Name: string; override;
  end;
  {$ENDIF}{$UNDEF UNIT_OV_INTF}{$UNDEF FACTORED_UNIT_INTF}

  {$IFDEF POWER_UNIT_INTF}
  class(specialize TPowerUnit<BaseU>)
    class function Exponent: integer; override;
  end;
  {$ENDIF}{$UNDEF POWER_UNIT_INTF}

  {$IFDEF FACTORED_POWER_UNIT_INTF}
  class(specialize TFactoredPowerUnit<BaseU>)
    class function Exponent: integer; override;
  end;
  {$ENDIF}{$UNDEF FACTORED_POWER_UNIT_INTF}
  {$IFNDEF DIM}{$DEFINE DIM}


  generic TSquareUnit<BaseU: TUnit> = {$DEFINE POWER_UNIT_INTF}{$i dim.pas}
  generic TCubicUnit<BaseU: TUnit> = {$DEFINE POWER_UNIT_INTF}{$i dim.pas}
  generic TQuarticUnit<BaseU: TUnit> = {$DEFINE POWER_UNIT_INTF}{$i dim.pas}
  generic TReciprocalUnit<BaseU: TUnit> = {$DEFINE POWER_UNIT_INTF}{$i dim.pas}

  generic TRatioUnit<NumeratorU, DenomU: TUnit> = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  generic TUnitProduct<U1, U2: TUnit> = {$DEFINE UNIT_OV_INTF}{$i dim.pas}

  generic TFactoredSquareUnit<BaseU: TFactoredUnit> = {$DEFINE FACTORED_POWER_UNIT_INTF}{$i dim.pas}
  generic TFactoredCubicUnit<BaseU: TFactoredUnit> = {$DEFINE FACTORED_POWER_UNIT_INTF}{$i dim.pas}
  generic TFactoredQuarticUnit<BaseU: TFactoredUnit> = {$DEFINE FACTORED_POWER_UNIT_INTF}{$i dim.pas}
  generic TFactoredReciprocalUnit<BaseU: TFactoredUnit> = {$DEFINE FACTORED_POWER_UNIT_INTF}{$i dim.pas}

  generic TFactoredRatioUnit<NumeratorU, DenomU: TFactoredUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TFactoredNumeratorUnit<NumeratorU: TFactoredUnit; DenomU: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TFactoredDenominatorUnit<NumeratorU: TUnit; DenomU: TFactoredUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TFactoredUnitProduct<U1, U2: TFactoredUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TLeftFactoredUnitProduct<U1: TFactoredUnit; U2: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TRightFactoredUnitProduct<U1: TUnit; U2: TFactoredUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}

  generic TTeraUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TGigaUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TMegaUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TKiloUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic THectoUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TDecaUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TDeciUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TCentiUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TMilliUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TMicroUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TNanoUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TPicoUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}

  { Dimensionned quantities }

  {$UNDEF DIM}{$ENDIF}
  // simulate inheritance for TQuantity record
  {$IF defined(BASIC_QTY_INTF) or defined(QTY_INTF)}
  public
    Value: double;
    function ToString: string;
    function ToVerboseString: string;
    function Abs: TSelf;
    constructor Assign(const AQuantity: TSelf); overload;
  {$ENDIF}{$UNDEF BASIC_QTY_INTF}
  {$IFDEF QTY_INTF}
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
  {$ENDIF}{$UNDEF QTY_INTF}
  {$IFDEF SQUARABLE_QTY_INTF}
    class operator *(const AQuantity1, AQuantity2: TSelf): TSquareQuantity;
    class operator /(const ASquareQuantity: TSquareQuantity; const AQuantity: TSelf): TSelf;

    class operator *(const ASquareQuantity: TSquareQuantity; const AQuantity: TSelf): TCubicQuantity;
    class operator *(const AQuantity: TSelf; const ASquareQuantity: TSquareQuantity): TCubicQuantity;
    class operator /(const ACubicQuantity: TCubicQuantity; const AQuantity: TSelf): TSquareQuantity;

    class operator *(const AQuantity: TSelf; const ACubicQuantity: TCubicQuantity): TQuarticQuantity;
    class operator *(const ACubicQuantity: TCubicQuantity; const AQuantity: TSelf): TQuarticQuantity;
    class operator /(const AQuarticQuantity: TQuarticQuantity; const AQuantity: TSelf): TCubicQuantity;
    function Quarted: TQuarticQuantity;
    function Squared: TSquareQuantity;
    function Cubed: TCubicQuantity;
  {$ENDIF}{$UNDEF SQUARABLE_QTY_INTF}
  {$IFDEF RATIO_QTY_INTF}
    class operator /(const ANumerator: TNumeratorQuantity; const ASelf: TSelf): TDenomQuantity;
    class operator *(const ASelf: TSelf; const ADenominator: TDenomQuantity): TNumeratorQuantity;
    class operator *(const ADenominator: TDenomQuantity; const ASelf: TSelf): TNumeratorQuantity;
    class operator :=(const ARatio: TRatio): TSelf;
    class operator :=(const ASelf: TSelf): TRatio;
    {$IFDEF FACTORED_QTY_INTF}
    class operator :=(const ASelf: TSelf): TBaseRatio;
    {$ENDIF}
  {$ENDIF}{$UNDEF RATIO_QTY_INTF}
  {$IFDEF QTY_PROD_INTF}
    //class operator /(const ASelf: TSelf; const AQuantity1: TQuantity1): TQuantity2;
    class operator /(const ASelf: TSelf; const AQuantity2: TQuantity2): TQuantity1;
    class operator :=(const AProduct: TProduct): TSelf;
    class operator :=(const ASelf: TSelf): TProduct;
  {$ENDIF}{$UNDEF QTY_PROD_INTF}
  {$IFDEF RECIP_QTY_INTF}
    class operator /(const AValue: double; const ASelf: TSelf): TDenomQuantity;
    class operator *(const ASelf: TSelf; const ADenominator: TDenomQuantity): double;
    class operator *(const ADenominator: TDenomQuantity; const ASelf: TSelf): double;
  {$ENDIF}{$UNDEF RECIP_QTY_INTF}
  {$IFDEF FACTORED_QTY_INTF}
    function ToBase: TBaseQuantity;
    constructor Assign(const AQuantity: TBaseQuantity); overload;
    class operator :=(const AQuantity: TSelf): TBaseQuantity;
    class function From(const AQuantity: TBaseQuantity): TSelf; static; inline;
  {$ENDIF}{$UNDEF FACTORED_QTY_INTF}
  {$IFNDEF DIM}{$DEFINE DIM}

  generic TQuarticQuantity<BaseU: TUnit> = record
    type TSelf = specialize TQuarticQuantity<BaseU>;
    type U = specialize TQuarticUnit<BaseU>;
    {$DEFINE QTY_INTF}{$i dim.pas}
  end;

  generic TCubicQuantity<BaseU: TUnit> = record
    type TSelf = specialize TCubicQuantity<BaseU>;
    type U = specialize TCubicUnit<BaseU>;
    {$DEFINE QTY_INTF}{$i dim.pas}
  end;

  generic TSquareQuantity<BaseU: TUnit> = record
    type TSelf = specialize TSquareQuantity<BaseU>;
    type U = specialize TSquareUnit<BaseU>;
    {$DEFINE QTY_INTF}{$i dim.pas}
  end;

  generic TQuantity<U: TUnit> = record
    type TSelf = specialize TQuantity<U>;
    type TSquareQuantity = specialize TSquareQuantity<U>;
    type TCubicQuantity = specialize TCubicQuantity<U>;
    type TQuarticQuantity = specialize TQuarticQuantity<U>;
    {$DEFINE QTY_INTF}{$DEFINE SQUARABLE_QTY_INTF}{$i dim.pas}
  end;

  generic TBasicQuantity<U: TUnit> = record
    type TSelf = specialize TBasicQuantity<U>;
    {$DEFINE BASIC_QTY_INTF}{$i dim.pas}
  end;

  generic TReciprocalQuantity<DenomU: TUnit> = record
    type U = specialize TReciprocalUnit<DenomU>;
    type TSelf = specialize TReciprocalQuantity<DenomU>;
    type TDenomQuantity = specialize TQuantity<DenomU>;
    {$DEFINE QTY_INTF}{$DEFINE RECIP_QTY_INTF}{$i dim.pas}
  end;

  generic TRatioQuantity<NumeratorU, DenomU: TUnit> = record
    type U = specialize TRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TRatioQuantity<NumeratorU, DenomU>;
    type TNumeratorQuantity = specialize TQuantity<NumeratorU>;
    type TDenomQuantity = specialize TQuantity<DenomU>;
    type TRatio = specialize TQuantity<U>;
    {$DEFINE QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TQuantityProduct<U1, U2: TUnit> = record
    type U = specialize TUnitProduct<U1, U2>;
    type TSelf = specialize TQuantityProduct<U1, U2>;
    type TQuantity1 = specialize TQuantity<U1>;
    type TQuantity2 = specialize TQuantity<U2>;
    type TProduct = specialize TQuantity<U>;
    {$DEFINE QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  generic TFactoredQuarticQuantity<BaseU: TUnit; U1: TFactoredUnit> = record
    type TSelf = specialize TFactoredQuarticQuantity<BaseU, U1>;
    type U = specialize TFactoredQuarticUnit<U1>;
    type TBaseQuantity = specialize TQuarticQuantity<BaseU>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredCubicQuantity<BaseU: TUnit; U1: TFactoredUnit> = record
    type TSelf = specialize TFactoredCubicQuantity<BaseU, U1>;
    type U = specialize TFactoredCubicUnit<U1>;
    type TBaseQuantity = specialize TCubicQuantity<BaseU>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredSquareQuantity<BaseU: TUnit; U1: TFactoredUnit> = record
    type TSelf = specialize TFactoredSquareQuantity<BaseU, U1>;
    type U = specialize TFactoredSquareUnit<U1>;
    type TBaseQuantity = specialize TSquareQuantity<BaseU>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredQuantity<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredQuantity<BaseU, U>;
    type TBaseQuantity = specialize TQuantity<BaseU>;
    type TSquareQuantity = specialize TFactoredSquareQuantity<BaseU, U>;
    type TCubicQuantity = specialize TFactoredCubicQuantity<BaseU, U>;
    type TQuarticQuantity = specialize TFactoredQuarticQuantity<BaseU, U>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE SQUARABLE_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredReciprocalQuantity<BaseDenomU: TUnit; DenomU: TFactoredUnit> = record
    type U = specialize TFactoredReciprocalUnit<DenomU>;
    type BaseU = specialize TReciprocalUnit<BaseDenomU>;
    type TBaseQuantity = specialize TReciprocalQuantity<BaseDenomU>;
    type TSelf = specialize TFactoredReciprocalQuantity<BaseDenomU, DenomU>;
    type TDenomQuantity = specialize TFactoredQuantity<BaseDenomU, DenomU>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RECIP_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredRatioQuantity<BaseNumeratorU, BaseDenomU: TUnit;
                                            NumeratorU, DenomU: TFactoredUnit> = record
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseQuantity = specialize TRatioQuantity<BaseNumeratorU, BaseDenomU>;
    type U = specialize TFactoredRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredRatioQuantity
                 <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type TNumeratorQuantity = specialize TFactoredQuantity<BaseNumeratorU, NumeratorU>;
    type TDenomQuantity = specialize TFactoredQuantity<BaseDenomU, DenomU>;
    type TRatio = specialize TFactoredQuantity<BaseU, U>;
    type TBaseRatio = specialize TQuantity<BaseU>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredNumeratorQuantity<BaseNumeratorU, BaseDenomU: TUnit;
                                                NumeratorU: TFactoredUnit> = record
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseQuantity = specialize TRatioQuantity<BaseNumeratorU, BaseDenomU>;
    type DenomU = BaseDenomU;
    type U = specialize TFactoredNumeratorUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredNumeratorQuantity
                 <BaseNumeratorU, BaseDenomU, NumeratorU>;
    type TNumeratorQuantity = specialize TFactoredQuantity<BaseNumeratorU, NumeratorU>;
    type TDenomQuantity = specialize TQuantity<DenomU>;
    type TRatio = specialize TFactoredQuantity<BaseU, U>;
    type TBaseRatio = specialize TQuantity<BaseU>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredDenominatorQuantity<BaseNumeratorU, BaseDenomU: TUnit;
                                                  DenomU: TFactoredUnit> = record
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseQuantity = specialize TRatioQuantity<BaseNumeratorU, BaseDenomU>;
    type NumeratorU = BaseNumeratorU;
    type U = specialize TFactoredDenominatorUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredDenominatorQuantity
                 <BaseNumeratorU, BaseDenomU, DenomU>;
    type TNumeratorQuantity = specialize TQuantity<NumeratorU>;
    type TDenomQuantity = specialize TFactoredQuantity<BaseDenomU, DenomU>;
    type TRatio = specialize TFactoredQuantity<BaseU, U>;
    type TBaseRatio = specialize TQuantity<BaseU>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredQuantityProduct<BaseU1, BaseU2: TUnit; U1, U2: TFactoredUnit> = record
    type TSelf = specialize TFactoredQuantityProduct<BaseU1, BaseU2, U1, U2>;
    type U = specialize TFactoredUnitProduct<U1, U2>;
    type TQuantity1 = specialize TFactoredQuantity<BaseU1, U1>;
    type TQuantity2 = specialize TFactoredQuantity<BaseU2, U2>;
    type TBaseQuantity = specialize TQuantityProduct<BaseU1, BaseU2>;
    type BaseU = specialize TUnitProduct<BaseU1, BaseU2>;
    type TProduct = specialize TFactoredQuantity<BaseU, U>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  generic TLeftFactoredQuantityProduct<BaseU1, BaseU2: TUnit; U1: TFactoredUnit> = record
    type U2 = BaseU2;
    type TSelf = specialize TLeftFactoredQuantityProduct<BaseU1, BaseU2, U1>;
    type U = specialize TLeftFactoredUnitProduct<U1, U2>;
    type TQuantity1 = specialize TFactoredQuantity<BaseU1, U1>;
    type TQuantity2 = specialize TQuantity<U2>;
    type TBaseQuantity = specialize TQuantityProduct<BaseU1, BaseU2>;
    type BaseU = specialize TUnitProduct<BaseU1, BaseU2>;
    type TProduct = specialize TFactoredQuantity<BaseU, U>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  generic TRightFactoredQuantityProduct<BaseU1, BaseU2: TUnit; U2: TFactoredUnit> = record
    type U1 = BaseU1;
    type TSelf = specialize TRightFactoredQuantityProduct<BaseU1, BaseU2, U2>;
    type U = specialize TRightFactoredUnitProduct<U1, U2>;
    type TQuantity1 = specialize TQuantity<U1>;
    type TQuantity2 = specialize TFactoredQuantity<BaseU2, U2>;
    type TBaseQuantity = specialize TQuantityProduct<BaseU1, BaseU2>;
    type BaseU = specialize TUnitProduct<BaseU1, BaseU2>;
    type TProduct = specialize TFactoredQuantity<BaseU, U>;
    {$DEFINE QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  { Unit identifiers }

  {$UNDEF DIM}{$ENDIF}
  // simulate inheritance for TUnitId record
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
    class operator *(const {%H-}TheUnit1, {%H-}TheUnit2: TSelf): TSquareId;
    class operator /(const {%H-}TheSquareUnit: TSquareId; const {%H-}TheUnit: TSelf): TSelf;

    class operator *(const {%H-}TheSquareUnit: TSquareId; const {%H-}TheUnit: TSelf): TCubicId;
    class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheSquareUnit: TSquareId): TCubicId;
    class operator /(const {%H-}TheCubicUnit: TCubicId; const {%H-}TheUnit: TSelf): TSquareId;

    class operator *(const {%H-}TheCubicUnit: TCubicId; const {%H-}TheUnit: TSelf): TQuarticId;
    class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheCubicUnit: TCubicId): TQuarticId;
    class operator /(const {%H-}TheQuarticUnit: TQuarticId; const {%H-}TheUnit: TSelf): TCubicId;
    function Squared: TSquareId;
    function Cubed: TCubicId;
    function Quarted: TQuarticId;
    function SquareRoot(const ASquareQuantity: TSquareQuantity): TQuantity;
    function CubicRoot(const ACubicQuantity: TCubicQuantity): TQuantity;
  {$ENDIF}{$UNDEF SQUARABLE_UNIT_ID_INTF}
  {$IFDEF FACTORED_UNIT_ID_INTF}
    class function From(const AQuantity: TBaseQuantity): TQuantity; inline; static;
    class function BaseUnit: TBaseUnitId; inline; static;
    class function Factor: double; inline; static;
  {$ENDIF}{$UNDEF FACTORED_UNIT_ID_INTF}
  {$IFDEF RECIP_UNIT_ID_INTF}
    class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheDenom: TDenomId): double;
    class function Inverse: TDenomId; inline; static;
  {$ENDIF}{$UNDEF RECIP_UNIT_ID_INTF}
  {$IFDEF RATIO_UNIT_ID_INTF}
    class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheDenom: TDenomId): TNumeratorId;
  {$ENDIF}{$UNDEF RATIO_UNIT_ID_INTF}
  {$IFDEF UNIT_PROD_ID_INTF}
    //class operator /(const {%H-}TheUnit: TSelf; const {%H-}Unit1: TId1): TId2;
    class operator /(const {%H-}TheUnit: TSelf; const {%H-}Unit2: TId2): TId1;
  {$ENDIF}{$UNDEF UNIT_PROD_ID_INTF}
  {$IFNDEF DIM}{$DEFINE DIM}

  generic TQuarticUnitId<BaseU: TUnit> = record
    type U = specialize TQuarticUnit<BaseU>;
    type TSelf = specialize TQuarticUnitId<BaseU>;
    type TQuantity = specialize TQuarticQuantity<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TCubicUnitId<BaseU: TUnit> = record
    type U = specialize TCubicUnit<BaseU>;
    type TSelf = specialize TCubicUnitId<BaseU>;
    type TQuantity = specialize TCubicQuantity<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TSquareUnitId<BaseU: TUnit> = record
    type U = specialize TSquareUnit<BaseU>;
    type TSelf = specialize TSquareUnitId<BaseU>;
    type TQuantity = specialize TSquareQuantity<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TBasicUnitId<U: TUnit> = record
    type TSelf = specialize TBasicUnitId<U>;
    type TQuantity = specialize TBasicQuantity<U>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TUnitId<U: TUnit> = record
    type TSelf = specialize TUnitId<U>;
    type TQuantity = specialize TQuantity<U>;
    type TSquareId = specialize TSquareUnitId<U>;
    type TSquareQuantity = specialize TSquareQuantity<U>;
    type TCubicId = specialize TCubicUnitId<U>;
    type TCubicQuantity = specialize TCubicQuantity<U>;
    type TQuarticId = specialize TQuarticUnitId<U>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE SQUARABLE_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredQuarticUnitId<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredQuarticUnitId<BaseU, U>;
    type TQuantity = specialize TFactoredQuarticQuantity<BaseU, U>;
    type TBaseQuantity = specialize TQuarticQuantity<BaseU>;
    type TBaseUnitId = specialize TQuarticUnitId<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredCubicUnitId<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredCubicUnitId<BaseU, U>;
    type TQuantity = specialize TFactoredCubicQuantity<BaseU, U>;
    type TBaseQuantity = specialize TCubicQuantity<BaseU>;
    type TBaseUnitId = specialize TCubicUnitId<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredSquareUnitId<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredSquareUnitId<BaseU, U>;
    type TQuantity = specialize TFactoredSquareQuantity<BaseU, U>;
    type TBaseQuantity = specialize TSquareQuantity<BaseU>;
    type TBaseUnitId = specialize TSquareUnitId<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredUnitId<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredUnitId<BaseU, U>;
    type TQuantity = specialize TFactoredQuantity<BaseU, U>;
    type TBaseQuantity = specialize TQuantity<BaseU>;
    type TBaseUnitId = specialize TUnitId<BaseU>;
    type TSquareId = specialize TFactoredSquareUnitId<BaseU, U>;
    type TSquareQuantity = specialize TFactoredSquareQuantity<BaseU, U>;
    type TCubicId = specialize TFactoredCubicUnitId<BaseU, U>;
    type TCubicQuantity = specialize TFactoredCubicQuantity<BaseU, U>;
    type TQuarticId = specialize TFactoredQuarticUnitId<BaseU, U>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE SQUARABLE_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TReciprocalUnitId<DenomU: TUnit> = record
    type U = specialize TReciprocalUnit<DenomU>;
    type TSelf = specialize TReciprocalUnitId<DenomU>;
    type TQuantity = specialize TReciprocalQuantity<DenomU>;
    type TDenomId = specialize TUnitId<DenomU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE RECIP_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredReciprocalUnitId<BaseDenomU: TUnit; DenomU: TFactoredUnit> = record
    type U = specialize TFactoredReciprocalUnit<DenomU>;
    type BaseU = specialize TReciprocalUnit<BaseDenomU>;
    type TBaseQuantity = specialize TReciprocalQuantity<BaseDenomU>;
    type TBaseUnitId = specialize TReciprocalUnitId<BaseDenomU>;
    type TSelf = specialize TFactoredReciprocalUnitId<BaseDenomU, DenomU>;
    type TQuantity = specialize TFactoredReciprocalQuantity<BaseDenomU, DenomU>;
    type TDenomId = specialize TFactoredUnitId<BaseDenomU, DenomU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RECIP_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TRatioUnitId<NumeratorU, DenomU: TUnit> = record
    type U = specialize TRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TRatioUnitId<NumeratorU, DenomU>;
    type TQuantity = specialize TRatioQuantity<NumeratorU, DenomU>;
    type TNumeratorId = specialize TUnitId<NumeratorU>;
    type TDenomId = specialize TUnitId<DenomU>;
    type TSquareId = specialize TSquareUnitId<U>;
    type TSquareQuantity = specialize TSquareQuantity<U>;
    type TCubicId = specialize TCubicUnitId<U>;
    type TCubicQuantity = specialize TCubicQuantity<U>;
    type TQuarticId = specialize TQuarticUnitId<U>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$DEFINE SQUARABLE_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TUnitProductId<U1, U2: TUnit> = record
    type TSelf = specialize TUnitProductId<U1, U2>;
    type U = specialize TUnitProduct<U1, U2>;
    type TQuantity = specialize TQuantityProduct<U1, U2>;
    type TId1 = specialize TUnitId<U1>;
    type TId2 = specialize TUnitId<U2>;
    type TSquareId = specialize TSquareUnitId<U>;
    type TSquareQuantity = specialize TSquareQuantity<U>;
    type TCubicId = specialize TCubicUnitId<U>;
    type TCubicQuantity = specialize TCubicQuantity<U>;
    type TQuarticId = specialize TQuarticUnitId<U>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$DEFINE SQUARABLE_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredUnitProductId<BaseU1, BaseU2: TUnit; U1, U2: TFactoredUnit> = record
    type TSelf = specialize TFactoredUnitProductId<BaseU1, BaseU2, U1, U2>;
    type U = specialize TFactoredUnitProduct<U1, U2>;
    type TBaseQuantity = specialize TQuantityProduct<BaseU1, BaseU2>;
    type TBaseUnitId = specialize TUnitProductId<BaseU1, BaseU2>;
    type TQuantity = specialize TFactoredQuantityProduct<BaseU1, BaseU2, U1, U2>;
    type TId1 = specialize TFactoredUnitId<BaseU1, U1>;
    type TId2 = specialize TFactoredUnitId<BaseU2, U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TLeftFactoredUnitProductId<BaseU1, BaseU2: TUnit; U1: TFactoredUnit> = record
    type U2 = BaseU2;
    type TSelf = specialize TLeftFactoredUnitProductId<BaseU1, BaseU2, U1>;
    type U = specialize TLeftFactoredUnitProduct<U1, U2>;
    type TBaseQuantity = specialize TQuantityProduct<BaseU1, BaseU2>;
    type TBaseUnitId = specialize TUnitProductId<BaseU1, BaseU2>;
    type TQuantity = specialize TLeftFactoredQuantityProduct<BaseU1, BaseU2, U1>;
    type TId1 = specialize TFactoredUnitId<BaseU1, U1>;
    type TId2 = specialize TUnitId<U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TRightFactoredUnitProductId<BaseU1, BaseU2: TUnit; U2: TFactoredUnit> = record
    type U1 = BaseU1;
    type TSelf = specialize TRightFactoredUnitProductId<BaseU1, BaseU2, U2>;
    type U = specialize TRightFactoredUnitProduct<U1, U2>;
    type TBaseQuantity = specialize TQuantityProduct<BaseU1, BaseU2>;
    type TBaseUnitId = specialize TUnitProductId<BaseU1, BaseU2>;
    type TQuantity = specialize TRightFactoredQuantityProduct<BaseU1, BaseU2, U2>;
    type TId1 = specialize TUnitId<U1>;
    type TId2 = specialize TFactoredUnitId<BaseU2, U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredRatioUnitId<BaseNumeratorU, BaseDenomU: TUnit;
                                       NumeratorU, DenomU: TFactoredUnit> = record
    type TSelf = specialize TFactoredRatioUnitId
                 <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type U = specialize TFactoredRatioUnit<NumeratorU, DenomU>;
    type TQuantity = specialize TFactoredRatioQuantity
                     <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type TNumeratorId = specialize TFactoredUnitId<BaseNumeratorU, NumeratorU>;
    type TDenomId = specialize TFactoredUnitId<BaseDenomU, DenomU>;
    type TBaseQuantity = specialize TRatioQuantity<BaseNumeratorU, BaseDenomU>;
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseUnitId = specialize TUnitId<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredNumeratorUnitId<BaseNumeratorU, BaseDenomU: TUnit;
                                       NumeratorU: TFactoredUnit> = record
    type TSelf = specialize TFactoredNumeratorUnitId
                 <BaseNumeratorU, BaseDenomU, NumeratorU>;
    type DenomU = BaseDenomU;
    type U = specialize TFactoredNumeratorUnit<NumeratorU, DenomU>;
    type TQuantity = specialize TFactoredNumeratorQuantity
                     <BaseNumeratorU, BaseDenomU, NumeratorU>;
    type TNumeratorId = specialize TFactoredUnitId<BaseNumeratorU, NumeratorU>;
    type TDenomId = specialize TUnitId<DenomU>;
    type TBaseQuantity = specialize TRatioQuantity<BaseNumeratorU, BaseDenomU>;
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseUnitId = specialize TUnitId<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredDenominatorUnitId<BaseNumeratorU, BaseDenomU: TUnit;
                                       DenomU: TFactoredUnit> = record
    type TSelf = specialize TFactoredDenominatorUnitId
                 <BaseNumeratorU, BaseDenomU, DenomU>;
    type NumeratorU = BaseNumeratorU;
    type U = specialize TFactoredDenominatorUnit<NumeratorU, DenomU>;
    type TQuantity = specialize TFactoredDenominatorQuantity
                     <BaseNumeratorU, BaseDenomU, DenomU>;
    type TNumeratorId = specialize TUnitId<NumeratorU>;
    type TDenomId = specialize TFactoredUnitId<BaseDenomU, DenomU>;
    type TBaseQuantity = specialize TRatioQuantity<BaseNumeratorU, BaseDenomU>;
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseUnitId = specialize TUnitId<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

function GetPluralName(ASingularName: string): string;
function FormatValue(ANumber: double): string;
function FormatUnitName(AName: string; AQuantity: double): string;
function GetRatioSymbol(ANumSymbol, ADenomSymbol: string): string;
function GetRatioName(ANumName, ADenomName: string): string;
function GetProductSymbol(ALeftSymbol, ARightSymbol: string): string;
function GetProductName(ALeftName, ARightName: string): string;

{$UNDEF DIM}{$ENDIF}
{$IF defined(DEF_PROD) or defined(ALT_PROD)}
operator *(const {%H-}ALeft: LeftId; const {%H-}ARight: RightId): ProdId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const {%H-}ARight: RightId; const {%H-}ALeft: LeftId): ProdId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
{$IFDEF NO_DIV_LEFT}{$UNDEF NO_DIV_LEFT}{$ELSE}
operator /(const {%H-}AProd: ProdId; const {%H-}ALeft: LeftId): RightId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
{$ENDIF}
{$IFNDEF DEF_PROD}
operator /(const {%H-}AProd: ProdId; const {%H-}ARight: RightId): LeftId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
{$ENDIF}

operator *(const {%H-}ALeft: LeftQty; const {%H-}ARight: RightQty): ProdQty; inline;
{$IFDEF IMPL}begin result.Value := ALeft.Value * ARight.Value; end;{$ENDIF}
operator *(const {%H-}ARight: RightQty; const {%H-}ALeft: LeftQty): ProdQty; inline;
{$IFDEF IMPL}begin result.Value := ARight.Value * ALeft.Value; end;{$ENDIF}
operator /(const {%H-}AProd: ProdQty; const {%H-}ALeft: LeftQty): RightQty; inline;
{$IFDEF IMPL}begin result.Value := AProd.Value / ALeft.Value; end;{$ENDIF}
operator /(const {%H-}AProd: ProdQty; const {%H-}ARight: RightQty): LeftQty; inline;
{$IFDEF IMPL}begin result.Value := AProd.Value / ARight.Value; end;{$ENDIF}
{$UNDEF ALT_PROD}{$UNDEF DEF_PROD}{$ENDIF}

{$IF defined(DEF_RATIO) or defined(ALT_RATIO)}
operator /(const {%H-}ANum: NumId; const {%H-}ADenom: DenomId): RatioId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const ANum: NumQty; const ADenom: DenomQty): RatioQty; inline;
{$IFDEF IMPL}begin result.Value:= ANum.Value / ADenom.Value; end;{$ENDIF}
{$IFNDEF DEF_RATIO}
operator *(const {%H-}ARatio: RatioId; const {%H-}ADenom: DenomId): NumId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const ARatio: RatioQty; const ADenom: DenomQty): NumQty; inline;
{$IFDEF IMPL}begin result.Value:= ARatio.Value * ADenom.Value; end;{$ENDIF}
operator *(const {%H-}ADenom: DenomId; const {%H-}ARatio: RatioId): NumId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const ADenom: DenomQty; const ARatio: RatioQty): NumQty; inline;
{$IFDEF IMPL}begin result.Value:= ADenom.Value * ARatio.Value; end;{$ENDIF}
operator /(const {%H-}ANum: NumId; const {%H-}ARatio: RatioId): DenomId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const ANum: NumQty; const ARatio: RatioQty): DenomQty; inline;
{$IFDEF IMPL}begin result.Value:= ANum.Value / ARatio.Value; end;{$ENDIF}
{$ENDIF}
{$UNDEF ALT_RATIO}{$UNDEF DEF_RATIO}{$ENDIF}

{$IF defined(DEF_RECIP) or defined(ALT_RECIP)}
operator /(const {%H-}AValue: double; const {%H-}ADenom: DenomId): RecipId; inline;
{$IFDEF IMPL}begin if AValue <> 1 then raise Exception.Create('Factor must be 1') end;{$ENDIF}
operator /(const {%H-}AValue: double; const {%H-}ARecip: RecipId): DenomId; inline;
{$IFDEF IMPL}begin if AValue <> 1 then raise Exception.Create('Factor must be 1') end;{$ENDIF}

operator /(const AValue: double; const ADenom: DenomQty): RecipQty; inline;
{$IFDEF IMPL}begin result.Value := AValue / ADenom.Value; end;{$ENDIF}
operator /(const AValue: double; const ARecip: RecipQty): DenomQty; inline;
{$IFDEF IMPL}begin result.Value := AValue / ARecip.Value; end;{$ENDIF}
{$UNDEF ALT_RECIP}{$UNDEF DEF_RECIP}{$ENDIF}

{$IFNDEF DIM}{$DEFINE DIM}

{$DEFINE INTF}
{$i baseunits.inc}
{$i derivedunits.inc}
{$i specialunits.inc}
{$i specialderived.inc}
{$UNDEF INTF}

implementation uses Math;

{ TCustomUnit }

class function TCustomUnit.GetPowerSymbol(AExponent: integer): string;
begin
  result := Symbol + IntToStr(AExponent);

  case result of
  's-1': result := 'Hz';
  'ms-1': result := 'kHz';
  'us-1': result := 'MHz';
  'ns-1': result := 'GHz';
  'ps-1': result := 'THz';
  'rad2': result := 'sr';
  end;
end;

class function TCustomUnit.GetPowerName(AExponent: integer): string;
begin
  if AExponent < 0 then
  begin
    result := 'reciprocal ';
    AExponent := -AExponent;
  end
  else
    result := '';

  case AExponent of
  0: result += 'unit';
  1: result += Name;
  2: result += 'square ' + Name;
  3: result += 'cubic ' + Name;
  4: result += 'quartic ' + Name;
  else result += Name + ' to the ' + intToStr(AExponent)+'th';
  end;

  case result of
  'reciprocal second': result := 'hertz';
  'reciprocal millisecond': result := 'kilohertz';
  'reciprocal microsecond': result := 'megahertz';
  'reciprocal nanosecond': result := 'gigahertz';
  'reciprocal picosecond': result := 'terahertz';
  'square radian': result := 'steradian';
  end;
end;

{ TPowerUnit }

class function TPowerUnit.Symbol: string;
begin
  result := BaseU.GetPowerSymbol(Exponent);
end;

class function TPowerUnit.Name: string;
begin
  result := BaseU.GetPowerName(Exponent);
end;

{ TFactoredPowerUnit }

class function TFactoredPowerUnit.Symbol: string;
begin
  result := BaseU.GetPowerSymbol(Exponent);
end;

class function TFactoredPowerUnit.Name: string;
begin
  result := BaseU.GetPowerName(Exponent);
end;

class function TFactoredPowerUnit.Factor: double;
begin
  result := IntPower(BaseU.Factor, Exponent);
end;

{ TSquareUnit }

class function TSquareUnit.Exponent: integer;
begin
  result := 2;
end;

{ TCubicUnit }

class function TCubicUnit.Exponent: integer;
begin
  result := 3;
end;

{ TQuarticUnit }

class function TQuarticUnit.Exponent: integer;
begin
  result := 4;
end;

{ TRatioUnit }

class function TRatioUnit.Symbol: string;
begin
  result := GetRatioSymbol(NumeratorU.Symbol, DenomU.Symbol);
end;

class function TRatioUnit.Name: string;
begin
  result := GetRatioName(NumeratorU.Name, DenomU.Name);
end;

{ TUnitProduct }

class function TUnitProduct.Symbol: string;
begin
  result := GetProductSymbol(U1.Symbol, U2.Symbol);
end;

class function TUnitProduct.Name: string;
begin
  result := GetProductName(U1.Name, U2.Name);
end;

{ TReciprocalUnit }

class function TReciprocalUnit.Exponent: integer;
begin
  result := -1;
end;

{ TFactoredSquareUnit }

class function TFactoredSquareUnit.Exponent: integer;
begin
  result := 2;
end;

{ TFactoredCubicUnit }

class function TFactoredCubicUnit.Exponent: integer;
begin
  result := 3;
end;

{ TFactoredQuarticUnit }

class function TFactoredQuarticUnit.Exponent: integer;
begin
  result := 4;
end;

{ TFactoredReciprocalUnit }

class function TFactoredReciprocalUnit.Exponent: integer;
begin
  result := -1;
end;

{ TFactoredRatioUnit }

class function TFactoredRatioUnit.Symbol: string;
begin
  result := GetRatioSymbol(NumeratorU.Symbol, DenomU.Symbol);
end;

class function TFactoredRatioUnit.Name: string;
begin
  result := GetRatioName(NumeratorU.Name, DenomU.Name);
end;

class function TFactoredRatioUnit.Factor: double;
begin
  result := NumeratorU.Factor / DenomU.Factor;
end;

{ TFactoredNumeratorUnit }

class function TFactoredNumeratorUnit.Symbol: string;
begin
  result := GetRatioSymbol(NumeratorU.Symbol, DenomU.Symbol);
end;

class function TFactoredNumeratorUnit.Name: string;
begin
  result := GetRatioName(NumeratorU.Name, DenomU.Name);
end;

class function TFactoredNumeratorUnit.Factor: double;
begin
  result := NumeratorU.Factor;
end;

{ TFactoredDenominatorUnit }

class function TFactoredDenominatorUnit.Symbol: string;
begin
  result := GetRatioSymbol(NumeratorU.Symbol, DenomU.Symbol);
end;

class function TFactoredDenominatorUnit.Name: string;
begin
  result := GetRatioName(NumeratorU.Name, DenomU.Name);
end;

class function TFactoredDenominatorUnit.Factor: double;
begin
  result := 1 / DenomU.Factor;
end;

{ TFactoredUnitProduct }

class function TFactoredUnitProduct.Symbol: string;
begin
  result := GetProductSymbol(U1.Symbol, U2.Symbol);
end;

class function TFactoredUnitProduct.Name: string;
begin
  result := GetProductName(U1.Name, U2.Name);
end;

class function TFactoredUnitProduct.Factor: double;
begin
  result := U1.Factor * U2.Factor;
end;

{ TLeftFactoredUnitProduct }

class function TLeftFactoredUnitProduct.Symbol: string;
begin
  result := GetProductSymbol(U1.Symbol, U2.Symbol);
end;

class function TLeftFactoredUnitProduct.Name: string;
begin
  result := GetProductName(U1.Name, U2.Name);
end;

class function TLeftFactoredUnitProduct.Factor: double;
begin
  result := U1.Factor;
end;

{ TRightFactoredUnitProduct }

class function TRightFactoredUnitProduct.Symbol: string;
begin
  result := GetProductSymbol(U1.Symbol, U2.Symbol);
end;

class function TRightFactoredUnitProduct.Name: string;
begin
  result := GetProductName(U1.Name, U2.Name);
end;

class function TRightFactoredUnitProduct.Factor: double;
begin
  result := U2.Factor;
end;

{ Factored units }

{$UNDEF DIM}{$ENDIF} // simulating generic const parameters
{$IFDEF FACTORED_UNIT_IMPL}
  class function T_FACTORED_UNIT.Factor: double;
  begin
    result := V_FACTOR;
  end;

  class function T_FACTORED_UNIT.Symbol: string;
  begin
    result := V_SYMBOL + U.Symbol;

    case result of
    'Mg': result := 't';
    'Gg': result := 'kt';
    end;
  end;

  class function T_FACTORED_UNIT.Name: string;
  begin
    result := V_NAME + U.Name;

    case result of
    'megagram': result := 'ton';
    'gigagram': result := 'kiloton';
    end;
  end;
{$ENDIF}{$UNDEF FACTORED_UNIT_IMPL}
{$IFNDEF DIM}{$DEFINE DIM}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TTeraUnit}
{$DEFINE V_FACTOR:=1E12}{$DEFINE V_SYMBOL:='T'}{$DEFINE V_NAME:='tera'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TGigaUnit}
{$DEFINE V_FACTOR:=1E9}{$DEFINE V_SYMBOL:='G'}{$DEFINE V_NAME:='giga'}{$i dim.pas}

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

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TNanoUnit}
{$DEFINE V_FACTOR:=1E-9}{$DEFINE V_SYMBOL:='n'}{$DEFINE V_NAME:='nano'}{$i dim.pas}

{$DEFINE FACTORED_UNIT_IMPL}{$DEFINE T_FACTORED_UNIT:=TPicoUnit}
{$DEFINE V_FACTOR:=1E-12}{$DEFINE V_SYMBOL:='p'}{$DEFINE V_NAME:='pico'}{$i dim.pas}

{ Unit identifiers }

{$UNDEF DIM}{$ENDIF}// generic implementation of TUnitId
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
    result := U.Name;
  end;

  class function T_UNIT_ID.Symbol: string;
  begin
    result := U.Symbol;
  end;

  class function T_UNIT_ID.From(const AQuantity: TQuantity): TQuantity;
  begin
    result := AQuantity;
  end;
{$ENDIF}{$UNDEF UNIT_ID_IMPL}
{$IFDEF SQUARABLE_UNIT_ID_IMPL}
  class operator T_UNIT_ID.*(const TheUnit1, TheUnit2: TSelf): TSquareId;
  begin end;

  class operator T_UNIT_ID./(const TheSquareUnit: TSquareId;
                             const TheUnit: TSelf): TSelf;
  begin end;


  class operator T_UNIT_ID.*(const TheUnit: TSelf;
    const TheSquareUnit: TSquareId): TCubicId;
  begin end;

  class operator T_UNIT_ID.*(const TheSquareUnit: TSquareId;
    const TheUnit: TSelf): TCubicId;
  begin end;

  class operator T_UNIT_ID./(const TheCubicUnit: TCubicId;
                             const TheUnit: TSelf): TSquareId;
  begin end;


  class operator T_UNIT_ID.*(const TheCubicUnit: TCubicId;
    const TheUnit: TSelf): TQuarticId;
  begin end;

  class operator T_UNIT_ID.*(const TheUnit: TSelf;
    const TheCubicUnit: TCubicId): TQuarticId;
  begin end;

  class operator T_UNIT_ID./(const TheQuarticUnit: TQuarticId;
                             const TheUnit: TSelf): TCubicId;
  begin end;


  function T_UNIT_ID.Squared: TSquareId; begin end;
  function T_UNIT_ID.Cubed: TCubicId; begin end;
  function T_UNIT_ID.Quarted: TQuarticId; begin end;

  function T_UNIT_ID.SquareRoot(const ASquareQuantity: TSquareQuantity): TQuantity;
  begin
    result.Value := System.Sqrt(ASquareQuantity.Value);
  end;

  function T_UNIT_ID.CubicRoot(const ACubicQuantity: TCubicQuantity): TQuantity;
  begin
    result.Value := System.Exp(System.Ln(ACubicQuantity.Value) / 3);
  end;
{$ENDIF}{$UNDEF SQUARABLE_UNIT_ID_IMPL}
{$IFDEF FACTORED_UNIT_ID_IMPL}
  class function T_UNIT_ID.From(const AQuantity: TBaseQuantity): TQuantity;
  begin
    result.Assign(AQuantity);
  end;
  class function T_UNIT_ID.BaseUnit: TBaseUnitId;
  begin end;
  class function T_UNIT_ID.Factor: double;
  begin
    result := U.Factor;
  end;
{$ENDIF}{$UNDEF FACTORED_UNIT_ID_IMPL}
{$IFDEF RECIP_UNIT_ID_IMPL}
  class operator T_UNIT_ID.*(const TheUnit: TSelf; const TheDenom: TDenomId): double;
  begin result := 1; end;

  class function T_UNIT_ID.Inverse: TDenomId;
  begin end;
{$ENDIF}{$UNDEF RECIP_UNIT_ID_IMPL}
{$IFDEF RATIO_UNIT_ID_IMPL}
  class operator T_UNIT_ID.*(const TheUnit: TSelf; const TheDenom: TDenomId): TNumeratorId;
  begin end;
{$ENDIF}{$UNDEF RATIO_UNIT_ID_IMPL}
{$IFDEF UNIT_PROD_ID_IMPL}
  {class operator T_UNIT_ID./(const {%H-}TheUnit: TSelf; const {%H-}Unit1: TId1): TId2;
  begin end;}

  class operator T_UNIT_ID./(const {%H-}TheUnit: TSelf; const {%H-}Unit2: TId2): TId1;
  begin end;
{$ENDIF}{$UNDEF UNIT_PROD_ID_IMPL}
{$IFNDEF DIM}{$DEFINE DIM}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TQuarticUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TCubicUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TSquareUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE SQUARABLE_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TBasicUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE RECIP_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TReciprocalUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RECIP_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredReciprocalUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}{$DEFINE SQUARABLE_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TRatioUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}{$DEFINE SQUARABLE_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitProductId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredQuarticUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredCubicUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredSquareUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE SQUARABLE_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredRatioUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredNumeratorUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredDenominatorUnitId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredUnitProductId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TLeftFactoredUnitProductId}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TRightFactoredUnitProductId}{$i dim.pas}

{ Dimensioned quantities }

{$UNDEF DIM}{$ENDIF}{$IF defined(BASIC_QTY_IMPL) or defined(QTY_IMPL)}
  function T_QUANTITY.ToString: string;
  begin
    result := FormatValue(Value) + ' ' + U.Symbol;
  end;

  function T_QUANTITY.ToVerboseString: string;
  begin
    result := FormatValue(Value) + ' ' + FormatUnitName(U.Name, Value);
  end;

  function T_QUANTITY.Abs: TSelf;
  begin
    result.Value := System.Abs(Value);
  end;

  constructor T_QUANTITY.Assign(const AQuantity: TSelf);
  begin
    self := AQuantity;
  end;
{$ENDIF}{$UNDEF BASIC_QTY_IMPL}
{$IFDEF QTY_IMPL}
  class operator T_QUANTITY.+(const AQuantity1, AQuantity2: TSelf): TSelf;
  begin
    result.Value := AQuantity1.Value + AQuantity2.Value;
  end;

  class operator T_QUANTITY.-(const AQuantity1, AQuantity2: TSelf): TSelf;
  begin
    result.Value := AQuantity1.Value - AQuantity2.Value;
  end;

  class operator T_QUANTITY.*(const AFactor: double; const AQuantity: TSelf): TSelf;
  begin
    result.Value := AFactor * AQuantity.Value;
  end;

  class operator T_QUANTITY.*(const AQuantity: TSelf; const AFactor: double): TSelf;
  begin
    result.Value := AQuantity.Value * AFactor;
  end;

  class operator T_QUANTITY./(const AQuantity: TSelf; const AFactor: double): TSelf;
  begin
    result.Value := AQuantity.Value / AFactor;
  end;

  class operator T_QUANTITY./(const AQuantity1, AQuantity2: TSelf): double;
  begin
    result := AQuantity1.Value / AQuantity2.Value;
  end;

  class operator T_QUANTITY.mod(const AQuantity1, AQuantity2: TSelf): TSelf;
  begin
    result.Value := AQuantity1.Value mod AQuantity2.Value;
  end;

  class operator T_QUANTITY.<(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value < AQuantity2.Value;
  end;

  class operator T_QUANTITY.<=(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value <= AQuantity2.Value;
  end;

  class operator T_QUANTITY.=(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value = AQuantity2.Value;
  end;

  class operator T_QUANTITY.>(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value > AQuantity2.Value;
  end;

  class operator T_QUANTITY.>=(const AQuantity1, AQuantity2: TSelf): boolean;
  begin
    result := AQuantity1.Value >= AQuantity2.Value;
  end;

{$ENDIF}{$UNDEF QTY_IMPL}
{$IFDEF SQUARABLE_QTY_IMPL}
  class operator T_QUANTITY.*(const AQuantity1, AQuantity2: TSelf): TSquareQuantity;
  begin
    result.Value := AQuantity1.Value * AQuantity2.Value;
  end;

  class operator T_QUANTITY./(const ASquareQuantity: TSquareQuantity;
    const AQuantity: TSelf): TSelf;
  begin
    result.Value := ASquareQuantity.Value / AQuantity.Value;
  end;


  class operator T_QUANTITY.*(
  const ASquareQuantity: TSquareQuantity; const AQuantity: TSelf): TCubicQuantity;
  begin
    result.Value := ASquareQuantity.Value * AQuantity.Value;
  end;

  class operator T_QUANTITY.*(const AQuantity: TSelf;
  const ASquareQuantity: TSquareQuantity): TCubicQuantity;
  begin
    result.Value := AQuantity.Value * ASquareQuantity.Value;
  end;

  class operator T_QUANTITY./(const ACubicQuantity: TCubicQuantity;
    const AQuantity: TSelf): TSquareQuantity;
  begin
    result.Value := ACubicQuantity.Value / AQuantity.Value;
  end;


  class operator T_QUANTITY.*(const AQuantity: TSelf;
  const ACubicQuantity: TCubicQuantity): TQuarticQuantity;
  begin
    result.Value := AQuantity.Value * ACubicQuantity.Value;
  end;

  class operator T_QUANTITY.*(const ACubicQuantity: TCubicQuantity;
  const AQuantity: TSelf): TQuarticQuantity;
  begin
    result.Value := ACubicQuantity.Value * AQuantity.Value;
  end;

  class operator T_QUANTITY./(const AQuarticQuantity: TQuarticQuantity;
  const AQuantity: TSelf): TCubicQuantity;
  begin
    result.Value := AQuarticQuantity.Value / AQuantity.Value;
  end;


  function T_QUANTITY.Squared: TSquareQuantity;
  begin
    result.Value := sqr(self.Value);
  end;

  function T_QUANTITY.Cubed: TCubicQuantity;
  begin
    result.Value := sqr(self.Value) * self.Value;
  end;

  function T_QUANTITY.Quarted: TQuarticQuantity;
  begin
    result.Value := sqr(self.Value) * sqr(self.Value);
  end;

{$ENDIF}{$UNDEF SQUARABLE_QTY_IMPL}
{$IFDEF RECIP_QTY_IMPL}
  class operator T_QUANTITY./(
    const AValue: double; const ASelf: TSelf): TDenomQuantity;
  begin
    result.Value := AValue / ASelf.Value;
  end;

  class operator T_QUANTITY.*(const ASelf: TSelf;
    const ADenominator: TDenomQuantity): double;
  begin
    result := ASelf.Value * ADenominator.Value;
  end;

  class operator T_QUANTITY.*(
    const ADenominator: TDenomQuantity; const ASelf: TSelf): double;
  begin
    result := ADenominator.Value * ASelf.Value;
  end;
{$ENDIF}{$UNDEF RECIP_QTY_IMPL}
{$IFDEF RATIO_QTY_IMPL}
  class operator T_QUANTITY./(
    const ANumerator: TNumeratorQuantity; const ASelf: TSelf): TDenomQuantity;
  begin
    result.Value := ANumerator.Value / ASelf.Value;
  end;

  class operator T_QUANTITY.*(const ASelf: TSelf;
    const ADenominator: TDenomQuantity): TNumeratorQuantity;
  begin
    result.Value := ASelf.Value * ADenominator.Value;
  end;

  class operator T_QUANTITY.*(
    const ADenominator: TDenomQuantity; const ASelf: TSelf): TNumeratorQuantity;
  begin
    result.Value := ADenominator.Value * ASelf.Value;
  end;

  class operator T_QUANTITY.:=(const ARatio: TRatio): TSelf;
  begin
    result.Value := ARatio.Value;
  end;

  class operator T_QUANTITY.:=(const ASelf: TSelf): TRatio;
  begin
    result.Value := ASelf.Value;
  end;
  {$IFDEF FACTORED_QTY_IMPL}
  class operator T_QUANTITY.:=(const ASelf: TSelf): TBaseRatio;
  begin
    result.Value := ASelf.ToBase.Value;
  end;
  {$ENDIF}
{$ENDIF}{$UNDEF RATIO_QTY_IMPL}
{$IFDEF QTY_PROD_IMPL}
  {class operator T_QUANTITY./(
    const ASelf: TSelf; const AQuantity1: TQuantity1): TQuantity2;
  begin
    result.Value := ASelf.Value / AQuantity1.Value;
  end;}

  class operator T_QUANTITY./(
    const ASelf: TSelf; const AQuantity2: TQuantity2): TQuantity1;
  begin
    result.Value := ASelf.Value / AQuantity2.Value;
  end;

  class operator T_QUANTITY.:=(const AProduct: TProduct): TSelf;
  begin
    result.Value := AProduct.Value;
  end;

  class operator T_QUANTITY.:=(const ASelf: TSelf): TProduct;
  begin
    result.Value := ASelf.Value;
  end;
{$ENDIF}{$UNDEF QTY_PROD_IMPL}
{$IFDEF FACTORED_QTY_IMPL}
  function T_QUANTITY.ToBase: TBaseQuantity;
  begin
    result := self;
  end;

  constructor T_QUANTITY.Assign(const AQuantity: TBaseQuantity);
  begin
    self.Value := AQuantity.Value / U.Factor;
  end;

  class function T_QUANTITY.From(
    const AQuantity: TBaseQuantity): TSelf;
  begin
    result.Value := AQuantity.Value / U.Factor;
  end;

  class operator T_QUANTITY.:=(const AQuantity: TSelf): TBaseQuantity;
  begin
    result.Value := AQuantity.Value * U.Factor;
  end;
{$ENDIF}{$UNDEF FACTORED_QTY_IMPL}
{$IFNDEF DIM}{$DEFINE DIM}

{$DEFINE QTY_IMPL}
{$DEFINE T_QUANTITY:=TQuarticQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}
{$DEFINE T_QUANTITY:=TCubicQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}
{$DEFINE T_QUANTITY:=TSquareQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE SQUARABLE_QTY_IMPL}
{$DEFINE T_QUANTITY:=TQuantity}{$i dim.pas}

{$DEFINE BASIC_QTY_IMPL}
{$DEFINE T_QUANTITY:=TBasicQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE RECIP_QTY_IMPL}
{$DEFINE T_QUANTITY:=TReciprocalQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_QUANTITY:=TRatioQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_QUANTITY:=TQuantityProduct}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredQuarticQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredCubicQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredSquareQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE SQUARABLE_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RECIP_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredReciprocalQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredRatioQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredNumeratorQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_QUANTITY:=TFactoredDenominatorQuantity}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_QUANTITY:=TFactoredQuantityProduct}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_QUANTITY:=TLeftFactoredQuantityProduct}{$i dim.pas}

{$DEFINE QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_QUANTITY:=TRightFactoredQuantityProduct}{$i dim.pas}

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
  if abs(ANumber) < 1000000000 then
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
    if result[pos0-1] = '.' then dec(pos0);
    delete(result, pos0, posE-pos0);
  end;
end;

function FormatUnitName(AName: string; AQuantity: double): string;
begin
  if abs(AQuantity) >= 2 then
    result := GetPluralName(AName)
    else result := AName;
end;

function GetRatioSymbol(ANumSymbol, ADenomSymbol: string): string;
begin
  if ANumSymbol.EndsWith('/' + ADenomSymbol) then
    result := ANumSymbol + '2'
  else if ANumSymbol.EndsWith('/' + ADenomSymbol + '2') then
    result := copy(ANumSymbol, 1, length(ANumSymbol)-1) + '3'
  else
    result := ANumSymbol + '/' + ADenomSymbol;

  result := GetSpecialUnitSymbolFromFormula(result);
end;

function GetRatioName(ANumName, ADenomName: string): string;
begin
  if ANumName.EndsWith(' per ' + ADenomName) then
    result := ANumName + ' squared'
  else if ANumName.EndsWith(' per ' + ADenomName + ' squared') then
    result := copy(ANumName, 1, length(ANumName)-8) + ' cubed'
  else
    result := ANumName + ' per ' + ADenomName;

  result := GetSpecialUnitNameFromRecipee(result);
end;

function GetProductSymbol(ALeftSymbol, ARightSymbol: string): string;
begin
  result := ALeftSymbol + '.' + ARightSymbol;
  result := GetSpecialUnitSymbolFromFormula(result);
end;

function GetProductName(ALeftName, ARightName: string): string;
begin
  result := ALeftName + '-' + ARightName;
  result := GetSpecialUnitNameFromRecipee(result);
end;

{$DEFINE IMPL}
{$i baseunits.inc}
{$i derivedunits.inc}
{$i specialunits.inc}
{$i specialderived.inc}
{$UNDEF IMPL}

end.{$UNDEF DIM}{$ENDIF}
