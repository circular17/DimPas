{$IFNDEF DIM}{$DEFINE DIM}
unit Dim;

{$H+}{$modeSwitch advancedRecords}
{$WARN NO_RETVAL OFF}{$MACRO ON}

interface

uses SysUtils;

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

////////////////////////////////// BASE UNITS //////////////////////////////////

{ Units of time }

type
  TSecond = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TSecondId = specialize TUnitId<TSecond>;
  TSeconds = specialize TQuantity<TSecond>;

  TMilliseconds = specialize TFactoredQuantity
                             <TSecond, specialize TMilliUnit<TSecond>>;
  TMicroseconds = specialize TFactoredQuantity
                             <TSecond, specialize TMicroUnit<TSecond>>;
  TNanoseconds = specialize TFactoredQuantity
                            <TSecond, specialize TNanoUnit<TSecond>>;

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

operator:=(const {%H-}s2: TSquareSecondId): TSquareSecondFactorId;
operator:=(const ASquareTime: TSquareSeconds): TSquareSecondsFactor;
operator:=(const ASquareTime: TSquareSecondsFactor): TSquareSeconds;

{ Units of length }

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
  TSquareMillimeterFactorId = specialize TFactoredUnitId
                                      <TSquareMeter, TSquareMillimeter>;
  TSquareMillimeters = specialize TFactoredSquareQuantity<TMeter, TMillimeter>;
  TSquareMillimetersFactor = specialize TFactoredQuantity<TSquareMeter, TSquareMillimeter>;

  TCubicMillimeter = specialize TFactoredCubicUnit<TMillimeter>;
  TCubicMillimeterId = specialize TFactoredCubicUnitId<TMeter, TMillimeter>;
  TCubicMillimeterFactorId = specialize TFactoredUnitId
                                     <TCubicMeter, TCubicMillimeter>;
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

// combining units
operator /(const {%H-}m3: TCubicMeterId; const {%H-}m2: TSquareMeterId): TMeterId; inline;
operator /(const {%H-}m4: TQuarticMeterId; const {%H-}m3: TCubicMeterId): TMeterId; inline;
operator /(const {%H-}m4: TQuarticMeterId; const {%H-}m2: TSquareMeterId): TSquareMeterId; inline;

// combining quantities
operator /(const AVolume: TCubicMeters; const ASurface: TSquareMeters): TMeters; inline;
operator /(const AMomentOfArea: TQuarticMeters; const AVolume: TCubicMeters): TMeters; inline;
operator /(const AMomentOfArea: TQuarticMeters; const AArea: TSquareMeters): TSquareMeters; inline;

// dimension equivalence
operator:=(const AVolume: TLitres): TCubicMeters;
operator:=(const AVolume: TLitres): TCubicDecimeters;

operator:=(const {%H-}m2: TSquareMeterId): TSquareMeterFactorId;
operator:=(const ASurface: TSquareMeters): TSquareMetersFactor;
operator:=(const ASurface: TSquareMetersFactor): TSquareMeters;
operator:=(const {%H-}mm2: TSquareMillimeterId): TSquareMillimeterFactorId;
operator:=(const ASurface: TSquareMillimeters): TSquareMillimetersFactor;
operator:=(const ASurface: TSquareMillimetersFactor): TSquareMillimeters;

operator:=(const {%H-}m3: TCubicMeterId): TCubicMeterFactorId;
operator:=(const AVolume: TCubicMeters): TCubicMetersFactor;
operator:=(const AVolume: TCubicMetersFactor): TCubicMeters;
operator:=(const {%H-}mm3: TCubicMillimeterId): TCubicMillimeterFactorId;
operator:=(const AVolume: TCubicMillimeters): TCubicMillimetersFactor;
operator:=(const AVolume: TCubicMillimetersFactor): TCubicMillimeters;

operator:=(const {%H-}m4: TQuarticMeterId): TQuarticMeterFactorId;
operator:=(const AHyperVolume: TQuarticMeters): TQuarticMetersFactor;
operator:=(const AHyperVolume: TQuarticMetersFactor): TQuarticMeters;

{ Units of mass }

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

{ Units of amount of substance }

type
  TMole = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TMoleId = specialize TUnitId<TMole>;
  TMoles = specialize TQuantity<TMole>;

var
  mol: TMole;

{ Units of electric current }

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

{ Units of temperature }

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

operator :=(const ATemperature: TDegreesCelsius): TKelvins;
operator :=(const ATemperature: TDegreesFahrenheit): TDegreesCelsius;
operator :=(const ATemperature: TDegreesFahrenheit): TKelvins;
operator -(const ATemperature1, ATemperature2: TDegreesCelsius): TKelvins;
operator +(const ATemperature: TDegreesCelsius; const ADifference: TKelvins): TDegreesCelsius;
operator +(const ADifference: TKelvins; const ATemperature: TDegreesCelsius): TDegreesCelsius;

{ Units of luminous energy }

type
  TCandela = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TCandelaId = specialize TUnitId<TCandela>;
  TCandelas = specialize TQuantity<TCandela>;

var
  cd: TCandelaId;

/////////////////////// UNITS DERIVED FROM BASE UNITS ////////////////////////

{ Units of speed }

type
  TMeterPerSecond = specialize TRatioUnit<TMeter, TSecond>;
  TMeterPerSecondId = specialize TRatioUnitId<TMeter, TSecond>;
  TMetersPerSecond = specialize TRatioQuantity<TMeter, TSecond>;

  TMillimeterPerSecond = specialize TFactoredNumeratorUnit<TMilliMeter, TSecond>;
  TMillimeterPerSecondId = specialize TFactoredNumeratorUnitId
                                           <TMeter, TSecond, TMilliMeter>;
  TMillimetersPerSecond = specialize TFactoredNumeratorQuantity
                                   <TMeter, TSecond, TMilliMeter>;

  TKilometerPerHour = specialize TFactoredRatioUnit<TKilometer, THour>;
  TKilometerPerHourId = specialize TFactoredRatioUnitId
                                           <TMeter, TSecond, TKilometer, THour>;
  TKilometersPerHour = specialize TFactoredRatioQuantity
                                  <TMeter, TSecond, TKilometer, THour>;

// combining units
operator /(const {%H-}m: TMeterId; const {%H-}s: TSecondId): TMeterPerSecondId; inline;
operator /(const {%H-}mm: TMillimeterId; const {%H-}s: TSecondId): TMillimeterPerSecondId; inline;
operator /(const {%H-}km: TKilometerId; const {%H-}h: THourId): TKilometerPerHourId; inline;

