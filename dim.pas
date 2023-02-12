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

  generic TMegaUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TKiloUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic THectoUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TDecaUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TDeciUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TCentiUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TMilliUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  generic TMicroUnit<U: TUnit> = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}

  { Dimensionned quantities }

  {$UNDEF INCLUDING}{$ENDIF}
  // simulate inheritance for TDimensionedQuantity record
  {$IF defined(BASIC_DIM_QTY_INTF) or defined(DIM_QTY_INTF)}
  public
    Value: double;
    function ToString: string;
    function ToVerboseString: string;
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
    type TCubicIdentifier = specialize TCubicUnitIdentifier<U>;
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
    type TCubicIdentifier = specialize TFactoredCubicUnitIdentifier<BaseU, U>;
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

{ Units of time }

type
  TSecond = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TSecondIdentifier = specialize TUnitIdentifier<TSecond>;
  TSeconds = specialize TDimensionedQuantity<TSecond>;

  TMilliseconds = specialize TFactoredDimensionedQuantity<TSecond, specialize TMilliUnit<TSecond>>;

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
  TSquareSecondIdentifier = specialize TSquareUnitIdentifier<TSecond>;
  TSquareSeconds = specialize TSquareDimensionedQuantity<TSecond>;

var
  ms: specialize TFactoredUnitIdentifier<TSecond, specialize TMilliUnit<TSecond>>;
  s: TSecondIdentifier;
  s2: TSquareSecondIdentifier;
  mn: specialize TFactoredUnitIdentifier<TSecond, TMinute>;
  h: THourIdentifier;
  day: specialize TFactoredUnitIdentifier<TSecond, TDay>;

{ Units of length }

type
  TMeter = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TMeterIdentifier = specialize TUnitIdentifier<TMeter>;
  TMeters = specialize TDimensionedQuantity<TMeter>;

  TSquareMeter = specialize TSquareUnit<TMeter>;
  TSquareMeterIdentifier = specialize TSquareUnitIdentifier<TMeter>;
  TSquareMeters = specialize TSquareDimensionedQuantity<TMeter>;
  TSquareMetersFactor = specialize TDimensionedQuantity<TSquareMeter>;

  TCubicMeter = specialize TCubicUnit<TMeter>;
  TCubicMeterIdentifier = specialize TCubicUnitIdentifier<TMeter>;
  TCubicMeters = specialize TCubicDimensionedQuantity<TMeter>;
  TCubicMetersFactor = specialize TDimensionedQuantity<TCubicMeter>;

  TQuarticMeterIdentifier = specialize TQuarticUnitIdentifier<TMeter>;
  TQuarticMeters = specialize TQuarticDimensionedQuantity<TMeter>;
  TQuarticMetersFactor = specialize TDimensionedQuantity<specialize TQuarticUnit<TMeter>>;

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
  TMillimeters = specialize TFactoredDimensionedQuantity<TMeter, TMillimeter>;

  TSquareMillimeter = specialize TFactoredSquareUnit<TMillimeter>;
  TSquareMillimeterIdentifier = specialize TFactoredSquareUnitIdentifier<TMeter, TMillimeter>;
  TSquareMillimeters = specialize TFactoredSquareDimensionedQuantity<TMeter, TMillimeter>;
  TSquareMillimetersFactor = specialize TFactoredDimensionedQuantity<TSquareMeter, TSquareMillimeter>;

  TCubicMillimeters = specialize TFactoredCubicDimensionedQuantity<TMeter, TMillimeter>;
  TQuarticMillimeters = specialize TFactoredQuarticDimensionedQuantity<TMeter, TMillimeter>;

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
  mm: specialize TFactoredUnitIdentifier<TMeter, TMillimeter>;
  mm2:specialize TFactoredSquareUnitIdentifier<TMeter, TMillimeter>;
  mm3:specialize TFactoredCubicUnitIdentifier<TMeter, TMillimeter>;
  mm4:specialize TFactoredQuarticUnitIdentifier<TMeter, TMillimeter>;

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

operator:=(const ASurface: TSquareMeters): TSquareMetersFactor;
operator:=(const ASurface: TSquareMillimeters): TSquareMillimetersFactor;
operator:=(const AVolume: TCubicMeters): TCubicMetersFactor;
operator:=(const AHyperVolume: TQuarticMeters): TQuarticMetersFactor;
operator:=(const ASurface: TSquareMetersFactor): TSquareMeters;
operator:=(const ASurface: TSquareMillimetersFactor): TSquareMillimeters;
operator:=(const AVolume: TCubicMetersFactor): TCubicMeters;
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

  // the kg is also a base unit for special units in SI
  TBaseKilogram = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TBaseKilograms = specialize TDimensionedQuantity<TBaseKilogram>;

  TTon = specialize TMegaUnit<TGram>;
  TTons = specialize TFactoredDimensionedQuantity<TGram, TTon>;

