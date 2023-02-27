{$IFNDEF INCLUDING}{$DEFINE INCLUDING}
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

  {$UNDEF INCLUDING}{$ENDIF}
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
  {$IFNDEF INCLUDING}{$DEFINE INCLUDING}


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

  {$UNDEF INCLUDING}{$ENDIF}
  // simulate inheritance for TDimensionedQuantity record
  {$IF defined(BASIC_DIM_QTY_INTF) or defined(DIM_QTY_INTF)}
  public
    Value: double;
    function ToString: string;
    function ToVerboseString: string;
    function Abs: TSelf;
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
    class operator :=(const ARatio: TDimensionedRatio): TSelf;
    class operator :=(const ASelf: TSelf): TDimensionedRatio;
    {$IFDEF FACTORED_QTY_INTF}
    class operator :=(const ASelf: TSelf): TBaseDimensionedRatio;
    {$ENDIF}
  {$ENDIF}{$UNDEF RATIO_QTY_INTF}
  {$IFDEF QTY_PROD_INTF}
    //class operator /(const ASelf: TSelf; const AQuantity1: TQuantity1): TQuantity2;
    class operator /(const ASelf: TSelf; const AQuantity2: TQuantity2): TQuantity1;
    class operator :=(const AProduct: TDimensionedProduct): TSelf;
    class operator :=(const ASelf: TSelf): TDimensionedProduct;
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
  {$IFNDEF INCLUDING}{$DEFINE INCLUDING}

  generic TQuarticDimensionedQuantity<BaseU: TUnit> = record
    type TSelf = specialize TQuarticDimensionedQuantity<BaseU>;
    type U = specialize TQuarticUnit<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$i dim.pas}
  end;

  generic TCubicDimensionedQuantity<BaseU: TUnit> = record
    type TSelf = specialize TCubicDimensionedQuantity<BaseU>;
    type U = specialize TCubicUnit<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$i dim.pas}
  end;

  generic TSquareDimensionedQuantity<BaseU: TUnit> = record
    type TSelf = specialize TSquareDimensionedQuantity<BaseU>;
    type U = specialize TSquareUnit<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$i dim.pas}
  end;

  generic TDimensionedQuantity<U: TUnit> = record
    type TSelf = specialize TDimensionedQuantity<U>;
    type TSquareQuantity = specialize TSquareDimensionedQuantity<U>;
    type TCubicQuantity = specialize TCubicDimensionedQuantity<U>;
    type TQuarticQuantity = specialize TQuarticDimensionedQuantity<U>;
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
    type TDimensionedRatio = specialize TDimensionedQuantity<U>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TDimensionedQuantityProduct<U1, U2: TUnit> = record
    type U = specialize TUnitProduct<U1, U2>;
    type TSelf = specialize TDimensionedQuantityProduct<U1, U2>;
    type TQuantity1 = specialize TDimensionedQuantity<U1>;
    type TQuantity2 = specialize TDimensionedQuantity<U2>;
    type TDimensionedProduct = specialize TDimensionedQuantity<U>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  generic TFactoredQuarticDimensionedQuantity<BaseU: TUnit; U1: TFactoredUnit> = record
    type TSelf = specialize TFactoredQuarticDimensionedQuantity<BaseU, U1>;
    type U = specialize TFactoredQuarticUnit<U1>;
    type TBaseDimensionedQuantity = specialize TQuarticDimensionedQuantity<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredCubicDimensionedQuantity<BaseU: TUnit; U1: TFactoredUnit> = record
    type TSelf = specialize TFactoredCubicDimensionedQuantity<BaseU, U1>;
    type U = specialize TFactoredCubicUnit<U1>;
    type TBaseDimensionedQuantity = specialize TCubicDimensionedQuantity<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredSquareDimensionedQuantity<BaseU: TUnit; U1: TFactoredUnit> = record
    type TSelf = specialize TFactoredSquareDimensionedQuantity<BaseU, U1>;
    type U = specialize TFactoredSquareUnit<U1>;
    type TBaseDimensionedQuantity = specialize TSquareDimensionedQuantity<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredDimensionedQuantity<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredDimensionedQuantity<BaseU, U>;
    type TBaseDimensionedQuantity = specialize TDimensionedQuantity<BaseU>;
    type TSquareQuantity = specialize TFactoredSquareDimensionedQuantity<BaseU, U>;
    type TCubicQuantity = specialize TFactoredCubicDimensionedQuantity<BaseU, U>;
    type TQuarticQuantity = specialize TFactoredQuarticDimensionedQuantity<BaseU, U>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE SQUARABLE_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredReciprocalDimensionedQuantity<BaseDenomU: TUnit; DenomU: TFactoredUnit> = record
    type U = specialize TFactoredReciprocalUnit<DenomU>;
    type BaseU = specialize TReciprocalUnit<BaseDenomU>;
    type TBaseDimensionedQuantity = specialize TReciprocalDimensionedQuantity<BaseDenomU>;
    type TSelf = specialize TFactoredReciprocalDimensionedQuantity<BaseDenomU, DenomU>;
    type TDenomQuantity = specialize TFactoredDimensionedQuantity<BaseDenomU, DenomU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RECIP_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU: TUnit;
                                            NumeratorU, DenomU: TFactoredUnit> = record
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseDimensionedQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type U = specialize TFactoredRatioUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredRatioDimensionedQuantity
                 <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type TNumeratorQuantity = specialize TFactoredDimensionedQuantity<BaseNumeratorU, NumeratorU>;
    type TDenomQuantity = specialize TFactoredDimensionedQuantity<BaseDenomU, DenomU>;
    type TDimensionedRatio = specialize TFactoredDimensionedQuantity<BaseU, U>;
    type TBaseDimensionedRatio = specialize TDimensionedQuantity<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredNumeratorDimensionedQuantity<BaseNumeratorU, BaseDenomU: TUnit;
                                                NumeratorU: TFactoredUnit> = record
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseDimensionedQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type DenomU = BaseDenomU;
    type U = specialize TFactoredNumeratorUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredNumeratorDimensionedQuantity
                 <BaseNumeratorU, BaseDenomU, NumeratorU>;
    type TNumeratorQuantity = specialize TFactoredDimensionedQuantity<BaseNumeratorU, NumeratorU>;
    type TDenomQuantity = specialize TDimensionedQuantity<DenomU>;
    type TDimensionedRatio = specialize TFactoredDimensionedQuantity<BaseU, U>;
    type TBaseDimensionedRatio = specialize TDimensionedQuantity<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredDenominatorDimensionedQuantity<BaseNumeratorU, BaseDenomU: TUnit;
                                                  DenomU: TFactoredUnit> = record
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseDimensionedQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type NumeratorU = BaseNumeratorU;
    type U = specialize TFactoredDenominatorUnit<NumeratorU, DenomU>;
    type TSelf = specialize TFactoredDenominatorDimensionedQuantity
                 <BaseNumeratorU, BaseDenomU, DenomU>;
    type TNumeratorQuantity = specialize TDimensionedQuantity<NumeratorU>;
    type TDenomQuantity = specialize TFactoredDimensionedQuantity<BaseDenomU, DenomU>;
    type TDimensionedRatio = specialize TFactoredDimensionedQuantity<BaseU, U>;
    type TBaseDimensionedRatio = specialize TDimensionedQuantity<BaseU>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE RATIO_QTY_INTF}{$i dim.pas}
  end;

  generic TFactoredDimensionedQuantityProduct<BaseU1, BaseU2: TUnit; U1, U2: TFactoredUnit> = record
    type TSelf = specialize TFactoredDimensionedQuantityProduct<BaseU1, BaseU2, U1, U2>;
    type U = specialize TFactoredUnitProduct<U1, U2>;
    type TQuantity1 = specialize TFactoredDimensionedQuantity<BaseU1, U1>;
    type TQuantity2 = specialize TFactoredDimensionedQuantity<BaseU2, U2>;
    type TBaseDimensionedQuantity = specialize TDimensionedQuantityProduct<BaseU1, BaseU2>;
    type BaseU = specialize TUnitProduct<BaseU1, BaseU2>;
    type TDimensionedProduct = specialize TFactoredDimensionedQuantity<BaseU, U>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  generic TLeftFactoredDimensionedQuantityProduct<BaseU1, BaseU2: TUnit; U1: TFactoredUnit> = record
    type U2 = BaseU2;
    type TSelf = specialize TLeftFactoredDimensionedQuantityProduct<BaseU1, BaseU2, U1>;
    type U = specialize TLeftFactoredUnitProduct<U1, U2>;
    type TQuantity1 = specialize TFactoredDimensionedQuantity<BaseU1, U1>;
    type TQuantity2 = specialize TDimensionedQuantity<U2>;
    type TBaseDimensionedQuantity = specialize TDimensionedQuantityProduct<BaseU1, BaseU2>;
    type BaseU = specialize TUnitProduct<BaseU1, BaseU2>;
    type TDimensionedProduct = specialize TFactoredDimensionedQuantity<BaseU, U>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  generic TRightFactoredDimensionedQuantityProduct<BaseU1, BaseU2: TUnit; U2: TFactoredUnit> = record
    type U1 = BaseU1;
    type TSelf = specialize TRightFactoredDimensionedQuantityProduct<BaseU1, BaseU2, U2>;
    type U = specialize TRightFactoredUnitProduct<U1, U2>;
    type TQuantity1 = specialize TDimensionedQuantity<U1>;
    type TQuantity2 = specialize TFactoredDimensionedQuantity<BaseU2, U2>;
    type TBaseDimensionedQuantity = specialize TDimensionedQuantityProduct<BaseU1, BaseU2>;
    type BaseU = specialize TUnitProduct<BaseU1, BaseU2>;
    type TDimensionedProduct = specialize TFactoredDimensionedQuantity<BaseU, U>;
    {$DEFINE DIM_QTY_INTF}{$DEFINE FACTORED_QTY_INTF}{$DEFINE QTY_PROD_INTF}{$i dim.pas}
  end;

  { Unit identifiers }

  {$UNDEF INCLUDING}{$ENDIF}
  // simulate inheritance for TUnitIdentifier record
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
    class operator *(const {%H-}TheUnit1, {%H-}TheUnit2: TSelf): TSquareIdentifier;
    class operator /(const {%H-}TheSquareUnit: TSquareIdentifier; const {%H-}TheUnit: TSelf): TSelf;

    class operator *(const {%H-}TheSquareUnit: TSquareIdentifier; const {%H-}TheUnit: TSelf): TCubicIdentifier;
    class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheSquareUnit: TSquareIdentifier): TCubicIdentifier;
    class operator /(const {%H-}TheCubicUnit: TCubicIdentifier; const {%H-}TheUnit: TSelf): TSquareIdentifier;

    class operator *(const {%H-}TheCubicUnit: TCubicIdentifier; const {%H-}TheUnit: TSelf): TQuarticIdentifier;
    class operator *(const {%H-}TheUnit: TSelf; const {%H-}TheCubicUnit: TCubicIdentifier): TQuarticIdentifier;
    class operator /(const {%H-}TheQuarticUnit: TQuarticIdentifier; const {%H-}TheUnit: TSelf): TCubicIdentifier;
    function Squared: TSquareIdentifier;
    function Cubed: TCubicIdentifier;
    function Quarted: TQuarticIdentifier;
    function SquareRoot(const ASquareQuantity: TSquareQuantity): TQuantity;
    function CubicRoot(const ACubicQuantity: TCubicQuantity): TQuantity;
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
  {$IFNDEF INCLUDING}{$DEFINE INCLUDING}

  generic TQuarticUnitIdentifier<BaseU: TUnit> = record
    type U = specialize TQuarticUnit<BaseU>;
    type TSelf = specialize TQuarticUnitIdentifier<BaseU>;
    type TQuantity = specialize TQuarticDimensionedQuantity<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TCubicUnitIdentifier<BaseU: TUnit> = record
    type U = specialize TCubicUnit<BaseU>;
    type TSelf = specialize TCubicUnitIdentifier<BaseU>;
    type TQuantity = specialize TCubicDimensionedQuantity<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TSquareUnitIdentifier<BaseU: TUnit> = record
    type U = specialize TSquareUnit<BaseU>;
    type TSelf = specialize TSquareUnitIdentifier<BaseU>;
    type TQuantity = specialize TSquareDimensionedQuantity<BaseU>;
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
    type TSquareIdentifier = specialize TSquareUnitIdentifier<U>;
    type TSquareQuantity = specialize TSquareDimensionedQuantity<U>;
    type TCubicIdentifier = specialize TCubicUnitIdentifier<U>;
    type TCubicQuantity = specialize TCubicDimensionedQuantity<U>;
    type TQuarticIdentifier = specialize TQuarticUnitIdentifier<U>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE SQUARABLE_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredQuarticUnitIdentifier<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredQuarticUnitIdentifier<BaseU, U>;
    type TQuantity = specialize TFactoredQuarticDimensionedQuantity<BaseU, U>;
    type TBaseQuantity = specialize TQuarticDimensionedQuantity<BaseU>;
    type TBaseUnitIdentifier = specialize TQuarticUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredCubicUnitIdentifier<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredCubicUnitIdentifier<BaseU, U>;
    type TQuantity = specialize TFactoredCubicDimensionedQuantity<BaseU, U>;
    type TBaseQuantity = specialize TCubicDimensionedQuantity<BaseU>;
    type TBaseUnitIdentifier = specialize TCubicUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredSquareUnitIdentifier<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredSquareUnitIdentifier<BaseU, U>;
    type TQuantity = specialize TFactoredSquareDimensionedQuantity<BaseU, U>;
    type TBaseQuantity = specialize TSquareDimensionedQuantity<BaseU>;
    type TBaseUnitIdentifier = specialize TSquareUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredUnitIdentifier<BaseU: TUnit; U: TFactoredUnit> = record
    type TSelf = specialize TFactoredUnitIdentifier<BaseU, U>;
    type TQuantity = specialize TFactoredDimensionedQuantity<BaseU, U>;
    type TBaseQuantity = specialize TDimensionedQuantity<BaseU>;
    type TBaseUnitIdentifier = specialize TUnitIdentifier<BaseU>;
    type TSquareIdentifier = specialize TFactoredSquareUnitIdentifier<BaseU, U>;
    type TSquareQuantity = specialize TFactoredSquareDimensionedQuantity<BaseU, U>;
    type TCubicIdentifier = specialize TFactoredCubicUnitIdentifier<BaseU, U>;
    type TCubicQuantity = specialize TFactoredCubicDimensionedQuantity<BaseU, U>;
    type TQuarticIdentifier = specialize TFactoredQuarticUnitIdentifier<BaseU, U>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE SQUARABLE_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TReciprocalUnitIdentifier<DenomU: TUnit> = record
    type U = specialize TReciprocalUnit<DenomU>;
    type TSelf = specialize TReciprocalUnitIdentifier<DenomU>;
    type TQuantity = specialize TReciprocalDimensionedQuantity<DenomU>;
    type TDenomIdentifier = specialize TUnitIdentifier<DenomU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE RECIP_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredReciprocalUnitIdentifier<BaseDenomU: TUnit; DenomU: TFactoredUnit> = record
    type U = specialize TFactoredReciprocalUnit<DenomU>;
    type BaseU = specialize TReciprocalUnit<BaseDenomU>;
    type TBaseQuantity = specialize TReciprocalDimensionedQuantity<BaseDenomU>;
    type TBaseUnitIdentifier = specialize TReciprocalUnitIdentifier<BaseDenomU>;
    type TSelf = specialize TFactoredReciprocalUnitIdentifier<BaseDenomU, DenomU>;
    type TQuantity = specialize TFactoredReciprocalDimensionedQuantity<BaseDenomU, DenomU>;
    type TDenomIdentifier = specialize TFactoredUnitIdentifier<BaseDenomU, DenomU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RECIP_UNIT_ID_INTF}{$i dim.pas}
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
    type TSelf = specialize TUnitProductIdentifier<U1, U2>;
    type U = specialize TUnitProduct<U1, U2>;
    type TQuantity = specialize TDimensionedQuantityProduct<U1, U2>;
    type TIdentifier1 = specialize TUnitIdentifier<U1>;
    type TIdentifier2 = specialize TUnitIdentifier<U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredUnitProductIdentifier<BaseU1, BaseU2: TUnit; U1, U2: TFactoredUnit> = record
    type TSelf = specialize TFactoredUnitProductIdentifier<BaseU1, BaseU2, U1, U2>;
    type U = specialize TFactoredUnitProduct<U1, U2>;
    type TBaseQuantity = specialize TDimensionedQuantityProduct<BaseU1, BaseU2>;
    type TBaseUnitIdentifier = specialize TUnitProductIdentifier<BaseU1, BaseU2>;
    type TQuantity = specialize TFactoredDimensionedQuantityProduct<BaseU1, BaseU2, U1, U2>;
    type TIdentifier1 = specialize TFactoredUnitIdentifier<BaseU1, U1>;
    type TIdentifier2 = specialize TFactoredUnitIdentifier<BaseU2, U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TLeftFactoredUnitProductIdentifier<BaseU1, BaseU2: TUnit; U1: TFactoredUnit> = record
    type U2 = BaseU2;
    type TSelf = specialize TLeftFactoredUnitProductIdentifier<BaseU1, BaseU2, U1>;
    type U = specialize TLeftFactoredUnitProduct<U1, U2>;
    type TBaseQuantity = specialize TDimensionedQuantityProduct<BaseU1, BaseU2>;
    type TBaseUnitIdentifier = specialize TUnitProductIdentifier<BaseU1, BaseU2>;
    type TQuantity = specialize TLeftFactoredDimensionedQuantityProduct<BaseU1, BaseU2, U1>;
    type TIdentifier1 = specialize TFactoredUnitIdentifier<BaseU1, U1>;
    type TIdentifier2 = specialize TUnitIdentifier<U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TRightFactoredUnitProductIdentifier<BaseU1, BaseU2: TUnit; U2: TFactoredUnit> = record
    type U1 = BaseU1;
    type TSelf = specialize TRightFactoredUnitProductIdentifier<BaseU1, BaseU2, U2>;
    type U = specialize TRightFactoredUnitProduct<U1, U2>;
    type TBaseQuantity = specialize TDimensionedQuantityProduct<BaseU1, BaseU2>;
    type TBaseUnitIdentifier = specialize TUnitProductIdentifier<BaseU1, BaseU2>;
    type TQuantity = specialize TRightFactoredDimensionedQuantityProduct<BaseU1, BaseU2, U2>;
    type TIdentifier1 = specialize TUnitIdentifier<U1>;
    type TIdentifier2 = specialize TFactoredUnitIdentifier<BaseU2, U2>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE UNIT_PROD_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredRatioUnitIdentifier<BaseNumeratorU, BaseDenomU: TUnit;
                                       NumeratorU, DenomU: TFactoredUnit> = record
    type TSelf = specialize TFactoredRatioUnitIdentifier
                 <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type U = specialize TFactoredRatioUnit<NumeratorU, DenomU>;
    type TQuantity = specialize TFactoredRatioDimensionedQuantity
                     <BaseNumeratorU, BaseDenomU, NumeratorU, DenomU>;
    type TNumeratorIdentifier = specialize TFactoredUnitIdentifier<BaseNumeratorU, NumeratorU>;
    type TDenomIdentifier = specialize TFactoredUnitIdentifier<BaseDenomU, DenomU>;
    type TBaseQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseUnitIdentifier = specialize TUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredNumeratorUnitIdentifier<BaseNumeratorU, BaseDenomU: TUnit;
                                       NumeratorU: TFactoredUnit> = record
    type TSelf = specialize TFactoredNumeratorUnitIdentifier
                 <BaseNumeratorU, BaseDenomU, NumeratorU>;
    type DenomU = BaseDenomU;
    type U = specialize TFactoredNumeratorUnit<NumeratorU, DenomU>;
    type TQuantity = specialize TFactoredNumeratorDimensionedQuantity
                     <BaseNumeratorU, BaseDenomU, NumeratorU>;
    type TNumeratorIdentifier = specialize TFactoredUnitIdentifier<BaseNumeratorU, NumeratorU>;
    type TDenomIdentifier = specialize TUnitIdentifier<DenomU>;
    type TBaseQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseUnitIdentifier = specialize TUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

  generic TFactoredDenominatorUnitIdentifier<BaseNumeratorU, BaseDenomU: TUnit;
                                       DenomU: TFactoredUnit> = record
    type TSelf = specialize TFactoredDenominatorUnitIdentifier
                 <BaseNumeratorU, BaseDenomU, DenomU>;
    type NumeratorU = BaseNumeratorU;
    type U = specialize TFactoredDenominatorUnit<NumeratorU, DenomU>;
    type TQuantity = specialize TFactoredDenominatorDimensionedQuantity
                     <BaseNumeratorU, BaseDenomU, DenomU>;
    type TNumeratorIdentifier = specialize TUnitIdentifier<NumeratorU>;
    type TDenomIdentifier = specialize TFactoredUnitIdentifier<BaseDenomU, DenomU>;
    type TBaseQuantity = specialize TRatioDimensionedQuantity<BaseNumeratorU, BaseDenomU>;
    type BaseU = specialize TRatioUnit<BaseNumeratorU, BaseDenomU>;
    type TBaseUnitIdentifier = specialize TUnitIdentifier<BaseU>;
    {$DEFINE UNIT_ID_INTF}{$DEFINE FACTORED_UNIT_ID_INTF}{$DEFINE RATIO_UNIT_ID_INTF}{$i dim.pas}
  end;

