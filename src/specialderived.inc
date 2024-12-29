////////////////////// UNITS DERIVED FROM SPECIAL UNITS ////////////////////////

{ Units of angular speed }
{$IFDEF INTF}
type
  TRadianPerSecond = specialize TRatioUnit<TRadian, TSecond>;
  TRadianPerSecondId = specialize TRatioUnitId<TRadian, TSecond>;
  TRadiansPerSecond = specialize TRatioQuantity<TRadian, TSecond>;
{$ENDIF}

{ main definition [ rad/s ] = [ rad ] / [ s ] }
{$DEFINE NumId:=TRadianId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TRadianPerSecondId}
{$DEFINE NumQty:=TRadians}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TRadiansPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ rad/s ] = [ m/s ] / [ m ] }
{$DEFINE NumtId:=TMeterPerSecondId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatiodId:=TRadianPerSecondId}
{$DEFINE NumQty:=TMetersPerSecond}{$DEFINE DenomQty:=TMeters}{$DEFINE RatiodQty:=TRadiansPerSecond}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ Units of squared angular speed }
{$IFDEF INTF}
type
  TSteradianPerSquareSecond = specialize TSquareUnit<TRadianPerSecond>;
  TSteradianPerSquareSecondId = specialize TSquareUnitId<TRadianPerSecond>;
  TSteradianPerSquareSecondFactorId = specialize TUnitId<TSteradianPerSquareSecond>;
  TSteradiansPerSquareSecond = specialize TSquareQuantity<TRadianPerSecond>;
  TSteradiansPerSquareSecondFactor = specialize TQuantity<TSteradianPerSquareSecond>;
{$ENDIF}

{ main definition [ sr/s2 ] = [ rad/s ] * [ rad/s ] }
operator *(const {%H-}ALeft: TRadianPerSecondId; const {%H-}ARight: TRadianPerSecondId): TSteradianPerSquareSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator *(const ALeft: TRadiansPerSecond; const ARight: TRadiansPerSecond): TSteradiansPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := ALeft.Value * ARight.Value; end;{$ENDIF}

{ alternative definition [ sr/s2 ] / [ rad/s ] = [ rad/s ] }
operator /(const {%H-}ANum: TSteradianPerSquareSecondId; const {%H-}ADenom: TRadianPerSecondId): TRadianPerSecondId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator /(const ANum: TSteradiansPerSquareSecond; const ADenom: TRadiansPerSecond): TRadiansPerSecond; inline;
{$IFDEF IMPL}begin result.Value := ANum.Value / ADenom.Value; end;{$ENDIF}

{ alternative definition [ sr/s2 ] = [ sr ] / [ s2 ] }
{$DEFINE NumId:=TSteradianId}{$DEFINE DenomId:=TSquareSecondId}{$DEFINE RatioId:=TSteradianPerSquareSecondId}
{$DEFINE NumQty:=TSteradians}{$DEFINE DenomQty:=TSquareSeconds}{$DEFINE RatioQty:=TSteradiansPerSquareSecond}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ sr/s2 ] = [ m/s2 ] / [ m ] }
{$DEFINE NumId:=TMeterPerSecondSquaredId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TSteradianPerSquareSecondId}
{$DEFINE NumQty:=TMetersPerSecondSquared}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TSteradiansPerSquareSecond}
{$DEFINE ALT_RATIO}{$i dim.pas}

// equivalences
operator:=(const {%H-}AQuantityId: TSteradianPerSquareSecondId): TSteradianPerSquareSecondFactorId; inline;
{$IFDEF IMPL}begin end;{$ENDIF}
operator:=(const AQuantity: TSteradiansPerSquareSecond): TSteradiansPerSquareSecondFactor; inline;
{$IFDEF IMPL}begin result.Value := AQuantity.Value; end;{$ENDIF}
operator:=(const AQuantity: TSteradiansPerSquareSecondFactor): TSteradiansPerSquareSecond; inline;
{$IFDEF IMPL}begin result.Value := AQuantity.Value; end;{$ENDIF}