var
  mg: specialize TFactoredUnitIdentifier<TGram, TMilligram>;
  g: TGramIdentifier;
  kg: TKilogramIdentifier;
  ton: specialize TFactoredUnitIdentifier<TGram, TTon>;

// dimension equivalence
operator:=(const AWeight: TKilograms): TBaseKilograms;
operator:=(const AWeight: TBaseKilograms): TGrams;

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

{ Units of speed }

type
  TMeterPerSecond = specialize TRatioUnit<TMeter, TSecond>;
  TMeterPerSecondIdentifier = specialize TRatioUnitIdentifier<TMeter, TSecond>;
  TMetersPerSecond = specialize TRatioDimensionedQuantity<TMeter, TSecond>;

  TKilometerPerHour = specialize TFactoredRatioUnit<TKilometer, THour>;
  TKilometerPerHourIdentifier = specialize TFactoredRatioUnitIdentifier
                                           <TMeter, TSecond, TKilometer, THour>;
  TKilometersPerHour = specialize TFactoredRatioDimensionedQuantity
                                  <TMeter, TSecond, TKilometer, THour>;

// combining units
operator /(const {%H-}m: TMeterIdentifier; const {%H-}s: TSecondIdentifier): TMeterPerSecondIdentifier; inline;
operator /(const {%H-}km: TKilometerIdentifier; const {%H-}h: THourIdentifier): TKilometerPerHourIdentifier; inline;