////////////////////////////////// BASE UNITS //////////////////////////////////

{ Units of time }

type
  TSecond = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TSecondIdentifier = specialize TUnitIdentifier<TSecond>;
  TSeconds = specialize TDimensionedQuantity<TSecond>;

  TMilliseconds = specialize TFactoredDimensionedQuantity
                             <TSecond, specialize TMilliUnit<TSecond>>;
  TMicroseconds = specialize TFactoredDimensionedQuantity
                             <TSecond, specialize TMicroUnit<TSecond>>;
  TNanoseconds = specialize TFactoredDimensionedQuantity
                            <TSecond, specialize TNanoUnit<TSecond>>;

  TMinute = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TMinutes = specialize TFactoredDimensionedQuantity<TSecond, TMinute>;

  THour = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  THourIdentifier = specialize TFactoredUnitIdentifier<TSecond, THour>;
  THours = specialize TFactoredDimensionedQuantity<TSecond, THour>;

  TDay = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TDays = specialize TFactoredDimensionedQuantity<TSecond, TDay>;

  // this unit is not really to be used directly because
  // time is divided one exponent at a time: m/s2 -> (m/s)/s
  // thus acceleration are "per second squared" instead of "per square second"
  TSquareSecond = specialize TSquareUnit<TSecond>;
  TSquareSecondIdentifier = specialize TSquareUnitIdentifier<TSecond>;
  TSquareSecondFactorIdentifier = specialize TUnitIdentifier<TSquareSecond>;
  TSquareSeconds = specialize TSquareDimensionedQuantity<TSecond>;
  TSquareSecondsFactor = specialize TDimensionedQuantity<TSquareSecond>;