{ Units of angular acceleration }
{$IFDEF INTF}
type
  TRadianPerSecondSquaredId = specialize TRatioUnitId<TRadianPerSecond, TSecond>;
  TRadiansPerSecondSquared = specialize TRatioQuantity<TRadianPerSecond, TSecond>;
{$ENDIF}

{ main definition [ rad/s2 ] = [ rad/s ] / [ s ] }
{$DEFINE NumId:=TRadianPerSecondId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TRadianPerSecondSquaredId}
{$DEFINE NumQty:=TRadiansPerSecond}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TRadiansPerSecondSquared}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternate definition [ rad/s2 ] * [ s2 ] = [ rad ] }
{$DEFINE LeftId:=TRadianPerSecondSquaredId}{$DEFINE RightId:=TSquareSecondId}{$DEFINE ProdId:=TRadianId}
{$DEFINE LeftQty:=TRadiansPerSecondSquared}{$DEFINE RightQty:=TSquareSeconds}{$DEFINE ProdQty:=TRadians}
{$DEFINE ALT_PROD}{$i dim.pas}

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

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TNewtonPerMeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TNewtonsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // N/m = N / m

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TMillimeterId}{$DEFINE RatioId:=TNewtonPerMillimeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TMillimeters}{$DEFINE RatioQty:=TNewtonsPerMillimeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // N/mm = N / mm

{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TCubicMeterId}{$DEFINE RatioId:=TNewtonPerCubicMeterId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TCubicMeters}{$DEFINE RatioQty:=TNewtonsPerCubicMeter}
{$DEFINE DEF_RATIO}{$i dim.pas} // N/m3 = N / m3

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

{$DEFINE NumId:=TPascalId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TNewtonPerCubicMeterId}
{$DEFINE NumQty:=TPascals}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TNewtonsPerCubicMeter}
{$DEFINE ALT_RATIO}{$i dim.pas} // N/m3 = Pa / m

{$DEFINE LeftId:=TKilogramPerCubicMeterId}{$DEFINE RightId:=TMeterPerSecondSquaredId}{$DEFINE ProdId:=TNewtonPerCubicMeterId}
{$DEFINE LeftQty:=TKilogramsPerCubicMeter}{$DEFINE RightQty:=TMetersPerSecondSquared}{$DEFINE ProdQty:=TNewtonsPerCubicMeter}
{$DEFINE ALT_PROD}{$i dim.pas} // N/m3 = kg/m3 * m/s2

{$DEFINE LeftId:=TPascalSecondId}{$DEFINE RightId:=TMeterId}{$DEFINE ProdId:=TKilogramPerSecondId}
{$DEFINE LeftQty:=TPascalSeconds}{$DEFINE RightQty:=TMeters}{$DEFINE ProdQty:=TKilogramsPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas} // kg/s = Pa*s * m

// MOMENTUM & IMPULSE

{$IFDEF INTF}
type
  TKilogramMeterPerSecond = specialize TUnitProduct<TBaseKilogram, TMeterPerSecond>;
  TKilogramMeterPerSecondId = specialize TUnitProductId<TBaseKilogram, TMeterPerSecond>;
  TKilogramMetersPerSecond = specialize TQuantityProduct<TBaseKilogram, TMeterPerSecond>;
{$ENDIF}

{ main definition [ kg*m/s ] = [kg ] * [ m/s ] }
{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TMeterPerSecondId}{$DEFINE ProdId:=TKilogramMeterPerSecondId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TMetersPerSecond}{$DEFINE ProdQty:=TKilogramMetersPerSecond}
{$DEFINE DEF_PROD}{$i dim.pas}

{ alternative definition [ kg*m/s ] = [ N ] * [ s ] }
{$DEFINE LeftId:=TNewtonId}{$DEFINE RightId:=TSecondId}{$DEFINE ProdId:= TKilogramMeterPerSecondId}
{$DEFINE LeftQty:=TNewtons}{$DEFINE RightQty:=TSeconds}{$DEFINE ProdQty:=TKilogramMetersPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas}

// ANGULAR MOMENTUM & ANGULAR IMPULSE