// combining dimensioned quantities
operator /(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond; inline;
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

{ Special units }
type
  THertzIdentifier = specialize TReciprocalUnitIdentifier<TSecond>;
  TFrequency = specialize TReciprocalDimensionedQuantity<TSecond>;

  TRadian = {$DEFINE UNIT_OV_INTF}{$i dim.pas}
  TRadianIdentifier = specialize TUnitIdentifier<TRadian>;
  TRadians = specialize TDimensionedQuantity<TRadian>;

  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondIdentifier = specialize TRatioUnitIdentifier<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioDimensionedQuantity<TRadian, TSecond>;

  TRadianPerSecondSquaredIdentifier = specialize TRatioUnitIdentifier<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioDimensionedQuantity<TRadianPerSecond, TSecond>;

  TDegree = {$DEFINE FACTORED_UNIT_INTF}{$i dim.pas}
  TDegreeIdentifier = specialize TFactoredUnitIdentifier<TRadian, TDegree>;
  TDegrees = specialize TFactoredDimensionedQuantity<TRadian, TDegree>;

  TGramMeterIdentifier = specialize TUnitProductIdentifier<TGram, TMeter>;
  TGramMeters = specialize TDimensionedQuantityProduct<TGram, TMeter>;
  TKilogramMeterIdentifier = specialize TLeftFactoredUnitProductIdentifier
                                        <TGram, TMeter, TKilogram>;
  TKilogramMeters = specialize TLeftFactoredDimensionedQuantityProduct
                           <TGram, TMeter, TKilogram>;

  TNewton = specialize TUnitProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtonIdentifier = specialize TUnitProductIdentifier<TBaseKilogram, TMeterPerSecondSquared>;
  TNewtons = specialize TDimensionedQuantityProduct<TBaseKilogram, TMeterPerSecondSquared>;
  TMillinewton = specialize TMilliUnit<TNewton>;
  TMillinewtonIdentifier = specialize TFactoredUnitIdentifier<TNewton, TMillinewton>;
  TMillinewtons = specialize TFactoredDimensionedQuantity<TNewton, TMillinewton>;
  TKilonewton = specialize TKiloUnit<TNewton>;
  TKilonewtonIdentifier = specialize TFactoredUnitIdentifier<TNewton, TKilonewton>;
  TKilonewtons = specialize TFactoredDimensionedQuantity<TNewton, TKilonewton>;

  TNewtonPerMeter = specialize TRatioUnit<TNewton, TMeter>;
  TNewtonPerMeterIdentifier = specialize TRatioUnitIdentifier<TNewton, TMeter>;
  TNewtonsPerMeter = specialize TRatioDimensionedQuantity<TNewton, TMeter>;

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
  TJouleIdentifer = specialize TUnitProductIdentifier<TNewton, TMeter>;
  TJoules = specialize TDimensionedQuantityProduct<TNewton, TMeter>;

  TCoulombIdentifer = specialize TUnitProductIdentifier<TAmpere, TSecond>;
  TCoulombs = specialize TDimensionedQuantityProduct<TAmpere, TSecond>;

  TLuxIdentifier = specialize TRatioUnitIdentifier<TCandela, specialize TSquareUnit<TMeter>>;
  TLuxQuantity = specialize TRatioDimensionedQuantity<TCandela, specialize TSquareUnit<TMeter>>;

  TSievertIdentifier = specialize TRatioUnitIdentifier
                                  <specialize TSquareUnit<TMeter>, specialize TSquareUnit<TSecond>>;
  TSieverts = specialize TRatioDimensionedQuantity
                         <specialize TSquareUnit<TMeter>, specialize TSquareUnit<TSecond>>;

  TKatalIdentifier = specialize TRatioUnitIdentifier<TMole, TSecond>;
  TKatals = specialize TRatioDimensionedQuantity<TMole, TSecond>;

  TGramPerCubicMeter = specialize TRatioUnit<TGram, TCubicMeter>;
  TGramPerCubicMeterIdentifier = specialize TRatioUnitIdentifier
                                            <TGram, TCubicMeter>;
  TGramsPerCubicMeter = specialize TRatioDimensionedQuantity
                                   <TGram, TCubicMeter>;

  TKilogramPerCubicMeter = specialize TFactoredNumeratorUnit<TKilogram, TCubicMeter>;
  TKilogramPerCubicMeterIdentifier = specialize TFactoredNumeratorUnitIdentifier
                                                <TGram, TCubicMeter, TKilogram>;
  TKilogramsPerCubicMeter = specialize TFactoredNumeratorDimensionedQuantity
                                       <TGram, TCubicMeter, TKilogram>;

var
  Hz: THertzIdentifier;
  rad: TRadianIdentifier;
  deg: TDegreeIdentifier;
  N: TNewtonIdentifier;
  kN: TKilonewtonIdentifier;
  C: TCoulombIdentifer;
  lx: TLuxIdentifier;
  Sv: TSievertIdentifier;
  kat: TKatalIdentifier;
  Pa: TPascalIdentifier;
  kPa: TKilopascalIdentifier;
  MPa: TMegapascalIdentifier;
  J: TJouleIdentifer;
  rho: TKilogramPerCubicMeterIdentifier;

// combining units
operator /(const {%H-}rad: TRadianIdentifier; const {%H-}s: TSecondIdentifier): TRadianPerSecondIdentifier; inline;
operator /(const {%H-}rad_s: TRadianPerSecondIdentifier; const {%H-}s: TSecondIdentifier): TRadianPerSecondSquaredIdentifier; inline;
operator /(const {%H-}m: TRadianIdentifier; const {%H-}s2: TSquareSecondIdentifier): TRadianPerSecondSquaredIdentifier; inline;

operator *(const {%H-}g: TGramIdentifier; const {%H-}m: TMeterIdentifier): TGramMeterIdentifier; inline;
operator *(const {%H-}kg: TKilogramIdentifier; const {%H-}m: TMeterIdentifier): TKilogramMeterIdentifier; inline;

operator *(const {%H-}g: TGramIdentifier; const {%H-}m_s2: TMeterPerSecondSquaredIdentifier): TMillinewtonIdentifier; inline;
operator *(const {%H-}kg: TKilogramIdentifier; const {%H-}m_s2: TMeterPerSecondSquaredIdentifier): TNewtonIdentifier; inline;
operator /(const {%H-}g: TGramMeterIdentifier; const {%H-}s2: TSquareSecondIdentifier): TMillinewtonIdentifier; inline;
operator /(const {%H-}kg: TKilogramMeterIdentifier; const {%H-}s2: TSquareSecondIdentifier): TNewtonIdentifier; inline;

operator /(const {%H-}N: TNewtonIdentifier; const {%H-}m2: TSquareMeterIdentifier): TPascalIdentifier; inline;
operator /(const {%H-}N: TNewtonIdentifier; const {%H-}mm2: TSquareMillimeterIdentifier): TMegapascalIdentifier; inline;
operator /(const {%H-}kN: TKilonewtonIdentifier; const {%H-}m2: TSquareMeterIdentifier): TKilopascalIdentifier; inline;

operator /(const {%H-}N: TNewtonIdentifier; const {%H-}m: TMeterIdentifier): TNewtonPerMeterIdentifier; inline;

operator *(const {%H-}N: TNewtonIdentifier; const {%H-}m: TMeterIdentifier): TJouleIdentifer; inline;

operator *(const {%H-}A: TAmpereIdentifier; const {%H-}s: TSecondIdentifier): TCoulombIdentifer; inline;

operator /(const {%H-}g: TGramIdentifier; const {%H-}m3: TCubicMeterIdentifier): TGramPerCubicMeterIdentifier; inline;
operator /(const {%H-}kg: TKilogramIdentifier; const {%H-}m3: TCubicMeterIdentifier): TKilogramPerCubicMeterIdentifier; inline;

// combining dimensioned quantities
operator /(const AValue: double; const ADuration: TSeconds): TFrequency; inline;

operator /(const AAngle: TRadians; const ADuration: TSeconds): TRadiansPerSecond; inline;
operator /(const ASpeed: TRadiansPerSecond; const ATime: TSeconds): TRadiansPerSecondSquared; inline;
operator /(const AAngle: TRadians; const ASquareTime: TSquareSeconds): TRadiansPerSecondSquared; inline;

operator *(const AWeight: TGrams; const ALength: TMeters): TGramMeters; inline;
operator *(const AWeight: TKilograms; const ALength: TMeters): TKilogramMeters; inline;

operator *(const AWeight: TGrams; const AAcceleration: TMetersPerSecondSquared): TMillinewtons; inline;
operator *(const AAcceleration: TMetersPerSecondSquared; const AWeight: TGrams): TMillinewtons; inline;
operator *(const AWeight: TKilograms; const AAcceleration: TMetersPerSecondSquared): TNewtons; inline;
operator *(const AAcceleration: TMetersPerSecondSquared; const AWeight: TKilograms): TNewtons; inline;

operator /(const AForce: TNewtons; const AArea: TSquareMeters): TPascals; inline;
operator /(const AForce: TNewtons; const AArea: TSquareMillimeters): TMegapascals; inline;
operator /(const AForce: TKilonewtons; const AArea: TSquareMeters): TKilopascals; inline;
operator /(const AForce: TKilonewtons; const AArea: TSquareMillimeters): TMegapascals; inline;

operator /(const AForce: TNewtons; const ALength: TMeters): TNewtonsPerMeter; inline;

operator *(const AForce: TNewtons; const ALength: TMeters): TJoules; inline;

operator *(const ACurrent: TAmperes; const ADuration: TSeconds): TCoulombs; inline;

operator /(const AMass: TGrams; const AVolume: TCubicMeters): TGramsPerCubicMeter; inline;
operator /(const AMass: TKilograms; const AVolume: TCubicMeters): TKilogramsPerCubicMeter; inline;

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
  'cd/m2': result := 'lx';
  'm2/s2': result := 'Sv';
  'mol/s': result := 'kat';
  'N/m2': result := 'Pa';
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
  'candela per square meter': result := 'lux';
  'square meter per square second': result := 'sievert';
  'mole per second': result := 'katal';
  'newton per square meter': result := 'pascal';
  end;
end;

function GetProductSymbol(ALeftSymbol, ARightSymbol: string): string;
begin
  result := ALeftSymbol + '.' + ARightSymbol;

  case result of
  's.A', 'A.s': result := 'C';
  'kg.m/s2': result := 'N';
  'N.m': result := 'J';
  end;
end;

function GetProductName(ALeftName, ARightName: string): string;
begin
  result := ALeftName + '-' + ARightName;

  case result of
  'ampere-second', 'second-ampere': result := 'coulomb';
  'kilogram-meter per second squared': result := 'newton';
  'newton-meter': result := 'joule';
  end;
end;

{ TCustomUnit }

class function TCustomUnit.GetPowerSymbol(AExponent: integer): string;
begin
  result := Symbol + IntToStr(AExponent);

  case result of
  's-1': result := 'Hz';
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

operator:=(const ASurface: TSquareMeters): TSquareMetersFactor;
begin
  result.Value := ASurface.Value;
end;

operator:=(const ASurface: TSquareMillimeters): TSquareMillimetersFactor;
begin
  result.Value := ASurface.Value;
end;

operator:=(const AVolume: TCubicMeters): TCubicMetersFactor;
begin
  result.Value := AVolume.Value;
end;

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

operator:=(const AWeight: TKilograms): TBaseKilograms;
begin
  result.Value := AWeight.Value;
end;

operator:=(const AWeight: TBaseKilograms): TGrams;
begin
  result.Value := AWeight.Value * 1000;
end;

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

operator /(const {%H-}km: TKilometerIdentifier; const {%H-}h: THourIdentifier): TKilometerPerHourIdentifier;
begin end;

// combining dimensioned quantities
operator/(const ALength: TMeters; const ADuration: TSeconds): TMetersPerSecond;
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

class function TDegree.Factor: double; begin result := Pi/180; end;
class function TDegree.Symbol: string; begin result := 'º'; end;
class function TDegree.Name: string;   begin result := 'degree'; end;

// combining units
operator/(const rad: TRadianIdentifier; const s: TSecondIdentifier): TRadianPerSecondIdentifier;
begin end;

operator/(const rad_s: TRadianPerSecondIdentifier; const s: TSecondIdentifier): TRadianPerSecondSquaredIdentifier;
begin end;

operator/(const m: TRadianIdentifier; const s2: TSquareSecondIdentifier): TRadianPerSecondSquaredIdentifier;
begin end;

operator*(const g: TGramIdentifier; const m: TMeterIdentifier): TGramMeterIdentifier;
begin end;

operator*(const kg: TKilogramIdentifier; const m: TMeterIdentifier): TKilogramMeterIdentifier;
begin end;

operator*(const g: TGramIdentifier; const m_s2: TMeterPerSecondSquaredIdentifier): TMillinewtonIdentifier;
begin end;

operator*(const kg: TKilogramIdentifier; const m_s2: TMeterPerSecondSquaredIdentifier): TNewtonIdentifier;
begin end;

operator/(const g: TGramMeterIdentifier; const s2: TSquareSecondIdentifier): TMillinewtonIdentifier;
begin end;

operator/(const kg: TKilogramMeterIdentifier; const s2: TSquareSecondIdentifier): TNewtonIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const m2: TSquareMeterIdentifier): TPascalIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const mm2: TSquareMillimeterIdentifier): TMegapascalIdentifier;
begin end;