var
  ns: specialize TFactoredUnitIdentifier<TSecond, specialize TNanoUnit<TSecond>>;
  us: specialize TFactoredUnitIdentifier<TSecond, specialize TMicroUnit<TSecond>>;
  ms: specialize TFactoredUnitIdentifier<TSecond, specialize TMilliUnit<TSecond>>;
  s: TSecondIdentifier;
  s2: TSquareSecondIdentifier;
  mn: specialize TFactoredUnitIdentifier<TSecond, TMinute>;
  h: THourIdentifier;
  day: specialize TFactoredUnitIdentifier<TSecond, TDay>;

operator:=(const {%H-}s2: TSquareSecondIdentifier): TSquareSecondFactorIdentifier;
operator:=(const ASquareTime: TSquareSeconds): TSquareSecondsFactor;
operator:=(const ASquareTime: TSquareSecondsFactor): TSquareSeconds;

{ Units of length }

type
  TMeter = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TMeterIdentifier = specialize TUnitIdentifier<TMeter>;
  TMeters = specialize TDimensionedQuantity<TMeter>;

  TSquareMeter = specialize TSquareUnit<TMeter>;
  TSquareMeterIdentifier = specialize TSquareUnitIdentifier<TMeter>;
  TSquareMeterFactorIdentifier = specialize TUnitIdentifier<TSquareMeter>;
  TSquareMeters = specialize TSquareDimensionedQuantity<TMeter>;
  TSquareMetersFactor = specialize TDimensionedQuantity<TSquareMeter>;

  TCubicMeter = specialize TCubicUnit<TMeter>;
  TCubicMeterIdentifier = specialize TCubicUnitIdentifier<TMeter>;
  TCubicMeterFactorIdentifier = specialize TUnitIdentifier<TCubicMeter>;
  TCubicMeters = specialize TCubicDimensionedQuantity<TMeter>;
  TCubicMetersFactor = specialize TDimensionedQuantity<TCubicMeter>;

  TQuarticMeter = specialize TQuarticUnit<TMeter>;
  TQuarticMeterIdentifier = specialize TQuarticUnitIdentifier<TMeter>;
  TQuarticMeterFactorIdentifier = specialize TUnitIdentifier<TQuarticMeter>;
  TQuarticMeters = specialize TQuarticDimensionedQuantity<TMeter>;
  TQuarticMetersFactor = specialize TDimensionedQuantity<TQuarticMeter>;

  TKilometer = specialize TKiloUnit<TMeter>;
  TKilometerIdentifier = specialize TFactoredUnitIdentifier<TMeter, TKilometer>;
  TKilometers = specialize TFactoredDimensionedQuantity<TMeter, TKilometer>;
  TSquareKilometers = specialize TFactoredSquareDimensionedQuantity<TMeter, TKilometer>;
  TCubicKilometers = specialize TFactoredCubicDimensionedQuantity<TMeter, TKilometer>;
  TQuarticKilometers = specialize TFactoredQuarticDimensionedQuantity<TMeter, TKilometer>;

  TDecimeter = specialize TDeciUnit<TMeter>;
  TDecimeters = specialize TFactoredDimensionedQuantity<TMeter, TDecimeter>;
  TSquareDecimeters = specialize TFactoredSquareDimensionedQuantity<TMeter, TDecimeter>;
  TCubicDecimeters = specialize TFactoredCubicDimensionedQuantity<TMeter, TDecimeter>;
  TQuarticDecimeters = specialize TFactoredQuarticDimensionedQuantity<TMeter, TDecimeter>;

  TCentimeter = specialize TCentiUnit<TMeter>;
  TCentimeters = specialize TFactoredDimensionedQuantity<TMeter, TCentimeter>;
  TSquareCentimeters = specialize TFactoredSquareDimensionedQuantity<TMeter, TCentimeter>;
  TCubicCentimeters = specialize TFactoredCubicDimensionedQuantity<TMeter, TCentimeter>;
  TQuarticCentimeters = specialize TFactoredQuarticDimensionedQuantity<TMeter, TCentimeter>;

  TMillimeter = specialize TMilliUnit<TMeter>;
  TMillimeterIdentifier = specialize TFactoredUnitIdentifier<TMeter, TMillimeter>;
  TMillimeters = specialize TFactoredDimensionedQuantity<TMeter, TMillimeter>;

  TSquareMillimeter = specialize TFactoredSquareUnit<TMillimeter>;
  TSquareMillimeterIdentifier = specialize TFactoredSquareUnitIdentifier<TMeter, TMillimeter>;
  TSquareMillimeterFactorIdentifier = specialize TFactoredUnitIdentifier
                                      <TSquareMeter, TSquareMillimeter>;
  TSquareMillimeters = specialize TFactoredSquareDimensionedQuantity<TMeter, TMillimeter>;
  TSquareMillimetersFactor = specialize TFactoredDimensionedQuantity<TSquareMeter, TSquareMillimeter>;

  TCubicMillimeter = specialize TFactoredCubicUnit<TMillimeter>;
  TCubicMillimeterIdentifier = specialize TFactoredCubicUnitIdentifier<TMeter, TMillimeter>;
  TCubicMillimeterFactorIdentifier = specialize TFactoredUnitIdentifier
                                     <TCubicMeter, TCubicMillimeter>;
  TCubicMillimeters = specialize TFactoredCubicDimensionedQuantity<TMeter, TMillimeter>;
  TCubicMillimetersFactor = specialize TFactoredDimensionedQuantity<TCubicMeter, TCubicMillimeter>;

  TQuarticMillimeters = specialize TFactoredQuarticDimensionedQuantity<TMeter, TMillimeter>;

  TMicrometer = specialize TMicroUnit<TMeter>;
  TMicrometerIdentifier = specialize TFactoredUnitIdentifier<TMeter, TMicrometer>;
  TMicrometers = specialize TFactoredDimensionedQuantity<TMeter, TMicrometer>;

  TNanometer = specialize TNanoUnit<TMeter>;
  TNanometerIdentifier = specialize TFactoredUnitIdentifier<TMeter, TNanometer>;
  TNanometers = specialize TFactoredDimensionedQuantity<TMeter, TNanometer>;

  TPicometer = specialize TPicoUnit<TMeter>;
  TPicometerIdentifier = specialize TFactoredUnitIdentifier<TMeter, TPicometer>;
  TPicometers = specialize TFactoredDimensionedQuantity<TMeter, TPicometer>;

  TLitre = class(TUnit)
    class function Symbol: string; override;
    class function Name: string; override;
  end;
  TLitreIdentifier = specialize TUnitIdentifier<TLitre>;
  TLitres = specialize TDimensionedQuantity<TLitre>;

  { TLitreHelper }

  TLitreHelper = record helper for TLitreIdentifier
    function From(const AVolume: TCubicMeters): TLitres;
    function From(const AVolume: TCubicDecimeters): TLitres;
  end;

var
  km: TKilometerIdentifier;
  km2:specialize TFactoredSquareUnitIdentifier<TMeter, TKilometer>;
  km3:specialize TFactoredCubicUnitIdentifier<TMeter, TKilometer>;
  km4:specialize TFactoredQuarticUnitIdentifier<TMeter, TKilometer>;
  m:  TMeterIdentifier;
  m2: TSquareMeterIdentifier;
  m3: TCubicMeterIdentifier;
  m4: TQuarticMeterIdentifier;
  cm: specialize TFactoredUnitIdentifier<TMeter, TCentimeter>;
  cm2:specialize TFactoredSquareUnitIdentifier<TMeter, TCentimeter>;
  cm3:specialize TFactoredCubicUnitIdentifier<TMeter, TCentimeter>;
  cm4:specialize TFactoredQuarticUnitIdentifier<TMeter, TCentimeter>;
  mm: TMillimeterIdentifier;
  mm2:TSquareMillimeterIdentifier;
  mm3:TCubicMillimeterIdentifier;
  mm4:specialize TFactoredQuarticUnitIdentifier<TMeter, TMillimeter>;
  um: TMicrometerIdentifier;
  nm: TNanometerIdentifier;
  pm: TPicometerIdentifier;

  L: TLitreIdentifier;

// combining units
operator /(const {%H-}m3: TCubicMeterIdentifier; const {%H-}m2: TSquareMeterIdentifier): TMeterIdentifier; inline;
operator /(const {%H-}m4: TQuarticMeterIdentifier; const {%H-}m3: TCubicMeterIdentifier): TMeterIdentifier; inline;
operator /(const {%H-}m4: TQuarticMeterIdentifier; const {%H-}m2: TSquareMeterIdentifier): TSquareMeterIdentifier; inline;

// combining dimensioned quantities
operator /(const AVolume: TCubicMeters; const ASurface: TSquareMeters): TMeters; inline;
operator /(const AMomentOfArea: TQuarticMeters; const AVolume: TCubicMeters): TMeters; inline;
operator /(const AMomentOfArea: TQuarticMeters; const AArea: TSquareMeters): TSquareMeters; inline;

// dimension equivalence
operator:=(const AVolume: TLitres): TCubicMeters;
operator:=(const AVolume: TLitres): TCubicDecimeters;

