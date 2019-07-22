#include "..\..\script_macros.hpp"
/*
    File: fn_chopShopSell.sqf
    Author: Bryan "Tonic" Boardwine
    Modified: Casperento

    Description:
    Sells the selected vehicle off.
*/
disableSerialization;

private _control = CONTROL(39400,39402);
private _price = _control lbValue (lbCurSel _control);
private _vehicle = _control lbData (lbCurSel _control);
_vehicle = call compile format ["%1", _vehicle];
_vehicle = objectFromNetId _vehicle;
if (isNull _vehicle) exitWith {};

hint localize "STR_Shop_ChopShopSelling";
life_action_inUse = true;
[0] call SOCK_fnc_updatePartial;

if (life_HC_isActive) then {
    [player,_vehicle,_price] remoteExecCall ["HC_fnc_chopShopSell",HC_Life];
} else {
    [player,_vehicle,_price] remoteExecCall ["TON_fnc_chopShopSell",RSERV];
};

if (LIFE_SETTINGS(getNumber,"player_advancedLog") isEqualTo 1) then {
    if (LIFE_SETTINGS(getNumber,"battlEye_friendlyLogging") isEqualTo 1) then {
        advanced_log = format [localize "STR_DL_AL_choppedVehicle_BEF",_vehicle,[_price] call life_fnc_numberText,[CASH] call life_fnc_numberText];
    } else {
        advanced_log = format [localize "STR_DL_AL_choppedVehicle",profileName,(getPlayerUID player),_vehicle,[_price] call life_fnc_numberText,[CASH] call life_fnc_numberText];
    };
    publicVariableServer "advanced_log";
};

closeDialog 0;