{$IFDEF INTF}
type
  TKilogramSquareMeter = specialize TUnitProduct<TBaseKilogram, TSquareMeter>;
  TKilogramSquareMeterId = specialize TUnitProductId<TBaseKilogram, TSquareMeter>;
  TKilogramSquareMeters = specialize TQuantityProduct<TBaseKilogram, TSquareMeter>;
{$ENDIF}

{ main definition [ kg*m2 ] = [ kg ] * [ m2 ] }
{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TSquareMeterId}{$DEFINE ProdId:=TKilogramSquareMeterId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TSquareMeters}{$DEFINE ProdQty:=TKilogramSquareMeters}
{$DEFINE DEF_PROD}{$i dim.pas}

{ alternative definition [ kg*m2 ] * [ sr/s2 ] = [ J ] }
{$DEFINE LeftId:=TKilogramSquareMeterId}{$DEFINE RightId:=TSteradianPerSquareSecondId}{$DEFINE ProdId:=TJouleId}
{$DEFINE LeftQty:=TKilogramSquareMeters}{$DEFINE RightQty:=TSteradiansPerSquareSecond}{$DEFINE ProdQty:=TJoules}
{$DEFINE ALT_PROD}{$i dim.pas}

// ANGULAR MOMENTUM & ANGULAR IMPULSE

{$IFDEF INTF}
type
  TKilogramSquareMeterPerSecond = specialize TRatioUnit<TKilogramSquareMeter, TSecond>;
  TKilogramSquareMeterPerSecondId = specialize TRatioUnitId<TKilogramSquareMeter, TSecond>;
  TKilogramSquareMetersPerSecond = specialize TRatioQuantity<TKilogramSquareMeter, TSecond>;
{$ENDIF}

{ main definition [ kg*m2/s ] = [ kg*m2 ] / [ s ] }
{$DEFINE NumId:=TKilogramSquareMeterId}{$DEFINE DenomId:=TSecondId}{$DEFINE RatioId:=TKilogramSquareMeterPerSecondId}
{$DEFINE NumQty:=TKilogramSquareMeters}{$DEFINE DenomQty:=TSeconds}{$DEFINE RatioQty:=TKilogramSquareMetersPerSecond}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ kg*m2/s ] = [ kg*m2 ] * [ rad/s ] }
{$DEFINE LeftId:=TKilogramSquareMeterId}{$DEFINE RightId:=TRadianPerSecondId}{$DEFINE ProdId:=TKilogramSquareMeterPerSecondId}
{$DEFINE LeftQty:=TKilogramSquareMeters}{$DEFINE RightQty:=TRadiansPerSecond}{$DEFINE ProdQty:=TKilogramSquareMetersPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas}

{ alternative definition [ kg*m2/s ] = [ N*m ] * [s] = [ J ] * [ s ] }
{$DEFINE LeftId:=TJouleId}{$DEFINE RightId:=TSecondId}{$DEFINE ProdId:=TKilogramSquareMeterPerSecondId}
{$DEFINE LeftQty:=TJoules}{$DEFINE RightQty:=TSeconds}{$DEFINE ProdQty:=TKilogramSquareMetersPerSecond}
{$DEFINE ALT_PROD}{$i dim.pas}

{ Heat and Thermodynamics }