operator:=(const {%H-}m2: TSquareMeterIdentifier): TSquareMeterFactorIdentifier;
operator:=(const ASurface: TSquareMeters): TSquareMetersFactor;
operator:=(const ASurface: TSquareMetersFactor): TSquareMeters;
operator:=(const {%H-}mm2: TSquareMillimeterIdentifier): TSquareMillimeterFactorIdentifier;
operator:=(const ASurface: TSquareMillimeters): TSquareMillimetersFactor;
operator:=(const ASurface: TSquareMillimetersFactor): TSquareMillimeters;

operator:=(const {%H-}m3: TCubicMeterIdentifier): TCubicMeterFactorIdentifier;
operator:=(const AVolume: TCubicMeters): TCubicMetersFactor;
operator:=(const AVolume: TCubicMetersFactor): TCubicMeters;
operator:=(const {%H-}mm3: TCubicMillimeterIdentifier): TCubicMillimeterFactorIdentifier;
operator:=(const AVolume: TCubicMillimeters): TCubicMillimetersFactor;
operator:=(const AVolume: TCubicMillimetersFactor): TCubicMillimeters;

operator:=(const {%H-}m4: TQuarticMeterIdentifier): TQuarticMeterFactorIdentifier;
operator:=(const AHyperVolume: TQuarticMeters): TQuarticMetersFactor;
operator:=(const AHyperVolume: TQuarticMetersFactor): TQuarticMeters;

{ Units of mass }

type
  TGram = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TGramIdentifier = specialize TUnitIdentifier<TGram>;
  TGrams = specialize TDimensionedQuantity<TGram>;

  TMilligram = specialize TMilliUnit<TGram>;
  TMilligrams = specialize TFactoredDimensionedQuantity<TGram, TMilligram>;

  TKilogram = specialize TKiloUnit<TGram>;
  TKilogramIdentifier = specialize TFactoredUnitIdentifier<TGram, TKilogram>;
  TKilograms = specialize TFactoredDimensionedQuantity<TGram, TKilogram>;

  TTon = specialize TMegaUnit<TGram>;
  TTons = specialize TFactoredDimensionedQuantity<TGram, TTon>;

var
  mg: specialize TFactoredUnitIdentifier<TGram, TMilligram>;
  g: TGramIdentifier;
  kg: TKilogramIdentifier;
  ton: specialize TFactoredUnitIdentifier<TGram, TTon>;

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
  A2: specialize TSquareUnitIdentifier<TAmpere>;

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

/////////////////////// UNITS DERIVED FROM BASE UNITS ////////////////////////

{ Units of speed }

type
  TMeterPerSecond = specialize TRatioUnit<TMeter, TSecond>;
  TMeterPerSecondIdentifier = specialize TRatioUnitIdentifier<TMeter, TSecond>;
  TMetersPerSecond = specialize TRatioDimensionedQuantity<TMeter, TSecond>;

  TMillimeterPerSecond = specialize TFactoredNumeratorUnit<TMilliMeter, TSecond>;
  TMillimeterPerSecondIdentifier = specialize TFactoredNumeratorUnitIdentifier
                                           <TMeter, TSecond, TMilliMeter>;
  TMillimetersPerSecond = specialize TFactoredNumeratorDimensionedQuantity
                                   <TMeter, TSecond, TMilliMeter>;

  TKilometerPerHour = specialize TFactoredRatioUnit<TKilometer, THour>;
  TKilometerPerHourIdentifier = specialize TFactoredRatioUnitIdentifier
                                           <TMeter, TSecond, TKilometer, THour>;
  TKilometersPerHour = specialize TFactoredRatioDimensionedQuantity
                                  <TMeter, TSecond, TKilometer, THour>;

// combining units
operator /(const {%H-}m: TMeterIdentifier; const {%H-}s: TSecondIdentifier): TMeterPerSecondIdentifier; inline;
operator /(const {%H-}mm: TMillimeterIdentifier; const {%H-}s: TSecondIdentifier): TMillimeterPerSecondIdentifier; inline;
operator /(const {%H-}km: TKilometerIdentifier; const {%H-}h: THourIdentifier): TKilometerPerHourIdentifier; inline;