// combining quantities
operator /(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond; inline;
operator /(const ALength: TMillimeters; const ADuration: TSeconds): TMillimetersPerSecond; inline;
operator /(const ALength: TKilometers; const ADuration: THours): TKilometersPerHour; inline;

{ Units of acceleration }

type
  TMeterPerSecondSquared = specialize TRatioUnit<TMeterPerSecond, TSecond>;
  TMeterPerSecondSquaredId = specialize TRatioUnitId<TMeterPerSecond, TSecond>;
  TMetersPerSecondSquared = specialize TRatioQuantity<TMeterPerSecond, TSecond>;

  TKilometerPerHourPerSecondId = specialize TFactoredNumeratorUnitId
                                                    <TMeterPerSecond, TSecond, TKilometerPerHour>;
  TKilometersPerHourPerSecond = specialize TFactoredNumeratorQuantity
                                           <TMeterPerSecond, TSecond, TKilometerPerHour>;

// combining units
operator /(const {%H-}m_s: TMeterPerSecondId; const {%H-}s: TSecondId): TMeterPerSecondSquaredId; inline;
operator /(const {%H-}m: TMeterId; const {%H-}s2: TSquareSecondId): TMeterPerSecondSquaredId; inline;
operator /(const {%H-}km_h: TKilometerPerHourId; const {%H-}s: TSecondId): TKilometerPerHourPerSecondId; inline;

// combining quantities
operator /(const ASpeed: TMetersPerSecond; const ATime: TSeconds): TMetersPerSecondSquared; inline;
operator /(const ALength: TMeters; const ASquareTime: TSquareSeconds): TMetersPerSecondSquared; inline;
operator /(const ASpeed: TKilometersPerHour; const ATime: TSeconds): TKilometersPerHourPerSecond; inline;

{ Mechanical derived units }

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

// combining units
operator /(const {%H-}g: TGramId; const {%H-}m3: TCubicMeterId): TGramPerCubicMeterId; inline;
operator /(const {%H-}g: TGramId; const {%H-}mm3: TCubicMillimeterId): TGramPerCubicMillimeterId; inline;

operator /(const {%H-}kg: TKilogramId; const {%H-}m3: TCubicMeterId): TKilogramPerCubicMeterId; inline;
operator /(const {%H-}kg: TKilogramId; const {%H-}mm3: TCubicMillimeterId): TKilogramPerCubicMillimeterId; inline;

// combining quantities
operator /(const AMass: TGrams; const AVolume: TCubicMeters): TGramsPerCubicMeter; inline;
operator /(const AMass: TGrams; const AVolume: TCubicMillimeters): TGramsPerCubicMillimeter; inline;

operator /(const AMass: TKilograms; const AVolume: TCubicMeters): TKilogramsPerCubicMeter; inline;
operator /(const AMass: TKilograms; const AVolume: TCubicMillimeters): TKilogramsPerCubicMillimeter; inline;

//////////////////////////////// SPECIAL UNITS /////////////////////////////////

{ Special units }
type
  THertzId = specialize TReciprocalUnitId<TSecond>;
  THertz = specialize TReciprocalQuantity<TSecond>;

  TKilohertz = specialize TFactoredReciprocalQuantity
                          <TSecond, specialize TMilliUnit<TSecond>>;
  TMegahertz = specialize TFactoredReciprocalQuantity
                          <TSecond, specialize TMicroUnit<TSecond>>;
  TGigahertz = specialize TFactoredReciprocalQuantity
                          <TSecond, specialize TNanoUnit<TSecond>>;
  TTerahertz = specialize TFactoredReciprocalQuantity
                          <TSecond, specialize TPicoUnit<TSecond>>;

  TRadian = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TRadianId = specialize TUnitId<TRadian>;
  TRadians = specialize TQuantity<TRadian>;
  TSteradian = specialize TSquareUnit<TRadian>;
  TSteradianId = specialize TSquareUnitId<TRadian>;
  TSteradianFactorId = specialize TUnitId<TSteradian>;
  TSteradians = specialize TSquareQuantity<TRadian>;
  TSteradiansFactor = specialize TQuantity<TSteradian>;

  { TRadianHelper }

  TRadianHelper = record helper for TRadianId
    function ArcCos(AValue: double): TRadians;
    function ArcSin(AValue: double): TRadians;
    function ArcTan(AValue: double): TRadians;
    function ArcTan2(y, x: double): TRadians;
  end;

  { TRadiansHelper }

  TRadiansHelper = record helper for TRadians
    function Cos: double;
    function Sin: double;
    function Tan: double;
    function Cotan: double;
    function Secant: double;
    function Cosecant: double;
  end;

  TDegree = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TDegreeId = specialize TFactoredUnitId<TRadian, TDegree>;
  TDegrees = specialize TFactoredQuantity<TRadian, TDegree>;
  TSquareDegreeId = specialize TFactoredSquareUnitId<TRadian, TDegree>;
  TSquareDegrees = specialize TFactoredSquareQuantity<TRadian, TDegree>;

  { TDegreeHelper }

  TDegreeHelper = record helper for TDegreeId
    function ArcCos(AValue: double): TDegrees;
    function ArcSin(AValue: double): TDegrees;
    function ArcTan(AValue: double): TDegrees;
    function ArcTan2(y, x: double): TDegrees;
  end;

  { TDegreesHelper }

  TDegreesHelper = record helper for TDegrees
    function Cos: double;
    function Sin: double;
    function Tan: double;
    function Cotan: double;
    function Secant: double;
    function Cosecant: double;
  end;

  TGramMeterId = specialize TUnitProductId<TGram, TMeter>;
  TGramMeters = specialize TQuantityProduct<TGram, TMeter>;
  TKilogramMeterId = specialize TLeftFactoredUnitProductId
                                        <TGram, TMeter, TKilogram>;
  TKilogramMeters = specialize TLeftFactoredQuantityProduct
                           <TGram, TMeter, TKilogram>;

  // the kg is also a base unit for special units in SI
  TBaseKilogram = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TBaseKilograms = specialize TQuantity<TBaseKilogram>;

type
  TNewton = specialize TUnitProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtonId = specialize TUnitProductId<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtons = specialize TQuantityProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TMillinewton = specialize TMilliUnit<TNewton>;
  TMillinewtonId = specialize TFactoredUnitId<TNewton, TMillinewton>;
  TMillinewtons = specialize TFactoredQuantity<TNewton, TMillinewton>;
  TKilonewton = specialize TKiloUnit<TNewton>;
  TKilonewtonId = specialize TFactoredUnitId<TNewton, TKilonewton>;
  TKilonewtons = specialize TFactoredQuantity<TNewton, TKilonewton>;

  TPascal = specialize TRatioUnit<TNewton, TSquareMeter>;
  TPascalId = specialize TRatioUnitId<TNewton, TSquareMeter>;
  TPascals = specialize TRatioQuantity<TNewton, TSquareMeter>;

  TKilopascal = specialize TFactoredNumeratorUnit<TKilonewton, TSquareMeter>;
  TKilopascalId = specialize TFactoredNumeratorUnitId<TNewton, TSquareMeter, TKilonewton>;
  TKilopascals = specialize TFactoredNumeratorQuantity<TNewton, TSquareMeter, TKilonewton>;

  TMegapascal = specialize TFactoredDenominatorUnit<TNewton, TSquareMillimeter>;
  TMegapascalId = specialize TFactoredDenominatorUnitId<TNewton, TSquareMeter, TSquareMillimeter>;
  TMegapascals = specialize TFactoredDenominatorQuantity<TNewton, TSquareMeter, TSquareMillimeter>;

  TJoule = specialize TUnitProduct<TNewton, TMeter>;
  TJouleId = specialize TUnitProductId<TNewton, TMeter>;
  TJoules = specialize TQuantityProduct<TNewton, TMeter>;

  TWatt = specialize TRatioUnit<TJoule, TSecond>;
  TWattId = specialize TRatioUnitId<TJoule, TSecond>;
  TWatts = specialize TRatioQuantity<TJoule, TSecond>;

  TCoulomb = specialize TUnitProduct<TAmpere, TSecond>;
  TCoulombId = specialize TUnitProductId<TAmpere, TSecond>;
  TCoulombs = specialize TQuantityProduct<TAmpere, TSecond>;

  TSquareCoulomb = specialize TSquareUnit<TCoulomb>;
  TSquareCoulombId = specialize TSquareUnitId<TCoulomb>;
  TSquareCoulombFactorId = specialize TUnitId<TSquareCoulomb>;
  TSquareCoulombs = specialize TSquareQuantity<TCoulomb>;
  TSquareCoulombsFactor = specialize TQuantity<TSquareCoulomb>;

  TVolt = specialize TRatioUnit<TJoule, TCoulomb>;
  TVoltId = specialize TRatioUnitId<TJoule, TCoulomb>;
  TVolts = specialize TRatioQuantity<TJoule, TCoulomb>;

  TSquareVolt = specialize TSquareUnit<TVolt>;
  TSquareVoltId = specialize TSquareUnitId<TVolt>;
  TSquareVolts = specialize TSquareQuantity<TVolt>;

  TFarad = specialize TRatioUnit<TCoulomb, TVolt>;
  TFaradId = specialize TRatioUnitId<TCoulomb, TVolt>;
  TFarads = specialize TRatioQuantity<TCoulomb, TVolt>;

  TMillifarads = specialize TFactoredQuantity
                            <TFarad, specialize TMilliUnit<TFarad>>;
  TMicrofarads = specialize TFactoredQuantity
                            <TFarad, specialize TMicroUnit<TFarad>>;
  TNanofarads = specialize TFactoredQuantity
                           <TFarad, specialize TNanoUnit<TFarad>>;
  TPicofarads = specialize TFactoredQuantity
                           <TFarad, specialize TPicoUnit<TFarad>>;

  TOhm = specialize TRatioUnit<TVolt, TAmpere>;
  TOhmId = specialize TRatioUnitId<TVolt, TAmpere>;
  TOhms = specialize TRatioQuantity<TVolt, TAmpere>;

  TSiemensId = specialize TRatioUnitId<TAmpere, TVolt>;
  TSiemens = specialize TRatioQuantity<TAmpere, TVolt>;

  TWeber = specialize TUnitProduct<TVolt, TSecond>;
  TWeberId = specialize TUnitProductId<TVolt, TSecond>;
  TWebers = specialize TQuantityProduct<TVolt, TSecond>;

  TTesla = specialize TRatioUnit<TWeber, TSquareMeter>;
  TTeslaId = specialize TRatioUnitId<TWeber, TSquareMeter>;
  TTeslas = specialize TRatioQuantity<TWeber, TSquareMeter>;

  THenry = specialize TRatioUnit<TWeber, TAmpere>;
  THenryId = specialize TRatioUnitId<TWeber, TAmpere>;
  THenrys = specialize TRatioQuantity<TWeber, TAmpere>;

  TLumen = specialize TUnitProduct<TCandela, TSteradian>;
  TLumenIdentifer = specialize TUnitProductId<TCandela, TSteradian>;
  TLumens = specialize TQuantityProduct<TCandela, TSteradian>;

  TLuxId = specialize TRatioUnitId<TLumen, TSquareMeter>;
  TLuxQuantity = specialize TRatioQuantity<TLumen, TSquareMeter>;

  TBecquerel = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TBecquerelId = specialize TUnitId<TBecquerel>;
  TBecquerels = specialize TQuantity<TBecquerel>;

  { TBecquerelHelper }

  TBecquerelHelper = record helper for TBecquerelId
    function From(const AFrequency: THertz): TBecquerels;
    function Inverse: TSecond;
  end;

  TKilobecquerel = specialize TKiloUnit<TBecquerel>;
  TKilobecquerelId = specialize TFactoredUnitId<TBecquerel, TKilobecquerel>;
  TKilobecquerels = specialize TFactoredQuantity<TBecquerel, TKilobecquerel>;

  TMegabecquerel = specialize TMegaUnit<TBecquerel>;
  TMegabecquerelId = specialize TFactoredUnitId<TBecquerel, TMegabecquerel>;
  TMegabecquerels = specialize TFactoredQuantity<TBecquerel, TMegabecquerel>;

  TCurie = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TCurieId = specialize TFactoredUnitId<TBecquerel, TCurie>;
  TCuries = specialize TFactoredQuantity<TBecquerel, TCurie>;

  TSquareMeterPerSquareSecond = specialize TRatioUnit<TSquareMeter, TSquareSecond>;
  TSquareMeterPerSquareSecondId = specialize TRatioUnitId<TSquareMeter, TSquareSecond>;
  TSquareMetersPerSquareSecond = specialize TRatioQuantity<TSquareMeter, TSquareSecond>;

  TGrayId = specialize TRatioUnitId<TJoule, TBaseKilogram>;
  TGrays = specialize TRatioQuantity<TJoule, TBaseKilogram>;

  { TGrayHelper }

  TGrayHelper = record helper for TGrayId
    function From(const ASquareSpeed: TSquareMetersPerSquareSecond): TGrays;
  end;

  TSievert = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TSievertId = specialize TUnitId<TSievert>;
  TSieverts = specialize TQuantity<TSievert>;

  { TSievertHelper }

  TSievertHelper = record helper for TSievertId
    function From(const ASquareSpeed: TSquareMetersPerSquareSecond): TSieverts;
  end;

  TKatalId = specialize TRatioUnitId<TMole, TSecond>;
  TKatals = specialize TRatioQuantity<TMole, TSecond>;

var
  Hz: THertzId;
  kHz: specialize TFactoredReciprocalUnitId<TSecond, specialize TMilliUnit<TSecond>>;
  MHz: specialize TFactoredReciprocalUnitId<TSecond, specialize TMicroUnit<TSecond>>;
  GHz: specialize TFactoredReciprocalUnitId<TSecond, specialize TNanoUnit<TSecond>>;
  THz: specialize TFactoredReciprocalUnitId<TSecond, specialize TPicoUnit<TSecond>>;
  rad: TRadianId;
  sr: TSteradianId;
  deg: TDegreeId;
  deg2: TSquareDegrees;
  N: TNewtonId;
  kN: TKilonewtonId;
  Pa: TPascalId;
  kPa: TKilopascalId;
  MPa: TMegapascalId;
  J: TJouleId;
  C: TCoulombId;
  C2: TSquareCoulombId;
  lm: TLumenIdentifer;
  lx: TLuxId;
  Gy: TGrayId;
  Sv: TSievertId;
  kat: TKatalId;
  W: TWattId;
  V: TVoltId;
  V2: TSquareVoltId;
  F: TFaradId;
  mF: specialize TFactoredUnitId<TFarad, specialize TMilliUnit<TFarad>>;
  uF: specialize TFactoredUnitId<TFarad, specialize TMicroUnit<TFarad>>;
  nF: specialize TFactoredUnitId<TFarad, specialize TNanoUnit<TFarad>>;
  pF: specialize TFactoredUnitId<TFarad, specialize TPicoUnit<TFarad>>;
  ohm: TOhmId;
  siemens, mho: TSiemensId;
  Wb: TWeberId;
  T: TTeslaId;
  henry: THenryId;
  Bq: TBecquerelId;
  kBq: TKilobecquerel;
  MBq: TMegabecquerel;
  Ci: TCurieId;

// dimension equivalence
operator:=(const AWeight: TKilograms): TBaseKilograms;
operator:=(const AWeight: TGrams): TBaseKilograms;
operator:=(const AWeight: TBaseKilograms): TKilograms;
operator:=(const AWeight: TBaseKilograms): TGrams;

operator:=(const AEquivalentDose: TSieverts): TSquareMetersPerSquareSecond;
operator:=(const AAbsorbedDose: TGrays): TSquareMetersPerSquareSecond;

operator:=(const ARadioactivity: TBecquerels): THertz;

operator:=(const {%H-}sr: TSteradianId): TSteradianFactorId;
operator:=(const ASolidAngle: TSteradians): TSteradiansFactor;
operator:=(const ASolidAngle: TSteradiansFactor): TSteradians;

operator:=(const {%H-}C2: TSquareCoulombId): TSquareCoulombFactorId;
operator:=(const ASquareCharge: TSquareCoulombs): TSquareCoulombsFactor;
operator:=(const ASquareCharge: TSquareCoulombsFactor): TSquareCoulombs;

// combining units
operator /(const {%H-}m_s: TMeterPerSecondId; const {%H-}m: TMeterId): THertzId; inline;
operator /(const {%H-}mm_s: TMillimeterPerSecondId; const {%H-}mm: TMillimeterId): THertzId; inline;

operator *(const {%H-}g: TGramId; const {%H-}m: TMeterId): TGramMeterId; inline;
operator *(const {%H-}kg: TKilogramId; const {%H-}m: TMeterId): TKilogramMeterId; inline;

operator *(const {%H-}g: TGramId; const {%H-}m_s2: TMeterPerSecondSquaredId): TMillinewtonId; inline;
operator *(const {%H-}m_s2: TMeterPerSecondSquaredId; const {%H-}g: TGramId): TMillinewtonId; inline;
operator /(const {%H-}mN: TMillinewtonId; const {%H-}g: TGramMeterId): TMeterPerSecondSquaredId; inline;

operator *(const {%H-}kg: TKilogramId; const {%H-}m_s2: TMeterPerSecondSquaredId): TNewtonId; inline;
operator *(const {%H-}g: TGramMeterId; const {%H-}m_s2: TMeterPerSecondSquaredId): TMillinewtonId;
operator *(const {%H-}m_s2: TMeterPerSecondSquaredId; const {%H-}kg: TKilogramId): TNewtonId; inline;
operator *(const {%H-}m_s2: TMeterPerSecondSquaredId; const {%H-}g: TGramMeterId): TMillinewtonId; inline;
operator /(const {%H-}N: TNewtonId; const {%H-}kg: TKilogramId): TMeterPerSecondSquaredId; inline;

operator /(const {%H-}N: TNewtonId; const {%H-}m2: TSquareMeterId): TPascalId; inline;
operator /(const {%H-}N: TNewtonId; const {%H-}mm2: TSquareMillimeterId): TMegapascalId; inline;
operator /(const {%H-}kN: TKilonewtonId; const {%H-}m2: TSquareMeterId): TKilopascalId; inline;

operator *(const {%H-}N: TNewtonId; const {%H-}m: TMeterId): TJouleId; inline;
operator *(const {%H-}m: TMeterId; const {%H-}N: TNewtonId): TJouleId; inline;
operator /(const {%H-}J: TJouleId; const {%H-}N: TNewtonId): TMeterId; inline;

operator /(const {%H-}J: TJouleId; const {%H-}s: TSecondId): TWattId; inline;

// definition A2 = W / Ω
operator /(const {%H-}W: TWattId; const {%H-}Ohm: TOhmId): TSquareAmpereId; inline;
operator /(const {%H-}W: TWattId; const {%H-}A2: TSquareAmpereId): TOhmId; inline;
operator *(const {%H-}A2: TSquareAmpereId; const {%H-}Ohm: TOhmId): TWattId; inline;
operator *(const {%H-}Ohm: TOhmId; const {%H-}A2: TSquareAmpereId): TWattId; inline;

operator /(const {%H-}J: TJouleId; const {%H-}C: TCoulombId): TVoltId; inline;
// alternative definition of V = W / A
operator /(const {%H-}W: TWattId; const {%H-}A: TAmpereId): TVoltId; inline;
operator /(const {%H-}W: TWattId; const {%H-}V: TVoltId): TAmpereId; inline;
operator *(const {%H-}A: TAmpereId; const {%H-}V: TVoltId): TWattId; inline;
operator *(const {%H-}V: TVoltId; const {%H-}A: TAmpereId): TWattId; inline;

// definition of V2 = W * Ω
operator *(const {%H-}W: TWattId; const {%H-}Ohm: TOhmId): TSquareVoltId; inline;
operator *(const {%H-}Ohm: TOhmId; const {%H-}W: TWattId): TSquareVoltId; inline;
operator /(const {%H-}V2: TSquareVoltId; const {%H-}W: TWattId): TOhmId; inline;
operator /(const {%H-}V2: TSquareVoltId; const {%H-}Ohm: TOhmId): TWattId; inline;

operator /(const {%H-}C: TCoulombId; const {%H-}V: TVoltId): TFaradId; inline;
// alternative definition of F = C2 / J
operator /(const {%H-}C2: TSquareCoulombId; const {%H-}J: TJouleId): TFaradId; inline;
operator /(const {%H-}C2: TSquareCoulombId; const {%H-}F: TFaradId): TJouleId; inline;
operator *(const {%H-}J: TJouleId; const {%H-}F: TFaradId): TSquareCoulombId; inline;
operator *(const {%H-}F: TFaradId; const {%H-}J: TJouleId): TSquareCoulombId; inline;

operator *(const {%H-}A: TAmpereId; const {%H-}s: TSecondId): TCoulombId; inline;
operator *(const {%H-}s: TSecondId; const {%H-}A: TAmpereId): TCoulombId; inline;
operator /(const {%H-}C: TCoulombId; const {%H-}A: TAmpereId): TSecondId; inline;

operator /(const {%H-}V: TVoltId; const {%H-}A: TAmpereId): TOhmId; inline;
// alternative definition of Ω = s / F
operator /(const {%H-}s: TSecondId; const {%H-}F: TFaradId): TOhmId; inline;
operator /(const {%H-}s: TSecondId; const {%H-}Ohm: TOhmId): TFaradId; inline;
operator *(const {%H-}F: TFaradId; const {%H-}Ohm: TOhmId): TSecondId; inline;
operator *(const {%H-}Ohm: TOhmId; const {%H-}F: TFaradId): TSecondId; inline;

operator /(const {%H-}A: TAmpereId; const {%H-}V: TVoltId): TSiemensId; inline;
// alternative definition of S = 1 / Ω
operator /(const {%H-}AValue: double; const {%H-}Ohm: TOhmId): TSiemensId; inline;
operator /(const {%H-}AValue: double; const {%H-}S: TSiemensId): TOhmId; inline;

operator *(const {%H-}V: TVoltId; const {%H-}s: TSecondId): TWeberId; inline;
operator *(const {%H-}s: TSecondId; const {%H-}V: TVoltId): TWeberId; inline;
operator /(const {%H-}Wb: TWeberId; const {%H-}V: TVoltId): TSecondId; inline;

operator /(const {%H-}Wb: TWeberId; const {%H-}m2: TSquareMeterId): TTeslaId; inline;

operator /(const {%H-}Wb: TWeberId; const {%H-}A: TAmpereId): THenryId; inline;

operator *(const {%H-}cd: TCandelaId; const {%H-}sr: TSteradianId): TLumenIdentifer; inline;
operator *(const {%H-}sr: TSteradianId; const {%H-}cd: TCandelaId): TLumenIdentifer; inline;
operator /(const {%H-}lm: TLumenIdentifer; const {%H-}cd: TCandelaId): TSteradianId; inline;

operator /(const {%H-}lm: TLumenIdentifer; const {%H-}m2: TSquareMeterId): TLuxId; inline;

operator /(const {%H-}J: TJouleId; const {%H-}kg: TKilogramId): TGrayId; inline;

operator /(const {%H-}m2: TSquareMeterId; const {%H-}s2: TSquareSecondId): TSquareMeterPerSquareSecondId; inline;

// alternative definition of m2_s2 = J / kg
operator *(const {%H-}kg: TKilogramId; const {%H-}m2_s2: TSquareMeterPerSquareSecondId): TJouleId; inline;
operator *(const {%H-}m2_s2: TSquareMeterPerSquareSecondId; const {%H-}kg: TKilogramId): TJouleId; inline;
operator /(const {%H-}J: TJouleId; const {%H-}m2_s2: TSquareMeterPerSquareSecondId): TKilogramId; inline;

// alternative definition m2_s2 = m/s * m/s
operator *(const {%H-}m_s: TMeterPerSecondId; const {%H-}m_s_: TMeterPerSecondId): TSquareMeterPerSquareSecondId; inline;
operator /(const {%H-}m2_s2: TSquareMeterPerSquareSecondId; const {%H-}m_s: TMeterPerSecondId): TMeterPerSecondId; inline;

operator /(const {%H-}mol: TMoleId; const {%H-}s: TSecondId): TKatalId; inline;

// combining quantities
operator /(const AValue: double; const ADuration: TSeconds): THertz; inline;

operator /(const AValue: double; const ARadioactivity: TBecquerels): TSeconds;
operator *(const ARadioactivity: TBecquerels; const ADenominator: TSeconds): double;
operator *(const ADenominator: TSeconds; const ARadioactivity: TBecquerels): double;

operator /(const ASpeed: TMetersPerSecond; const ALength: TMeters): THertz; inline;
operator /(const ASpeed: TMillimetersPerSecond; const ALength: TMillimeters): THertz; inline;

operator *(const AWeight: TGrams; const ALength: TMeters): TGramMeters; inline;
operator *(const AWeight: TKilograms; const ALength: TMeters): TKilogramMeters; inline;

operator *(const AWeight: TGrams; const AAcceleration: TMetersPerSecondSquared): TMillinewtons; inline;
operator *(const AAcceleration: TMetersPerSecondSquared; const AWeight: TGrams): TMillinewtons; inline;
operator /(const AForce: TMillinewtons; const AWeight: TGrams): TMetersPerSecondSquared; inline;

operator *(const AWeight: TKilograms; const AAcceleration: TMetersPerSecondSquared): TNewtons; inline;
operator *(const AAcceleration: TMetersPerSecondSquared; const AWeight: TKilograms): TNewtons; inline;
operator /(const AForce: TNewtons; const AWeight: TKilograms): TMetersPerSecondSquared; inline;

operator /(const AForce: TNewtons; const AArea: TSquareMeters): TPascals; inline;
operator /(const AForce: TNewtons; const AArea: TSquareMillimeters): TMegapascals; inline;
operator /(const AForce: TKilonewtons; const AArea: TSquareMeters): TKilopascals; inline;
operator /(const AForce: TKilonewtons; const AArea: TSquareMillimeters): TMegapascals; inline;

operator *(const AForce: TNewtons; const ALength: TMeters): TJoules; inline;
operator *(const ALength: TMeters; const AForce: TNewtons): TJoules; inline;
operator /(const AWork: TJoules; const AForce: TNewtons): TMeters; inline;

operator /(const AWork: TJoules; const ATime: TSeconds): TWatts; inline;

// definition A2 = W / Ω
operator /(const APower: TWatts; const AResistance: TOhms): TSquareAmperes; inline;
operator /(const APower: TWatts; const ASquareCurrent: TSquareAmperes): TOhms; inline;
operator *(const ASquareCurrent: TSquareAmperes; const AResistance: TOhms): TWatts; inline;
operator *(const AResistance: TOhms; const ASquareCurrent: TSquareAmperes): TWatts; inline;

operator /(const AWork: TJoules; const ACharge: TCoulombs): TVolts; inline;
// alternative definition of V = W / A
operator /(const APower: TWatts; const ACurrent: TAmperes): TVolts; inline;
operator /(const APower: TWatts; const AVoltage: TVolts): TAmperes; inline;
operator *(const ACurrent: TAmperes; const AVoltage: TVolts): TWatts; inline;
operator *(const AVoltage: TVolts; const ACurrent: TAmperes): TWatts; inline;

// definition of V2 = W * Ω
operator *(const APower: TWatts; const AResistance: TOhms): TSquareVolts; inline;
operator *(const AResistance: TOhms; const APower: TWatts): TSquareVolts; inline;
operator /(const ASquareVoltage: TSquareVolts; const APower: TWatts): TOhms; inline;
operator /(const ASquareVoltage: TSquareVolts; const AResistance: TOhms): TWatts; inline;

operator /(const ACharge: TCoulombs; const AVoltage: TVolts): TFarads; inline;
// alternative definition of F = C2 / J
operator /(const ASquareCharge: TSquareCoulombs; const AWork: TJoules): TFarads; inline;
operator /(const ASquareCharge: TSquareCoulombs; const ACapacitance: TFarads): TJoules; inline;
operator *(const AWork: TJoules; const ACapacitance: TFarads): TSquareCoulombs; inline;
operator *(const ACapacitance: TFarads; const AWork: TJoules): TSquareCoulombs; inline;

operator *(const ACurrent: TAmperes; const ADuration: TSeconds): TCoulombs; inline;
operator *(const ADuration: TSeconds; const ACurrent: TAmperes): TCoulombs; inline;
operator /(const ACharge: TCoulombs; const ACurrent: TAmperes): TSeconds; inline;

operator /(const AVoltage: TVolts; const ACurrent: TAmperes): TOhms; inline;
// alternative definition of Ω = s / F
operator /(const ATime: TSeconds; const ACapacitance: TFarads): TOhms; inline;
operator /(const ATime: TSeconds; const AImpedance: TOhms): TFarads; inline;
operator *(const ACapacitance: TFarads; const AImpedance: TOhms): TSeconds; inline;
operator *(const AImpedance: TOhms; const ACapacitance: TFarads): TSeconds; inline;

operator /(const ACurrent: TAmperes; const AVoltage: TVolts): TSiemens; inline;
// alternative definition of S = 1 / Ω
operator /(const AValue: double; const AResistance: TOhms): TSiemens; inline;
operator /(const AValue: double; const AElectricalConductance: TSiemens): TOhms; inline;

operator *(const AVoltage: TVolts; const ATime: TSeconds): TWebers; inline;
operator *(const ATime: TSeconds; const AVoltage: TVolts): TWebers; inline;
operator /(const AMagneticFlux: TWebers; const AVoltage: TVolts): TSeconds; inline;

operator /(const AMagneticFlux: TWebers; const AArea: TSquareMeters): TTeslas; inline;

operator /(const AMagneticFlux: TWebers; const ACurrent: TAmperes): THenrys; inline;

operator *(const ALuminousIntensity: TCandelas; const ASolidAngle: TSteradians): TLumens; inline;
operator *(const ASolidAngle: TSteradians; const ALuminousIntensity: TCandelas): TLumens; inline;
operator /(const ALuminousFlux: TLumens; const ALuminousIntensity: TCandelas): TSteradians; inline;

operator /(const ALuminousFlux: TLumens; const AArea: TSquareMeters): TLuxQuantity; inline;

operator /(const AEnergy: TJoules; const AMass: TKilograms): TGrays; inline;

operator /(const AArea: TSquareMeters; const ASquareTime: TSquareSeconds): TSquareMetersPerSquareSecond; inline;

// alternative definition of m2/s2 = J / kg
operator *(const AMass: TKilograms; const ASquareSpeed: TSquareMetersPerSquareSecond): TJoules; inline;
operator *(const ASquareSpeed: TSquareMetersPerSquareSecond; const AMass: TKilograms): TJoules; inline;
operator /(const AWork: TJoules; const ASquareSpeed: TSquareMetersPerSquareSecond): TKilograms; inline;

// alternative definition m2/s2 = m/s * m/s
operator *(const ASpeed1: TMetersPerSecond; const ASpeed2: TMetersPerSecond): TSquareMetersPerSquareSecond; inline;
operator /(const ASquareSpeed: TSquareMetersPerSquareSecond; const ASpeed: TMetersPerSecond): TMetersPerSecond; inline;

operator /(const AAmountOfSustance: TMoles; const ATime: TSeconds): TKatals; inline;

////////////////////// UNITS DERIVED FROM SPECIAL UNITS ////////////////////////

{ Units of speed }

type
  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondId = specialize TRatioUnitId<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioQuantity<TRadian, TSecond>;

// combining units
operator /(const {%H-}rad: TRadianId; const {%H-}s: TSecondId): TRadianPerSecondId; inline;

// combining quantities
operator /(const AAngle: TRadians; const ADuration: TSeconds): TRadiansPerSecond; inline;

{ Units of acceleration }

type
  TRadianPerSecondSquaredId = specialize TRatioUnitId<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioQuantity<TRadianPerSecond, TSecond>;

// combining units
operator /(const {%H-}rad_s: TRadianPerSecondId; const {%H-}s: TSecondId): TRadianPerSecondSquaredId; inline;
operator /(const {%H-}rad: TRadianId; const {%H-}s2: TSquareSecondId): TRadianPerSecondSquaredId; inline;

// combining quantities
operator /(const ASpeed: TRadiansPerSecond; const ATime: TSeconds): TRadiansPerSecondSquared; inline;
operator /(const AAngle: TRadians; const ASquareTime: TSquareSeconds): TRadiansPerSecondSquared; inline;

{ Mechanical derived units }

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

  TKilogramPerSecond = specialize TRatioUnit<TBaseKilogram, TSecond>;
  TKilogramPerSecondId = specialize TRatioUnitId<TBaseKilogram, TSecond>;
  TKilogramsPerSecond = specialize TRatioQuantity<TBaseKilogram, TSecond>;

// combining units
operator /(const {%H-}N: TNewtonId; const {%H-}m: TMeterId): TNewtonPerMeterId; inline;
operator /(const {%H-}N: TNewtonId; const {%H-}mm: TMillimeterId): TNewtonPerMillimeterId; inline;

operator *(const {%H-}Pa: TPascalId; const {%H-}m: TMeterId): TNewtonPerMeterId; inline;
operator *(const {%H-}m: TMeterId; const {%H-}Pa: TPascalId): TNewtonPerMeterId; inline;
operator *(const {%H-}MPa: TMegapascalId; const {%H-}mm: TMillimeterId): TNewtonPerMillimeterId; inline;
operator *(const {%H-}mm: TMillimeterId; const {%H-}MPa: TMegapascalId): TNewtonPerMillimeterId; inline;

operator /(const {%H-}N: TNewtonId; const {%H-}m3: TCubicMeterId): TNewtonPerCubicMeterId; inline;

// alternative definition N/m3 = kg/m3 * m/s2
operator *(const {%H-}kg_m3: TKilogramPerCubicMeterId; const {%H-}m_s2: TMeterPerSecondSquaredId): TNewtonPerCubicMeterId; inline;
operator *(const {%H-}m_s2: TMeterPerSecondSquaredId; const {%H-}kg_m3: TKilogramPerCubicMeterId): TNewtonPerCubicMeterId; inline;
operator /(const {%H-}N_m3: TNewtonPerCubicMeterId; const {%H-}kg_m3: TKilogramPerCubicMeterId): TMeterPerSecondSquaredId; inline;
operator /(const {%H-}N_m3: TNewtonPerCubicMeterId; const {%H-}m_s2: TMeterPerSecondSquaredId): TKilogramPerCubicMeterId; inline;

operator *(const {%H-}Pa: TPascalId; const {%H-}s: TSecondId): TPascalSecondId; inline;
operator *(const {%H-}s: TSecondId; const {%H-}Pa: TPascalId): TPascalSecondId; inline;
operator /(const {%H-}Pas: TPascalSecondId; const {%H-}Pa: TPascalId): TSecondId; inline;

operator /(const {%H-}kg: TKilogramId; const {%H-}s: TSecondId): TKilogramPerSecondId; inline;

// alternative definition kg/s = Pa*s * m
operator *(const {%H-}Pas: TPascalSecondId; const {%H-}m: TMeterId): TKilogramPerSecondId; inline;
operator *(const {%H-}m: TMeterId; const {%H-}Pas: TPascalSecondId): TKilogramPerSecondId; inline;
operator /(const {%H-}kg_s: TKilogramPerSecondId; const {%H-}Pas: TPascalSecondId): TMeterId; inline;
operator /(const {%H-}kg_s: TKilogramPerSecondId; const {%H-}m: TMeterId): TPascalSecondId; inline;

// alternative definition kg/s = N / m/s
operator /(const {%H-}N: TNewtonId; const {%H-}m_s: TMeterPerSecondId): TKilogramPerSecondId; inline;
operator *(const {%H-}m_s: TMeterPerSecondId; const {%H-}kg_s: TKilogramPerSecondId): TNewtonId; inline;
operator *(const {%H-}kg_s: TKilogramPerSecondId; const {%H-}m_s: TMeterPerSecondId): TNewtonId; inline;
operator /(const {%H-}N: TNewtonId; const {%H-}kg_s: TKilogramPerSecondId): TMeterPerSecondId; inline;

// combining quantities
operator /(const AForce: TNewtons; const ALength: TMeters): TNewtonsPerMeter; inline;
operator /(const AForce: TNewtons; const ALength: TMillimeters): TNewtonsPerMillimeter; inline;

operator *(const APressure: TPascals; const ALength: TMeters): TNewtonsPerMeter; inline;
operator *(const ALength: TMeters; const APressure: TPascals): TNewtonsPerMeter; inline;
operator *(const APressure: TMegapascals; const ALength: TMillimeters): TNewtonsPerMillimeter; inline;
operator *(const ALength: TMillimeters; const APressure: TMegapascals): TNewtonsPerMillimeter; inline;

operator /(const AForce: TNewtons; const AVolume: TCubicMeters): TNewtonsPerCubicMeter; inline;

// alternative definition N/m3 = kg/m3 * m/s2
operator *(const ADensity: TKilogramsPerCubicMeter; const AAcceleration: TMetersPerSecondSquared): TNewtonsPerCubicMeter; inline;
operator *(const AAcceleration: TMetersPerSecondSquared; const ADensity: TKilogramsPerCubicMeter): TNewtonsPerCubicMeter; inline;
operator /(const ASpecificWeight: TNewtonsPerCubicMeter; const ADensity: TKilogramsPerCubicMeter): TMetersPerSecondSquared; inline;
operator /(const ASpecificWeight: TNewtonsPerCubicMeter; const AAcceleration: TMetersPerSecondSquared): TKilogramsPerCubicMeter; inline;

operator *(const APressure: TPascals; const ATime: TSeconds): TPascalsSecond; inline;
operator *(const ATime: TSeconds; const APressure: TPascals): TPascalsSecond; inline;
operator /(const ADynViscosity: TPascalsSecond; const APressure: TPascals): TSeconds; inline;

operator /(const AMass: TKilograms; const ATime: TSeconds): TKilogramsPerSecond; inline;

// alternative definition kg/s = Pa*s * m
operator *(const ADynViscosity: TPascalsSecond; const ALength: TMeters): TKilogramsPerSecond; inline;
operator *(const ALength: TMeters; const ADynViscosity: TPascalsSecond): TKilogramsPerSecond; inline;
operator /(const AMassFlux: TKilogramsPerSecond; const ADynViscosity: TPascalsSecond): TMeters; inline;
operator /(const AMassFlux: TKilogramsPerSecond; const ALength: TMeters): TPascalsSecond; inline;

// alternative definition kg/s = N / m/s
operator /(const AForce: TNewtons; const ASpeed: TMetersPerSecond): TKilogramsPerSecond; inline;
operator *(const ASpeed: TMetersPerSecond; const AMassFlux: TKilogramsPerSecond): TNewtons; inline;
operator *(const AMassFlux: TKilogramsPerSecond; const ASpeed: TMetersPerSecond): TNewtons; inline;
operator /(const AForce: TNewtons; const AMassFlux: TKilogramsPerSecond): TMetersPerSecond; inline;

{ Formatting }

function GetPluralName(ASingularName: string): string;
function FormatValue(ANumber: double): string;
function FormatUnitName(AName: string; AQuantity: double): string;
function GetRatioSymbol(ANumSymbol, ADenomSymbol: string): string;
function GetRatioName(ANumName, ADenomName: string): string;
function GetProductSymbol(ALeftSymbol, ARightSymbol: string): string;
function GetProductName(ALeftName, ARightName: string): string;

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

  case result of
  'lm/m2': result := 'lx';
  'mol/s': result := 'kat';
  'N/m2': result := 'Pa';
  'kN/m2': result := 'kPa';
  'N/mm2': result := 'MPa';
  'J/s': result := 'W';
  'J/C': result := 'V';
  'W/A': result := 'V';
  'C2/J': result := 'F';
  'C/V': result := 'F';
  'V/A': result := 'Ω';
  's/F': result := 'Ω';
  'Wb/m2': result := 'T';
  'Wb/A': result := 'H';
  'A/V': result := 'S';
  'J/kg': result := 'Gy';
  end;
end;

function GetRatioName(ANumName, ADenomName: string): string;
begin
  if ANumName.EndsWith(' per ' + ADenomName) then
    result := ANumName + ' squared'
  else if ANumName.EndsWith(' per ' + ADenomName + ' squared') then
    result := copy(ANumName, 1, length(ANumName)-8) + ' cubed'
  else
    result := ANumName + ' per ' + ADenomName;

  case result of
  'lumen per square meter': result := 'lux';
  'mole per second': result := 'katal';
  'newton per square meter': result := 'pascal';
  'kilonewton per square meter': result := 'kilopascal';
  'newton per square millimeter': result := 'megapascal';
  'joule per second': result := 'watt';
  'joule per coulomb': result := 'volt';
  'watt per ampere': result := 'volt';
  'square coulomb per joule': result:= 'farad';
  'coulomb per volt': result:= 'farad';
  'volt per ampere': result:= 'ohm';
  'second per farad': result:= 'ohm';
  'weber per square meter': result:= 'tesla';
  'weber per ampere': result:= 'henry';
  'ampere per volt': result:= 'siemens';
  'joule per kilogram': result := 'gray';
  end;
end;

function GetProductSymbol(ALeftSymbol, ARightSymbol: string): string;
begin
  result := ALeftSymbol + '.' + ARightSymbol;

  case result of
  's.A', 'A.s': result := 'C';
  'kg.m/s2': result := 'N';
  'N.m': result := 'J';
  'cd.sr': result := 'lm';
  'V.s': result := 'Wb';
  end;
end;

function GetProductName(ALeftName, ARightName: string): string;
begin
  result := ALeftName + '-' + ARightName;

  case result of
  'ampere-second', 'second-ampere': result := 'coulomb';
  'kilogram-meter per second squared': result := 'newton';
  'newton-meter': result := 'joule';
  'candela-steradian': result := 'lumen';
  'volt-second': result := 'weber';
  end;
end;

{ TBecquerelHelper }

function TBecquerelHelper.From(const AFrequency: THertz): TBecquerels;
begin
  result.Value := AFrequency.Value;
end;

function TBecquerelHelper.Inverse: TSecond;
begin end;

{ TGrayHelper }

function TGrayHelper.From(const ASquareSpeed: TSquareMetersPerSquareSecond): TGrays;
begin
  result.Value := ASquareSpeed.Value;
end;

{ TSievertHelper }

function TSievertHelper.From(const ASquareSpeed: TSquareMetersPerSquareSecond): TSieverts;
begin
  result.Value := ASquareSpeed.Value;
end;

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
    result := 'reciprocal '
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

{$UNDEF DIM}{$ENDIF}
// simulating generic const parameters
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
    end;
  end;

  class function T_FACTORED_UNIT.Name: string;
  begin
    result := V_NAME + U.Name;

    case result of
    'megagram': result := 'ton';
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

{$UNDEF DIM}{$ENDIF}
// generic implementation of TUnitId
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

{$UNDEF DIM}{$ENDIF}
{$IF defined(BASIC_QTY_IMPL) or defined(QTY_IMPL)}
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

class function TLitre.Symbol: string; begin result := 'L'; end;
class function TLitre.Name: string;   begin result := 'litre'; end;

operator:=(const s2: TSquareSecondId): TSquareSecondFactorId;
begin end;

operator:=(const ASquareTime: TSquareSeconds): TSquareSecondsFactor;
begin
  result.Value := ASquareTime.Value;
end;

operator:=(const ASquareTime: TSquareSecondsFactor): TSquareSeconds;
begin
  result.Value := ASquareTime.Value;
end;

operator /(const {%H-}m3: TCubicMeterId; const {%H-}m2: TSquareMeterId): TMeterId;
begin end;

operator /(const {%H-}m4: TQuarticMeterId; const {%H-}m3: TCubicMeterId): TMeterId;
begin end;

operator /(const {%H-}m4: TQuarticMeterId; const {%H-}m2: TSquareMeterId): TSquareMeterId;
begin end;

operator /(const AVolume: TCubicMeters; const ASurface: TSquareMeters): TMeters;
begin
  result.Value := AVolume.Value / ASurface.Value;
end;

operator /(const AMomentOfArea: TQuarticMeters; const AVolume: TCubicMeters): TMeters;
begin
  result.Value := AMomentOfArea.Value / AVolume.Value;
end;

operator /(const AMomentOfArea: TQuarticMeters; const AArea: TSquareMeters): TSquareMeters;
begin
  result.Value := AMomentOfArea.Value / AArea.Value;
end;

operator:=(const AVolume: TLitres): TCubicMeters;
begin
  result.Value := AVolume.Value * 0.001;
end;

operator:=(const AVolume: TLitres): TCubicDecimeters;
begin
  result.Value := AVolume.Value;
end;

operator:=(const m2: TSquareMeterId): TSquareMeterFactorId;
begin end;

operator:=(const ASurface: TSquareMeters): TSquareMetersFactor;
begin
  result.Value := ASurface.Value;
end;

operator:=(const mm2: TSquareMillimeterId): TSquareMillimeterFactorId;
begin end;

operator:=(const ASurface: TSquareMillimeters): TSquareMillimetersFactor;
begin
  result.Value := ASurface.Value;
end;

operator:=(const m3: TCubicMeterId): TCubicMeterFactorId;
begin end;

operator:=(const AVolume: TCubicMeters): TCubicMetersFactor;
begin
  result.Value := AVolume.Value;
end;

operator:=(const mm3: TCubicMillimeterId): TCubicMillimeterFactorId;
begin end;

operator:=(const AVolume: TCubicMillimeters): TCubicMillimetersFactor;
begin
  result.Value := AVolume.Value;
end;

operator:=(const m4: TQuarticMeterId): TQuarticMeterFactorId;
begin end;

operator:=(const AHyperVolume: TQuarticMeters): TQuarticMetersFactor;
begin
  result.Value := AHyperVolume.Value;
end;

operator:=(const ASurface: TSquareMetersFactor): TSquareMeters;
begin
  result.Value := ASurface.Value;
end;

operator:=(const ASurface: TSquareMillimetersFactor): TSquareMillimeters;
begin
  result.Value := ASurface.Value;
end;

operator:=(const AVolume: TCubicMetersFactor): TCubicMeters;
begin
  result.Value := AVolume.Value;
end;

operator:=(const AVolume: TCubicMillimetersFactor): TCubicMillimeters;
begin
  result.Value := AVolume.Value;
end;

operator:=(const AHyperVolume: TQuarticMetersFactor): TQuarticMeters;
begin
  result.Value := AHyperVolume.Value;
end;

function TLitreHelper.From(const AVolume: TCubicMeters): TLitres;
begin
  result.Value := AVolume.Value * 1000;
end;

function TLitreHelper.From(const AVolume: TCubicDecimeters): TLitres;
begin
  result.Value := AVolume.Value;
end;

class function TGram.Symbol: string; begin result := 'g'; end;
class function TGram.Name: string;   begin result := 'gram'; end;

class function TBaseKilogram.Symbol: string; begin result := 'kg'; end;
class function TBaseKilogram.Name: string;   begin result := 'kilogram'; end;

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

class function TDegreeCelsiusIdHelper.From(const ATemperature: TKelvins): TDegreesCelsius;
begin
  result.Value := ATemperature.Value - 273.15;
end;

operator:=(const ATemperature: TDegreesFahrenheit): TDegreesCelsius;
begin
  result.Value := (ATemperature.Value - 32)/1.8;
end;

class function TDegreeFahrenheitIdHelper.From(
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
operator /(const {%H-}m: TMeterId; const {%H-}s: TSecondId): TMeterPerSecondId;
begin end;

operator /(const mm: TMillimeterId; const s: TSecondId): TMillimeterPerSecondId;
begin end;

operator /(const {%H-}km: TKilometerId; const {%H-}h: THourId): TKilometerPerHourId;
begin end;

operator *(const m_s: TMeterPerSecondId; const m_s_: TMeterPerSecondId): TSquareMeterPerSquareSecondId;
begin end;

operator /(const m2_s2: TSquareMeterPerSquareSecondId; const m_s: TMeterPerSecondId): TMeterPerSecondId;
begin end;

// combining quantities
operator/(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond;
begin
  result.Value:= ALength.Value / ADuration.Value;
end;

operator /(const ALength: TMillimeters; const ADuration: TSeconds): TMillimetersPerSecond;
begin
  result.Value:= ALength.Value / ADuration.Value;
end;

operator/(const ALength: TKilometers; const ADuration: THours): TKilometersPerHour;
begin
  result.Value:= ALength.Value / ADuration.Value;
end;

operator *(const ASpeed1: TMetersPerSecond; const ASpeed2: TMetersPerSecond): TSquareMetersPerSquareSecond;
begin
  result.Value := ASpeed1.Value * ASpeed2.Value;
end;

operator /(const ASquareSpeed: TSquareMetersPerSquareSecond; const ASpeed: TMetersPerSecond): TMetersPerSecond;
begin
  result.Value := ASquareSpeed.Value / ASpeed.Value;
end;

{ Units of acceleration }

// combining units
operator /(const {%H-}m_s: TMeterPerSecondId; const {%H-}s: TSecondId): TMeterPerSecondSquaredId;
begin end;

operator /(const {%H-}m: TMeterId; const {%H-}s2: TSquareSecondId): TMeterPerSecondSquaredId;
begin end;

operator/(const km_h: TKilometerPerHourId; const s: TSecondId): TKilometerPerHourPerSecondId;
begin end;

// combining quantities
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

{ TRadianHelper }

function TRadianHelper.ArcCos(AValue: double): TRadians;
begin
  result.Value := Math.ArcCos(AValue);
end;

function TRadianHelper.ArcSin(AValue: double): TRadians;
begin
  result.Value := Math.ArcSin(AValue);
end;

function TRadianHelper.ArcTan(AValue: double): TRadians;
begin
  result.Value := System.ArcTan(AValue);
end;

function TRadianHelper.ArcTan2(y, x: double): TRadians;
begin
  result.Value := Math.ArcTan2(y, x);
end;

{ TRadiansHelper }

function TRadiansHelper.Cos: double;
begin
  result := System.Cos(Value);
end;

function TRadiansHelper.Sin: double;
begin
  result := System.Sin(Value);
end;

function TRadiansHelper.Tan: double;
begin
  result := Math.Tan(Value);
end;

function TRadiansHelper.Cotan: double;
begin
  result := Math.Cotan(Value);
end;

function TRadiansHelper.Secant: double;
begin
  result := Math.Secant(Value);
end;

function TRadiansHelper.Cosecant: double;
begin
  result := Math.Cosecant(Value);
end;

class function TDegree.Factor: double; begin result := Pi/180; end;
class function TDegree.Symbol: string; begin result := 'º'; end;
class function TDegree.Name: string;   begin result := 'degree'; end;

{ TDegreeHelper }

function TDegreeHelper.ArcCos(AValue: double): TDegrees;
begin
  result.Assign(rad.ArcCos(AValue));
end;

function TDegreeHelper.ArcSin(AValue: double): TDegrees;
begin
  result.Assign(rad.ArcSin(AValue));
end;

function TDegreeHelper.ArcTan(AValue: double): TDegrees;
begin
  result.Assign(rad.ArcTan(AValue));
end;

function TDegreeHelper.ArcTan2(y, x: double): TDegrees;
begin
  result.Assign(rad.ArcTan2(y, x));
end;

{ TDegreesHelper }

function TDegreesHelper.Cos: double;
begin
  result := ToBase.Cos;
end;

function TDegreesHelper.Sin: double;
begin
  result := ToBase.Sin;
end;

function TDegreesHelper.Tan: double;
begin
  result := ToBase.Tan;
end;

function TDegreesHelper.Cotan: double;
begin
  result := ToBase.Cotan;
end;

function TDegreesHelper.Secant: double;
begin
  result := ToBase.Secant;
end;

function TDegreesHelper.Cosecant: double;
begin
  result := ToBase.Cosecant;
end;

class function TSievert.Symbol: string; begin result := 'Sv'; end;
class function TSievert.Name: string;   begin result := 'sievert'; end;

class function TBecquerel.Symbol: string; begin result := 'Bq'; end;
class function TBecquerel.Name: string;   begin result := 'becquerel'; end;

class function TCurie.Symbol: string; begin result := 'Ci'; end;
class function TCurie.Name: string;   begin result := 'curie'; end;
class function TCurie.Factor: double; begin result := 37e9; end;

// dimension equivalence
operator:=(const AWeight: TKilograms): TBaseKilograms;
begin
  result.Value := AWeight.Value;
end;

operator:=(const AWeight: TGrams): TBaseKilograms;
begin
  result.Value := AWeight.Value * 0.001;
end;

operator:=(const AWeight: TBaseKilograms): TKilograms;
begin
  result.Value := AWeight.Value;
end;

operator:=(const AWeight: TBaseKilograms): TGrams;
begin
  result.Value := AWeight.Value * 1000;
end;

operator:=(const AEquivalentDose: TSieverts): TSquareMetersPerSquareSecond;
begin
  result.Value := AEquivalentDose.Value;
end;

operator:=(const AAbsorbedDose: TGrays): TSquareMetersPerSquareSecond;
begin
  result.Value := AAbsorbedDose.Value;
end;

operator:=(const ARadioactivity: TBecquerels): THertz;
begin
  result.Value := ARadioactivity.Value;
end;

// combining units
operator/(const rad: TRadianId; const s: TSecondId): TRadianPerSecondId;
begin end;

operator/(const rad_s: TRadianPerSecondId; const s: TSecondId): TRadianPerSecondSquaredId;
begin end;

operator/(const rad: TRadianId; const s2: TSquareSecondId): TRadianPerSecondSquaredId;
begin end;

operator:=(const sr: TSteradianId): TSteradianFactorId;
begin end;

operator:=(const ASolidAngle: TSteradians): TSteradiansFactor;
begin
  result.Value := ASolidAngle.Value;
end;

operator:=(const ASolidAngle: TSteradiansFactor): TSteradians;
begin
  result.Value := ASolidAngle.Value;
end;

operator:=(const C2: TSquareCoulombId): TSquareCoulombFactorId;
begin end;

operator:=(const ASquareCharge: TSquareCoulombs): TSquareCoulombsFactor;
begin
  result.Value := ASquareCharge.Value;
end;

operator:=(const ASquareCharge: TSquareCoulombsFactor): TSquareCoulombs;
begin
  result.Value := ASquareCharge.Value;
end;

operator /(const m_s: TMeterPerSecondId; const m: TMeterId): THertzId;
begin end;

operator /(const mm_s: TMillimeterPerSecondId; const mm: TMillimeterId): THertzId;
begin end;

operator*(const g: TGramId; const m: TMeterId): TGramMeterId;
begin end;

operator*(const kg: TKilogramId; const m: TMeterId): TKilogramMeterId;
begin end;

operator*(const g: TGramId; const m_s2: TMeterPerSecondSquaredId): TMillinewtonId;
begin end;

operator *(const m_s2: TMeterPerSecondSquaredId; const g: TGramId): TMillinewtonId;
begin end;

operator /(const mN: TMillinewtonId; const g: TGramMeterId): TMeterPerSecondSquaredId;
begin end;

operator*(const kg: TKilogramId; const m_s2: TMeterPerSecondSquaredId): TNewtonId;
begin end;

operator*(const g: TGramMeterId; const m_s2: TMeterPerSecondSquaredId): TMillinewtonId;
begin end;

operator *(const m_s2: TMeterPerSecondSquaredId; const kg: TKilogramId): TNewtonId;
begin end;

operator*(const m_s2: TMeterPerSecondSquaredId; const g: TGramMeterId): TMillinewtonId;
begin end;

operator /(const N: TNewtonId; const kg: TKilogramId): TMeterPerSecondSquaredId;
begin end;

operator /(const N: TNewtonId; const m2: TSquareMeterId): TPascalId;
begin end;

operator /(const N: TNewtonId; const mm2: TSquareMillimeterId): TMegapascalId;
begin end;

operator/(const kN: TKilonewtonId; const m2: TSquareMeterId): TKilopascalId;
begin end;

operator /(const N: TNewtonId; const m: TMeterId): TNewtonPerMeterId;
begin end;

operator /(const N: TNewtonId; const mm: TMillimeterId): TNewtonPerMillimeterId;
begin end;

operator *(const Pa: TPascalId; const m: TMeterId): TNewtonPerMeterId;
begin end;

operator *(const m: TMeterId; const Pa: TPascalId): TNewtonPerMeterId;
begin end;

operator *(const MPa: TMegapascalId; const mm: TMillimeterId): TNewtonPerMillimeterId;
begin end;

operator *(const mm: TMillimeterId; const MPa: TMegapascalId): TNewtonPerMillimeterId;
begin end;

operator /(const N: TNewtonId; const m3: TCubicMeterId): TNewtonPerCubicMeterId;
begin end;

operator *(const kg_m3: TKilogramPerCubicMeterId; const m_s2: TMeterPerSecondSquaredId): TNewtonPerCubicMeterId;
begin end;

operator *(const m_s2: TMeterPerSecondSquaredId; const kg_m3: TKilogramPerCubicMeterId): TNewtonPerCubicMeterId;
begin end;

operator /(const N_m3: TNewtonPerCubicMeterId; const kg_m3: TKilogramPerCubicMeterId): TMeterPerSecondSquaredId;
begin end;

operator /(const N_m3: TNewtonPerCubicMeterId; const m_s2: TMeterPerSecondSquaredId): TKilogramPerCubicMeterId;
begin end;

operator *(const Pa: TPascalId; const s: TSecondId): TPascalSecondId;
begin end;

operator *(const s: TSecondId; const Pa: TPascalId): TPascalSecondId;
begin end;

operator /(const Pas: TPascalSecondId; const Pa: TPascalId): TSecondId;
begin end;

operator /(const kg: TKilogramId; const s: TSecondId): TKilogramPerSecondId;
begin end;

operator *(const Pas: TPascalSecondId; const m: TMeterId): TKilogramPerSecondId;
begin end;

operator *(const m: TMeterId; const Pas: TPascalSecondId): TKilogramPerSecondId;
begin end;

operator /(const kg_s: TKilogramPerSecondId; const Pas: TPascalSecondId): TMeterId;
begin end;

operator /(const kg_s: TKilogramPerSecondId; const m: TMeterId): TPascalSecondId;
begin end;

operator /(const N: TNewtonId; const m_s: TMeterPerSecondId): TKilogramPerSecondId;
begin end;

operator *(const m_s: TMeterPerSecondId; const kg_s: TKilogramPerSecondId): TNewtonId;
begin end;

operator *(const kg_s: TKilogramPerSecondId; const m_s: TMeterPerSecondId): TNewtonId;
begin end;

operator /(const N: TNewtonId; const kg_s: TKilogramPerSecondId): TMeterPerSecondId;
begin end;

operator *(const N: TNewtonId; const m: TMeterId): TJouleId;
begin end;

operator *(const m: TMeterId; const N: TNewtonId): TJouleId;
begin end;

operator /(const J: TJouleId; const N: TNewtonId): TMeterId;
begin end;

operator *(const kg: TKilogramId; const m2_s2: TSquareMeterPerSquareSecondId): TJouleId;
begin end;

operator *(const m2_s2: TSquareMeterPerSquareSecondId; const kg: TKilogramId): TJouleId;
begin end;

operator /(const J: TJouleId; const m2_s2: TSquareMeterPerSquareSecondId): TKilogramId;
begin end;

operator /(const J: TJouleId; const s: TSecondId): TWattId;
begin end;

operator /(const W: TWattId; const Ohm: TOhmId): TSquareAmpereId;
begin end;

operator /(const W: TWattId; const A2: TSquareAmpereId): TOhmId;
begin end;

operator *(const A2: TSquareAmpereId; const Ohm: TOhmId): TWattId;
begin end;

operator *(const Ohm: TOhmId; const A2: TSquareAmpereId): TWattId;
begin end;

operator /(const J: TJouleId; const C: TCoulombId): TVoltId;
begin end;

operator /(const W: TWattId; const A: TAmpereId): TVoltId;
begin end;

operator /(const W: TWattId; const V: TVoltId): TAmpereId;
begin end;

operator *(const A: TAmpereId; const V: TVoltId): TWattId;
begin end;

operator *(const V: TVoltId; const A: TAmpereId): TWattId;
begin end;

operator *(const W: TWattId; const Ohm: TOhmId): TSquareVoltId;
begin end;

operator *(const Ohm: TOhmId; const W: TWattId): TSquareVoltId;
begin end;

operator /(const V2: TSquareVoltId; const W: TWattId): TOhmId;
begin end;

operator /(const V2: TSquareVoltId; const Ohm: TOhmId): TWattId;
begin end;

operator /(const C: TCoulombId; const V: TVoltId): TFaradId;
begin end;

operator /(const C2: TSquareCoulombId; const J: TJouleId): TFaradId;
begin end;

operator /(const C2: TSquareCoulombId; const F: TFaradId): TJouleId;
begin end;

operator *(const J: TJouleId; const F: TFaradId): TSquareCoulombId;
begin end;

operator *(const F: TFaradId; const J: TJouleId): TSquareCoulombId;
begin end;

operator *(const A: TAmpereId; const s: TSecondId): TCoulombId;
begin end;

operator *(const s: TSecondId; const A: TAmpereId): TCoulombId;
begin end;

operator /(const C: TCoulombId; const A: TAmpereId): TSecondId;
begin end;

operator /(const V: TVoltId; const A: TAmpereId): TOhmId;
begin end;

operator /(const s: TSecondId; const F: TFaradId): TOhmId;
begin end;

operator /(const s: TSecondId; const Ohm: TOhmId): TFaradId;
begin end;

operator *(const F: TFaradId; const Ohm: TOhmId): TSecondId;
begin end;

operator *(const Ohm: TOhmId; const F: TFaradId): TSecondId;
begin end;

operator /(const A: TAmpereId; const V: TVoltId): TSiemensId;
begin end;

operator /(const AValue: double; const Ohm: TOhmId): TSiemensId;
begin end;

operator /(const AValue: double; const S: TSiemensId): TOhmId;
begin end;

operator *(const V: TVoltId; const s: TSecondId): TWeberId;
begin end;

operator *(const s: TSecondId; const V: TVoltId): TWeberId;
begin end;

operator /(const Wb: TWeberId; const V: TVoltId): TSecondId;
begin end;

operator /(const Wb: TWeberId; const m2: TSquareMeterId): TTeslaId;
begin end;

operator /(const Wb: TWeberId; const A: TAmpereId): THenryId;
begin end;

operator *(const cd: TCandelaId; const sr: TSteradianId): TLumenIdentifer;
begin end;

operator *(const sr: TSteradianId; const cd: TCandelaId): TLumenIdentifer;
begin end;

operator /(const lm: TLumenIdentifer; const cd: TCandelaId): TSteradianId;
begin end;

operator/(const lm: TLumenIdentifer; const m2: TSquareMeterId): TLuxId;
begin end;

operator /(const J: TJouleId; const kg: TKilogramId): TGrayId;
begin end;

operator/(const m2: TSquareMeterId; const s2: TSquareSecondId): TSquareMeterPerSquareSecondId;
begin end;

operator/(const mol: TMoleId; const s: TSecondId): TKatalId;
begin end;

operator /(const g: TGramId; const m3: TCubicMeterId): TGramPerCubicMeterId;
begin end;

operator /(const g: TGramId; const mm3: TCubicMillimeterId): TGramPerCubicMillimeterId;
begin end;

operator /(const kg: TKilogramId; const m3: TCubicMeterId): TKilogramPerCubicMeterId;
begin end;

operator /(const kg: TKilogramId; const mm3: TCubicMillimeterId): TKilogramPerCubicMillimeterId;
begin end;

// combining quantities
operator/(const AValue: double; const ADuration: TSeconds): THertz;
begin
  result.Value := AValue / ADuration.Value;
end;

operator/(const AValue: double; const ARadioactivity: TBecquerels): TSeconds;
begin
  result := AValue / ARadioactivity;
end;

operator*(const ARadioactivity: TBecquerels; const ADenominator: TSeconds): double;
begin
  result := ARadioactivity * ADenominator;
end;

operator*(const ADenominator: TSeconds; const ARadioactivity: TBecquerels): double;
begin
  result := ADenominator * ARadioactivity;
end;

operator /(const ASpeed: TMetersPerSecond; const ALength: TMeters): THertz;
begin
  result.Value := ASpeed.Value / ALength.Value;
end;

operator /(const ASpeed: TMillimetersPerSecond; const ALength: TMillimeters): THertz; inline;
begin
  result.Value := ASpeed.Value / ALength.Value;
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

operator *(const AWeight: TGrams; const ALength: TMeters): TGramMeters;
begin
  result.Value := AWeight.Value * ALength.Value;
end;

operator *(const AWeight: TKilograms; const ALength: TMeters): TKilogramMeters;
begin
  result.Value := AWeight.Value * ALength.Value;
end;

operator*(const AWeight: TGrams; const AAcceleration: TMetersPerSecondSquared ): TMillinewtons;
begin
  result.Value := AWeight.Value * AAcceleration.Value;
end;

operator*(const AAcceleration: TMetersPerSecondSquared; const AWeight: TGrams): TMillinewtons;
begin
  result.Value := AAcceleration.Value * AWeight.Value;
end;

operator /(const AForce: TMillinewtons; const AWeight: TGrams): TMetersPerSecondSquared;
begin
  result.Value := AForce.Value / AWeight.Value;
end;

operator*(const AWeight: TKilograms; const AAcceleration: TMetersPerSecondSquared): TNewtons;
begin
  result.Value := AWeight.Value * AAcceleration.Value;
end;

operator*(const AAcceleration: TMetersPerSecondSquared; const AWeight: TKilograms): TNewtons;
begin
  result.Value := AWeight.Value * AAcceleration.Value;
end;

operator /(const AForce: TNewtons; const AWeight: TKilograms): TMetersPerSecondSquared; inline;
begin
  result.Value := AForce.Value / AWeight.Value;
end;

operator /(const AForce: TNewtons; const AArea: TSquareMeters): TPascals;
begin
  result.Value := AForce.Value / AArea.Value;
end;

operator /(const AForce: TNewtons; const AArea: TSquareMillimeters): TMegapascals;
begin
  result.Value := AForce.Value / AArea.Value;
end;

operator/(const AForce: TKilonewtons; const AArea: TSquareMeters): TKilopascals;
begin
  result.Value := AForce.Value / AArea.Value;
end;

operator/(const AForce: TKilonewtons; const AArea: TSquareMillimeters): TMegapascals;
begin
  result := AForce.ToBase / AArea;
end;

operator /(const AForce: TNewtons; const ALength: TMeters): TNewtonsPerMeter;
begin
  result.Value := AForce.Value / ALength.Value;
end;

operator /(const AForce: TNewtons; const ALength: TMillimeters): TNewtonsPerMillimeter;
begin
  result.Value := AForce.Value / ALength.Value;
end;

operator *(const APressure: TPascals; const ALength: TMeters): TNewtonsPerMeter;
begin
  result.Value := APressure.Value * ALength.Value;
end;

operator *(const ALength: TMeters; const APressure: TPascals): TNewtonsPerMeter;
begin
  result.Value := ALength.Value * APressure.Value;
end;

operator *(const APressure: TMegapascals; const ALength: TMillimeters): TNewtonsPerMillimeter;
begin
  result.Value := APressure.Value * ALength.Value;
end;

operator *(const ALength: TMillimeters; const APressure: TMegapascals): TNewtonsPerMillimeter;
begin
  result.Value := ALength.Value * APressure.Value;
end;

operator /(const AForce: TNewtons; const AVolume: TCubicMeters): TNewtonsPerCubicMeter;
begin
  result.Value := AForce.Value / AVolume.Value;
end;

operator *(const ADensity: TKilogramsPerCubicMeter; const AAcceleration: TMetersPerSecondSquared): TNewtonsPerCubicMeter;
begin
  result.Value := ADensity.Value * AAcceleration.Value;
end;

operator *(const AAcceleration: TMetersPerSecondSquared; const ADensity: TKilogramsPerCubicMeter): TNewtonsPerCubicMeter;
begin
  result.Value := AAcceleration.Value * ADensity.Value;
end;

operator /(const ASpecificWeight: TNewtonsPerCubicMeter; const ADensity: TKilogramsPerCubicMeter): TMetersPerSecondSquared;
begin
  result.Value := ASpecificWeight.Value / ADensity.Value;
end;

operator /(const ASpecificWeight: TNewtonsPerCubicMeter; const AAcceleration: TMetersPerSecondSquared): TKilogramsPerCubicMeter;
begin
  result.Value := ASpecificWeight.Value / AAcceleration.Value;
end;

operator *(const APressure: TPascals; const ATime: TSeconds): TPascalsSecond;
begin
  result.Value := APressure.Value * ATime.Value;
end;

operator *(const ATime: TSeconds; const APressure: TPascals): TPascalsSecond;
begin
  result.Value := ATime.Value * APressure.Value;
end;

operator /(const ADynViscosity: TPascalsSecond; const APressure: TPascals): TSeconds;
begin
  result.Value := ADynViscosity.Value / APressure.Value;
end;

operator /(const AMass: TKilograms; const ATime: TSeconds): TKilogramsPerSecond;
begin
  result.Value := AMass.Value / ATime.Value;
end;

operator *(const ADynViscosity: TPascalsSecond; const ALength: TMeters): TKilogramsPerSecond;
begin
  result.Value := ADynViscosity.Value * ALength.Value;
end;

operator *(const ALength: TMeters; const ADynViscosity: TPascalsSecond): TKilogramsPerSecond;
begin
  result.Value := ALength.Value * ADynViscosity.Value;
end;

operator /(const AMassFlux: TKilogramsPerSecond; const ADynViscosity: TPascalsSecond): TMeters;
begin
  result.Value := AMassFlux.Value / ADynViscosity.Value;
end;

operator /(const AMassFlux: TKilogramsPerSecond; const ALength: TMeters): TPascalsSecond;
begin
  result.Value := AMassFlux.Value / ALength.Value;
end;

operator /(const AForce: TNewtons; const ASpeed: TMetersPerSecond): TKilogramsPerSecond;
begin
  result.Value := AForce.Value / ASpeed.Value;
end;

operator *(const ASpeed: TMetersPerSecond; const AMassFlux: TKilogramsPerSecond): TNewtons;
begin
  result.Value := ASpeed.Value * AMassFlux.Value;
end;

operator *(const AMassFlux: TKilogramsPerSecond; const ASpeed: TMetersPerSecond): TNewtons;
begin
  result.Value := AMassFlux.Value * ASpeed.Value;
end;

operator /(const AForce: TNewtons; const AMassFlux: TKilogramsPerSecond): TMetersPerSecond;
begin
  result.Value := AForce.Value / AMassFlux.Value;
end;

operator *(const AForce: TNewtons; const ALength: TMeters): TJoules;
begin
  result.Value := AForce.Value * ALength.Value;
end;

operator *(const ALength: TMeters; const AForce: TNewtons): TJoules;
begin
  result.Value := ALength.Value * AForce.Value;
end;

operator /(const AWork: TJoules; const AForce: TNewtons): TMeters;
begin
  result.Value := AWork.Value / AForce.Value;
end;

operator *(const AMass: TKilograms; const ASquareSpeed: TSquareMetersPerSquareSecond): TJoules;
begin
  result.Value := AMass.Value * ASquareSpeed.Value;
end;

operator *(const ASquareSpeed: TSquareMetersPerSquareSecond; const AMass: TKilograms): TJoules;
begin
  result.Value := ASquareSpeed.Value * AMass.Value;
end;

operator /(const AWork: TJoules; const ASquareSpeed: TSquareMetersPerSquareSecond): TKilograms;
begin
  result.Value := AWork.Value / ASquareSpeed.Value;
end;

operator /(const AWork: TJoules; const ATime: TSeconds): TWatts;
begin
  result.Value := AWork.Value / ATime.Value;
end;

operator /(const APower: TWatts; const AResistance: TOhms): TSquareAmperes;
begin
  result.Value := APower.Value / AResistance.Value;
end;

operator /(const APower: TWatts; const ASquareCurrent: TSquareAmperes): TOhms;
begin
  result.Value := APower.Value / ASquareCurrent.Value;
end;

operator *(const ASquareCurrent: TSquareAmperes; const AResistance: TOhms): TWatts; inline;
begin
  result.Value := ASquareCurrent.Value * AResistance.Value;
end;

operator *(const AResistance: TOhms; const ASquareCurrent: TSquareAmperes): TWatts;
begin
  result.Value := AResistance.Value * ASquareCurrent.Value;
end;

operator /(const AWork: TJoules; const ACharge: TCoulombs): TVolts;
begin
  result.Value := AWork.Value / ACharge.Value;
end;

operator /(const APower: TWatts; const ACurrent: TAmperes): TVolts;
begin
  result.Value := APower.Value / ACurrent.Value;
end;

operator /(const APower: TWatts; const AVoltage: TVolts): TAmperes;
begin
  result.Value := APower.Value / AVoltage.Value;
end;

operator *(const ACurrent: TAmperes; const AVoltage: TVolts): TWatts;
begin
  result.Value := ACurrent.Value * AVoltage.Value;
end;

operator *(const AVoltage: TVolts; const ACurrent: TAmperes): TWatts; inline;
begin
  result.Value := AVoltage.Value * ACurrent.Value;
end;

operator *(const APower: TWatts; const AResistance: TOhms): TSquareVolts;
begin
  result.Value := APower.Value * AResistance.Value;
end;

operator *(const AResistance: TOhms; const APower: TWatts): TSquareVolts;
begin
  result.Value := AResistance.Value * APower.Value;
end;

operator /(const ASquareVoltage: TSquareVolts; const APower: TWatts): TOhms;
begin
  result.Value := ASquareVoltage.Value / APower.Value;
end;

operator /(const ASquareVoltage: TSquareVolts; const AResistance: TOhms): TWatts;
begin
  result.Value := ASquareVoltage.Value / AResistance.Value;
end;

operator /(const ACharge: TCoulombs; const AVoltage: TVolts): TFarads;
begin
  result.Value := ACharge.Value / AVoltage.Value;
end;

operator /(const ASquareCharge: TSquareCoulombs; const AWork: TJoules): TFarads;
begin
  result.Value := ASquareCharge.Value / AWork.Value;
end;

operator /(const ASquareCharge: TSquareCoulombs; const ACapacitance: TFarads): TJoules;
begin
  result.Value := ASquareCharge.Value / ACapacitance.Value;
end;

operator *(const AWork: TJoules; const ACapacitance: TFarads): TSquareCoulombs;
begin
  result.Value := AWork.Value * ACapacitance.Value;
end;

operator *(const ACapacitance: TFarads; const AWork: TJoules): TSquareCoulombs;
begin
  result.Value := ACapacitance.Value * AWork.Value;
end;

operator*(const ACurrent: TAmperes; const ADuration: TSeconds): TCoulombs;
begin
  result.Value := ACurrent.Value * ADuration.Value;
end;

operator *(const ADuration: TSeconds; const ACurrent: TAmperes): TCoulombs; inline;
begin
  result.Value := ADuration.Value * ACurrent.Value;
end;

operator /(const ACharge: TCoulombs; const ACurrent: TAmperes): TSeconds; inline;
begin
  result.Value := ACharge.Value / ACurrent.Value;
end;

operator /(const AVoltage: TVolts; const ACurrent: TAmperes): TOhms;
begin
  result.Value := AVoltage.Value / ACurrent.Value;
end;

operator /(const ATime: TSeconds; const ACapacitance: TFarads): TOhms;
begin
  result.Value := ATime.Value / ACapacitance.Value;
end;

operator /(const ATime: TSeconds; const AImpedance: TOhms): TFarads;
begin
  result.Value := ATime.Value / AImpedance.Value;
end;

operator *(const ACapacitance: TFarads; const AImpedance: TOhms): TSeconds;
begin
  result.Value := ACapacitance.Value * AImpedance.Value;
end;

operator *(const AImpedance: TOhms; const ACapacitance: TFarads): TSeconds;
begin
  result.Value := AImpedance.Value * ACapacitance.Value;
end;

operator /(const ACurrent: TAmperes; const AVoltage: TVolts): TSiemens;
begin
  result.Value := ACurrent.Value / AVoltage.Value;
end;

operator /(const AValue: double; const AResistance: TOhms): TSiemens;
begin
  result.Value := AValue / AResistance.Value;
end;

operator /(const AValue: double; const AElectricalConductance: TSiemens): TOhms;
begin
  result.Value := AValue / AElectricalConductance.Value;
end;

operator *(const AVoltage: TVolts; const ATime: TSeconds): TWebers;
begin
  result.Value := AVoltage.Value * ATime.Value;
end;

operator *(const ATime: TSeconds; const AVoltage: TVolts): TWebers;
begin
  result.Value := ATime.Value * AVoltage.Value;
end;

operator /(const AMagneticFlux: TWebers; const AVoltage: TVolts): TSeconds;
begin
  result.Value := AMagneticFlux.Value / AVoltage.Value;
end;

operator /(const AMagneticFlux: TWebers; const AArea: TSquareMeters): TTeslas;
begin
  result.Value := AMagneticFlux.Value / AArea.Value;
end;

operator /(const AMagneticFlux: TWebers; const ACurrent: TAmperes): THenrys;
begin
  result.Value := AMagneticFlux.Value / ACurrent.Value;
end;

operator *(const ALuminousIntensity: TCandelas; const ASolidAngle: TSteradians): TLumens;
begin
  result.Value := ALuminousIntensity.Value * ASolidAngle.Value;
end;

operator *(const ASolidAngle: TSteradians; const ALuminousIntensity: TCandelas): TLumens;
begin
  result.Value := ASolidAngle.Value * ALuminousIntensity.Value;
end;

operator /(const ALuminousFlux: TLumens; const ALuminousIntensity: TCandelas): TSteradians;
begin
  result.Value := ALuminousFlux.Value / ALuminousIntensity.Value;
end;

operator /(const ALuminousFlux: TLumens; const ASolidAngle: TSteradians): TCandelas;
begin
  result.Value := ALuminousFlux.Value / ASolidAngle.Value;
end;

operator/(const ALuminousFlux: TLumens; const AArea: TSquareMeters): TLuxQuantity;
begin
  result.Value := ALuminousFlux.Value / AArea.Value;
end;

operator /(const AEnergy: TJoules; const AMass: TKilograms): TGrays;
begin
  result.Value := AEnergy.Value / AMass.Value;
end;

operator/(const AArea: TSquareMeters; const ASquareTime: TSquareSeconds): TSquareMetersPerSquareSecond;
begin
  result.Value := AArea.Value / ASquareTime.Value;
end;

operator/(const AAmountOfSustance: TMoles; const ATime: TSeconds): TKatals;
begin
  result.Value := AAmountOfSustance.Value / ATime.Value;
end;

operator /(const AMass: TGrams; const AVolume: TCubicMeters): TGramsPerCubicMeter;
begin
  result.Value := AMass.Value / AVolume.Value;
end;

operator /(const AMass: TGrams; const AVolume: TCubicMillimeters): TGramsPerCubicMillimeter;
begin
  result.Value := AMass.Value / AVolume.Value;
end;

operator /(const AMass: TKilograms; const AVolume: TCubicMeters): TKilogramsPerCubicMeter;
begin
  result.Value := AMass.Value / AVolume.Value;
end;

operator /(const AMass: TKilograms; const AVolume: TCubicMillimeters): TKilogramsPerCubicMillimeter;
begin
  result.Value := AMass.Value / AVolume.Value;
end;

end.
{$ENDIF}