{$IFDEF INTF}
type
  // HEAT CAPACITY

  TJoulePerKelvin = specialize TRatioUnit<TJoule, TKelvin>;
  TJoulePerKelvinId = specialize TRatioUnitId<TJoule, TKelvin>;
  TJoulesPerKelvin = specialize TRatioQuantity<TJoule, TKelvin>;

  TKilogramKelvin = specialize TUnitProduct<TBaseKilogram, TKelvin>;
  TKilogramKelvinId = specialize TUnitProductId<TBaseKilogram, TKelvin>;
  TKilogramKelvins = specialize TQuantityProduct<TBaseKilogram, TKelvin>;

  TJoulePerKilogramPerKelvin = specialize TRatioUnit<TJoule, TKilogramKelvin>;
  TJoulePerKilogramPerKelvinId = specialize TRatioUnitId<TJoule, TKilogramKelvin>;
  TJoulesPerKilogramPerKelvin = specialize TRatioQuantity<TJoule, TKilogramKelvin>;

  // HEAT CONDUCTION

  TKelvinPerMeter = specialize TRatioUnit<TKelvin, TMeter>;
  TKelvinPerMeterId = specialize TRatioUnitId<TKelvin, TMeter>;
  TKelvinsPerMeter = specialize TRatioQuantity<TKelvin, TMeter>;

  TMeterKelvin = specialize TUnitProduct<TMeter, TKelvin>;
  TMeterKelvinId = specialize TUnitProductId<TMeter, TKelvin>;
  TMeterKelvins = specialize TQuantityProduct<TMeter, TKelvin>;

  TWattPerKelvin = specialize TRatioUnit<TWatt, TKelvin>;
  TWattPerKelvinId = specialize TRatioUnitId<TWatt, TKelvin>;
  TWattsPerKelvin = specialize TRatioQuantity<TWatt, TKelvin>;

  TWattPerMeter = specialize TRatioUnit<TWatt, TMeter>;
  TWattPerMeterId = specialize TRatioUnitId<TWatt, TMeter>;
  TWattsPerMeter = specialize TRatioQuantity<TWatt, TMeter>;

  TWattPerSquareMeter = specialize TRatioUnit<TWatt, TSquareMeter>;
  TWattPerSquareMeterId = specialize TRatioUnitId<TWatt, TSquareMeter>;
  TWattsPerSquareMeter = specialize TRatioQuantity<TWatt, TSquareMeter>;

  TWattPerMeterPerKelvin = specialize TRatioUnit<TWatt, TMeterKelvin>;
  TWattPerMeterPerKelvinId = specialize TRatioUnitId<TWatt, TMeterKelvin>;
  TWattsPerMeterPerKelvin = specialize TRatioQuantity<TWatt, TMeterKelvin>;

  // HEAT CONVECTION

  TSquareMeterKelvin = specialize TUnitProduct<TSquareMeter, TKelvin>;
  TSquareMeterKelvinId = specialize TUnitProductId<TSquareMeter, TKelvin>;
  TSquareMeterKelvins = specialize TQuantityProduct<TSquareMeter, TKelvin>;

  TWattPerSquareMeterPerKelvin = specialize TRatioUnit<TWatt, TSquareMeterKelvin>;
  TWattPerSquareMeterPerKelvinId = specialize TRatioUnitId<TWatt, TSquareMeterKelvin>;
  TWattsPerSquareMeterPerKelvin = specialize TRatioQuantity<TWatt, TSquareMeterKelvin>;

  // THERMAL RADIATION

  TSquareMeterQuarticKelvin = specialize TUnitProduct<TSquareMeter, TQuarticKelvin>;
  TSquareMeterQuarticKelvinId = specialize TUnitProductId<TSquareMeter, TQuarticKelvin>;
  TSquareMeterQuarticKelvins = specialize TQuantityProduct<TSquareMeter, TQuarticKelvin>;

  TWattPerQuarticKelvin = specialize TRatioUnit<TWatt, TQuarticKelvin>;
  TWattPerQuarticKelvinId = specialize TRatioUnitId<TWatt, TQuarticKelvin>;
  TWattsPerQuarticKelvin = specialize TRatioQuantity<TWatt, TQuarticKelvin>;

  TWattPerSquareMeterPerQuarticKelvin = specialize TRatioUnit<TWatt, TSquareMeterQuarticKelvin>;
  TWattPerSquareMeterPerQuarticKelvinId = specialize TRatioUnitId<TWatt, TSquareMeterQuarticKelvin>;
  TWattsPerSquareMeterPerQuarticKelvin = specialize TRatioQuantity<TWatt, TSquareMeterQuarticKelvin>;

  // LINEAR THERMAL EXPANSION

  TReciprocalKelvinId = specialize TReciprocalUnitId<TKelvin>;
  TReciprocalKelvins = specialize TReciprocalQuantity<TKelvin>;

{$ENDIF}

// HEAT CAPACITY