// combining dimensioned quantities
operator /(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond; inline;
operator /(const ALength: TMillimeters; const ADuration: TSeconds): TMillimetersPerSecond; inline;
operator /(const ALength: TKilometers; const ADuration: THours): TKilometersPerHour; inline;

{ Units of acceleration }

type
  TMeterPerSecondSquared = specialize TRatioUnit<TMeterPerSecond, TSecond>;
  TMeterPerSecondSquaredIdentifier = specialize TRatioUnitIdentifier<TMeterPerSecond, TSecond>;
  TMetersPerSecondSquared = specialize TRatioDimensionedQuantity<TMeterPerSecond, TSecond>;

  TKilometerPerHourPerSecondIdentifier = specialize TFactoredNumeratorUnitIdentifier
                                                    <TMeterPerSecond, TSecond, TKilometerPerHour>;
  TKilometersPerHourPerSecond = specialize TFactoredNumeratorDimensionedQuantity
                                           <TMeterPerSecond, TSecond, TKilometerPerHour>;

// combining units
operator /(const {%H-}m_s: TMeterPerSecondIdentifier; const {%H-}s: TSecondIdentifier): TMeterPerSecondSquaredIdentifier; inline;
operator /(const {%H-}m: TMeterIdentifier; const {%H-}s2: TSquareSecondIdentifier): TMeterPerSecondSquaredIdentifier; inline;
operator /(const {%H-}km_h: TKilometerPerHourIdentifier; const {%H-}s: TSecondIdentifier): TKilometerPerHourPerSecondIdentifier; inline;

// combining dimensioned quantities
operator /(const ASpeed: TMetersPerSecond; const ATime: TSeconds): TMetersPerSecondSquared; inline;
operator /(const ALength: TMeters; const ASquareTime: TSquareSeconds): TMetersPerSecondSquared; inline;
operator /(const ASpeed: TKilometersPerHour; const ATime: TSeconds): TKilometersPerHourPerSecond; inline;

{ Mechanical derived units }

type
  TGramPerCubicMeter = specialize TRatioUnit<TGram, TCubicMeter>;
  TGramPerCubicMeterIdentifier = specialize TRatioUnitIdentifier
                                            <TGram, TCubicMeter>;
  TGramsPerCubicMeter = specialize TRatioDimensionedQuantity
                                   <TGram, TCubicMeter>;

  TGramPerCubicMillimeter = specialize TFactoredDenominatorUnit<TGram, TCubicMillimeter>;
  TGramPerCubicMillimeterIdentifier = specialize TFactoredDenominatorUnitIdentifier
                                                 <TGram, TCubicMeter, TCubicMillimeter>;
  TGramsPerCubicMillimeter = specialize TFactoredDenominatorDimensionedQuantity
                                        <TGram, TCubicMeter, TCubicMillimeter>;

  TKilogramPerCubicMeter = specialize TFactoredNumeratorUnit<TKilogram, TCubicMeter>;
  TKilogramPerCubicMeterIdentifier = specialize TFactoredNumeratorUnitIdentifier
                                                <TGram, TCubicMeter, TKilogram>;
  TKilogramsPerCubicMeter = specialize TFactoredNumeratorDimensionedQuantity
                                       <TGram, TCubicMeter, TKilogram>;

  TKilogramPerCubicMillimeter = specialize TFactoredRatioUnit<TKilogram, TCubicMillimeter>;
  TKilogramPerCubicMillimeterIdentifier = specialize TFactoredRatioUnitIdentifier
                                          <TGram, TCubicMeter, TKilogram, TCubicMillimeter>;
  TKilogramsPerCubicMillimeter = specialize TFactoredRatioDimensionedQuantity
                                 <TGram, TCubicMeter, TKilogram, TCubicMillimeter>;

// combining units
operator /(const {%H-}g: TGramIdentifier; const {%H-}m3: TCubicMeterIdentifier): TGramPerCubicMeterIdentifier; inline;
operator /(const {%H-}g: TGramIdentifier; const {%H-}mm3: TCubicMillimeterIdentifier): TGramPerCubicMillimeterIdentifier; inline;

operator /(const {%H-}kg: TKilogramIdentifier; const {%H-}m3: TCubicMeterIdentifier): TKilogramPerCubicMeterIdentifier; inline;
operator /(const {%H-}kg: TKilogramIdentifier; const {%H-}mm3: TCubicMillimeterIdentifier): TKilogramPerCubicMillimeterIdentifier; inline;

// combining dimensioned quantities
operator /(const AMass: TGrams; const AVolume: TCubicMeters): TGramsPerCubicMeter; inline;
operator /(const AMass: TGrams; const AVolume: TCubicMillimeters): TGramsPerCubicMillimeter; inline;

operator /(const AMass: TKilograms; const AVolume: TCubicMeters): TKilogramsPerCubicMeter; inline;
operator /(const AMass: TKilograms; const AVolume: TCubicMillimeters): TKilogramsPerCubicMillimeter; inline;

//////////////////////////////// SPECIAL UNITS /////////////////////////////////

{ Special units }
type
  THertzIdentifier = specialize TReciprocalUnitIdentifier<TSecond>;
  THertz = specialize TReciprocalDimensionedQuantity<TSecond>;

  TKilohertz = specialize TFactoredReciprocalDimensionedQuantity
                          <TSecond, specialize TMilliUnit<TSecond>>;
  TMegahertz = specialize TFactoredReciprocalDimensionedQuantity
                          <TSecond, specialize TMicroUnit<TSecond>>;
  TGigahertz = specialize TFactoredReciprocalDimensionedQuantity
                          <TSecond, specialize TNanoUnit<TSecond>>;
  TTerahertz = specialize TFactoredReciprocalDimensionedQuantity
                          <TSecond, specialize TPicoUnit<TSecond>>;

  TRadian = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TRadianIdentifier = specialize TUnitIdentifier<TRadian>;
  TRadians = specialize TDimensionedQuantity<TRadian>;
  TSteradian = specialize TSquareUnit<TRadian>;
  TSteradianIdentifier = specialize TSquareUnitIdentifier<TRadian>;
  TSteradianFactorIdentifier = specialize TUnitIdentifier<TSteradian>;
  TSteradians = specialize TSquareDimensionedQuantity<TRadian>;
  TSteradiansFactor = specialize TDimensionedQuantity<TSteradian>;

  { TRadianHelper }

  TRadianHelper = record helper for TRadianIdentifier
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
  TDegreeIdentifier = specialize TFactoredUnitIdentifier<TRadian, TDegree>;
  TDegrees = specialize TFactoredDimensionedQuantity<TRadian, TDegree>;
  TSquareDegreeIdentifier = specialize TFactoredSquareUnitIdentifier<TRadian, TDegree>;
  TSquareDegrees = specialize TFactoredSquareDimensionedQuantity<TRadian, TDegree>;

  { TDegreeHelper }

  TDegreeHelper = record helper for TDegreeIdentifier
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

  TGramMeterIdentifier = specialize TUnitProductIdentifier<TGram, TMeter>;
  TGramMeters = specialize TDimensionedQuantityProduct<TGram, TMeter>;
  TKilogramMeterIdentifier = specialize TLeftFactoredUnitProductIdentifier
                                        <TGram, TMeter, TKilogram>;
  TKilogramMeters = specialize TLeftFactoredDimensionedQuantityProduct
                           <TGram, TMeter, TKilogram>;

  // the kg is also a base unit for special units in SI
  TBaseKilogram = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TBaseKilograms = specialize TDimensionedQuantity<TBaseKilogram>;

type
  TNewton = specialize TUnitProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtonIdentifier = specialize TUnitProductIdentifier<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtons = specialize TDimensionedQuantityProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TMillinewton = specialize TMilliUnit<TNewton>;
  TMillinewtonIdentifier = specialize TFactoredUnitIdentifier<TNewton, TMillinewton>;
  TMillinewtons = specialize TFactoredDimensionedQuantity<TNewton, TMillinewton>;
  TKilonewton = specialize TKiloUnit<TNewton>;
  TKilonewtonIdentifier = specialize TFactoredUnitIdentifier<TNewton, TKilonewton>;
  TKilonewtons = specialize TFactoredDimensionedQuantity<TNewton, TKilonewton>;

  TPascal = specialize TRatioUnit<TNewton, TSquareMeter>;
  TPascalIdentifier = specialize TRatioUnitIdentifier<TNewton, TSquareMeter>;
  TPascals = specialize TRatioDimensionedQuantity<TNewton, TSquareMeter>;

  TKilopascal = specialize TFactoredNumeratorUnit<TKilonewton, TSquareMeter>;
  TKilopascalIdentifier = specialize TFactoredNumeratorUnitIdentifier<TNewton, TSquareMeter, TKilonewton>;
  TKilopascals = specialize TFactoredNumeratorDimensionedQuantity<TNewton, TSquareMeter, TKilonewton>;

  TMegapascal = specialize TFactoredDenominatorUnit<TNewton, TSquareMillimeter>;
  TMegapascalIdentifier = specialize TFactoredDenominatorUnitIdentifier<TNewton, TSquareMeter, TSquareMillimeter>;
  TMegapascals = specialize TFactoredDenominatorDimensionedQuantity<TNewton, TSquareMeter, TSquareMillimeter>;

  TJoule = specialize TUnitProduct<TNewton, TMeter>;
  TJouleIdentifier = specialize TUnitProductIdentifier<TNewton, TMeter>;
  TJoules = specialize TDimensionedQuantityProduct<TNewton, TMeter>;

  TWatt = specialize TRatioUnit<TJoule, TSecond>;
  TWattIdentifier = specialize TRatioUnitIdentifier<TJoule, TSecond>;
  TWatts = specialize TRatioDimensionedQuantity<TJoule, TSecond>;

  TCoulomb = specialize TUnitProduct<TAmpere, TSecond>;
  TCoulombIdentifier = specialize TUnitProductIdentifier<TAmpere, TSecond>;
  TCoulombs = specialize TDimensionedQuantityProduct<TAmpere, TSecond>;

  TSquareCoulomb = specialize TSquareUnit<TCoulomb>;
  TSquareCoulombIdentifier = specialize TSquareUnitIdentifier<TCoulomb>;
  TSquareCoulombFactorIdentifier = specialize TUnitIdentifier<TSquareCoulomb>;
  TSquareCoulombs = specialize TSquareDimensionedQuantity<TCoulomb>;
  TSquareCoulombsFactor = specialize TDimensionedQuantity<TSquareCoulomb>;

  TVolt = specialize TRatioUnit<TJoule, TCoulomb>;
  TVoltIdentifier = specialize TRatioUnitIdentifier<TJoule, TCoulomb>;
  TVolts = specialize TRatioDimensionedQuantity<TJoule, TCoulomb>;

  TFarad = specialize TRatioUnit<TCoulomb, TVolt>;
  TFaradIdentifier = specialize TRatioUnitIdentifier<TCoulomb, TVolt>;
  TFarads = specialize TRatioDimensionedQuantity<TCoulomb, TVolt>;

  TMillifarads = specialize TFactoredDimensionedQuantity
                            <TFarad, specialize TMilliUnit<TFarad>>;
  TMicrofarads = specialize TFactoredDimensionedQuantity
                            <TFarad, specialize TMicroUnit<TFarad>>;
  TNanofarads = specialize TFactoredDimensionedQuantity
                           <TFarad, specialize TNanoUnit<TFarad>>;
  TPicofarads = specialize TFactoredDimensionedQuantity
                           <TFarad, specialize TPicoUnit<TFarad>>;

  TOhm = specialize TRatioUnit<TVolt, TAmpere>;
  TOhmIdentifier = specialize TRatioUnitIdentifier<TVolt, TAmpere>;
  TOhms = specialize TRatioDimensionedQuantity<TVolt, TAmpere>;

  TSiemensIdentifier = specialize TRatioUnitIdentifier<TAmpere, TVolt>;
  TSiemens = specialize TRatioDimensionedQuantity<TAmpere, TVolt>;

  TWeber = specialize TUnitProduct<TVolt, TSecond>;
  TWeberIdentifier = specialize TUnitProductIdentifier<TVolt, TSecond>;
  TWebers = specialize TDimensionedQuantityProduct<TVolt, TSecond>;

  TTesla = specialize TRatioUnit<TWeber, TSquareMeter>;
  TTeslaIdentifier = specialize TRatioUnitIdentifier<TWeber, TSquareMeter>;
  TTeslas = specialize TRatioDimensionedQuantity<TWeber, TSquareMeter>;

  THenry = specialize TRatioUnit<TWeber, TAmpere>;
  THenryIdentifier = specialize TRatioUnitIdentifier<TWeber, TAmpere>;
  THenrys = specialize TRatioDimensionedQuantity<TWeber, TAmpere>;

  TLumen = specialize TUnitProduct<TCandela, TSteradian>;
  TLumenIdentifer = specialize TUnitProductIdentifier<TCandela, TSteradian>;
  TLumens = specialize TDimensionedQuantityProduct<TCandela, TSteradian>;

  TLuxIdentifier = specialize TRatioUnitIdentifier<TLumen, TSquareMeter>;
  TLuxQuantity = specialize TRatioDimensionedQuantity<TLumen, TSquareMeter>;

  TBecquerel = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TBecquerelIdentifier = specialize TUnitIdentifier<TBecquerel>;
  TBecquerels = specialize TDimensionedQuantity<TBecquerel>;

  { TBecquerelHelper }

  TBecquerelHelper = record helper for TBecquerelIdentifier
    function From(const AFrequency: THertz): TBecquerels;
    function Inverse: TSecond;
  end;

  TKilobecquerel = specialize TKiloUnit<TBecquerel>;
  TKilobecquerelIdentifier = specialize TFactoredUnitIdentifier<TBecquerel, TKilobecquerel>;
  TKilobecquerels = specialize TFactoredDimensionedQuantity<TBecquerel, TKilobecquerel>;

  TMegabecquerel = specialize TMegaUnit<TBecquerel>;
  TMegabecquerelIdentifier = specialize TFactoredUnitIdentifier<TBecquerel, TMegabecquerel>;
  TMegabecquerels = specialize TFactoredDimensionedQuantity<TBecquerel, TMegabecquerel>;

  TCurie = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TCurieIdentifier = specialize TFactoredUnitIdentifier<TBecquerel, TCurie>;
  TCuries = specialize TFactoredDimensionedQuantity<TBecquerel, TCurie>;

  TGrayIdentifier = specialize TRatioUnitIdentifier<TJoule, TBaseKilogram>;
  TGrays = specialize TRatioDimensionedQuantity<TJoule, TBaseKilogram>;

  TSievertIdentifier = specialize TRatioUnitIdentifier
                                  <TSquareMeter, specialize TSquareUnit<TSecond>>;
  TSieverts = specialize TRatioDimensionedQuantity
                         <TSquareMeter, specialize TSquareUnit<TSecond>>;

  TKatalIdentifier = specialize TRatioUnitIdentifier<TMole, TSecond>;
  TKatals = specialize TRatioDimensionedQuantity<TMole, TSecond>;

var
  Hz: THertzIdentifier;
  kHz: specialize TFactoredReciprocalUnitIdentifier<TSecond, specialize TMilliUnit<TSecond>>;
  MHz: specialize TFactoredReciprocalUnitIdentifier<TSecond, specialize TMicroUnit<TSecond>>;
  GHz: specialize TFactoredReciprocalUnitIdentifier<TSecond, specialize TNanoUnit<TSecond>>;
  THz: specialize TFactoredReciprocalUnitIdentifier<TSecond, specialize TPicoUnit<TSecond>>;
  rad: TRadianIdentifier;
  sr: TSteradianIdentifier;
  deg: TDegreeIdentifier;
  deg2: TSquareDegrees;
  N: TNewtonIdentifier;
  kN: TKilonewtonIdentifier;
  Pa: TPascalIdentifier;
  kPa: TKilopascalIdentifier;
  MPa: TMegapascalIdentifier;
  J: TJouleIdentifier;
  C: TCoulombIdentifier;
  C2: TSquareCoulombIdentifier;
  lm: TLumenIdentifer;
  lx: TLuxIdentifier;
  Gy: TGrayIdentifier;
  Sv: TSievertIdentifier;
  kat: TKatalIdentifier;
  W: TWattIdentifier;
  V: TVoltIdentifier;
  F: TFaradIdentifier;
  mF: specialize TFactoredUnitIdentifier<TFarad, specialize TMilliUnit<TFarad>>;
  uF: specialize TFactoredUnitIdentifier<TFarad, specialize TMicroUnit<TFarad>>;
  nF: specialize TFactoredUnitIdentifier<TFarad, specialize TNanoUnit<TFarad>>;
  pF: specialize TFactoredUnitIdentifier<TFarad, specialize TPicoUnit<TFarad>>;
  ohm: TOhmIdentifier;
  siemens, mho: TSiemensIdentifier;
  Wb: TWeberIdentifier;
  T: TTeslaIdentifier;
  henry: THenryIdentifier;
  Bq: TBecquerelIdentifier;
  kBq: TKilobecquerel;
  MBq: TMegabecquerel;
  Ci: TCurieIdentifier;

// dimension equivalence
operator:=(const AWeight: TKilograms): TBaseKilograms;
operator:=(const AWeight: TGrams): TBaseKilograms;
operator:=(const AWeight: TBaseKilograms): TKilograms;
operator:=(const AWeight: TBaseKilograms): TGrams;
operator:=(const AEquivalentDose: TSieverts): TGrays;
operator:=(const AAbsorbedDose: TGrays): TSieverts;
operator:=(const ARadioactivity: TBecquerels): THertz;

operator:=(const {%H-}sr: TSteradianIdentifier): TSteradianFactorIdentifier;
operator:=(const ASolidAngle: TSteradians): TSteradiansFactor;
operator:=(const ASolidAngle: TSteradiansFactor): TSteradians;

operator:=(const {%H-}C2: TSquareCoulombIdentifier): TSquareCoulombFactorIdentifier;
operator:=(const ASquareCharge: TSquareCoulombs): TSquareCoulombsFactor;
operator:=(const ASquareCharge: TSquareCoulombsFactor): TSquareCoulombs;

// combining units
operator /(const {%H-}m_s: TMeterPerSecondIdentifier; const {%H-}m: TMeterIdentifier): THertzIdentifier; inline;
operator /(const {%H-}mm_s: TMillimeterPerSecondIdentifier; const {%H-}mm: TMillimeterIdentifier): THertzIdentifier; inline;

operator *(const {%H-}g: TGramIdentifier; const {%H-}m: TMeterIdentifier): TGramMeterIdentifier; inline;
operator *(const {%H-}kg: TKilogramIdentifier; const {%H-}m: TMeterIdentifier): TKilogramMeterIdentifier; inline;

operator *(const {%H-}g: TGramIdentifier; const {%H-}m_s2: TMeterPerSecondSquaredIdentifier): TMillinewtonIdentifier; inline;
operator *(const {%H-}m_s2: TMeterPerSecondSquaredIdentifier; const {%H-}g: TGramIdentifier): TMillinewtonIdentifier; inline;
operator /(const {%H-}mN: TMillinewtonIdentifier; const {%H-}g: TGramMeterIdentifier): TMeterPerSecondSquaredIdentifier; inline;

operator *(const {%H-}kg: TKilogramIdentifier; const {%H-}m_s2: TMeterPerSecondSquaredIdentifier): TNewtonIdentifier; inline;
operator *(const {%H-}g: TGramMeterIdentifier; const {%H-}m_s2: TMeterPerSecondSquaredIdentifier): TMillinewtonIdentifier;
operator *(const {%H-}m_s2: TMeterPerSecondSquaredIdentifier; const {%H-}kg: TKilogramIdentifier): TNewtonIdentifier; inline;
operator *(const {%H-}m_s2: TMeterPerSecondSquaredIdentifier; const {%H-}g: TGramMeterIdentifier): TMillinewtonIdentifier; inline;
operator /(const {%H-}N: TNewtonIdentifier; const {%H-}kg: TKilogramIdentifier): TMeterPerSecondSquaredIdentifier; inline;

operator /(const {%H-}N: TNewtonIdentifier; const {%H-}m2: TSquareMeterIdentifier): TPascalIdentifier; inline;
operator /(const {%H-}N: TNewtonIdentifier; const {%H-}mm2: TSquareMillimeterIdentifier): TMegapascalIdentifier; inline;
operator /(const {%H-}kN: TKilonewtonIdentifier; const {%H-}m2: TSquareMeterIdentifier): TKilopascalIdentifier; inline;

operator *(const {%H-}N: TNewtonIdentifier; const {%H-}m: TMeterIdentifier): TJouleIdentifier; inline;
operator *(const {%H-}m: TMeterIdentifier; const {%H-}N: TNewtonIdentifier): TJouleIdentifier; inline;
operator /(const {%H-}J: TJouleIdentifier; const {%H-}N: TNewtonIdentifier): TMeterIdentifier; inline;

operator /(const {%H-}J: TJouleIdentifier; const {%H-}s: TSecondIdentifier): TWattIdentifier; inline;

operator /(const {%H-}J: TJouleIdentifier; const {%H-}C: TCoulombIdentifier): TVoltIdentifier; inline;
// alternative definition of V = W / A
operator /(const {%H-}W: TWattIdentifier; const {%H-}A: TAmpereIdentifier): TVoltIdentifier; inline;
operator /(const {%H-}W: TWattIdentifier; const {%H-}V: TVoltIdentifier): TAmpereIdentifier; inline;
operator *(const {%H-}A: TAmpereIdentifier; const {%H-}V: TVoltIdentifier): TWattIdentifier; inline;
operator *(const {%H-}V: TVoltIdentifier; const {%H-}A: TAmpereIdentifier): TWattIdentifier; inline;

operator /(const {%H-}C: TCoulombIdentifier; const {%H-}V: TVoltIdentifier): TFaradIdentifier; inline;
// alternative definition of F = C2 / J
operator /(const {%H-}C2: TSquareCoulombIdentifier; const {%H-}J: TJouleIdentifier): TFaradIdentifier; inline;
operator /(const {%H-}C2: TSquareCoulombIdentifier; const {%H-}F: TFaradIdentifier): TJouleIdentifier; inline;
operator *(const {%H-}J: TJouleIdentifier; const {%H-}F: TFaradIdentifier): TSquareCoulombIdentifier; inline;
operator *(const {%H-}F: TFaradIdentifier; const {%H-}J: TJouleIdentifier): TSquareCoulombIdentifier; inline;

operator *(const {%H-}A: TAmpereIdentifier; const {%H-}s: TSecondIdentifier): TCoulombIdentifier; inline;
operator *(const {%H-}s: TSecondIdentifier; const {%H-}A: TAmpereIdentifier): TCoulombIdentifier; inline;
operator /(const {%H-}C: TCoulombIdentifier; const {%H-}A: TAmpereIdentifier): TSecondIdentifier; inline;

operator /(const {%H-}V: TVoltIdentifier; const {%H-}A: TAmpereIdentifier): TOhmIdentifier; inline;
// alternative definition of Ω = s / F
operator /(const {%H-}s: TSecondIdentifier; const {%H-}F: TFaradIdentifier): TOhmIdentifier; inline;
operator /(const {%H-}s: TSecondIdentifier; const {%H-}Ohm: TOhmIdentifier): TFaradIdentifier; inline;
operator *(const {%H-}F: TFaradIdentifier; const {%H-}Ohm: TOhmIdentifier): TSecondIdentifier; inline;
operator *(const {%H-}Ohm: TOhmIdentifier; const {%H-}F: TFaradIdentifier): TSecondIdentifier; inline;

operator /(const {%H-}A: TAmpereIdentifier; const {%H-}V: TVoltIdentifier): TSiemensIdentifier; inline;
// alternative definition of S = 1 / Ω
operator /(const {%H-}AValue: double; const {%H-}Ohm: TOhmIdentifier): TSiemensIdentifier; inline;
operator /(const {%H-}AValue: double; const {%H-}S: TSiemensIdentifier): TOhmIdentifier; inline;

operator *(const {%H-}V: TVoltIdentifier; const {%H-}s: TSecondIdentifier): TWeberIdentifier; inline;
operator *(const {%H-}s: TSecondIdentifier; const {%H-}V: TVoltIdentifier): TWeberIdentifier; inline;
operator /(const {%H-}Wb: TWeberIdentifier; const {%H-}V: TVoltIdentifier): TSecondIdentifier; inline;

operator /(const {%H-}Wb: TWeberIdentifier; const {%H-}m2: TSquareMeterIdentifier): TTeslaIdentifier; inline;

operator /(const {%H-}Wb: TWeberIdentifier; const {%H-}A: TAmpereIdentifier): THenryIdentifier; inline;

operator *(const {%H-}cd: TCandelaIdentifier; const {%H-}sr: TSteradianIdentifier): TLumenIdentifer; inline;
operator *(const {%H-}sr: TSteradianIdentifier; const {%H-}cd: TCandelaIdentifier): TLumenIdentifer; inline;
operator /(const {%H-}lm: TLumenIdentifer; const {%H-}cd: TCandelaIdentifier): TSteradianIdentifier; inline;

operator /(const {%H-}lm: TLumenIdentifer; const {%H-}m2: TSquareMeterIdentifier): TLuxIdentifier; inline;

operator /(const {%H-}J: TJouleIdentifier; const {%H-}kg: TKilogramIdentifier): TGrayIdentifier; inline;

operator /(const {%H-}m2: TSquareMeterIdentifier; const {%H-}s2: TSquareSecondIdentifier): TSievertIdentifier; inline;

operator /(const {%H-}mol: TMoleIdentifier; const {%H-}s: TSecondIdentifier): TKatalIdentifier; inline;

// combining dimensioned quantities
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

operator /(const AWork: TJoules; const ACharge: TCoulombs): TVolts; inline;
// alternative definition of V = W / A
operator /(const APower: TWatts; const ACurrent: TAmperes): TVolts; inline;
operator /(const APower: TWatts; const AVoltage: TVolts): TAmperes; inline;
operator *(const ACurrent: TAmperes; const AVoltage: TVolts): TWatts; inline;
operator *(const AVoltage: TVolts; const ACurrent: TAmperes): TWatts; inline;

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

operator /(const AArea: TSquareMeters; const ASquareTime: TSquareSeconds): TSieverts; inline;

operator /(const AAmountOfSustance: TMoles; const ATime: TSeconds): TKatals; inline;

////////////////////// UNITS DERIVED FROM SPECIAL UNITS ////////////////////////

{ Units of speed }

type
  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondIdentifier = specialize TRatioUnitIdentifier<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioDimensionedQuantity<TRadian, TSecond>;

// combining units
operator /(const {%H-}rad: TRadianIdentifier; const {%H-}s: TSecondIdentifier): TRadianPerSecondIdentifier; inline;

// combining dimensioned quantities
operator /(const AAngle: TRadians; const ADuration: TSeconds): TRadiansPerSecond; inline;

{ Units of acceleration }

type
  TRadianPerSecondSquaredIdentifier = specialize TRatioUnitIdentifier<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioDimensionedQuantity<TRadianPerSecond, TSecond>;

// combining units
operator /(const {%H-}rad_s: TRadianPerSecondIdentifier; const {%H-}s: TSecondIdentifier): TRadianPerSecondSquaredIdentifier; inline;
operator /(const {%H-}rad: TRadianIdentifier; const {%H-}s2: TSquareSecondIdentifier): TRadianPerSecondSquaredIdentifier; inline;

// combining dimensioned quantities
operator /(const ASpeed: TRadiansPerSecond; const ATime: TSeconds): TRadiansPerSecondSquared; inline;
operator /(const AAngle: TRadians; const ASquareTime: TSquareSeconds): TRadiansPerSecondSquared; inline;

{ Mechanical derived units }

type
  TNewtonPerMeter = specialize TRatioUnit<TNewton, TMeter>;
  TNewtonPerMeterIdentifier = specialize TRatioUnitIdentifier<TNewton, TMeter>;
  TNewtonsPerMeter = specialize TRatioDimensionedQuantity<TNewton, TMeter>;

  TNewtonPerMilliMeter = specialize TFactoredDenominatorUnit<TNewton, TMilliMeter>;
  TNewtonPerMilliMeterIdentifier = specialize TFactoredDenominatorUnitIdentifier<TNewton, TMeter, TMilliMeter>;
  TNewtonsPerMilliMeter = specialize TFactoredDenominatorDimensionedQuantity<TNewton, TMeter, TMilliMeter>;

// combining units
operator /(const {%H-}N: TNewtonIdentifier; const {%H-}m: TMeterIdentifier): TNewtonPerMeterIdentifier; inline;
operator /(const {%H-}N: TNewtonIdentifier; const {%H-}mm: TMillimeterIdentifier): TNewtonPerMillimeterIdentifier; inline;

operator *(const {%H-}Pa: TPascalIdentifier; const {%H-}m: TMeterIdentifier): TNewtonPerMeterIdentifier; inline;
operator *(const {%H-}m: TMeterIdentifier; const {%H-}Pa: TPascalIdentifier): TNewtonPerMeterIdentifier; inline;
operator *(const {%H-}MPa: TMegapascalIdentifier; const {%H-}mm: TMillimeterIdentifier): TNewtonPerMillimeterIdentifier; inline;
operator *(const {%H-}mm: TMillimeterIdentifier; const {%H-}MPa: TMegapascalIdentifier): TNewtonPerMillimeterIdentifier; inline;

// combining dimensioned quantities
operator /(const AForce: TNewtons; const ALength: TMeters): TNewtonsPerMeter; inline;
operator /(const AForce: TNewtons; const ALength: TMillimeters): TNewtonsPerMillimeter; inline;

operator *(const APressure: TPascals; const ALength: TMeters): TNewtonsPerMeter; inline;
operator *(const ALength: TMeters; const APressure: TPascals): TNewtonsPerMeter; inline;
operator *(const APressure: TMegapascals; const ALength: TMillimeters): TNewtonsPerMillimeter; inline;
operator *(const ALength: TMillimeters; const APressure: TMegapascals): TNewtonsPerMillimeter; inline;

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
  'm2/s2': result := 'Sv';
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
  'square meter per square second': result := 'sievert';
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

{$UNDEF INCLUDING}{$ENDIF}
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
{$IFNDEF INCLUDING}{$DEFINE INCLUDING}

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

{$UNDEF INCLUDING}{$ENDIF}
// generic implementation of TUnitIdentifier
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
  class operator T_UNIT_ID.*(const TheUnit1, TheUnit2: TSelf): TSquareIdentifier;
  begin end;

  class operator T_UNIT_ID./(const TheSquareUnit: TSquareIdentifier;
                             const TheUnit: TSelf): TSelf;
  begin end;


  class operator T_UNIT_ID.*(const TheUnit: TSelf;
    const TheSquareUnit: TSquareIdentifier): TCubicIdentifier;
  begin end;

  class operator T_UNIT_ID.*(const TheSquareUnit: TSquareIdentifier;
    const TheUnit: TSelf): TCubicIdentifier;
  begin end;

  class operator T_UNIT_ID./(const TheCubicUnit: TCubicIdentifier;
                             const TheUnit: TSelf): TSquareIdentifier;
  begin end;


  class operator T_UNIT_ID.*(const TheCubicUnit: TCubicIdentifier;
    const TheUnit: TSelf): TQuarticIdentifier;
  begin end;

  class operator T_UNIT_ID.*(const TheUnit: TSelf;
    const TheCubicUnit: TCubicIdentifier): TQuarticIdentifier;
  begin end;

  class operator T_UNIT_ID./(const TheQuarticUnit: TQuarticIdentifier;
                             const TheUnit: TSelf): TCubicIdentifier;
  begin end;


  function T_UNIT_ID.Squared: TSquareIdentifier; begin end;
  function T_UNIT_ID.Cubed: TCubicIdentifier; begin end;
  function T_UNIT_ID.Quarted: TQuarticIdentifier; begin end;

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
{$IFNDEF INCLUDING}{$DEFINE INCLUDING}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TQuarticUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TCubicUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TSquareUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE SQUARABLE_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TBasicUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE RECIP_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TReciprocalUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RECIP_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredReciprocalUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TRatioUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TUnitProductIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredQuarticUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredCubicUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredSquareUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE SQUARABLE_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredRatioUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredNumeratorUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE RATIO_UNIT_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredDenominatorUnitIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TFactoredUnitProductIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TLeftFactoredUnitProductIdentifier}{$i dim.pas}