operator/(const kN: TKilonewtonIdentifier; const m2: TSquareMeterIdentifier): TKilopascalIdentifier;
begin end;

operator /(const N: TNewtonIdentifier; const m: TMeterIdentifier): TNewtonPerMeterIdentifier;
begin end;

operator *(const N: TNewtonIdentifier; const m: TMeterIdentifier): TJouleIdentifer;
begin end;

operator *(const A: TAmpereIdentifier; const s: TSecondIdentifier): TCoulombIdentifer;
begin end;

operator /(const g: TGramIdentifier; const m3: TCubicMeterIdentifier): TGramPerCubicMeterIdentifier;
begin end;

operator /(const kg: TKilogramIdentifier; const m3: TCubicMeterIdentifier): TKilogramPerCubicMeterIdentifier;
begin end;

// combining dimensioned quantities
operator/(const AValue: double; const ADuration: TSeconds): TFrequency;
begin
  result.Value := AValue / ADuration.Value;
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

operator *(const AWeight: TGrams; const ALength: TMeters): TGramMeters; inline;
begin
  result.Value := AWeight.Value * ALength.Value;
end;

operator *(const AWeight: TKilograms; const ALength: TMeters): TKilogramMeters; inline;
begin
  result.Value := AWeight.Value * ALength.Value;