{ main definition [ J/K ] = [ J ] / [ K ] }
{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TKelvinId}{$DEFINE RatioId:=TJoulePerKelvinId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TKelvins}{$DEFINE RatioQty:=TJoulesPerKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ kg*K ] = [ kg ] * [ K ] }
{$DEFINE LeftId:=TKilogramId}{$DEFINE RightId:=TKelvinId}{$DEFINE ProdId:=TKilogramKelvinId}
{$DEFINE LeftQty:=TKilograms}{$DEFINE RightQty:=TKelvins}{$DEFINE ProdQty:=TKilogramKelvins}
{$DEFINE DEF_PROD}{$i dim.pas}

{ main definition [ J/kg/K ] = [ J ] / [ kg*K ] }
{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TKilogramKelvinId}{$DEFINE RatioId:=TJoulePerKilogramPerKelvinId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TKilogramKelvins}{$DEFINE RatioQty:=TJoulesPerKilogramPerKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ J/kg/K ] = [ J/kg ] / [ K ] = [ m2/s2 ] / [ K ] }
{$DEFINE NumId:=TSquareMeterPerSquareSecondId}{$DEFINE DenomId:=TKelvinId}{$DEFINE RatioId:=TJoulePerKilogramPerKelvinId}
{$DEFINE NumQty:=TSquareMetersPerSquareSecond}{$DEFINE DenomQty:=TKelvins}{$DEFINE RatioQty:=TJoulesPerKilogramPerKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ J/kg/K ] = [ J/K ] / [ kg ] }
{$DEFINE LeftId:=TJoulePerKilogramPerKelvinId}{$DEFINE RightId:=TKilogramId}{$DEFINE ProdId:=TJoulePerKelvinId}
{$DEFINE LeftQty:=TJoulesPerKilogramPerKelvin}{$DEFINE RightQty:=TKilograms}{$DEFINE ProdQty:=TJoulesPerKelvin}
{$DEFINE ALT_PROD}{$i dim.pas}

// HEAT CONDUCTION

{ main definition [ K/m ] = [ K ] / [ m ] }
{$DEFINE NumId:=TKelvinId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TKelvinPerMeterId}
{$DEFINE NumQty:=TKelvins}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TKelvinsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ m*K ] = [ m ] * [ K ] }
{$DEFINE LeftId:=TMeterId}{$DEFINE RightId:=TKelvinId}{$DEFINE ProdId:=TMeterKelvinId}
{$DEFINE LeftQty:=TMeters}{$DEFINE RightQty:=TKelvins}{$DEFINE ProdQty:=TMeterKelvins}
{$DEFINE DEF_PROD}{$i dim.pas}