{$DEFINE UNIT_ID_IMPL}{$DEFINE FACTORED_UNIT_ID_IMPL}{$DEFINE UNIT_PROD_ID_IMPL}
{$DEFINE T_UNIT_ID:=TRightFactoredUnitProductIdentifier}{$i dim.pas}

{ Dimensioned quantities }

{$UNDEF INCLUDING}{$ENDIF}
{$IF defined(BASIC_DIM_QTY_IMPL) or defined(DIM_QTY_IMPL)}
  function T_DIM_QUANTITY.ToString: string;
  begin
    result := FormatValue(Value) + ' ' + U.Symbol;
  end;

  function T_DIM_QUANTITY.ToVerboseString: string;
  begin
    result := FormatValue(Value) + ' ' + FormatUnitName(U.Name, Value);
  end;

  function T_DIM_QUANTITY.Abs: TSelf;
  begin
    result.Value := System.Abs(Value);
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
  class operator T_DIM_QUANTITY.*(const AQuantity1, AQuantity2: TSelf): TSquareQuantity;
  begin
    result.Value := AQuantity1.Value * AQuantity2.Value;
  end;

  class operator T_DIM_QUANTITY./(const ASquareQuantity: TSquareQuantity;
    const AQuantity: TSelf): TSelf;
  begin
    result.Value := ASquareQuantity.Value / AQuantity.Value;
  end;


  class operator T_DIM_QUANTITY.*(
  const ASquareQuantity: TSquareQuantity; const AQuantity: TSelf): TCubicQuantity;
  begin
    result.Value := ASquareQuantity.Value * AQuantity.Value;
  end;

  class operator T_DIM_QUANTITY.*(const AQuantity: TSelf;
  const ASquareQuantity: TSquareQuantity): TCubicQuantity;
  begin
    result.Value := AQuantity.Value * ASquareQuantity.Value;
  end;

  class operator T_DIM_QUANTITY./(const ACubicQuantity: TCubicQuantity;
    const AQuantity: TSelf): TSquareQuantity;
  begin
    result.Value := ACubicQuantity.Value / AQuantity.Value;
  end;


  class operator T_DIM_QUANTITY.*(const AQuantity: TSelf;
  const ACubicQuantity: TCubicQuantity): TQuarticQuantity;
  begin
    result.Value := AQuantity.Value * ACubicQuantity.Value;
  end;

  class operator T_DIM_QUANTITY.*(const ACubicQuantity: TCubicQuantity;
  const AQuantity: TSelf): TQuarticQuantity;
  begin
    result.Value := ACubicQuantity.Value * AQuantity.Value;
  end;

  class operator T_DIM_QUANTITY./(const AQuarticQuantity: TQuarticQuantity;
  const AQuantity: TSelf): TCubicQuantity;
  begin
    result.Value := AQuarticQuantity.Value / AQuantity.Value;
  end;


  function T_DIM_QUANTITY.Squared: TSquareQuantity;
  begin
    result.Value := sqr(self.Value);
  end;

  function T_DIM_QUANTITY.Cubed: TCubicQuantity;
  begin
    result.Value := sqr(self.Value) * self.Value;
  end;

  function T_DIM_QUANTITY.Quarted: TQuarticQuantity;
  begin
    result.Value := sqr(self.Value) * sqr(self.Value);
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

  class operator T_DIM_QUANTITY.:=(const ARatio: TDimensionedRatio): TSelf;
  begin
    result.Value := ARatio.Value;
  end;

  class operator T_DIM_QUANTITY.:=(const ASelf: TSelf): TDimensionedRatio;
  begin
    result.Value := ASelf.Value;
  end;
  {$IFDEF FACTORED_QTY_IMPL}
  class operator T_DIM_QUANTITY.:=(const ASelf: TSelf): TBaseDimensionedRatio;
  begin
    result.Value := ASelf.ToBase.Value;
  end;
  {$ENDIF}
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

  class operator T_DIM_QUANTITY.:=(const AProduct: TDimensionedProduct): TSelf;
  begin
    result.Value := AProduct.Value;
  end;

  class operator T_DIM_QUANTITY.:=(const ASelf: TSelf): TDimensionedProduct;
  begin
    result.Value := ASelf.Value;
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
{$IFNDEF INCLUDING}{$DEFINE INCLUDING}