end;

operator*(const AWeight: TGrams; const AAcceleration: TMetersPerSecondSquared ): TMillinewtons;
begin
  result.Value := AWeight.Value * AAcceleration.Value;
end;

operator*(const AAcceleration: TMetersPerSecondSquared; const AWeight: TGrams): TMillinewtons;
begin
  result.Value := AWeight.Value * AAcceleration.Value;
end;

operator*(const AWeight: TKilograms; const AAcceleration: TMetersPerSecondSquared): TNewtons;
begin
  result.Value := AWeight.Value * AAcceleration.Value;
end;

operator*(const AAcceleration: TMetersPerSecondSquared; const AWeight: TKilograms): TNewtons;
begin
  result.Value := AWeight.Value * AAcceleration.Value;
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

operator *(const AForce: TNewtons; const ALength: TMeters): TJoules;
begin
  result.Value := AForce.Value * ALength.Value;
end;

operator*(const ACurrent: TAmperes; const ADuration: TSeconds): TCoulombs;
begin
  result.Value := ACurrent.Value * ADuration.Value;
end;

operator /(const AMass: TGrams; const AVolume: TCubicMeters): TGramsPerCubicMeter;
begin
  result.Value := AMass.Value / AVolume.Value;
end;

operator /(const AMass: TKilograms; const AVolume: TCubicMeters): TKilogramsPerCubicMeter;
begin
  result.Value := AMass.Value / AVolume.Value;
end;

end.
{$ENDIF}