{ main definition [ W/K ] = [ W ] / [ K ] }
{$DEFINE NumId:=TWattId}{$DEFINE DenomId:=TKelvinId}{$DEFINE RatioId:=TWattPerKelvinId}
{$DEFINE NumQty:=TWatts}{$DEFINE DenomQty:=TKelvins}{$DEFINE RatioQty:=TWattsPerKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ W/m ] = [ W ] / [ m ] }
{$DEFINE NumId:=TWattId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TWattPerMeterId}
{$DEFINE NumQty:=TWatts}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TWattsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ W/m2 ] = [ W ] / [ m2 ] }
{$DEFINE NumId:=TWattId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TWattPerSquareMeterId}
{$DEFINE NumQty:=TWatts}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TWattsPerSquareMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ W/m/K ] = [ W ] / [ m*K ] }
{$DEFINE NumId:=TWattId}{$DEFINE DenomId:=TMeterKelvinId}{$DEFINE RatioId:=TWattPerMeterPerKelvinId}
{$DEFINE NumQty:=TWatts}{$DEFINE DenomQty:=TMeterKelvins}{$DEFINE RatioQty:=TWattsPerMeterPerKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ W/m/K ] = [ W/m ] / [ K ] }
{$DEFINE NumId:=TWattPerMeterId}{$DEFINE DenomId:=TKelvinId}{$DEFINE RatioId:=TWattPerMeterPerKelvinId}
{$DEFINE NumQty:=TWattsPerMeter}{$DEFINE DenomQty:=TKelvins}{$DEFINE RatioQty:=TWattsPerMeterPerKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ W/m/K ] = [ W/K ] / [ m ] }
{$DEFINE NumId:=TWattPerKelvinId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TWattPerMeterPerKelvinId}
{$DEFINE NumQty:=TWattsPerKelvin}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TWattsPerMeterPerKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ W/m/K ] = [ W/m2 ] / [ K/m ] }
{$DEFINE NumId:=TWattPerSquareMeterId}{$DEFINE DenomId:=TKelvinPerMeterId}{$DEFINE RatioId:=TWattPerMeterPerKelvinId}
{$DEFINE NumQty:=TWattsPerSquareMeter}{$DEFINE DenomQty:=TKelvinsPerMeter}{$DEFINE RatioQty:=TWattsPerMeterPerKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

// HEAT CONVECTION

{ main definition [ m2*K ] = [ m2 ] * [ K ] }
{$DEFINE LeftId:=TSquareMeterId}{$DEFINE RightId:=TKelvinId}{$DEFINE ProdId:=TSquareMeterKelvinId}
{$DEFINE LeftQty:=TSquareMeters}{$DEFINE RightQty:=TKelvins}{$DEFINE ProdQty:=TSquareMeterKelvins}
{$DEFINE DEF_PROD}{$i dim.pas}

{ main definition [ W/m2/K ] = [ W ] / [ m2*K ] }
{$DEFINE NumId:=TWattId}{$DEFINE DenomId:=TSquareMeterKelvinId}{$DEFINE RatioId:=TWattPerSquareMeterPerKelvinId}
{$DEFINE NumQty:=TWatts}{$DEFINE DenomQty:=TSquareMeterKelvins}{$DEFINE RatioQty:=TWattsPerSquareMeterPerKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ W/m2/K ] = [ W/m2 ] / [ K ] }
{$DEFINE NumId:=TWattPerSquareMeterId}{$DEFINE DenomId:=TKelvinId}{$DEFINE RatioId:=TWattPerSquareMeterPerKelvinId}
{$DEFINE NumQty:=TWattsPerSquareMeter}{$DEFINE DenomQty:=TKelvins}{$DEFINE RatioQty:=TWattsPerSquareMeterPerKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ W/m2/K ] = [ W/K ] / [ m2 ] }
{$DEFINE NumId:=TWattPerKelvinId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TWattPerSquareMeterPerKelvinId}
{$DEFINE NumQty:=TWattsPerKelvin}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TWattsPerSquareMeterPerKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

// THERMAL RADIATION

{ main definition [ m2*K4 ] = [ m2 ] * [ K4 ] }
{$DEFINE LeftId:=TSquareMeterId}{$DEFINE RightId:=TQuarticKelvinId}{$DEFINE ProdId:=TSquareMeterQuarticKelvinId}
{$DEFINE LeftQty:=TSquareMeters}{$DEFINE RightQty:=TQuarticKelvins}{$DEFINE ProdQty:=TSquareMeterQuarticKelvins}
{$DEFINE DEF_PROD}{$i dim.pas}

{ main definition [ W/K4 ] = [ W ] / [ K4 ] }
{$DEFINE NumId:=TWattId}{$DEFINE DenomId:=TQuarticKelvinId}{$DEFINE RatioId:=TWattPerQuarticKelvinId}
{$DEFINE NumQty:=TWatts}{$DEFINE DenomQty:=TQuarticKelvins}{$DEFINE RatioQty:=TWattsPerQuarticKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ main definition [ W/m2/K4 ] = [ W ] / [ m2*K4 ] }
{$DEFINE NumId:=TWattId}{$DEFINE DenomId:=TSquareMeterQuarticKelvinId}{$DEFINE RatioId:=TWattPerSquareMeterPerQuarticKelvinId}
{$DEFINE NumQty:=TWatts}{$DEFINE DenomQty:=TSquareMeterQuarticKelvins}{$DEFINE RatioQty:=TWattsPerSquareMeterPerQuarticKelvin}
{$DEFINE DEF_RATIO}{$i dim.pas}