{$DEFINE DIM_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TQuarticDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TCubicDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TSquareDimensionedQuantity}{$i dim.pas}

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
{$DEFINE T_DIM_QUANTITY:=TFactoredQuarticDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredCubicDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredSquareDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE SQUARABLE_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RECIP_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredReciprocalDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredRatioDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredNumeratorDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE RATIO_QTY_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredDenominatorDimensionedQuantity}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_DIM_QUANTITY:=TFactoredDimensionedQuantityProduct}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_DIM_QUANTITY:=TLeftFactoredDimensionedQuantityProduct}{$i dim.pas}

{$DEFINE DIM_QTY_IMPL}{$DEFINE FACTORED_QTY_IMPL}{$DEFINE QTY_PROD_IMPL}
{$DEFINE T_DIM_QUANTITY:=TRightFactoredDimensionedQuantityProduct}{$i dim.pas}

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

operator:=(const s2: TSquareSecondIdentifier): TSquareSecondFactorIdentifier;
begin end;

operator:=(const ASquareTime: TSquareSeconds): TSquareSecondsFactor;
begin
  result.Value := ASquareTime.Value;
end;

operator:=(const ASquareTime: TSquareSecondsFactor): TSquareSeconds;
begin
  result.Value := ASquareTime.Value;
end;

operator /(const {%H-}m3: TCubicMeterIdentifier; const {%H-}m2: TSquareMeterIdentifier): TMeterIdentifier;
begin end;

operator /(const {%H-}m4: TQuarticMeterIdentifier; const {%H-}m3: TCubicMeterIdentifier): TMeterIdentifier;
begin end;

operator /(const {%H-}m4: TQuarticMeterIdentifier; const {%H-}m2: TSquareMeterIdentifier): TSquareMeterIdentifier;
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

operator:=(const m2: TSquareMeterIdentifier): TSquareMeterFactorIdentifier;
begin end;

operator:=(const ASurface: TSquareMeters): TSquareMetersFactor;
begin
  result.Value := ASurface.Value;
end;

operator:=(const mm2: TSquareMillimeterIdentifier): TSquareMillimeterFactorIdentifier;
begin end;

operator:=(const ASurface: TSquareMillimeters): TSquareMillimetersFactor;
begin
  result.Value := ASurface.Value;
end;