{ alternative definition [ W/m2/K4 ] = [ W/m2 ] / [ K4 ] }
{$DEFINE NumId:=TWattPerSquareMeterId}{$DEFINE DenomId:=TQuarticKelvinId}{$DEFINE RatioId:=TWattPerSquareMeterPerQuarticKelvinId}
{$DEFINE NumQty:=TWattsPerSquareMeter}{$DEFINE DenomQty:=TQuarticKelvins}{$DEFINE RatioQty:=TWattsPerSquareMeterPerQuarticKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ W/m2/K4 ] = [ W/K4 ] / [ m2 ] }
{$DEFINE NumId:=TWattPerQuarticKelvinId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TWattPerSquareMeterPerQuarticKelvinId}
{$DEFINE NumQty:=TWattsPerQuarticKelvin}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TWattsPerSquareMeterPerQuarticKelvin}
{$DEFINE ALT_RATIO}{$i dim.pas}

// LINEAR THERMAL EXPANSION

{$DEFINE DenomId:=TKelvinId}{$DEFINE RecipId:=TReciprocalKelvinId}
{$DEFINE DenomQty:=TKelvins}{$DEFINE RecipQty:=TReciprocalKelvins}
{$DEFINE DEF_RECIP}{$i dim.pas} // K-1 = 1 / K

// GRAVITATIONAL POTENTIAL ENERGY

{$IFDEF INTF}
type
  TSquareKilogramPerMeter = specialize TRatioUnit<TSquareKilogram, TMeter>;
  TSquareKilogramPerMeterId = specialize TRatioUnitId<TSquareKilogram, TMeter>;
  TSquareKilogramsPerMeter = specialize TRatioQuantity<TSquareKilogram, TMeter>;
{$ENDIF}

{ main definition [ kg2/m ] = [ kg2 ] / [ m ] }
{$DEFINE NumId:=TSquareKilogramId}{$DEFINE DenomId:=TMeterId}{$DEFINE RatioId:=TSquareKilogramPerMeterId}
{$DEFINE NumQty:=TSquareKilograms}{$DEFINE DenomQty:=TMeters}{$DEFINE RatioQty:=TSquareKilogramsPerMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TSquareKilogramPerSquareMeter = specialize TRatioUnit<TSquareKilogram, TSquareMeter>;
  TSquareKilogramPerSquareMeterId = specialize TRatioUnitId<TSquareKilogram, TSquareMeter>;
  TSquareKilogramsPerSquareMeter = specialize TRatioQuantity<TSquareKilogram, TSquareMeter>;
{$ENDIF}

{ main definition [ kg2/m2 ] = [ kg2 ] / [ m2 ] }
{$DEFINE NumId:=TSquareKilogramId}{$DEFINE DenomId:=TSquareMeterId}{$DEFINE RatioId:=TSquareKilogramPerSquareMeterId}
{$DEFINE NumQty:=TSquareKilograms}{$DEFINE DenomQty:=TSquareMeters}{$DEFINE RatioQty:=TSquareKilogramsPerSquareMeter}
{$DEFINE DEF_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TSquareMeterPerSquareKilogram = specialize TRatioUnit<TSquareMeter, TSquareKilogram>;
  TSquareMeterPerSquareKilogramId = specialize TRatioUnitId<TSquareMeter, TSquareKilogram>;
  TSquareMetersPerSquareKilogram = specialize TRatioQuantity<TSquareMeter, TSquareKilogram>;
{$ENDIF}

{ main definition [ m2/kg2 ] = [ m2 ] / [ kg2 ] }
{$DEFINE NumId:=TSquareMeterId}{$DEFINE DenomId:=TSquareKilogramId}{$DEFINE RatioId:=TSquareMeterPerSquareKilogramId}
{$DEFINE NumQty:=TSquareMeters}{$DEFINE DenomQty:=TSquareKilograms}{$DEFINE RatioQty:=TSquareMetersPerSquareKilogram}
{$DEFINE DEF_RATIO}{$i dim.pas}

{$IFDEF INTF}
type
  TNewtonPerSquareKilogram = specialize TRatioUnit<TNewton, TSquareKilogram>;
  TNewtonPerSquareKilogramId = specialize TRatioUnitId<TNewton, TSquareKilogram>;
  TNewtonsPerSquareKilogram = specialize TRatioQuantity<TNewton, TSquareKilogram>;
{$ENDIF}

{ main definition [ N/kg2 ] = [ N ] / [ kg2 ] }
{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TSquareKilogramId}{$DEFINE RatioId:=TNewtonPerSquareKilogramId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TSquareKilograms}{$DEFINE RatioQty:=TNewtonsPerSquareKilogram}
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

{ Units of gravitational constant }
{$IFDEF INTF}
type
  TNewtonSquareMeterPerSquareKilogram = specialize TUnitProduct<TNewton, TSquareMeterPerSquareKilogram>;
  TNewtonSquareMeterPerSquareKilogramId = specialize TUnitProductId<TNewton, TSquareMeterPerSquareKilogram>;
  TNewtonSquareMetersPerSquareKilogram = specialize TQuantityProduct<TNewton, TSquareMeterPerSquareKilogram>;
{$ENDIF}

{ main definition [ N*m2/kg2 ] = [ N ] * [ m2/kg2 ] }
{$DEFINE LeftId:=TNewtonId}{$DEFINE RightId:=TSquareMeterPerSquareKilogramId}{$DEFINE ProdId:=TNewtonSquareMeterPerSquareKilogramId}
{$DEFINE LeftQty:=TNewtons}{$DEFINE RightQty:=TSquareMetersPerSquareKilogram}{$DEFINE ProdQty:=TNewtonSquareMetersPerSquareKilogram}
{$DEFINE DEF_PROD}{$i dim.pas}

{ alternative definition [ N*m2/kg2 ] = [ N ] / [ kg2/m2 ] }
{$DEFINE NumId:=TNewtonId}{$DEFINE DenomId:=TSquareKilogramPerSquareMeterId}{$DEFINE RatioId:=TNewtonSquareMeterPerSquareKilogramId}
{$DEFINE NumQty:=TNewtons}{$DEFINE DenomQty:=TSquareKilogramsPerSquareMeter}{$DEFINE RatioQty:=TNewtonSquareMetersPerSquareKilogram}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ N*m2/kg2 ] = [ N*m2 ] / [ kg2 ] }
{$DEFINE NumId:=TNewtonSquareMeterId}{$DEFINE DenomId:=TSquareKilogramId}{$DEFINE RatioId:=TNewtonSquareMeterPerSquareKilogramId}
{$DEFINE NumQty:=TNewtonSquareMeters}{$DEFINE DenomQty:=TSquareKilograms}{$DEFINE RatioQty:=TNewtonSquareMetersPerSquareKilogram}
{$DEFINE ALT_RATIO}{$i dim.pas}

{ alternative definition [ N*m2/kg2 ] = [ N/kg2 ] * [ m2 ] }
{$DEFINE LeftId:=TNewtonPerSquareKilogramId}{$DEFINE RightId:=TSquareMeterId}{$DEFINE ProdId:=TNewtonSquareMeterPerSquareKilogramId}
{$DEFINE LeftQty:=TNewtonsPerSquareKilogram}{$DEFINE RightQty:=TSquareMeters}{$DEFINE ProdQty:=TNewtonSquareMetersPerSquareKilogram}
{$DEFINE ALT_PROD}{$i dim.pas}

{ alternative definition [ N*m2/kg2 ] = [ J ] / [ kg2/m ] }
{$DEFINE NumId:=TJouleId}{$DEFINE DenomId:=TSquareKilogramPerMeterId}{$DEFINE RatioId:=TNewtonSquareMeterPerSquareKilogramId}
{$DEFINE NumQty:=TJoules}{$DEFINE DenomQty:=TSquareKilogramsPerMeter}{$DEFINE RatioQty:=TNewtonSquareMetersPerSquareKilogram}
{$DEFINE ALT_RATIO}{$i dim.pas}