operator:=(const m3: TCubicMeterIdentifier): TCubicMeterFactorIdentifier;
begin end;

operator:=(const AVolume: TCubicMeters): TCubicMetersFactor;
begin
  result.Value := AVolume.Value;
end;

operator:=(const mm3: TCubicMillimeterIdentifier): TCubicMillimeterFactorIdentifier;
begin end;

operator:=(const AVolume: TCubicMillimeters): TCubicMillimetersFactor;
begin
  result.Value := AVolume.Value;
end;

operator:=(const m4: TQuarticMeterIdentifier): TQuarticMeterFactorIdentifier;
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

operator /(const mm: TMillimeterIdentifier; const s: TSecondIdentifier): TMillimeterPerSecondIdentifier;
begin end;

operator /(const {%H-}km: TKilometerIdentifier; const {%H-}h: THourIdentifier): TKilometerPerHourIdentifier;
begin end;

// combining dimensioned quantities
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

operator:=(const AEquivalentDose: TSieverts): TGrays;
begin
  result.Value := AEquivalentDose.Value;
end;

operator:=(const AAbsorbedDose: TGrays): TSieverts;
begin
  result.Value := AAbsorbedDose.Value;
end;

operator:=(const ARadioactivity: TBecquerels): THertz;
begin
  result.Value := ARadioactivity.Value;
end;

// combining units
operator/(const rad: TRadianIdentifier; const s: TSecondIdentifier): TRadianPerSecondIdentifier;
begin end;

operator/(const rad_s: TRadianPerSecondIdentifier; const s: TSecondIdentifier): TRadianPerSecondSquaredIdentifier;
begin end;

operator/(const rad: TRadianIdentifier; const s2: TSquareSecondIdentifier): TRadianPerSecondSquaredIdentifier;
begin end;

operator:=(const sr: TSteradianIdentifier): TSteradianFactorIdentifier;
begin end;

operator:=(const ASolidAngle: TSteradians): TSteradiansFactor;
begin
  result.Value := ASolidAngle.Value;
end;

operator:=(const ASolidAngle: TSteradiansFactor): TSteradians;
begin
  result.Value := ASolidAngle.Value;
end;

operator:=(const C2: TSquareCoulombIdentifier): TSquareCoulombFactorIdentifier;
begin end;

operator:=(const ASquareCharge: TSquareCoulombs): TSquareCoulombsFactor;
begin
  result.Value := ASquareCharge.Value;
end;

operator:=(const ASquareCharge: TSquareCoulombsFactor): TSquareCoulombs;
begin
  result.Value := ASquareCharge.Value;
end;

operator /(const m_s: TMeterPerSecondIdentifier; const m: TMeterIdentifier): THertzIdentifier;
begin end;

operator /(const mm_s: TMillimeterPerSecondIdentifier; const mm: TMillimeterIdentifier): THertzIdentifier;
begin end;

operator*(const g: TGramIdentifier; const m: TMeterIdentifier): TGramMeterIdentifier;
begin end;

operator*(const kg: TKilogramIdentifier; const m: TMeterIdentifier): TKilogramMeterIdentifier;
begin end;

operator*(const g: TGramIdentifier; const m_s2: TMeterPerSecondSquaredIdentifier): TMillinewtonIdentifier;
begin end;

operator *(const m_s2: TMeterPerSecondSquaredIdentifier; const g: TGramIdentifier): TMillinewtonIdentifier;
begin end;

operator /(const mN: TMillinewtonIdentifier; const g: TGramMeterIdentifier): TMeterPerSecondSquaredIdentifier;
begin end;

operator*(const kg: TKilogramIdentifier; const m_s2: TMeterPerSecondSquaredIdentifier): TNewtonIdentifier;
begin end;

operator*(const g: TGramMeterIdentifier; const m_s2: TMeterPerSecondSquaredIdentifier): TMillinewtonIdentifier;
begin end;

operator *(const m_s2: TMeterPerSecondSquaredIdentifier; const kg: TKilogramIdentifier): TNewtonIdentifier;
begin end;

operator*(const m_s2: TMeterPerSecondSquaredIdentifier; const g: TGramMeterIdentifier): TMillinewtonIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const kg: TKilogramIdentifier): TMeterPerSecondSquaredIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const m2: TSquareMeterIdentifier): TPascalIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const mm2: TSquareMillimeterIdentifier): TMegapascalIdentifier;
begin end;

operator/(const kN: TKilonewtonIdentifier; const m2: TSquareMeterIdentifier): TKilopascalIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const m: TMeterIdentifier): TNewtonPerMeterIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const mm: TMillimeterIdentifier): TNewtonPerMillimeterIdentifier;
begin end;

operator *(const Pa: TPascalIdentifier; const m: TMeterIdentifier): TNewtonPerMeterIdentifier;
begin end;

operator *(const m: TMeterIdentifier; const Pa: TPascalIdentifier): TNewtonPerMeterIdentifier;
begin end;

operator *(const MPa: TMegapascalIdentifier; const mm: TMillimeterIdentifier): TNewtonPerMillimeterIdentifier;
begin end;

operator *(const mm: TMillimeterIdentifier; const MPa: TMegapascalIdentifier): TNewtonPerMillimeterIdentifier;
begin end;

operator *(const N: TNewtonIdentifier; const m: TMeterIdentifier): TJouleIdentifier;
begin end;

operator *(const m: TMeterIdentifier; const N: TNewtonIdentifier): TJouleIdentifier;
begin end;

operator /(const J: TJouleIdentifier; const N: TNewtonIdentifier): TMeterIdentifier;
begin end;

operator /(const J: TJouleIdentifier; const s: TSecondIdentifier): TWattIdentifier;
begin end;

operator /(const J: TJouleIdentifier; const C: TCoulombIdentifier): TVoltIdentifier;
begin end;

operator /(const W: TWattIdentifier; const A: TAmpereIdentifier): TVoltIdentifier;
begin end;

operator /(const W: TWattIdentifier; const V: TVoltIdentifier): TAmpereIdentifier;
begin end;

operator *(const A: TAmpereIdentifier; const V: TVoltIdentifier): TWattIdentifier;
begin end;

operator *(const V: TVoltIdentifier; const A: TAmpereIdentifier): TWattIdentifier;
begin end;

operator /(const C: TCoulombIdentifier; const V: TVoltIdentifier): TFaradIdentifier;
begin end;

operator /(const C2: TSquareCoulombIdentifier; const J: TJouleIdentifier): TFaradIdentifier;
begin end;

operator /(const C2: TSquareCoulombIdentifier; const F: TFaradIdentifier): TJouleIdentifier;
begin end;

operator *(const J: TJouleIdentifier; const F: TFaradIdentifier): TSquareCoulombIdentifier;
begin end;

operator *(const F: TFaradIdentifier; const J: TJouleIdentifier): TSquareCoulombIdentifier;
begin end;

operator *(const A: TAmpereIdentifier; const s: TSecondIdentifier): TCoulombIdentifier;
begin end;

operator *(const s: TSecondIdentifier; const A: TAmpereIdentifier): TCoulombIdentifier;
begin end;

operator /(const C: TCoulombIdentifier; const A: TAmpereIdentifier): TSecondIdentifier;
begin end;

operator /(const V: TVoltIdentifier; const A: TAmpereIdentifier): TOhmIdentifier;
begin end;

operator /(const s: TSecondIdentifier; const F: TFaradIdentifier): TOhmIdentifier;
begin end;

operator /(const s: TSecondIdentifier; const Ohm: TOhmIdentifier): TFaradIdentifier;
begin end;

operator *(const F: TFaradIdentifier; const Ohm: TOhmIdentifier): TSecondIdentifier;
begin end;

operator *(const Ohm: TOhmIdentifier; const F: TFaradIdentifier): TSecondIdentifier;
begin end;

operator /(const A: TAmpereIdentifier; const V: TVoltIdentifier): TSiemensIdentifier;
begin end;

operator /(const AValue: double; const Ohm: TOhmIdentifier): TSiemensIdentifier;
begin end;

operator /(const AValue: double; const S: TSiemensIdentifier): TOhmIdentifier;
begin end;

operator *(const V: TVoltIdentifier; const s: TSecondIdentifier): TWeberIdentifier;
begin end;

operator *(const s: TSecondIdentifier; const V: TVoltIdentifier): TWeberIdentifier;
begin end;

operator /(const Wb: TWeberIdentifier; const V: TVoltIdentifier): TSecondIdentifier;
begin end;

operator /(const Wb: TWeberIdentifier; const m2: TSquareMeterIdentifier): TTeslaIdentifier;
begin end;

operator /(const Wb: TWeberIdentifier; const A: TAmpereIdentifier): THenryIdentifier;
begin end;

operator *(const cd: TCandelaIdentifier; const sr: TSteradianIdentifier): TLumenIdentifer;
begin end;

operator *(const sr: TSteradianIdentifier; const cd: TCandelaIdentifier): TLumenIdentifer;
begin end;

operator /(const lm: TLumenIdentifer; const cd: TCandelaIdentifier): TSteradianIdentifier;
begin end;

operator/(const lm: TLumenIdentifer; const m2: TSquareMeterIdentifier): TLuxIdentifier;
begin end;

operator /(const J: TJouleIdentifier; const kg: TKilogramIdentifier): TGrayIdentifier;
begin end;

operator/(const m2: TSquareMeterIdentifier; const s2: TSquareSecondIdentifier): TSievertIdentifier;
begin end;

operator/(const mol: TMoleIdentifier; const s: TSecondIdentifier): TKatalIdentifier;
begin end;

operator /(const g: TGramIdentifier; const m3: TCubicMeterIdentifier): TGramPerCubicMeterIdentifier;
begin end;

operator /(const g: TGramIdentifier; const mm3: TCubicMillimeterIdentifier): TGramPerCubicMillimeterIdentifier;
begin end;

operator /(const kg: TKilogramIdentifier; const m3: TCubicMeterIdentifier): TKilogramPerCubicMeterIdentifier;
begin end;

operator /(const kg: TKilogramIdentifier; const mm3: TCubicMillimeterIdentifier): TKilogramPerCubicMillimeterIdentifier;
begin end;

// combining dimensioned quantities
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

operator *(const AForce: TNewtons; const ALength: TMeters): TJoules;
begin
  result.Value := AForce.Value * ALength.Value;
end;

operator *(const ALength: TMeters; const AForce: TNewtons): TJoules; inline;
begin
  result.Value := ALength.Value * AForce.Value;
end;

operator /(const AWork: TJoules; const AForce: TNewtons): TMeters; inline;
begin
  result.Value := AWork.Value / AForce.Value;
end;

operator /(const AWork: TJoules; const ATime: TSeconds): TWatts;
begin
  result.Value := AWork.Value / ATime.Value;
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

operator/(const AArea: TSquareMeters; const ASquareTime: TSquareSeconds): TSieverts;
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


